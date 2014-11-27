Return-Path: <cyrus@holtmann.org>
Date: Thu, 27 Nov 2014 14:50:18 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v11 3/3] Bluetooth: start and stop service discovery
Message-ID: <20141127125018.GB28057@t440s>
References: <1417051767-19597-1-git-send-email-jpawlowski@google.com>
 <1417051767-19597-3-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417051767-19597-3-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Nov 26, 2014, Jakub Pawlowski wrote:
> This patch introduces start service discovery method. The reason
> behind that is to enable users to find specific services in range
> by UUID. Whole filtering is done in mgmt_device_found.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci.h      |   1 +
>  include/net/bluetooth/hci_core.h |   6 +
>  include/net/bluetooth/mgmt.h     |   9 ++
>  net/bluetooth/hci_core.c         |   1 +
>  net/bluetooth/mgmt.c             | 277 +++++++++++++++++++++++++++++++++++----
>  5 files changed, 267 insertions(+), 27 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index a8784e6..a88acee 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -211,6 +211,7 @@ enum {
>   */
>  enum {
>  	HCI_LE_SCAN_RESTARTING,
> +	HCI_SERVICE_FILTER,
>  };

At closer inspection it seems to me that this flag is redundant. Take
for example the following if-statement from later on in your patch:

> +	if (!test_bit(HCI_SERVICE_FILTER, &hdev->discovery.flags) ||
> +	    (hdev->discovery.sd_rssi == 127 &&
> +	     hdev->discovery.sd_num_uuid == 0)) {
> +		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +		return;
> +	}

It should be possible to use simply the RSSI and UUID count to select
the special "service discovery" behavior. I might have overlooked
something though, in which case please enlighten me :)

> +
> +	/* sd prefix stands for service discovery related properties */
> +	s8			sd_rssi;
> +	u16			sd_num_uuid;
> +	u8			(*sd_uuid)[16];
>  };

Minor cosmetic thing I know, but I'd prefer to drop the sd_ prefix from
these. I don't think we'll ever end up having similar variables but for
a different purpose in the discovery struct (and if we do then we can
always add namespacing back).

I've also corrected the parameter naming in mgmt-api.txt to match what
we use for other "lists" like Link Keys. The variables here should also
reflect that. I'd suggest as follows:

	s8      rssi;
	u16     uuid_count;
	u8      (*uuids)[16];


> +#define MGMT_OP_START_SERVICE_DISCOVERY	0x003A
> +struct mgmt_cp_start_service_discovery {
> +	__u8 type;
> +	__s8 rssi_threshold;
> +	__le16 num_uuid;
> +	__u8 uuid[0][16];
> +} __packed;

Here you should also update the naming. I'm not sure it's worth having
the _treshold though since you're using just "rssi" elsewhere.

> +/* cleans up the state set up by the start_service_discovery function. */
> +void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
> +{
> +	if (!test_and_clear_bit(HCI_SERVICE_FILTER, &hdev->discovery.flags))
> +		return;
> +
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> +	if (hdev->discovery.sd_num_uuid > 0)
> +		kfree(hdev->discovery.sd_uuid);
> +	hdev->discovery.sd_num_uuid = 0;
> +}

Is this function really needed? I mean, what it does is clearly needed,
but I'd have just put it into hci_discovery_set_state() when going to
DISCOVERY_STOPPED. You could of course keep the code as a helper
function but just call it from hci_discovery_set_state(). I might have
overlooked something of course but that'd seem the most natural (and
simple) place to put this stuff.

Btw, the dependency of num_uuid to the kfree call still looks wrong to
me (I asked to change it in an earlier review). The kfree() could be
made unconditional as long as you remember to set the uuid pointer to
NULL afterwards.

> +static int init_service_discovery(struct hci_dev *hdev, s8 rssi, u16 num_uuid,
> +				  u8 (*uuid)[16])
> +{
> +	hdev->discovery.sd_rssi = rssi;
> +	hdev->discovery.sd_num_uuid = num_uuid;
> +
> +	if (num_uuid > 0) {
> +		hdev->discovery.sd_uuid = kmalloc(16 * num_uuid, GFP_KERNEL);
> +		if (!hdev->discovery.sd_uuid)
> +			return -ENOMEM;
> +		memcpy(hdev->discovery.sd_uuid, uuid, 16 * num_uuid);
> +	}

The memcpy and kmalloc calls could be simplified to a single kmemdup
call:

	hdev->discovery.uuids = kmemdup(uuids, 16 * uuid_count, GFP_KERNEL);

>  static int generic_start_discovery(struct sock *sk, struct hci_dev *hdev,
>  				   void *data, u16 len, u16 opcode)
>  {
> -	struct mgmt_cp_start_discovery *cp = data;
>  	struct pending_cmd *cmd;
>  	struct hci_cp_le_set_scan_param param_cp;
>  	struct hci_cp_le_set_scan_enable enable_cp;
>  	struct hci_cp_inquiry inq_cp;
>  	struct hci_request req;
>  	/* General inquiry access code (GIAC) */
> +	s8 sd_rssi = 0;
>  	u8 lap[3] = { 0x33, 0x8b, 0x9e };
> -	u8 status, own_addr_type;
> +	u8 status, own_addr_type, type;
> +	u8 (*sd_uuid)[16] = NULL;
> +	u16 sd_num_uuid = 0;
>  	int err;
>  
>  	BT_DBG("%s", hdev->name);
>  
> +	if (opcode == MGMT_OP_START_SERVICE_DISCOVERY) {
> +		struct mgmt_cp_start_service_discovery *cp = data;
> +		u16 expected_len, num_uuid_tmp;
> +
> +		type = cp->type;
> +		num_uuid_tmp = __le16_to_cpu(cp->num_uuid);
> +		expected_len = sizeof(*cp) + num_uuid_tmp * 16;
> +
> +		if (expected_len != len) {
> +			return cmd_complete(sk, hdev->id, opcode,
> +					    MGMT_STATUS_INVALID_PARAMS, &type,
> +					    sizeof(type));
> +		}

No need for the { } in a one-statement branch. Also, the num_uuid_tmp
variable seems unnecessary here. Can't you just directly assign to your
sd_num_uuid variable? (which btw should be renamed to uuid_count)

> +		sd_rssi = cp->rssi_threshold;
> +		sd_num_uuid = num_uuid_tmp;
> +		if (sd_num_uuid > 0)
> +			sd_uuid = cp->uuid;
> +	} else {
> +		struct mgmt_cp_start_discovery *cp = data;
> +
> +		type = cp->type;
> +	}

Since you've got a dedicated branch for each type of discovery we could
avoid the sd_num_uuid initialization to 0 upon declaration (something
that's in general discouraged whenever possible). The you'd just set it
to the __le16_to_cpu() result in the first branch and 0 in the second.

Johan

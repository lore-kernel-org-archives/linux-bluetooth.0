Return-Path: <cyrus@holtmann.org>
Message-ID: <1329308103.28848.77.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Implement Read Supported Commands commands
 for mgmt
From: Marcel Holtmann <marcel@holtmann.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Feb 2012 13:15:03 +0100
In-Reply-To: <1329307504-28250-1-git-send-email-johan.hedberg@gmail.com>
References: <1329307504-28250-1-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch implements the Read Supported Commands mgmt command which was
> recently added to the API specification. It returns a list of supported
> commands and events to user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  include/net/bluetooth/mgmt.h |    7 +++
>  net/bluetooth/mgmt.c         |  101 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 5b5edee..255a996 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -63,6 +63,13 @@ struct mgmt_rp_read_version {
>  	__le16 revision;
>  } __packed;
>  
> +#define MGMT_OP_READ_COMMANDS		0x0002
> +struct mgmt_rp_read_commands {
> +	__le16 num_commands;
> +	__le16 num_events;
> +	__le16 opcodes[0];
> +} __packed;
> +
>  #define MGMT_OP_READ_INDEX_LIST		0x0003
>  struct mgmt_rp_read_index_list {
>  	__le16 num_controllers;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a2c2e12..dbd521d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -35,6 +35,71 @@
>  #define MGMT_VERSION	0
>  #define MGMT_REVISION	1
>  
> +static u16 mgmt_commands[] = {
> +	MGMT_OP_READ_INDEX_LIST,
> +	MGMT_OP_READ_INFO,
> +	MGMT_OP_SET_POWERED,
> +	MGMT_OP_SET_DISCOVERABLE,
> +	MGMT_OP_SET_CONNECTABLE,
> +	MGMT_OP_SET_FAST_CONNECTABLE,
> +	MGMT_OP_SET_PAIRABLE,
> +	MGMT_OP_SET_LINK_SECURITY,
> +	MGMT_OP_SET_SSP,
> +	MGMT_OP_SET_HS,
> +	MGMT_OP_SET_LE,
> +	MGMT_OP_SET_DEV_CLASS,
> +	MGMT_OP_SET_LOCAL_NAME,
> +	MGMT_OP_ADD_UUID,
> +	MGMT_OP_REMOVE_UUID,
> +	MGMT_OP_LOAD_LINK_KEYS,
> +	MGMT_OP_LOAD_LONG_TERM_KEYS,
> +	MGMT_OP_DISCONNECT,
> +	MGMT_OP_GET_CONNECTIONS,
> +	MGMT_OP_PIN_CODE_REPLY,
> +	MGMT_OP_PIN_CODE_NEG_REPLY,
> +	MGMT_OP_SET_IO_CAPABILITY,
> +	MGMT_OP_PAIR_DEVICE,
> +	MGMT_OP_CANCEL_PAIR_DEVICE,
> +	MGMT_OP_UNPAIR_DEVICE,
> +	MGMT_OP_USER_CONFIRM_REPLY,
> +	MGMT_OP_USER_CONFIRM_NEG_REPLY,
> +	MGMT_OP_USER_PASSKEY_REPLY,
> +	MGMT_OP_USER_PASSKEY_NEG_REPLY,
> +	MGMT_OP_READ_LOCAL_OOB_DATA,
> +	MGMT_OP_ADD_REMOTE_OOB_DATA,
> +	MGMT_OP_REMOVE_REMOTE_OOB_DATA,
> +	MGMT_OP_START_DISCOVERY,
> +	MGMT_OP_STOP_DISCOVERY,
> +	MGMT_OP_CONFIRM_NAME,
> +	MGMT_OP_BLOCK_DEVICE,
> +	MGMT_OP_UNBLOCK_DEVICE,
> +};
> +
> +static u16 mgmt_events[] = {
> +	MGMT_EV_CMD_COMPLETE,
> +	MGMT_EV_CMD_STATUS,

I think you want to leave the two event above out. The specification
states that they are not included, because always mandatory. They are
actually implicit anyway. Without it you are lost.

And I think you can make both arrays const.

Other than that, looks good.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



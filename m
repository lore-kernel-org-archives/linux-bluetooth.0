Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v4 BlueZ 4/4] Bluetooth: mgmt: Added new
 MGMT_OP_ADD_CONN_PARAM command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20170314183058.25555-1-eu@felipetonello.com>
 <20170314183058.25555-5-eu@felipetonello.com>
 <CABBYNZJ6LJpTaMYyOu+eUhzD_ADaw8jHURJLdP61276tCX=Y5w@mail.gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Felipe Ferreri Tonello <eu@felipetonello.com>
Message-ID: <7569c343-20d7-587f-7e90-6ff933fcecbf@felipetonello.com>
Date: Mon, 20 Mar 2017 09:01:33 +0000
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ6LJpTaMYyOu+eUhzD_ADaw8jHURJLdP61276tCX=Y5w@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------0D9B3903D5FF0C5621746B15"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------0D9B3903D5FF0C5621746B15
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi Luiz,

On 17/03/17 17:44, Luiz Augusto von Dentz wrote:
> Hi Felipe,
> 
> On Tue, Mar 14, 2017 at 8:30 PM, Felipe F. Tonello <eu@felipetonello.com> wrote:
>> This command is similar to MGMT_OP_LOAD_CONN_PARAM with the exception
>> that it only updates one connection parameter and it doesn't cleanup
>> previous parameters set.
>>
>> This is useful for applications to update one specific connection
>> parameter and not caring about other cached connection parameters.
>>
>> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
>> ---
>>  include/net/bluetooth/mgmt.h |  10 +++++
>>  net/bluetooth/mgmt.c         | 103 ++++++++++++++++++++++++++++---------------
>>  2 files changed, 77 insertions(+), 36 deletions(-)
>>
>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>> index 72a456bbbcd5..34e5fae8c9d5 100644
>> --- a/include/net/bluetooth/mgmt.h
>> +++ b/include/net/bluetooth/mgmt.h
>> @@ -604,6 +604,16 @@ struct mgmt_cp_set_appearance {
>>  } __packed;
>>  #define MGMT_SET_APPEARANCE_SIZE       2
>>
>> +#define MGMT_OP_ADD_CONN_PARAM         0x0044
>> +struct mgmt_cp_add_conn_param {
>> +       struct mgmt_addr_info addr;
>> +       __le16 min_interval;
>> +       __le16 max_interval;
>> +       __le16 latency;
>> +       __le16 timeout;
>> +} __packed;
>> +#define MGMT_ADD_CONN_PARAM_SIZE       (MGMT_ADDR_INFO_SIZE + 8)
> 
> I do remember mentioning that this command shall accept multiple
> setting at time, just like load.

Yes, that is correct. But as I mentioned on the previous email I sent, I
think this is not the correct approach, since this command effectively
would be only used in the case of peripheral using a Slave Connection
Interval AD. In this case, to avoid multiple calls to this command, I
believe we should parse this particular AD in the Kernel, and just
update the connection parameters accordingly. There is no need to let
user-space know about this, since it is in the AD anyway (it will be
persistent by the slave peripheral wishes).

> 
>> +
>>  #define MGMT_EV_CMD_COMPLETE           0x0001
>>  struct mgmt_ev_cmd_complete {
>>         __le16  opcode;
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index 1fba2a03f8ae..b8e86bf1fe1b 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
>>         MGMT_OP_START_LIMITED_DISCOVERY,
>>         MGMT_OP_READ_EXT_INFO,
>>         MGMT_OP_SET_APPEARANCE,
>> +       MGMT_OP_ADD_CONN_PARAM,
>>  };
>>
>>  static const u16 mgmt_events[] = {
>> @@ -5462,6 +5463,69 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
>>         return err;
>>  }
>>
>> +/* This function requires the caller holds hdev->lock */
>> +static u8 really_add_conn_param(struct hci_dev *hdev,
>> +                               struct mgmt_cp_add_conn_param *param)
>> +{
>> +       struct hci_conn_params *hci_param;
>> +       u16 min, max, latency, timeout;
>> +       u8 addr_type;
>> +
>> +       if (param->addr.type == BDADDR_LE_PUBLIC)
>> +               addr_type = ADDR_LE_DEV_PUBLIC;
>> +       else if (param->addr.type == BDADDR_LE_RANDOM)
>> +               addr_type = ADDR_LE_DEV_RANDOM;
>> +       else
>> +               return MGMT_STATUS_INVALID_PARAMS;
>> +
>> +       min = le16_to_cpu(param->min_interval);
>> +       max = le16_to_cpu(param->max_interval);
>> +       latency = le16_to_cpu(param->latency);
>> +       timeout = le16_to_cpu(param->timeout);
>> +
>> +       BT_DBG("min 0x%04x max 0x%04x latency 0x%04x timeout 0x%04x",
>> +              min, max, latency, timeout);
>> +
>> +       if (hci_check_conn_params(min, max, latency, timeout) < 0) {
>> +               BT_ERR("Ignoring invalid connection parameters");
>> +               return MGMT_STATUS_INVALID_PARAMS;
>> +       }
>> +
>> +       hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
>> +                                       addr_type);
>> +       if (!hci_param) {
>> +               BT_ERR("Failed to add connection parameters");
>> +               return MGMT_STATUS_FAILED;
>> +       }
>> +
>> +       hci_param->conn_min_interval = min;
>> +       hci_param->conn_max_interval = max;
>> +       hci_param->conn_latency = latency;
>> +       hci_param->supervision_timeout = timeout;
>> +
>> +       return 0;
>> +}
>> +
>> +static int add_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
>> +                            u16 len)
>> +{
>> +       struct mgmt_cp_add_conn_param *cp = data;
>> +       u8 cmd_status;
>> +
>> +       if (!lmp_le_capable(hdev))
>> +               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM,
>> +                                      MGMT_STATUS_NOT_SUPPORTED);
>> +
>> +       hci_dev_lock(hdev);
>> +
>> +       cmd_status = really_add_conn_param(hdev, cp);
>> +
>> +       hci_dev_unlock(hdev);
>> +
>> +       return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_CONN_PARAM,
>> +                                cmd_status, NULL, 0);
>> +}
>> +
>>  static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
>>                            u16 len)
>>  {
>> @@ -5500,46 +5564,12 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
>>
>>         for (i = 0; i < param_count; i++) {
>>                 struct mgmt_conn_param *param = &cp->params[i];
>> -               struct hci_conn_params *hci_param;
>> -               u16 min, max, latency, timeout;
>> -               u8 addr_type;
>>
>>                 BT_DBG("Adding %pMR (type %u)", &param->addr.bdaddr,
>>                        param->addr.type);
>>
>> -               if (param->addr.type == BDADDR_LE_PUBLIC) {
>> -                       addr_type = ADDR_LE_DEV_PUBLIC;
>> -               } else if (param->addr.type == BDADDR_LE_RANDOM) {
>> -                       addr_type = ADDR_LE_DEV_RANDOM;
>> -               } else {
>> -                       BT_ERR("Ignoring invalid connection parameters");
>> -                       continue;
>> -               }
>> -
>> -               min = le16_to_cpu(param->min_interval);
>> -               max = le16_to_cpu(param->max_interval);
>> -               latency = le16_to_cpu(param->latency);
>> -               timeout = le16_to_cpu(param->timeout);
>> -
>> -               BT_DBG("min 0x%04x max 0x%04x latency 0x%04x timeout 0x%04x",
>> -                      min, max, latency, timeout);
>> -
>> -               if (hci_check_conn_params(min, max, latency, timeout) < 0) {
>> -                       BT_ERR("Ignoring invalid connection parameters");
>> -                       continue;
>> -               }
>> -
>> -               hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
>> -                                               addr_type);
>> -               if (!hci_param) {
>> -                       BT_ERR("Failed to add connection parameters");
>> -                       continue;
>> -               }
>> -
>> -               hci_param->conn_min_interval = min;
>> -               hci_param->conn_max_interval = max;
>> -               hci_param->conn_latency = latency;
>> -               hci_param->supervision_timeout = timeout;
>> +               really_add_conn_param(hdev,
>> +                       (struct mgmt_cp_add_conn_param *)param);
> 
> Once Add support more than one setting the only real difference from
> Load should be that Load does reset the settings before adding,
> everything else remains the same.
> 
>>         }
>>
>>         hci_dev_unlock(hdev);
>> @@ -6538,6 +6568,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
>>         { read_ext_controller_info,MGMT_READ_EXT_INFO_SIZE,
>>                                                 HCI_MGMT_UNTRUSTED },
>>         { set_appearance,          MGMT_SET_APPEARANCE_SIZE },
>> +       { add_conn_param,          MGMT_ADD_CONN_PARAM_SIZE },
>>  };
>>
>>  void mgmt_index_added(struct hci_dev *hdev)
>> --
>> 2.12.0
>>
> 

-- 
Felipe

--------------0D9B3903D5FF0C5621746B15
Content-Type: application/pgp-keys;
 name="0x92698E6A.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0x92698E6A.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
SkAyCfQaSw==
=JwBB
-----END PGP PUBLIC KEY BLOCK-----

--------------0D9B3903D5FF0C5621746B15--

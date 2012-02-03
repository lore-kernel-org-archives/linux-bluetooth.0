Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1328290794.2062.46.camel@aeonflux>
References: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
	<1328135692-24255-4-git-send-email-andre.guedes@openbossa.org>
	<1328290794.2062.46.camel@aeonflux>
Date: Fri, 3 Feb 2012 17:56:52 -0300
Message-ID: <CACJA=fWpy2Nf=+2s_dHAt94VmrHkQNkp8bC8Xg0vg9en1QsTPA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] Bluetooth: Add hci_do_le_scan()
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Feb 3, 2012 at 2:39 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Andre,
>
>> This patch adds to hci_core the hci_do_le_scan function which
>> should be used to scan LE devices.
>>
>> In order to enable LE scan, hci_do_le_scan() sends commands (Set
>> LE Scan Parameters and Set LE Scan Enable) to the controller and
>> waits for its results. If commands were executed successfully a
>> delayed work is scheduled to disable the ongoing scanning after
>> some amount of time. This function blocks.
>>
>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A08 ++++
>> =A0net/bluetooth/hci_core.c =A0 =A0 =A0 =A0 | =A0 79 +++++++++++++++++++=
+++++++++++++++++++
>> =A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| =A0 13 +++++-
>> =A03 files changed, 97 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index eab98d3..47111df 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -126,6 +126,12 @@ struct adv_entry {
>> =A0 =A0 =A0 u8 bdaddr_type;
>> =A0};
>>
>> +struct le_scan_params {
>> + =A0 =A0 u8 type;
>> + =A0 =A0 u16 interval;
>> + =A0 =A0 u16 window;
>> +};
>> +
>> =A0#define NUM_REASSEMBLY 4
>> =A0struct hci_dev {
>> =A0 =A0 =A0 struct list_head list;
>> @@ -263,6 +269,8 @@ struct hci_dev {
>>
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 dev_flags;
>>
>> + =A0 =A0 struct delayed_work =A0 =A0 le_scan_disable;
>> +
>> =A0 =A0 =A0 int (*open)(struct hci_dev *hdev);
>> =A0 =A0 =A0 int (*close)(struct hci_dev *hdev);
>> =A0 =A0 =A0 int (*flush)(struct hci_dev *hdev);
>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> index 35843f1..2f5d1ae 100644
>> --- a/net/bluetooth/hci_core.c
>> +++ b/net/bluetooth/hci_core.c
>> @@ -759,6 +759,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>> =A0 =A0 =A0 if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work(&hdev->service_cache);
>>
>> + =A0 =A0 cancel_delayed_work_sync(&hdev->le_scan_disable);
>> +
>> =A0 =A0 =A0 hci_dev_lock(hdev);
>> =A0 =A0 =A0 inquiry_cache_flush(hdev);
>> =A0 =A0 =A0 hci_conn_hash_flush(hdev);
>> @@ -1573,6 +1575,81 @@ int hci_add_adv_entry(struct hci_dev *hdev,
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static void le_scan_param_req(struct hci_dev *hdev, unsigned long opt)
>> +{
>> + =A0 =A0 struct le_scan_params *param =3D =A0(struct le_scan_params *) =
opt;
>> + =A0 =A0 struct hci_cp_le_set_scan_param cp;
>> +
>> + =A0 =A0 memset(&cp, 0, sizeof(cp));
>> + =A0 =A0 cp.type =3D param->type;
>> + =A0 =A0 cp.interval =3D cpu_to_le16(param->interval);
>> + =A0 =A0 cp.window =3D cpu_to_le16(param->window);
>> +
>> + =A0 =A0 hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), &cp);
>> +}
>> +
>> +static void le_scan_enable_req(struct hci_dev *hdev, unsigned long opt)
>> +{
>> + =A0 =A0 struct hci_cp_le_set_scan_enable cp;
>> +
>> + =A0 =A0 memset(&cp, 0, sizeof(cp));
>> + =A0 =A0 cp.enable =3D 1;
>> +
>> + =A0 =A0 hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp)=
;
>> +}
>> +
>> +static int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 u16 window, int timeout)
>> +{
>> + =A0 =A0 long timeo =3D msecs_to_jiffies(3000);
>> + =A0 =A0 struct le_scan_params param;
>> + =A0 =A0 int err;
>> +
>> + =A0 =A0 BT_DBG("%s", hdev->name);
>> +
>> + =A0 =A0 if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINPROGRESS;
>> +
>> + =A0 =A0 param.type =3D type;
>> + =A0 =A0 param.interval =3D interval;
>> + =A0 =A0 param.window =3D window;
>> +
>> + =A0 =A0 hci_req_lock(hdev);
>> +
>> + =A0 =A0 err =3D __hci_request(hdev, le_scan_param_req, (unsigned long)=
 &param,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeo);
>> + =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>> +
>> + =A0 =A0 err =3D __hci_request(hdev, le_scan_enable_req, 0, timeo);
>> + =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed;
>> +
>> + =A0 =A0 hci_req_unlock(hdev);
>
> in this specific case, it might be better to do it like this:
>
> =A0 =A0 =A0 =A0hci_req_lock();
>
> =A0 =A0 =A0 =A0err =3D __hci_request(hdev, ...)
> =A0 =A0 =A0 =A0if (!err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D __hci_request(hdev, ...)
>
> =A0 =A0 =A0 =A0hci_req_unlock()
>
> =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;

Ok, I'm gonna change this and send a new version of this series.

>> +
>> + =A0 =A0 schedule_delayed_work(&hdev->le_scan_disable,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 msecs_to_jiffies(timeout));
>> +
>> + =A0 =A0 return 0;
>> +
>> +failed:
>> + =A0 =A0 hci_req_unlock(hdev);
>> + =A0 =A0 return err;
>> +}
>> +
>> +static void le_scan_disable_work(struct work_struct *work)
>> +{
>> + =A0 =A0 struct hci_dev *hdev =3D container_of(work, struct hci_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 le_scan_disable.work);
>> + =A0 =A0 struct hci_cp_le_set_scan_enable cp;
>> +
>> + =A0 =A0 BT_DBG("%s", hdev->name);
>> +
>> + =A0 =A0 memset(&cp, 0, sizeof(cp));
>> +
>> + =A0 =A0 hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp)=
;
>> +}
>> +
>> =A0/* Register HCI device */
>> =A0int hci_register_dev(struct hci_dev *hdev)
>> =A0{
>> @@ -1658,6 +1735,8 @@ int hci_register_dev(struct hci_dev *hdev)
>>
>> =A0 =A0 =A0 atomic_set(&hdev->promisc, 0);
>>
>> + =A0 =A0 INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work=
);
>> +
>> =A0 =A0 =A0 write_unlock(&hci_dev_list_lock);
>>
>> =A0 =A0 =A0 hdev->workqueue =3D alloc_workqueue(hdev->name, WQ_HIGHPRI |=
 WQ_UNBOUND |
>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
>> index dd8056c..0bcfeca 100644
>> --- a/net/bluetooth/hci_event.c
>> +++ b/net/bluetooth/hci_event.c
>> @@ -1030,6 +1030,8 @@ static void hci_cc_le_set_scan_param(struct hci_de=
v *hdev, struct sk_buff *skb)
>> =A0 =A0 =A0 __u8 status =3D *((__u8 *) skb->data);
>>
>> =A0 =A0 =A0 BT_DBG("%s status 0x%x", hdev->name, status);
>> +
>> + =A0 =A0 hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_PARAM, status);
>> =A0}
>>
>> =A0static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>> @@ -1040,15 +1042,17 @@ static void hci_cc_le_set_scan_enable(struct hci=
_dev *hdev,
>>
>> =A0 =A0 =A0 BT_DBG("%s status 0x%x", hdev->name, status);
>>
>> - =A0 =A0 if (status)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> =A0 =A0 =A0 cp =3D hci_sent_cmd_data(hdev, HCI_OP_LE_SET_SCAN_ENABLE);
>> =A0 =A0 =A0 if (!cp)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> =A0 =A0 =A0 switch (cp->enable) {
>> =A0 =A0 =A0 case LE_SCANNING_ENABLED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 hci_req_complete(hdev, HCI_OP_LE_SET_SCAN_ENAB=
LE, status);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&hdev->adv_work);
>> @@ -1060,6 +1064,9 @@ static void hci_cc_le_set_scan_enable(struct hci_d=
ev *hdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> =A0 =A0 =A0 case LE_SCANNING_DISABLED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hci_dev_lock(hdev);
>
> Long term we can not spread hci_req_complete around. We need a more
> general solution. Please start working on that one and send a proposal.

Sure, I talked with Claudio and as soon as we finish pushing discovery
patches upstream I can work on a general solution for that.

BR,

Andre

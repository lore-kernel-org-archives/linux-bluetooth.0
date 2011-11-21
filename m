Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/6] Bluetooth: LE scan infra-structure
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1321683091.15441.626.camel@aeonflux>
Date: Mon, 21 Nov 2011 14:24:26 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <248D198B-63ED-493D-A285-666324080DA9@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org> <1321051824-5216-4-git-send-email-andre.guedes@openbossa.org> <1321053220.15441.411.camel@aeonflux> <944367C4-28CD-4EF2-8D4C-FF2FA1A734D5@openbossa.org> <1321683091.15441.626.camel@aeonflux>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Nov 19, 2011, at 3:11 AM, Marcel Holtmann wrote:

> Hi Andre,
>=20
>>>> This patch adds to hci_core the infra-structure to carry out the
>>>> LE scan. Functions were created to init the LE scan and cancel
>>>> an ongoing scanning (hci_do_le_scan and hci_cancel_le_scan).
>>>>=20
>>>> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
>>>> ---
>>>> include/net/bluetooth/hci_core.h |    5 +++
>>>> net/bluetooth/hci_core.c         |   69 =
++++++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 74 insertions(+), 0 deletions(-)
>>>>=20
>>>> diff --git a/include/net/bluetooth/hci_core.h =
b/include/net/bluetooth/hci_core.h
>>>> index f6d5d90..69dda9b 100644
>>>> --- a/include/net/bluetooth/hci_core.h
>>>> +++ b/include/net/bluetooth/hci_core.h
>>>> @@ -232,6 +232,8 @@ struct hci_dev {
>>>> 	struct list_head	adv_entries;
>>>> 	struct timer_list	adv_timer;
>>>>=20
>>>> +	struct timer_list	le_scan_timer;
>>>> +
>>>> 	struct hci_dev_stats	stat;
>>>>=20
>>>> 	struct sk_buff_head	driver_init;
>>>> @@ -987,5 +989,8 @@ void hci_le_ltk_neg_reply(struct hci_conn =
*conn);
>>>>=20
>>>> int hci_do_inquiry(struct hci_dev *hdev, u8 length);
>>>> int hci_cancel_inquiry(struct hci_dev *hdev);
>>>> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, =
u16 window,
>>>> +								int =
timeout);
>>>> +int hci_cancel_le_scan(struct hci_dev *hdev);
>>>>=20
>>>> #endif /* __HCI_CORE_H */
>>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>>> index 64cdafe..c07dc15 100644
>>>> --- a/net/bluetooth/hci_core.c
>>>> +++ b/net/bluetooth/hci_core.c
>>>> @@ -1423,6 +1423,23 @@ int hci_add_adv_entry(struct hci_dev *hdev,
>>>> 	return 0;
>>>> }
>>>>=20
>>>> +static int le_scan(struct hci_dev *hdev, u8 enable)
>>>> +{
>>>> +	struct hci_cp_le_set_scan_enable cp;
>>>> +
>>>> +	memset(&cp, 0, sizeof(cp));
>>>> +	cp.enable =3D enable;
>>>> +
>>>> +	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), =
&cp);
>>>> +}
>>>> +
>>>> +static void le_scan_timeout(unsigned long arg)
>>>> +{
>>>> +	struct hci_dev *hdev =3D (void *) arg;
>>>> +
>>>> +	le_scan(hdev, 0);
>>>> +}
>>>> +
>>>> /* Register HCI device */
>>>> int hci_register_dev(struct hci_dev *hdev)
>>>> {
>>>> @@ -1501,6 +1518,9 @@ int hci_register_dev(struct hci_dev *hdev)
>>>> 	setup_timer(&hdev->adv_timer, hci_clear_adv_cache,
>>>> 						(unsigned long) hdev);
>>>>=20
>>>> +	setup_timer(&hdev->le_scan_timer, le_scan_timeout,
>>>> +						(unsigned long) hdev);
>>>> +
>>>> 	INIT_WORK(&hdev->power_on, hci_power_on);
>>>> 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
>>>>=20
>>>> @@ -1587,6 +1607,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>>>> 	hci_del_sysfs(hdev);
>>>>=20
>>>> 	del_timer(&hdev->adv_timer);
>>>> +	del_timer(&hdev->le_scan_timer);
>>>>=20
>>>> 	destroy_workqueue(hdev->workqueue);
>>>>=20
>>>> @@ -2615,3 +2636,51 @@ int hci_cancel_inquiry(struct hci_dev *hdev)
>>>>=20
>>>> 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
>>>> }
>>>> +
>>>> +static int set_le_scan_param(struct hci_dev *hdev, u8 type, u16 =
interval,
>>>> +								u16 =
window)
>>>> +{
>>>> +	struct hci_cp_le_set_scan_param cp;
>>>> +
>>>> +	memset(&cp, 0, sizeof(cp));
>>>> +	cp.type =3D type;
>>>> +	cp.interval =3D cpu_to_le16(interval);
>>>> +	cp.window =3D cpu_to_le16(window);
>>>> +
>>>> +	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_PARAM, sizeof(cp), =
&cp);
>>>> +}
>>>> +
>>>> +int hci_do_le_scan(struct hci_dev *hdev, u8 type, u16 interval, =
u16 window,
>>>> +								int =
timeout)
>>>> +{
>>>> +	int err;
>>>> +
>>>> +	if (test_bit(HCI_LE_SCAN, &hdev->hci_flags))
>>>> +		return -EINPROGRESS;
>>>> +
>>>> +	BT_DBG("%s", hdev->name);
>>>> +
>>>> +	err =3D set_le_scan_param(hdev, type, interval, window);
>>>> +	if (err < 0)
>>>> +		return err;
>>>> +
>>>> +	err =3D le_scan(hdev, 1);
>>>> +	if (err < 0)
>>>> +		return err;
>>>=20
>>> since you are using hci_send_cmd, you never check the error from the
>>> controller for set_le_scan_param. We should be doing exactly that =
before
>>> just going ahead with a scan.
>>=20
>> Yes, you're right, there is no error checking at this point.
>>=20
>> I took some time thinking about this problem and I concluded we
>> should not bother so much about it (at least for now). The reasons
>> are:
>>=20
>> 1. The spec says the Set LE Scan Parameters command fails if it
>> is issued when LE scan is enabled. We guarantee this doesn't happen
>> since we check the HCI_LE_SCAN flag before sending any command to
>> the controller.
>>=20
>> 2. Even if the Set LE Scan Parameters command fails for some other
>> unknown reason, we would do the LE scanning with the last parameters
>> set. This doesn't seem to be a big deal.
>>=20
>> 3. We've done lots of tests (with different dongles), but I've not
>> seen this error happening so far. It seems to be difficult to
>> reproduce it.
>>=20
>> I also took some time thinking about a fix for that, but I didn't =
find
>> any easy/clean way to do it.=20
>>=20
>> So I think we should just log if the Set LE Scan Parameters command
>> fails and, if somehow, this becomes often we come up with a fix for =
it.
>=20
> so the proposed fix is to ignore the problem?
>=20
>>> It is also not guaranteed that the controller queues up these =
commands,
>>> it might just return busy from le_scan() if it can have more than =
one
>>> outstanding commands (which many controller can do).
>>=20
>> I didn't follow you here. We have a mechanism to keep track of how
>> many commands the host is allowed to send to the controller. The
>> tasklet hdev->cmd_task only issue a command if the controller is
>> able to handle it.
>=20
> Yes, we do handle that, but we do not handle the controllers radio
> resources. There is no requirement for a controller to queue the =
command
> internally. If it does not have radio resources or is still busy with
> the previous command, it can just return busy.

Ok, I got that. Then, I'll fix this and therefore the Set LE Scan
Parameters command failing case.

>=20
>> Besides, other parts of the code send more than one command in =
sequence
>> and it doesn't seem to be a problem (see set_fast_connectable() in
>> mgmt.c, hci_init_req() in hci_core.c and hci_setup() in hci_event.c).
>=20
> The fast connectable thing is a problem then as well. The init code
> works different here. That is done via hci_request in a context that =
can
> sleep.
>=20
>> But anyway, if the controller returns error from le_scan(), we do the
>> proper handling in hci_cc_le_set_scan_enable().
>=20
> That is not the point here. That is obviously required.
>=20
> Regards
>=20
> Marcel
>=20
>=20

BR,

Andre

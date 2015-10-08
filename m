Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20151008133820.GA20576@t440s.P-661HNU-F1>
References: <1444259885-29382-1-git-send-email-jpawlowski@google.com>
	<20151008133820.GA20576@t440s.P-661HNU-F1>
Date: Thu, 8 Oct 2015 11:54:49 -0700
Message-ID: <CAD0=r8xq9RRTu5yTgkA4TsVy+mE-oytM8dXiKjxDXgz-PO1jgg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: fix autoconnect for pending connect attempt
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan, Marcel

On Thu, Oct 8, 2015 at 6:38 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Oct 07, 2015, Jakub Pawlowski wrote:
>> When adding device to auto connect whitelist when there is pending
>> connect attempt, there is no need to update scan, or to add it to
>> pend_le_conns list.
>>
>> When trying to connect to le device, it is added to pend_le_conns and
>> background scan is updated. There's no need to repeat this operation when
>> adding device to auto connect list. Only update of params->auto_connect
>> value is required.
>>
>> If both operations try to update background scan, and are quickly queued
>> together when scan was disabled, second operation might improperly try to
>> start, instead of restarting scan. This means that adding device to
>> connect whitelist would report failure, even though it succeeded.
>>
>> In order to reproduce this bug type in bluetoothctl:
>> connect D9:00:00:00:00
>> disconnect D9:00:00:00:00
>> connect D9:00:00:00:00
>>
>> and observe bluetoothd logs (error happens during second connect attempt):
>> src/device.c:device_connect_le() Connection attempt to: D0:5F:B8:52:22:9F
>> Failed to add device D0:5F:B8:52:22:9F (1): Busy (0x0a)
>> ---
>>  net/bluetooth/mgmt.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Could you resend this with a proper signed-off-by line?
>
>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>> index ccaf5a4..c29b6dd 100644
>> --- a/net/bluetooth/mgmt.c
>> +++ b/net/bluetooth/mgmt.c
>> @@ -6122,7 +6122,12 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
>>               break;
>>       case HCI_AUTO_CONN_DIRECT:
>>       case HCI_AUTO_CONN_ALWAYS:
>> -             if (!is_connected(hdev, addr, addr_type)) {
>> +             /* If we are connected, don't add to whitelist. If we are
>> +              * connecting, we're already added to pend_le_conns and
>> +              * scanning.
>> +              */
>> +             if (!is_connected(hdev, addr, addr_type) &&
>> +                 params->auto_connect != HCI_AUTO_CONN_EXPLICIT) {
>>                       list_add(&params->action, &hdev->pend_le_conns);
>>                       __hci_update_background_scan(req);
>>               }
>
> Is it really only HCI_AUTO_CONN_EXPLICIT that we should care about? What
> if the previous value is HCI_AUTO_CONN_DIRECT and the new one
> HCI_AUTO_CONN_ALWAYS or vice versa, aren't we then also adding to the
> list twice?

we're never adding to list twice, there is
list_del_init(&params->action) before switch that removes it first.
list_add inside "if" is actually bug, should be before it, thanks for
pointing that.

This bug is not about adding to list multiple times. It's about
hci_update_background_scan being little bit "broken", it's more of
workaround than actually fix of real underlying issue. I'm trying to
find better solution.

Here's more info:
when you connect to device using random address from bluetoothd, it
opens socket, and also send MGMT_OP_ADD_DEVICE to add device to
whitelist.

Opening socket to random address device means it'll be added to
whitelist. Somewhere in the flow, it'll update background scan state.
That means CURRENT state of HCI_LE_SCAN will be checked, and
HCI_OP_LE_SET_SCAN_ENABLE will be scheduled, but NOT executed yet.

Then MGMT_OP_ADD_DEVICE is called. It also need to update background
state. It also checks CURRENT state of HCI_LE_SCAN, and schedule
HCI_OP_LE_SET_SCAN_ENABLE.

Now both scheduled HCI_OP_LE_SET_SCAN_ENABLE operations are executed.
And second of them fails, because it's trying to cal SET_SCAN_PARAMS
when scan is already enabled (we always have SET_SCAN_PARAMS before
SET_SCAN_ENABLE). Actually on some controllers it's fine to enable
'enabled' scan, and disable 'disabled' scan, and on other it cause
error.


So keeping __hci_update_background_scan inside this if is just a
workaround to make adding to whitelist just after calling connect work
properly. The proper solution would be to probably make
SET_SCAN_ENABLE check scan state during execution, or maybe keep info
that scan change is scheduled so that later scan updates know what
state they'll be working on. Any help and ideas are welcomed. I'm
willing to invest more time to fix that. Every time I make a change
that touches or modifies update_background_scan I must spend few hours
making sure nothing explodes. Would be nice to make it easier to
modify that code.




>
> Johan

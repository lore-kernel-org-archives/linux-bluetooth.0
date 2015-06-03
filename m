Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <837DB900-4EF4-4F3B-9C70-24868141DCDC@holtmann.org>
References: <CAD0=r8wrEw4zPxAxph1pGg3VGNxnQ8smh45qGn1YYbwmMQr8BQ@mail.gmail.com>
	<DEB8F453-F8E5-4DAD-AC7B-9303601173BA@holtmann.org>
	<CAD0=r8zOXHNxDogUCTUR=XW-Viv-AxE5YqTxQ2ZpRMMb-x5axw@mail.gmail.com>
	<837DB900-4EF4-4F3B-9C70-24868141DCDC@holtmann.org>
Date: Tue, 2 Jun 2015 18:47:13 -0700
Message-ID: <CAD0=r8xxJwCm-pcNueBAyVyyECQS8pn1OXq_jK=PAy0SanaVLw@mail.gmail.com>
Subject: Re: Unable to re-connect paired LE device after MAC rotation
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 1, 2015 at 8:58 PM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Jakub,
>
>>>> 1. Have iPhone and Linux machine running latest BlueZ on latest
>>>> kernel. iPhone have random mac "ABC".
>>>> 2. Connect from BlueZ to iPhone, pair with PIN. iPhone real mac
>>>> address "XXX" is being shown right now. I can connect to it form
>>>> bluetoothctl using "XXX"  address, btmon shows it's random mac address
>>>> "ABC" in connect request.
>>>>
>>>> 3. Restart bluetooth on iPhone. It's random mac is rotated to "BCD".
>>>> Try to connect from bluetoothctl using "XXX", btomon still shows old
>>>> mac address "ABC" in connect request, therefore it'll fail and will be
>>>> unable to connect.
>>>>
>>>> That's a bug is, right ? BlueZ should be smart, and for paired device
>>>> it should start a "Selective Connection Establishment Procedure"
>>>> instead of "Auto Connection Establishment Procedure", as described in
>>>> BT spec 4.2 [Vol 3, Part C] 9.3.7 .
>>>>
>>>>
>>>> If I now manually start discovery before calling connect BlueZ would
>>>> pick new iPhone address, "BCD" and use it for connection if I try to
>>>> connect to "XXX".
>>>>
>>>> Is that something that should be fixed ? If yes I'll spend some time o=
n it.
>>>
>>> I think the problem you see is that we call HCI LE Create Connection di=
rectly without doing a scan first. This has been long on the list that we s=
hould actually scan to find the device first and only then call HCI LE Crea=
te Connection.
>>
>> Should scan happen before connecting only for paired devices using RPA
>> ? Scanning for non-paired devices won't really do nothing good, right
>> ?
>
> it is required for devices using RPA. We can do a passive scan without th=
e whitelist in that case. For all other cases it makes no difference, but i=
t also doesn=E2=80=99t do any harm. Actually HCI LE Create Connection will =
scan as well. Most likely doing a passive scan and only trying to call HCI =
LE Create Connection when we actually saw the device gives us better latenc=
y when multiple LE connection attempt are requested at the same time. Right=
 now calling HCI LE Create Connection is a big hammer that will make any ot=
her connection attempt wait. Normally that is not problematic if the device=
 is in range and advertising. If it is not, then this might stall everybody=
 else.

So I played with that, and it looks like adding non paired device to
kernel whitelist through "MGMT_ADD_DEVICE" doesn't work, so I fixed
that only for paired devices, would probably require kernel changes to
make it also work for non-paired devices.

>
> Actually we already have the background scanning and connection logic. In=
 the end any connection attempt should just be temporarily added to that co=
nnection list. The existing code would do the right trick of utilising the =
whitelist when possible. So it might be as simple as converting the code pa=
th coming via L2CAP connect() into just using the same code path as the aut=
omatic connection handling.
>
>>> Check debugfs entries in /sys/kernel/debug/bluetooth/hci0 that the IRK =
list really lists the IRK and last known RPA of the iPhone. That makes sure=
 that we could resolve the address. And then try to scan first before tryin=
g to connect again. If that then does the trick and updates the known RPA o=
f the iPhone to the new one, then it is problem that we do not scan before =
calling connect.
>>
>> Scanning first before trying to connect fixes the problem. I'll try to f=
ix that.
>
> We should have fixed that a long time ago. Seems it just has been forgott=
en. Thanks for looking into that.
>
> Regards
>
> Marcel
>

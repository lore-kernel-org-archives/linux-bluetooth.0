Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100928081513.GA20800@jh-x301>
References: <AANLkTikrQ2fAHDZwMncOpNRadjm=tdobvDoas=v5eyxH@mail.gmail.com>
	<20100928081513.GA20800@jh-x301>
Date: Wed, 29 Sep 2010 17:39:22 +0300
Message-ID: <AANLkTi=tbFyN+a29SOGqwVtWHtsmqObhbA6=9bn1He9q@mail.gmail.com>
Subject: Re: Spurious authentication request?
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Sep 28, 2010 at 11:15 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Daniel,
>
> On Mon, Sep 27, 2010, Daniel Örstadius wrote:
>> Occasionally when pairing with a headset BlueZ issues what looks
>> to be an unnecessary "Authentication Requested" after
>> receiving "Auth Complete" and "Simple Pairing Complete".
>>
>> 2010-09-22 11:23:45.282348 > HCI Event: Auth Complete (0x06) plen 3
>>     status 0x00 handle 2
>> 2010-09-22 11:23:45.282378 < HCI Command: Set Connection Encryption
>> (0x01|0x0013) plen 3
>>     handle 2 encrypt 0x01
>> [..]
>> 2010-09-22 11:23:45.363646 < HCI Command: Authentication Requested
>> (0x01|0x0011) plen 2
>>     handle 2
>>
>> This request is coming from bonding_connect_cb and occurs if that
>> callback happens to be executed before the function
>> hcid_dbus_bonding_process_complete (triggered by the auth complete
>> event). The order between those functions might have been affected
>> by this patch
>>
>> http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=be35d00671519b8d92361c2caad9abeedda151f8
>>
>> The request for authentication seems to be used for legacy pairing and
>> should probably not be made for simple pairing. Also, it might be
>> inconsistent that the kernel issues "Authentication Requested" for
>> simple pairing, but bluetoothd does it for legacy?
>>
>> I guess enclosing the call in a check for legacy pairing would
>> work, if that information is or can be made available to
>> bluetoothd.
>>
>> Have I understood the situation correctly and if so, what would
>> be a good way to fix this issue?
>
> The reason why the extra authentication request is there is to deal with
> old kernels that do not initiate authentication by themselves. So
> checking for SSP vs legacy pairing wouldn't work.
>

Ok, thanks.

In newer kernels the auth req seems to be triggered in
hci_event.c/hci_remote_features_evt() only if both sides support SSP.
For legacy pairing it's up to bluetoothd to request authentication.

Because of that, there is an unnecessary "auth req" from bluetoothd in 2.1
pairing if bonding_connect_cb gets called before device_bonding_complete.
The latter function clears the bonding_req in btd_device, causing the former
to return directly.

I think this is the relation between HCI events and those functions in
bluetoothd: [*]

auth complete evt => device_bonding_complete
encrypt change evt => bonding_connect_cb

"auth complete" occurs before "encrypt change", but its corresponding
function doesn't always get called first (maybe because of the low priority
on the raw HCI socket watch in security.c).

As you mentioned offline it might work to query the kernel to find out if
the device is authenticated. I don't know what should be considered to
be the root cause of the issue.

/Daniel

[*] From looking at the sources, the kernel seems respond to the "auth
complete" event with a request for encryption. Could be that
bonding_connect_cb in bluetoothd gets called when the kernel receives
the "encrypt change" event (since the socket state goes to
BT_CONNECTED at that point and bluetoothd is watching the socket for
G_IO_OUT via glib).

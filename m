Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1281445643.12579.210.camel@localhost.localdomain>
References: <1281443393-31160-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1281445643.12579.210.camel@localhost.localdomain>
Date: Tue, 10 Aug 2010 16:53:36 +0300
Message-ID: <AANLkTikB39NLcaaUGw60s-4N8keE9xdjiJ0ETyVW_vXR@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: new sockopt to enter active state when sending
	data
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 10, 2010 at 4:07 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andrei,
>
>> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>>
>> Patch adds new socket option to enter active state when sending
>> data. Modified version of Fabien Chevalier patch (Sep/2008).
>> Discussions:
>> http://www.spinics.net/lists/bluez-devel/msg00567.html
>> http://www.spinics.net/lists/linux-bluetooth/msg03765.html
>>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>> =A0include/net/bluetooth/hci_core.h | =A0 =A01 +
>> =A0include/net/bluetooth/l2cap.h =A0 =A0| =A0 =A01 +
>> =A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 | =A0 =A07 ++++++-
>> =A0net/bluetooth/l2cap.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A04 files changed, 11 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index e42f6ed..477a492 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -178,6 +178,7 @@ struct hci_conn {
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 auth_type;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 sec_level;
>> =A0 =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 power_save;
>> + =A0 =A0 __u8 =A0 =A0 =A0 =A0 =A0 =A0 force_active;
>> =A0 =A0 =A0 __u16 =A0 =A0 =A0 =A0 =A0 =A0disc_timeout;
>> =A0 =A0 =A0 unsigned long =A0 =A0pend;
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap=
.h
>> index 7c695bf..0a8ac4c 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -57,6 +57,7 @@ struct l2cap_options {
>> =A0 =A0 =A0 __u8 =A0mode;
>> =A0 =A0 =A0 __u8 =A0fcs;
>> =A0 =A0 =A0 __u8 =A0max_tx;
>> + =A0 =A0 __u8 =A0force_active;
>> =A0 =A0 =A0 __u16 txwin_size;
>> =A0};
>
> this is a clear NAK. You are breaking API and ABI compatibility with
> this change.
>
> Also don't overload the l2cap_options, create a new one.

I have sent new patch. Are other comments from 2008 patch still valid?

Like using SOL_BLUETOOTH and make sockopt for RFCOMM as well.

Regards,
Andrei

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100811132757.GC13302@jh-x301>
References: <1281530667-25379-1-git-send-email-luiz.dentz@gmail.com>
	<1281530667-25379-2-git-send-email-luiz.dentz@gmail.com>
	<20100811132757.GC13302@jh-x301>
Date: Wed, 11 Aug 2010 16:43:03 +0300
Message-ID: <AANLkTi=6GQv4qN0VUnvY-qcJptcWeHcrs7WPN+CS675H@mail.gmail.com>
Subject: Re: [PATCH 2/2] Fix not unmarking temporary flag when a new key is
	created
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 11, 2010 at 4:27 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Wed, Aug 11, 2010, Luiz Augusto von Dentz wrote:
>> --- a/src/dbus-hci.c
>> +++ b/src/dbus-hci.c
>> @@ -746,8 +746,8 @@ int hcid_dbus_link_key_notify(bdaddr_t *local, bdaddr_t *peer,
>>       else if (!bonding && old_key_type == 0xff)
>>               hcid_dbus_bonding_process_complete(local, peer, 0);
>>
>> -     if (temporary)
>> -             device_set_temporary(device, TRUE);
>> +     if (device_is_temporary(device) != temporary)
>> +             device_set_temporary(device, temporary);
>>
>>       return 0;
>
> I'd prefer if you just call device_set_temporary(device, temporary)
> directly. That'd save you the if-check and a call to device_is_temporary.

Fair enough, I will change it and send a new patch in a few minutes.

-- 
Luiz Augusto von Dentz
Computer Engineer

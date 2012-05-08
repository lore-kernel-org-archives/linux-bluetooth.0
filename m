Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336488880.5970.149.camel@aeonflux>
References: <1336483706-1533-1-git-send-email-dh.herrmann@googlemail.com>
	<1336483706-1533-3-git-send-email-dh.herrmann@googlemail.com>
	<CAA37ikZW1H1zfPr8d5uonpY0SEZk=dbDQ+XsYhOytXg4ExuLAA@mail.gmail.com>
	<1336488880.5970.149.camel@aeonflux>
Date: Tue, 8 May 2012 15:11:01 -0300
Message-ID: <CAA37ikaTN=jyf4NfVvLp0SmfPSmCvAodt-DEro+RB=y+g8sFyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Remove batostr()
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-bluetooth@vger.kernel.org,
	gustavo@padovan.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, May 8, 2012 at 11:54 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Ulisses,
>
>> > batostr() is not used anywhere and I don't see any reason why we shoul=
d
>> > keep it. Use ba2str() instead.
>> >
>> > Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>> > ---
>> > =A0include/net/bluetooth/bluetooth.h | =A0 =A01 -
>> > =A0net/bluetooth/lib.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 14 ----------=
----
>> > =A02 files changed, 15 deletions(-)
>>
>> The patchset looks good to me. I'm also not sure we need another
>> specifier for snprintf().
>>
>> Given we had static buffers instead of allocating them in the stack
>> every time it'd be good to hear from Marcel if we had a reason and if
>> it's still valid. IMO we don't have problems with stack usage in our
>> code paths now but I haven't actually checked it.
>
> that code is most likely 11+ years old. It is actually not from me. So
> if you wanna know why, you need to track down Max.
>
> Using %pM and baswap seems to be the best approach for fixing this right
> now. However I am not against introducing a snprintf modifier for
> Bluetooth addresses.

I see. Ok, makes sense. David or Andrei? Will any of you guys send a patch?

Regards,

--=20
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

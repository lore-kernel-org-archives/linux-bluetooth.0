Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319457038.15441.230.camel@aeonflux>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<CAE6HaMkxvTPa1eTj1Og7Lvqn=PvieuKJyzugPouwiUTOsnnW_g@mail.gmail.com>
	<1319457038.15441.230.camel@aeonflux>
Date: Mon, 24 Oct 2011 14:06:37 +0200
Message-ID: <CAE6HaM=m40hr76CWirfEjnou_DfGswEjqrN_8F0if-XR8oFE5g@mail.gmail.com>
Subject: Re: [PATCH bluez] add get_le/get_be helpers
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Oct 24, 2011 at 1:50 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Vinicius,
>
>> Sorry if this comes too late, but here's an idea:
>>
>> How about changing the name of the functions to something a little
>> more high level, for example: in attrib/att.h we have
>> att_{get,put}_u16() that uses the byte order defined in the ATT spec
>> (little endian).
>>
>> So my suggestion is to have bt_{get,put}_u*() and sdp_{get,put}_u*
>> functions (perhaps also no_{get,put}_u* for cases when we use the host
>> byte order). The bt_ functions will be used for everything that uses
>> the Bluetooth byte order and the sdp_ ones for SDP, which is the only
>> case of Big Endian defined by Bluetooth, correct me if I am wrong.
>
> lets not try to be too smart. We want the code clearly identify what
> endian is expected. Same as the kernel handles this.
>

After reading Szymon comments I came to the same conclusion. This more
explicit approach makes more sense.


> Regards
>
> Marcel
>
>
>


Cheers,
-- 
Vinicius

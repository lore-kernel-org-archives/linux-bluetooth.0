Return-Path: <cyrus@holtmann.org>
Sender: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <cr@cristianrodriguez.net>
Message-ID: <50D8A8B6.6040600@opensuse.org>
Date: Mon, 24 Dec 2012 16:10:46 -0300
From: =?UTF-8?B?Q3Jpc3RpYW4gUm9kcsOtZ3Vleg==?= <crrodriguez@opensuse.org>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] lib: use %m instead of strerror
References: <1356362730-16557-1-git-send-email-crrodriguez@opensuse.org> <1356369208.29264.46.camel@aeonflux>
In-Reply-To: <1356369208.29264.46.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon 24 Dec 2012 02:13:28 PM CLST, Marcel Holtmann wrote:
> Hi Cristian,
>
>> Unlike strerror, %m is thread safe and we do not know
>> to what kind of program libbluetooh is being linked too.
>> ---
>>   lib/sdp.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> patch has been applied.
>
> Regards
>
> Marcel
>
>
OK, just FYI, just checked the source code.. uclibc has to be built 
with UCLIBC_HAS_PRINTF_M_SPEC=y and will be fine.

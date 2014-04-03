Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_7+YZ=nOKxgCkg6Ok85610yTEr307qWyTubDh32cJgEmgsOQ@mail.gmail.com>
References: <1396518234-8375-1-git-send-email-marcin.kraglak@tieto.com>
	<CAJdJm_P+OjFYyggY4g_TTZJ7V1H7a46k45KntCZxnTwFRCE4ZA@mail.gmail.com>
	<CAN_7+YZ=nOKxgCkg6Ok85610yTEr307qWyTubDh32cJgEmgsOQ@mail.gmail.com>
Date: Thu, 3 Apr 2014 16:16:33 -0400
Message-ID: <CAJdJm_P2VQwB+N1-Ew8j4K27Absfi6BTBHJBKznkkBWwkpU5zA@mail.gmail.com>
Subject: Re: [RFC] gatt: Add API for creating services
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz

On Thu, Apr 3, 2014 at 4:07 PM, Lukasz Rymanowski
<lukasz.rymanowski@gmail.com> wrote:
> Indeed the only common thing is attribute database as I mention in
> offline email.
> And we are perfectly fine to have this in src/shared/gatt-db.c
> We started in src/gatt.c as this fine anyway contains now only db.
>
> However, I think that bdt_attribure fits us and we want to use it in gatt-db,
> but user of the gatt-db would be use only handle as proposed by Marcin.

Indeed, moving the GATT DB to src/shared will also mean having a
struct similar to btd_attribute there (but in my RFC it will be
internal as the API will only deal with handles).

> Actually, also ATT encoding and decoding could be common part.

I can't find ATT decoding/encoding on the Android HAL headers. Are you
sure this is not handled internally by Android HAL?

>> - implement proper database "defragmentation".
>
> Since Android does not have way to handle it, we will leave it for future work.

IMHO this needs at least to be detected and return a proper error.

>> - How attribute permissions are handled?
>>
> What do you mean?

As I said on the other reply, I could not understand how the
"permissions" parameters should be used in Android. Once you figure
out how to use them, we need to make a generic way to also handle
permissions on Linux. For now I'll just ignore it on the RFC code.

Best Regards,
-- 
Anderson Lizardo
http://www.indt.org/?lang=en
INdT - Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <C4C119D8-6EEA-405E-A6DE-D88A7F471CD9@holtmann.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org>
	<1405718037-15401-2-git-send-email-armansito@chromium.org>
	<2774A89A-B2EE-4346-BAD1-DBA0E3014661@holtmann.org>
	<CAHrH25TprAhCBBOUJZrwDPpttuxXE=+QMBnKL9WpsR_h3g70QQ@mail.gmail.com>
	<C4C119D8-6EEA-405E-A6DE-D88A7F471CD9@holtmann.org>
Date: Wed, 23 Jul 2014 15:54:26 -0700
Message-ID: <CAHrH25R3RAiwHU-PN=DVa-65wWTV807Tz2m0WyfOUH5VSbBC7w@mail.gmail.com>
Subject: Re: [PATCH 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> I am feeling uneasy about doing it this way. Can we try to start with jus=
t using a uint8 for the ATT error and see how far that gets us. I have bad =
experience with overloading values from standards and binary protocols with=
 our own. And I know range wise this is safe (at least at the moment).
>
> Or for that case we have an extra parameter indicating the success or fai=
lure of a verified write. It might be better to make it procedure specific =
instead of generalizing it.
>
> We do not have to do it all at once. This is why I think we should start =
just reporting the ATT errors and see how far that gets us. So we learn whi=
ch are the cases that will actually need special handling.
>
> For the cases of protocol errors, there is not much point in telling the =
higher layers about the exact violation. If it happens, you are in trouble.=
 Nothing you do will fix it.
>

Now that I look at it, there are 4 errors that I have defined:
  - UNKNOWN, which is only returned when a malloc fails in a call to
bt_att_send.
  - INVALID_RSP, returned when the server sends a malformed PDU
  - FAILED_ALLOC, returned when a malloc fails in bt_gatt routines/subrouti=
nes
  - RELIABLE_WRITE, returned when the reliable write verification fails

The first 3 of these have no good way of recovering from other than
killing the connection or crashing/exiting and the last one applies to
only one specific GATT procedure. So I'll go with your suggestion
here. All existing callback functions will accept a "bool success" and
a "uint8_t att_ecode" parameter. If att_ecode is 0 but success is
false, then one of the first 3 conditions above happened. For reliable
writes I'll add a new callback which also takes in a "bool
reliable_verified", that if false, indicates that the write failed
because it couldn't be verified.

The other case that I can think of is the signed write, for which we
can have a specific callback as well.

Sound good?


>> I think so. I like to keep these procedures more or less inline with
>> what is defined in the core spec. The distinction between these is
>> simple enough that the upper layer can correctly determine which one
>> to use as needed.
>
> We can do that of course, but for me the questions is always if it gets r=
eally used that way. Will any code really make the distinction and care abo=
ut it. If not, then this is just bloat that makes the higher layers work fo=
r something they should not.
>

I see value in having these separate routines. I will keep them for
now, but I'd be happy to remove/revise them later if unifying them
turns out to be better as the whole thing starts getting clearer as I
work on it.

Cheers,
Arman

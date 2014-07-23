Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 01/11] shared/gatt: Introduce gatt-helpers.h skeleton.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25R3RAiwHU-PN=DVa-65wWTV807Tz2m0WyfOUH5VSbBC7w@mail.gmail.com>
Date: Thu, 24 Jul 2014 01:00:42 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <9A86525A-DA3F-4113-AEBA-F27A7630F16B@holtmann.org>
References: <1405718037-15401-1-git-send-email-armansito@chromium.org> <1405718037-15401-2-git-send-email-armansito@chromium.org> <2774A89A-B2EE-4346-BAD1-DBA0E3014661@holtmann.org> <CAHrH25TprAhCBBOUJZrwDPpttuxXE=+QMBnKL9WpsR_h3g70QQ@mail.gmail.com> <C4C119D8-6EEA-405E-A6DE-D88A7F471CD9@holtmann.org> <CAHrH25R3RAiwHU-PN=DVa-65wWTV807Tz2m0WyfOUH5VSbBC7w@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> I am feeling uneasy about doing it this way. Can we try to start with just using a uint8 for the ATT error and see how far that gets us. I have bad experience with overloading values from standards and binary protocols with our own. And I know range wise this is safe (at least at the moment).
>> 
>> Or for that case we have an extra parameter indicating the success or failure of a verified write. It might be better to make it procedure specific instead of generalizing it.
>> 
>> We do not have to do it all at once. This is why I think we should start just reporting the ATT errors and see how far that gets us. So we learn which are the cases that will actually need special handling.
>> 
>> For the cases of protocol errors, there is not much point in telling the higher layers about the exact violation. If it happens, you are in trouble. Nothing you do will fix it.
>> 
> 
> Now that I look at it, there are 4 errors that I have defined:
>  - UNKNOWN, which is only returned when a malloc fails in a call to
> bt_att_send.
>  - INVALID_RSP, returned when the server sends a malformed PDU
>  - FAILED_ALLOC, returned when a malloc fails in bt_gatt routines/subroutines
>  - RELIABLE_WRITE, returned when the reliable write verification fails
> 
> The first 3 of these have no good way of recovering from other than
> killing the connection or crashing/exiting and the last one applies to
> only one specific GATT procedure. So I'll go with your suggestion
> here. All existing callback functions will accept a "bool success" and
> a "uint8_t att_ecode" parameter. If att_ecode is 0 but success is
> false, then one of the first 3 conditions above happened. For reliable
> writes I'll add a new callback which also takes in a "bool
> reliable_verified", that if false, indicates that the write failed
> because it couldn't be verified.
> 
> The other case that I can think of is the signed write, for which we
> can have a specific callback as well.
> 
> Sound good?

sounds good to me. Please go ahead with it.

>>> I think so. I like to keep these procedures more or less inline with
>>> what is defined in the core spec. The distinction between these is
>>> simple enough that the upper layer can correctly determine which one
>>> to use as needed.
>> 
>> We can do that of course, but for me the questions is always if it gets really used that way. Will any code really make the distinction and care about it. If not, then this is just bloat that makes the higher layers work for something they should not.
>> 
> 
> I see value in having these separate routines. I will keep them for
> now, but I'd be happy to remove/revise them later if unifying them
> turns out to be better as the whole thing starts getting clearer as I
> work on it.

Fair enough.

Regards

Marcel


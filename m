Return-Path: <cyrus@holtmann.org>
References: <1378449817-575-1-git-send-email-djcb.bulk@gmail.com> <52E3B66B-DC7A-4225-8779-8C1E9B0FC15E@holtmann.org>
From: Dirk-Jan C. Binnema <djcb.bulk@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth\@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] build: use -lrt for clock_gettime on glibc < 2.17
In-reply-to: <52E3B66B-DC7A-4225-8779-8C1E9B0FC15E@holtmann.org>
Date: Fri, 06 Sep 2013 11:07:02 +0300
Message-ID: <87mwnqnzkp.fsf@djcbsoftware.nl>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

marcel@holtmann.org writes:

> Hi Dirk-Jan,,
>
>> glibc before 2.17 (e.g., fedora 18) requires -lrt for clock_gettime.
>> AC_SEARCH_LIBS adds it to LIBS in that case
>> ---
>> configure.ac | 1 +
>> 1 file changed, 1 insertion(+)
>> 
>> diff --git a/configure.ac b/configure.ac
>> index 050d30d..403e323 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -40,6 +40,7 @@ AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
>> AC_CHECK_FUNC(signalfd, dummy=yes,
>> 			AC_MSG_ERROR(signalfd support is required))
>> 
>> +AC_SEARCH_LIBS(clock_gettime,rt)
>
> I do like this since this now it links everything with -lrt even if it is not needed.

Hmm, I suppose there's a missing 'not'...

Note, AC_SEARCH_LIBS tries without rt first, and only adds -lrt if
clock_gettime is not defined without it.

Or did you mean building parts of bluez without -lrt in the glibc < 2.17
case? If so, please see my next patch, which only uses -lrt (if needed)
for bluetoothd.

Cheers,
Dirk.


-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C

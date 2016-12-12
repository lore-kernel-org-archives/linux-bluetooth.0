Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMet0ipdif=_16Wm=C=dS2mWPiCTjBRY3sFXUrEcVQkdtdodtQ@mail.gmail.com>
References: <CAMet0ipdif=_16Wm=C=dS2mWPiCTjBRY3sFXUrEcVQkdtdodtQ@mail.gmail.com>
From: Szymon Janc <szymon.janc@codecoup.pl>
Date: Mon, 12 Dec 2016 22:12:32 +0100
Message-ID: <CAAEJBh+Pnk35tX4iULbL_fcY9XA7A7t-sWhKRg=fQHY-rxrmrw@mail.gmail.com>
Subject: Re: regular vs android versions, avdtptest
To: Kalervo Kontola <kontolabt@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kalervo,

On 12 December 2016 at 19:35, Kalervo Kontola <kontolabt@gmail.com> wrote:
>
> Hi all,
>
> avdtptest was created via:
> https://01.org/jira/browse/BA-113
> Thus avdtptest.c is in android directory.
>
> Is there any recommended way to use avdtptest with regular version?
> I mean that if using the one created in android directory then it
> depends on bluez/android specific files and those are not exactly the
> same files that are in profiles/audio directory, e.g., avdtp.c and
> avdtp.h.

You can build that by passing --enable-android to configure. avdtptest won't be
installable (by make install) but you should be able to run it from source tree.
But note that you still be using avdtp from android build.

> Also, is there any list showing main differences between those android
> and regular versions (especially from audio point of view)?
> and which of those deltas are android specific ones?

android/avdtp.c is based on code from profile/audio but it was redesigned to be
reusable as a library. It doesn't have any bluetoothd nor L2CAP dependencies
and it is instantiated on (any) connected file descriptor. This lib is
quite well tested
(including unit tests based on BT test specification in unit/ folder,
those are using
local sockets pair) but it is not the same code as in profiles/audio.

> (I noticed that there are some plans (good!) to unify code between
> android and regular versions.)

There are but as always we are lacking time. Ideally android/avdtp.c should be
moved to profile/audio/ and use there too. So that it is shared
between linux and
android daemons.

>
> Thanks!
> Kalervo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
pozdrawiam
Szymon K. Janc

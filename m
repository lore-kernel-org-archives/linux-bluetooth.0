Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Kalervo Kontola <kontolabt@gmail.com>
Date: Mon, 12 Dec 2016 20:35:38 +0200
Message-ID: <CAMet0ipdif=_16Wm=C=dS2mWPiCTjBRY3sFXUrEcVQkdtdodtQ@mail.gmail.com>
Subject: regular vs android versions, avdtptest
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

avdtptest was created via:
https://01.org/jira/browse/BA-113
Thus avdtptest.c is in android directory.

Is there any recommended way to use avdtptest with regular version?
I mean that if using the one created in android directory then it
depends on bluez/android specific files and those are not exactly the
same files that are in profiles/audio directory, e.g., avdtp.c and
avdtp.h.

Also, is there any list showing main differences between those android
and regular versions (especially from audio point of view)?
and which of those deltas are android specific ones?
(I noticed that there are some plans (good!) to unify code between
android and regular versions.)

Thanks!
Kalervo

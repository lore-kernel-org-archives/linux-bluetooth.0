Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] OPP regression or PTS issues
Date: Thu, 17 Apr 2014 10:56:21 +0200
Message-Id: <1397724982-9238-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There were some major changes between PTS 5.0 and 5.1 for OPP. Some PICS were
added as well as some tests cases. While doing the regression tests I came
across some regression however some of those looks to me like PTS issue; vide:
vcf extension not being recognized.
Would be good to get developers insight into this matter.

Sebastian Chlad (1):
  android/pts: Re-run OPP PTS 5.1 test

 android/pts-opp.txt | 116 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 44 deletions(-)

-- 
1.8.5.3


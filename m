Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCHv3 BlueZ 0/5] plugin/sixaxis: Set leds using the sysfs leds class
Date: Tue, 27 May 2014 13:25:13 +0200
Message-Id: <1401189915-2092-1-git-send-email-ao2@ao2.it>
In-Reply-To: <1400103605-25183-1-git-send-email-ao2@ao2.it>
References: <1400103605-25183-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

here's the updated patch series.

Fixes to get_js_numbers() are coming later.

Thanks,
   Antonio


Antonio Ospite (2):
  plugins/sixaxis: Add a get_leds_data() function
  plugins/sixaxis: Add a set_leds_sysfs() function

 configure.ac      |   4 +-
 plugins/sixaxis.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 123 insertions(+), 13 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

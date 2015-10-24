Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>,
	Jukka Rissanen <jukka.rissanen@linux.intel.com>
Subject: [RFC bluetooth-next 0/2] bluetooth: 6lowpan: suggestions for Jukka
Date: Sat, 24 Oct 2015 16:50:54 +0200
Message-Id: <1445698256-10407-1-git-send-email-alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this patch series is compile checked only and is a suggestion for Jukka which
has currently some issues with 6lowpan. These issues are page faults and I
suppose something is wrong with the memory management of the skbs.

Jukka, I also add several TODOs, take the patches and take a closer look into
that. Thanks. I mainly copied the parsing mechanism for dispatches from
802.15.4 6LoWPAN.

I hope these patches will solve your issues. If you have questions then simple
ask.

Compile tested only because I still have no btle dongle, but I think there
exists also some simulator, or? :-)

- Alex

Cc: Jukka Rissanen <jukka.rissanen@linux.intel.com>

Alexander Aring (2):
  bluetooth: 6lowpan: avoid endless loop
  bluetooth: 6lowpan: rework receive handling

 net/bluetooth/6lowpan.c | 161 +++++++++++++++++++++++++++++-------------------
 1 file changed, 96 insertions(+), 65 deletions(-)

-- 
2.6.1


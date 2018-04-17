Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Philipp Haselwarter <philipp@haselwarter.org>
To: linux-bluetooth@vger.kernel.org
Subject: Low latency options for Bluetooth?
Message-ID: <87wox5di3k.fsf@mure.haselwarter.org>
Date: Tue, 17 Apr 2018 17:54:07 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Legacy bluetooth codecs have a latency of ~200 ms or more, which creates
a noticeable lag when watching videos or during voice calls.

The AptX Low Latency (LL) codec can provide a stable connection with at
most 40 ms of latency.

- Is there a way to get AptX LL to work on Linux?
- Are there alternatives for a low latency Bluetooth connection?

PS: I hope this is a legitimate place for this question; I couldn't find
a bluez-user mailing list.

Cheers,
-- 
Philipp G. Haselwarter

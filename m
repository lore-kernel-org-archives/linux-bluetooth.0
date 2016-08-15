Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jason Anderssen <j@keyinitiative.com>
Content-Type: text/plain; charset=utf-8
Subject: Multiple frames from BLE device
Message-Id: <47472352-6857-4BAB-9A34-A417D8F64985@keyinitiative.com>
Date: Mon, 15 Aug 2016 16:49:33 +1000
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Getting into this bluez programming, I have a BLE beacon that transmits 3 different frames, however, when I use very similar code from hcitool.c :

while(select(descriptor) ) {
…
…
…
	int len = read(descriptor);
..
…
…
}

It always gets a single frame from the beacon, I never see the 3 different frames, after I reset the parameters to start the scan again, I may see a different frame for a little while, then I might see another frame for a little while.
I suspect the underlying code is only accepting one advertisement per cycle, and then ignoring all subsequent advertisements from the same MAC address ? (just a guess)

So my question is, what is the correct way to get multiple advertisements from the same beacon, if my assumption above is correct ?
I have been studying the bluez tools code to try and work around it, but thought I would cut to the chase and get some professional advice from the guru’s on this list :-)

Thanks again for you help in advance.

Cheers
Jason






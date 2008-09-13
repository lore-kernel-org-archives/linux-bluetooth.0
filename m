Return-Path: <cyrus@holtmann.org>
Subject: Input pairing broken again
From: David Woodhouse <dwmw2@infradead.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain
Date: Fri, 12 Sep 2008 17:21:50 -0700
Message-Id: <1221265310.10249.10.camel@macbook.infradead.org>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using the wizard to pair with my Anycom BTM-100 mouse is broken by
commit 58d8ea3c (Make discovery service routine to search for driver
uuids.)

I think the pairing actually works OK, but it takes so long that the
wizard times out, and doesn't bother to connect the new input device.
Looking at the dump at http://david.woodhou.se/btmouse-fail.dump it
seems to be taking about 30 seconds.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation


Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jason Anderssen <j@keyinitiative.com>
Content-Type: text/plain; charset=us-ascii
Subject: LE RSSI value
Message-Id: <5E15B113-2E5C-46FF-8112-EE7E10977BD6@keyinitiative.com>
Date: Tue, 16 Aug 2016 11:30:41 +1000
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have been writing a BLE scanner following hcittool.c as a basis, however, getting the RSSI value does not seem as straight forward.
I have worked out that I need to run btmon in the background, and then use hcitool with lescan option to get the RSSI from the btmon output.
While I wait for an expertise answer from this mail group, I will continue debugging the btmon to hopefully work out how to get this value for a advertising beacon, but hope that someone on this list may give me the ultimate solution.

Basically I would simply like to get the RSSI when I receive a advertisement, any direction or code samples would be much appreciated.

Cheers and thanks in advance for you help.
Jason Anderssen
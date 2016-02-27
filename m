Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Chris Jackson <chris@cd-jackson.com>
Content-Type: text/plain; charset=utf-8
Subject: Receiving BLE advertisements over DBus
Message-Id: <CD162F8F-68B5-42BD-AC1B-76DC1E1B80AE@cd-jackson.com>
Date: Sat, 27 Feb 2016 00:08:15 +0000
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Is it possible to receive BLE advertisements over the DBus interface - if so, how?

I suspect that the answer is that it’s not currently possible - is there any plans to add such support?  It seems that this is something that is becoming more necessary as the number of devices sending data in the discovery packet increases…

Any information on this would be appreciated - if necessary I’d be happy to look at implementing something if the BlueZ architects can comment on a recommended approach.

Thanks
Chris
Return-Path: <cyrus@holtmann.org>
From: Adam Warski <adam@warski.org>
Content-Type: text/plain; charset=windows-1252
Subject: Discovering LE advertisements programatically
Message-Id: <41458C64-3510-481A-92F4-1296C06600CC@warski.org>
Date: Fri, 24 Jan 2014 15:15:36 +0100
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I’m trying to find a good way to discover and retrieve LE advertisements programatically.

My first shot was to try to use DBus. I was trying to extend what the test/test-discovery script is doing, but it seems using DBus I can only get notified of new devices being discovered. Is there a way to get the actual LE advertisement via DBus? The device properties seem not to contain the info from the advertisement PDU.

If that’s not possible using DBus, is the way to go just using C?

I also tried using command line, a combination of “hcitool lescan” and “hcidump”/“hcidump -R" gives what I need more or less (plain hcidump gives me the RSSI, hcidump -R gives me the raw packet that I need). Still, I guess there must be a better way.

Thanks,
Adam  

-- 
Adam Warski

http://twitter.com/#!/adamwarski
http://www.softwaremill.com
http://www.warski.org
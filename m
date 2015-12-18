Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: ARM SBC as a BLE Peripheral
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <1450426763-17753-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 18 Dec 2015 08:21:44 -0800
Message-Id: <38CECA18-9BB8-4480-BA0F-027B87AB7A85@gmail.com>
References: <1450426763-17753-1-git-send-email-gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I hope this question isn’t completely out of order here… I’ve been lurking for a week or so, and it seems the list is mostly patch submission/discussion.

I’m working with a small Linux ARM SBC (similar to a Raspberry Pi), trying to set it up as a BLE peripheral. I’m running Debian Jessie, and build 5.36 of the bluez stack.

I’m relatively new to the bluez stack. I’ve been able to follow some SO posts and such to poke a couple of hciconfig commands to get my device advertising so that I can scan it with a phone app, and even changed its advertised name by tweaking one of the bluetoothd .conf files. But getting past that, I’m not sure really where to go. I want to set up a single service and characteristic with notify/write so that I can communicate with it via my phone app.

I *think* I’ve discerned that there may be 3 different ways I could do this?

1) Just use the hcitool/hciconfig command line tools. Work out all the hairy details of the various HCI command bytes, and write a script or something that just calls these command line tools. Not sure how I would be notified when a characteristic had been updated.

2) There’s a C library. So write a C program that cross compiles for the ARM, including the ARM headers for the bluez stuff. I have not seen a rigorous reference document for these APIs. I’m assuming it’s “use the source Luke”.

3) There’s a dbus interface. I appear to have dbus running on my device. But I have zero experience with interfacing with dbus, and I have yet to find any overview of what the bluez-dbus protocols look like. Would this be more general to weld a python3 script to though?

I get that I’ve got some learning to do, I’m looking for some guidance on which of the 3 above to bite off. I’d hate to spend a bunch of time figuring out #2 and then get told “oh, that’s the old way of doing it, you should have gone the other route.”

I would be indebted for any code samples or for any general approach examples. Even if its just a link that my google skills did not find. If there are guns-for-hire lurking here, I’d probably be even to scrape together some cash to pay someone to help us bootstrap our efforts here.

My BLE experience to date involves getting to know the iOS APIs, and having worked with the STMicro BlueNRGs ACI interface in a very embedded form.

Again, sorry if this is the wrong list, if there is a better place to seek for some guidance, please let me know.

Thanks In Advance



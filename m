Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Could example-gatt-server and example-advertisement be folded into one?
Message-Id: <5B92EB78-6761-4617-9186-CC5040532A91@gmail.com>
Date: Fri, 15 Jan 2016 17:10:34 -0800
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Subject mostly asks it all. I’m not asking whether the bluez distributed examples could be folded into one.

I have been able able to build a working BLE interface to my Linux SBC using python to operate as a peripheral. I worked from these two files. Is there any reason I couldn’t weld the two files together into one? Or do they need to be run as two separate processes with two separate mainloops?

I’m really hoping to get any answer, my last few questions went unanswered (which happens), but I’ve begun to wonder if my emails are getting through.

I’ll try to publish my example somewhere soon, for the benefit of all.
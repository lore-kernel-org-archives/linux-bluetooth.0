Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Travis Griggs <travisgriggs@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: good dbus command line tool for embedded exploration of the ble api?
Message-Id: <C6A28C41-E0ED-4070-A66F-F32C1B657D8F@gmail.com>
Date: Thu, 24 Mar 2016 17:04:56 -0700
To: linux-bluetooth@vger.kernel.org
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I just started transitioning from 5.37 to 5.38. 2 or so months ago, I had gotten an Arm single board computer acting as a peripheral based on copying/guesswork from how example-advertise and example-gatt-server work. I’m trying to resurrect that work. But one thing I think I need to understand better is how dbus works. I’m looking for some kind of command line tool that I can use in this environment to explore the bus layout and get a feel for how it all fits together. Does someone have a good recommendation, preferably something that’s available as debian (jessie) package. I had seen a reference to qdbus, but it looks like it would drag in the entire Qt framework. If there was something for python(3) that explained the jst of dbus and how to explore it with python, I could just use that, but the python dbus docs I’ve found haven’t done a lot to help me.  Thanks for any hints, tips, etc.
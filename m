Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: 5.40 Gatt BLE broke and fixed
From: Travis Griggs <travisgriggs@gmail.com>
In-Reply-To: <bug-130751-62941@https.bugzilla.kernel.org/>
Date: Wed, 13 Jul 2016 11:55:45 -0700
Message-Id: <7139D6D9-5288-40FB-9276-889F569652B5@gmail.com>
References: <bug-130751-62941@https.bugzilla.kernel.org/>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This post is mostly informational, in case some other poor soul is scratching their head with what happened in 5.40.

I upgraded from 5.39 to 5.40 yesterday, and my embedded Linux boarding acting as a BLE Peripheral/GATT Server quit working.

After some digging around, I discovered that the interfaces for ReadValue() and WriteValue() have changed. An extra ‘options’ option has been added to the method arguments, and the method signatures need to change accordingly. Let the example provided in test/example-gatt-server be your guide. Bluez does not appear to be at that stage yet where a change like this has a big README/ANNOUNCEMENT somewhere that points out the particulars on a change like this.

Thank you so much to whoever writes and maintains the example python apps in the test directory. They’re a godsend for figuring things like this out. 

The other feature that is indispensable for things like this, is the -d option for the bluetooth daemon. I modify my /lib/systemd/system/bluetooth.service to read:

ExecStart=/usr/lib/bluetooth/bluetoothd -d -E --noplugin=*

With that -d option, watching the output of journalctl -flu bluetooth is really good at illuminating what’s not working. Thanks to those who put effort into the useful debug output.
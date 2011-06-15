Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Jun 2011 19:02:06 +0200
From: YuGiOhJCJ Mailing-List <yugiohjcj-mailinglist@laposte.net>
To: linux-bluetooth@vger.kernel.org
Subject: Computer => Phone SUCCESS | Computer => Headset FAILURE
Message-Id: <20110615190206.b7bdd7f7.yugiohjcj-mailinglist@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hello,

I have 2 devices (a phone and a headset) :
$ hcitool scan
Scanning ...
	00:24:9F:75:E3:AA	BlackBerry 8900
	00:1E:7C:01:0A:5E	Philips SHB9000

I can connect my computer and my phone like this :
$ bluetooth-agent 0000
Pincode request for device /org/bluez/3308/hci0/dev_00_24_9F_75_E3_AA
Authorizing request for /org/bluez/3308/hci0/dev_00_24_9F_75_E3_AA
$ sudo hcitool cc 00:24:9F:75:E3:AA
$ hcitool con
Connections:
	> ACL 00:24:9F:75:E3:AA handle 11 state 1 lm MASTER AUTH ENCRYPT

But I can't connect my computer and my headset :
$ bluetooth-agent 0000
$ sudo hcitool cc 00:1E:7C:01:0A:5E
$ hcitool con
Connections:
	> ACL 00:24:9F:75:E3:AA handle 11 state 1 lm MASTER AUTH ENCRYPT

So the problem is only with my headset.
What's the difference please?


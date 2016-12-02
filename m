Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1480695827.14634.1.camel@hadess.net>
Subject: "ChromeLinux" HCI name, and Alias
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Fri, 02 Dec 2016 17:23:47 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

Using bluez 5.43 on Fedora 25, I get:

$ hciconfig hci0 name | grep Name
	Name: 'ChromeLinux_900A'

When the PrettyHostname is:
$ grep PRETTY /etc/machine-info 
PRETTY_HOSTNAME=classic

I grepped through a bunch of things, including the firmware, the kernel
sources, and bluez, but couldn't find the source of this name.

I'm also fairly certain that the hostname plugin doesn't work, as it's
trying to talk to services which wouldn't be started yet. Is there any
reason why this code can't poke /etc/machine-info directly?

Cheers

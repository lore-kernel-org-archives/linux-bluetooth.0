Return-Path: <cyrus@holtmann.org>
Subject: Re: Bluetooth-sendto without display
From: Marcel Holtmann <marcel@holtmann.org>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <677416.58415.qm@web52612.mail.re2.yahoo.com>
References: <677416.58415.qm@web52612.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Mon, 24 Aug 2009 09:48:10 -0700
Message-Id: <1251132490.2950.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ed,

> I am trying to write a simple shell script to keep sending a file to a pre-determined phone upon power up. Base on the latest ubuntu, I am able to 
> "bluetooth-sendto --device=00:xx:... myfile". 
> Then I tied to run without GUI by unchecking GDM using rcconf. Now bluetooth-sendto will fail with cannot find display.
> Is there a way to cheat, I tried --display=0, --display=0:0.0 .. still does not work. 
> Or is there obex-send that I could use without gnome?

the obexd packages contains test/send-files. Don't try to make a GNOME
program run headless. Use a proper command line tool.

Regards

Marcel



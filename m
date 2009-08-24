Return-Path: <cyrus@holtmann.org>
Message-ID: <677416.58415.qm@web52612.mail.re2.yahoo.com>
Date: Mon, 24 Aug 2009 07:59:37 -0700 (PDT)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: Bluetooth-sendto without display
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, I am trying to write a simple shell script to keep sending a file to a pre-determined phone upon power up. Base on the latest ubuntu, I am able to 
"bluetooth-sendto --device=00:xx:... myfile". 
Then I tied to run without GUI by unchecking GDM using rcconf. Now bluetooth-sendto will fail with cannot find display.
Is there a way to cheat, I tried --display=0, --display=0:0.0 .. still does not work. 
Or is there obex-send that I could use without gnome?

Thanks in advance.




      __________________________________________________________________
Looking for the perfect gift? Give the gift of Flickr! 

http://www.flickr.com/gift/

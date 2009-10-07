Return-Path: <cyrus@holtmann.org>
From: "Andrew Kohlsmith (Mailing List Account)" <aklists@mixdown.ca>
Reply-To: akohlsmith-lists@mixdown.ca
To: linux-bluetooth@vger.kernel.org
Subject: stubborn pairing
Date: Wed, 7 Oct 2009 18:42:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200910071842.24988.aklists@mixdown.ca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I am hoping someone can lend a hand here. I am running 2.6.31 (although the 
issue has been around for quite some time), and the internal bluetooth module 
in my Toshiba Satellite U300 (omnibook kernel module, SVN trunk).

I'm trying to pair with my iphone, but it seems that it times out almost 
immediately.

$ hcitool cc 00:23:DF:21:xx:yy
$ hcitool auth 00:23:DF:21:xx:yy
Not connected.

$ hcitool cc 00:23:DF:21:xx:yy && hcitool auth 00:23:DF:21:xx:yy

This brings up the KDE bluetooth PIN helper, I enter a PIN, but it immediately 
fails with 

HCI authentication request failed: Input/output error

On the console.  If I'm *REALLY* fast and lucky I may get it to pair, but 
it'll never connect afterward.

Can anyone give me any tips/pointers?  I'm pretty sure there's an easier way 
of doing it (maybe via dbus) but I haven't found any documentation on it, and 
I'm out of my league when it comes to dbus in general.

-A.




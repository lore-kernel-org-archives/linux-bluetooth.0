Return-Path: <cyrus@holtmann.org>
Message-ID: <444018.59197.qm@web52606.mail.re2.yahoo.com>
Date: Fri, 23 Jul 2010 10:48:31 -0700 (PDT)
From: Ed Tsang <netdesign_98@yahoo.com>
Subject: How to past connect complete event status (page timeout) to apps
To: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,  I tried to implement my apps to do different things depend on the failed 
connection attempt.
On Hci dump I could saw the connect complete status is different depend on the 
actual failure (e.g. 0x10 accept timeout, 0x06, PIN missing, 0x04 page 
timeout).  But the apps (base on obex-client) is not able to see those status 
code.
   The obex-client attempt a sdp_connect and then g_io_add_watch.  On the 
callback, we could see the G_IO_ERROR but I could not figure out a way to get 
more detail on the failed condition.  I tried look into the Bluez and could not 
figure what to change to pass those connect event status up..
    Anyone could offer some advise/hint...

Cheers,
Ed



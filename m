Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300708272211k2c881289h8f6c572e0780305e@mail.gmail.com>
Date: Mon, 27 Aug 2007 23:11:48 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] freepulse results
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hey

I have been playing with Claudio's freepulse set with the a2dp service
from utils head. The set uses a broadcom chipset and runs bt2.0+edr.
I've been using a bt1.2 adapter but that shouldn't matter.

I do hear very subtle pops coming out of the set, several times per
second, but only during quiet music. When I was experimenting with the
old HP a2dp-only set over a year ago, it would pop like this during
overruns (underruns were a jarring *crack* sound). Maybe these are
caused by the data coming across too quickly.

This set doesn't have complete avrcp controls. It has a sort of "mute"
button but I don't see any messages from the audio service so I don't
think it is actually trying to pause the stream via avrcp or even a2dp
messages.

This set has a much improved latency. I can watch video without any
sync correction.

Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

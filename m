Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 2 May 2007 10:52:58 +0100
From: Peter Stephenson <pws@csr.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Message-Id: <20070502105258.18bf397b.pws@csr.com>
In-Reply-To: <be976db60705011301r50289c43hc117c35deae39dc9@mail.gmail.com>
References: <be976db60705011301r50289c43hc117c35deae39dc9@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] signal strength, link quality and transmit power
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

"Mark S. Townsley" <mstownsley@gmail.com> wrote:
> I am trying to interpret the values return from reading a connection's
> signal strength, link quality and transmit power.

These are all determined in the device, so you may get a different
range of results from different manufacturers.

Signal strength is output power received locally from a remote device
(see note below).

Link quality is some estimate (it's allowed to be anything) to tell you
how successfully data is getting through.  CSR has always used bit
error rates for the estimate; this is very common.  We don't
*guarantee* anything more than a higher number means we think the link
is better.  However, it turns out that up to now we've always done it
the same way and Marcel has a table at
http://www.holtmann.org/linux/bluetooth/csr.html to convert to actual
bit error rate.

I'm not sure where you're getting the information on transmit power
from, but in most contexts it refers to the power at which the local
station is sending, probably in dBm (see below).  Hence it tells you
how loudly the device you have thinks it needs to shout to be heard.
(In fact, on devices where the transmit power changes, this is
signalled from the far end, which measures its own RSSI and requests
the originator to increase or decrease power.)

> For example, I would sometimes get rssi values in the negative.  What
> does that mean?

Normally, RSSI values are measured in dBm; this is a logarithmic scale
such that 1 mW of power is 0 dBm, while 10 mW is 10 dBm and 0.1 mW is
-10 dBm, etc.  (Try going into a shop and asking for a 50 dBm light
bulb.)

However, you need to be cautious in interpreting RSSI values if you're
getting the usual status read out supplied over HCI: it doesn't
tell you the *actual* RSSI, it tells you how much above or below the
"golden range", i.e. the preferred range of "good" signals, the value
is. So it's not actually in dBm; a negative value indicates it's so
many dB's "too quiet" for the chip to be happy, and a positive value so
many dB's "too loud".

RSSIs from inquiry results (rather than as reported during connections)
are in straight dBm, on the other hand.

> And in general, are higher values on these parameters indicate a
> better connection quality?

For the first two, broadly yes.  What *exactly* they're telling you
is a more complicated matter.

-- 
Peter Stephenson <pws@csr.com>                  Software Engineer
CSR PLC, Churchill House, Cambridge Business Park, Cowley Road
Cambridge, CB4 0WZ, UK                          Tel: +44 (0)1223 692070


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

To get further information regarding CSR, please visit our Investor Relations page at http://ir.csr.com/csr/about/overview

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

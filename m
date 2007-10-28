Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <472425AB.9080802@qualcomm.com>
References: <471DA835.2060308@qualcomm.com>
	<1193139336.6184.191.camel@violet> <471E200E.80108@qualcomm.com>
	<1193352893.6184.301.camel@violet>  <472425AB.9080802@qualcomm.com>
Date: Sun, 28 Oct 2007 18:49:30 +0100
Message-Id: <1193593771.5096.12.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] What's the purpose of the new btusb driver ?
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

Hi Max,

> > I heard rumors that Qualcomm is working on a BlueZ based project. 
>
> Hmm. Heard from whom ?

we had one guy from Qualcomm attending the BlueZ developer meeting a few
month ago. So it seems there some efforts.

> > Any chance you are coming back to help me out with the kernel stuff. All
> > this new Alternate MAC/PHY stuff is a lot of work.
>
> It is ? I haven't been following BT spec development. I get these emails
> from SIG (I'm still subscribed to their mailing list). But they are being
> redirected to /dev/null because of lack of time.
> Can you give me some pointers to that MAC/PHY stuff you're talking about ?
> Is it in the latest spec ?

Nothing is set in stone here, but for the Seattle release of the
specification next year it seems that Alternate MAC/PHY additions are
coming. Which means using Ultra-Wideband and/or IEEE 802.11 as alternate
radio technologies for high speed links.

Also the L2CAP retransmission and flow control will be started to be
used by profile specification. This means we need an implementation for
that at some point. I started working on it, but always get distracted
by user space stuff.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

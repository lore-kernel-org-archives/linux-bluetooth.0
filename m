Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
References: <46BD85F4.1090400@free.fr>  <1186855275.6698.10.camel@violet>
	<1186999158.6262.10.camel@ubuntu.mpl.access-company.com>
Date: Mon, 13 Aug 2007 12:05:38 +0200
Message-Id: <1186999538.6698.141.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] An explanation of a2dpd weird
	behaviour	on	high	resolution timers enabled kernels
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

Hi Frederic,

> > you might wanna focus on the Bluetooth audio service in bluez-utils (the
> > code got committed today) which now has A2DP support.
> 
> That's great news !!! I was thinking of this coming out soon, but didn't expect something so early.

the CSR based headphones seem to work pretty good so far. We have some
minor issues on the AVDTP protocol level, but they are fixable. The
current big issue are the Broadcom based headphones. While CSR seems to
be quite forgiving if you send data too fast (actually I think they use
flow control in the baseband to slow us down), the Broadcom ones are
not. We have to send the next SBC frame at the exact time slot.
Otherwise the audio sounds too fast or frames are skipped. If you have
any ideas on how we can improve pcm_bluetooth.c (yes, that handling is
inside the ALSA plugin), I would like to know.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

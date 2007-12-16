Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <47646F04.8080301@am.sony.com>
References: <463F7386.6050900@am.sony.com>
	<1178608551.8628.52.camel@aeonflux.holtmann.net>
	<1178622391.2824.34.camel@pmac.infradead.org>
	<1178630359.8628.63.camel@aeonflux.holtmann.net>
	<1178639244.2824.40.camel@pmac.infradead.org>
	<1178642601.8628.67.camel@aeonflux.holtmann.net>
	<4640FF63.8070403@am.sony.com>  <4641331E.1070408@am.sony.com>
	<1178694136.8628.82.camel@aeonflux.holtmann.net>
	<47646F04.8080301@am.sony.com>
Date: Sun, 16 Dec 2007 02:24:54 +0100
Message-Id: <1197768294.8050.8.camel@aeonflux>
Mime-Version: 1.0
Cc: dwmw2@infradead.org,
	BlueZ development <bluez-devel@lists.sourceforge.net>,
	bluez-devel@lists.sf.net, maxk@qualcomm.com
Subject: Re: [Bluez-devel] [RFC] PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
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

Hi Geoff,

> OK, so users are screaming for bluetooth support.  Can we get this
> resolved?
> 
> Here is the patch again.
> 
> -Geoff
> 
> ----------------------------------------------------------------------
> Subject: PS3 Bluetooth quirk for HCI_FLT_CLEAR_ALL
> 
> It seems the PS3 built-in bluetooth host controler doesn't support the
> HCI_FLT_CLEAR_ALL command properly.  Add a check to conditionally use
> the HCI_FLT_CONN_SETUP command to clear the event filter on PS3.

actually can you just test with a 2.6.23 or later kernel. I fixed the
OCF_SET_EVENT_FLT since it was broken since the beginning. In case you
give HCI_FTL_CLEAR_ALL you are not allowed to give any additional
parameters. Otherwise the command fails. So with this command now
succeeding, it might be enough to get Bluetooth working.

Regards

Marcel



-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185379787.3641.260.camel@cookie.hadess.net>
References: <1185295124.3641.148.camel@cookie.hadess.net>
	<1185311973.7111.77.camel@violet>
	<1185379787.3641.260.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 19:48:56 +0200
Message-Id: <1185385736.6239.0.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Implement browse callback in the applet
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

Hi Bastien,

> > > The patch implements the browse callback for the applet. It hardcodes
> > > the use of nautilus, but we should probably also check for nautilus in
> > > the obexftp_available().
> > > 
> > > It also fixes a popup menu being created _each time_ someone
> > > right-clicks on the bluetooth applet.
> > 
> > can you split this into two patches. They are both two independent
> > things.
> 
> And the left-over of that patch. Uses the new functionality from the
> BluetoothDeviceSelection widget.

the patch is in the CVS now. Thanks.

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

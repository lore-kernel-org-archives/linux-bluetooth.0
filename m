Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1185350162.3641.217.camel@cookie.hadess.net>
References: <1185293793.3641.129.camel@cookie.hadess.net>
	<1185311688.7111.72.camel@violet>
	<1185315051.3641.189.camel@cookie.hadess.net>
	<1185318541.3641.195.camel@cookie.hadess.net>
	<1185347068.7111.91.camel@violet>
	<1185348803.3641.213.camel@cookie.hadess.net>
	<1185350022.7111.97.camel@violet>
	<1185350162.3641.217.camel@cookie.hadess.net>
Date: Wed, 25 Jul 2007 10:05:17 +0200
Message-Id: <1185350717.7111.109.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] Make BluetoothClient work on all adapters
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

> > > So, the only thing I'm supposed to do, is change the model
> > > automatically, so that when we get the model for the default adapter,
> > > the model should change automatically. That will require the
> > > DefaultAdapterChanged signal to live in the instance, as in my patch, as
> > > globally, we don't have any knownledge of the instances.
> > 
> > We can have that in the model if we connect the proper signals to the
> > rows. That is the way I prefer, because the rest is messy and would need
> > DBusProxy for every instance. We don't since the model should be global
> > and actually valid for the lifetime of the application. However don't
> > worry. We can fix this up in the background. Once we have proper widgets
> > available, we don't have to expose the model to the applications anymore
> > (or at least less).
> 
> What's needed for the patch to go in then? Should we just make sure that
> we use the default adapter when NULL is passed to those few functions,
> and that's it? Even easier...

patch for that is in the CVS now. Including the changes to the wizard.

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

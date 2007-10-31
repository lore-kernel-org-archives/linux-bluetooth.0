Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1193847868.31723.99.camel@cookie.hadess.net>
References: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
	<1192631052.6184.25.camel@violet>
	<5f84803c0710170748j57f46eebh37a6707b9ec02b86@mail.gmail.com>
	<1192633908.10179.2.camel@snoogens.fab.redhat.com>
	<47173238.5070508@free.fr>  <1193847250.32459.36.camel@violet>
	<1193847868.31723.99.camel@cookie.hadess.net>
Date: Wed, 31 Oct 2007 17:36:03 +0100
Message-Id: <1193848563.32459.67.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [PATCH] make bluez GNOME UIs singletons
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

> > actually I do think that the current behavior should be default. I
> > really want that behavior. There are corner cases that need to be
> > thought of and making it a singleton only hides these issues.
> > 
> > However having a special switch that makes it a singleton would be a
> > good enhancement and I agree with you that any application started by
> > the applet should only exists once. The applet can use that specific
> > switch easily and we don't break current behavior.
> 
> As long as the switch exists, I don't mind. I'd probably make it the
> default for Fedora, in the .desktop files, and it wouldn't break normal
> development use.

sorry I wasn't clear on this. Yes, in the .desktop it should be also
included. Only when calling it from the terminal it should keep the
current behavior, because that is what I expect when I type a command.

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

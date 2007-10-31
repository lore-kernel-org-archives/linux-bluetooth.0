Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47173238.5070508@free.fr>
References: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
	<1192631052.6184.25.camel@violet>
	<5f84803c0710170748j57f46eebh37a6707b9ec02b86@mail.gmail.com>
	<1192633908.10179.2.camel@snoogens.fab.redhat.com>
	<47173238.5070508@free.fr>
Date: Wed, 31 Oct 2007 17:14:10 +0100
Message-Id: <1193847250.32459.36.camel@violet>
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

Hi Fabien,

> >>         actually the wizard and the properties applications are meant
> >>         to be
> >>         _not_ singletons. They are designed in a way that multiple
> >>         instances can
> >>         exist and work together.
> >>         
> >>         For the applet, only one instance is useful. However for
> >>         testing and 
> >>         development purposes it is nice to start two of them.
> >>
> >> The applet already has the ability to launch the properties dialog and
> >> I think it should also have an entry to launch the wizard.   This
> >> makes it very easy to get to a state where you have multiple copies
> >> open at once.  I think it's confusing to users and it doesn't buy you
> >> anything.  Just in case it's not clear, the patch allows for one
> >> instance per desktop session. 
> > 
> > Both of you are right. Developers should be able to launch another
> > applet or prefs for testing, but users should only ever see one applet
> > and prefs dialogue.
> > 
> > Maybe a command-line flag or envvar to disable the singleton behaviour
> > in Chris' patch would be acceptable for Marcel?
>
> Bastien, i agree with you. :-)
>  From the user experience perspective, having more than one instance of 
> those windows is just plain wrong( in fact this was a remark one working 
> collegue of mine just had when he discovered the bluez GUI for the first 
> time :-) )
> If Marcel wants to keep the old behaviour for testing purpose, i'm not 
> against it, but i really think the singleton behavior should be the default.

actually I do think that the current behavior should be default. I
really want that behavior. There are corner cases that need to be
thought of and making it a singleton only hides these issues.

However having a special switch that makes it a singleton would be a
good enhancement and I agree with you that any application started by
the applet should only exists once. The applet can use that specific
switch easily and we don't break current behavior.

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

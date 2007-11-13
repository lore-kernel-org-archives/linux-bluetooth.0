Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0711130824u2ad55b4bn36f42781b3c7ffe@mail.gmail.com>
References: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
	<1192631052.6184.25.camel@violet>
	<5f84803c0710170748j57f46eebh37a6707b9ec02b86@mail.gmail.com>
	<1192633908.10179.2.camel@snoogens.fab.redhat.com>
	<47173238.5070508@free.fr> <1193847250.32459.36.camel@violet>
	<1193847868.31723.99.camel@cookie.hadess.net>
	<5f84803c0711130824u2ad55b4bn36f42781b3c7ffe@mail.gmail.com>
Date: Tue, 13 Nov 2007 16:30:09 +0000
Message-Id: <1194971409.3140.41.camel@cookie.hadess.net>
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


On Tue, 2007-11-13 at 11:24 -0500, Chris Rivera wrote:
> On Oct 31, 2007 11:24 AM, Bastien Nocera <hadess@hadess.net> wrote:
> >
> > On Wed, 2007-10-31 at 17:14 +0100, Marcel Holtmann wrote:
> > <snip>
> > > actually I do think that the current behavior should be default. I
> > > really want that behavior. There are corner cases that need to be
> > > thought of and making it a singleton only hides these issues.
> > >
> > > However having a special switch that makes it a singleton would be a
> > > good enhancement and I agree with you that any application started by
> > > the applet should only exists once. The applet can use that specific
> > > switch easily and we don't break current behavior.
> >
> > As long as the switch exists, I don't mind. I'd probably make it the
> > default for Fedora, in the .desktop files, and it wouldn't break normal
> > development use.
> >
> > Chris, can you update the patches for that?
> 
> Sorry for the delayed response.  Attached is an updated patch that
> adds a flag to enable the singleton behavior.

Could you modify the .desktop file that starts the applet as well?


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

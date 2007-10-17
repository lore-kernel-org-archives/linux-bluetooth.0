Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0710170748j57f46eebh37a6707b9ec02b86@mail.gmail.com>
References: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
	<1192631052.6184.25.camel@violet>
	<5f84803c0710170748j57f46eebh37a6707b9ec02b86@mail.gmail.com>
Date: Wed, 17 Oct 2007 16:11:48 +0100
Message-Id: <1192633908.10179.2.camel@snoogens.fab.redhat.com>
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


On Wed, 2007-10-17 at 10:48 -0400, Chris Rivera wrote:
> On 10/17/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>         
>         actually the wizard and the properties applications are meant
>         to be
>         _not_ singletons. They are designed in a way that multiple
>         instances can
>         exist and work together.
>         
>         For the applet, only one instance is useful. However for
>         testing and 
>         development purposes it is nice to start two of them.
> 
> The applet already has the ability to launch the properties dialog and
> I think it should also have an entry to launch the wizard.   This
> makes it very easy to get to a state where you have multiple copies
> open at once.  I think it's confusing to users and it doesn't buy you
> anything.  Just in case it's not clear, the patch allows for one
> instance per desktop session. 

Both of you are right. Developers should be able to launch another
applet or prefs for testing, but users should only ever see one applet
and prefs dialogue.

Maybe a command-line flag or envvar to disable the singleton behaviour
in Chris' patch would be acceptable for Marcel?

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

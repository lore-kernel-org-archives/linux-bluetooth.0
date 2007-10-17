Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
References: <5f84803c0710161138i6123770dk22c1b63d03f45f59@mail.gmail.com>
Date: Wed, 17 Oct 2007 16:24:11 +0200
Message-Id: <1192631052.6184.25.camel@violet>
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

Hi Chris,

> Howdy folks.  The attached patch makes the applet, properties dialog,
> and wizard singletons.  Currently, you can open several instances of
> these at a time.  This is particularly annoying since you can launch
> the properties dialog from the applet.  I also added a simple DBUS
> method (Present) to the properties dialog and wizard that can be
> called by another instance to bring the current instance to the
> foreground. 

actually the wizard and the properties applications are meant to be
_not_ singletons. They are designed in a way that multiple instances can
exist and work together.

For the applet, only one instance is useful. However for testing and
development purposes it is nice to start two of them.

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

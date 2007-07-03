Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300707031114o3e6d61ddt7c8677d3b738cfef@mail.gmail.com>
Date: Tue, 3 Jul 2007 12:14:40 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <468A7156.1050708@gmail.com>
MIME-Version: 1.0
References: <46896137.90202@gmail.com>
	<d89ddf300707021858u2e5e8f80k35794595254736f6@mail.gmail.com>
	<468A7156.1050708@gmail.com>
Subject: Re: [Bluez-devel] A few questions about bluetooth-alsa project
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

hey

> > sure... I could put them in contrib/
> >
> Do you want me to send them directly to you?

ok

> I see that there are some alsa-lib modules being built. So, do I still
> need to specify a custom asoundrc file? Wouldn't the device show up
> automatically in the applet's preferences?

I don't make the rules--I only complain about them. You might think
that the device would show up, but alsa has two apis for listing
devices: hardware only and hardware and plugins. No one uses the
latter so even when you do everything right, the alsa clients don't
know the device is there. you have to type in the name (some apps
won't let you do that). You won't escape creating the asoundrc.

The ray of hope here is that we want to get the bluez version to
behave well enough that it can be set as the default device, so no one
has to worry about what device is selected any more.

the bluez wiki discusses the bluez utils version
http://wiki.bluez.org/wiki/Audio
http://wiki.bluez.org/wiki/HOWTO/AudioDevices

brad
brought to you in non-html :)

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

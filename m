Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1187025905.6262.34.camel@ubuntu.mpl.access-company.com>
References: <46C088D7.9000108@silicom.fr>
	<1187023591.6262.28.camel@ubuntu.mpl.access-company.com>
	<1187024773.6698.217.camel@violet>
	<1187025905.6262.34.camel@ubuntu.mpl.access-company.com>
Date: Mon, 13 Aug 2007 19:50:32 +0200
Message-Id: <1187027432.6698.242.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] New A2DP support : HOWTO ?
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

> > once you called CreateDevice (which is needed only once), you can
> > actually press a button on the headset and it should re-connect and you
> > can play music.
> 
> I have a few question too :
> 
> I have not setup any asoundrc and alsa found the bluetooth plugin. Any
> ideas?

no idea how that works. You normally need something like:

pcm.bluetooth {
        type bluetooth
}

In the future we might add some parameters to pick the right device.
This entry will select the currently connected headset or will connect
to the default one.

> What if I start the media player with headset not connected?

It will try to connect to the default headset.

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

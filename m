Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300710242155y7020adc3sc00e4873fa39911b@mail.gmail.com>
References: <6BA4FAD4-57D8-419A-B6BB-A86591FFDD3F@canonical.com>
	<d89ddf300710242155y7020adc3sc00e4873fa39911b@mail.gmail.com>
Date: Fri, 26 Oct 2007 00:50:01 +0200
Message-Id: <1193352601.6184.293.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] GUI for Bluetooth headsets..
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

Hi Michael,

> It would be more fitting to have the gui talk to the audio service
> with dbus to set up headsets. The stuff in asoundrc is a convenience
> for doing it manually.
> 
> The wiki has examples of the python code that is needed here. We could
> mock something up in python as a proof of concept. I suspect that
> ultimately audio service ui would be glued into the bluetooth applet.

the usage of the D-Bus interface for the audio service is the real
approach for this. You can configure as many headsets as you want and
then switch the default one. The ALSA plugin and the GStreamer plugin
will both pick the default one if not told to use a different one.

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

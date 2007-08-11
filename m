Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46BD85F4.1090400@free.fr>
References: <46BD85F4.1090400@free.fr>
Date: Sat, 11 Aug 2007 20:01:15 +0200
Message-Id: <1186855275.6698.10.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] An explanation of a2dpd weird behaviour on
	high	resolution timers enabled kernels
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

> I recently purchased a new combo A2DP/HFP headset from Sony Ericsson.
> This was the first time i was able to try Frederic's a2dpd daemon. :-)

you might wanna focus on the Bluetooth audio service in bluez-utils (the
code got committed today) which now has A2DP support.

Parts are based on the work from bluetooth-alsa, but the overall design
concept is a little bit different. For example is the SBC encoding done
inside the ALSA plugin and not inside the daemon. This allows us to
avoid any unnecessary copying of data between processes. My laptop
showed xmms running at 5% CPU and that includes MP3 decoding and then
SBC encoding.

I have seen some weird behavior with this when the playback speed is way
to fast. This might be related or totally unrelated. I simply don't
know.

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

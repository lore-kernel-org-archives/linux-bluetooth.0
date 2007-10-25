Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 25 Oct 2007 11:45:13 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20071025094513.GA8346@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Subject: [Bluez-devel] audio support choppy with mplayer and video
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

Hi folks

I tried the bluetooth audio support in bluez. It works nice with
esd/alsa except that the audio delay is incorrect.

With the alsa support in mplayer it makes more problems. Audio files can
be played without problems. But video files produces choppy video and
audio output. It looks like some runaway delay loop and already happened
in the bluetooth-alsa support some months ago but was fixed in the
meantime.

I use current bluez-utils and mplayer trunk.

Bastian

-- 
Intuition, however illogical, is recognized as a command prerogative.
		-- Kirk, "Obsession", stardate 3620.7

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

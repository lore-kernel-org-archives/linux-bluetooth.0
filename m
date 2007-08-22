Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <076BF2A0-A0AF-44B5-9A4D-2BC3EBBE2940@cadvium.net>
To: bluez-devel@lists.sourceforge.net
From: robert <rbscott@cadvium.net>
Date: Wed, 22 Aug 2007 11:23:16 -0700
Subject: [Bluez-devel] SCO Question
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

Hello Bluez,

How would I go about redirecting incoming SCO data to an alsa device,  
and transmit incoming audio data out as SCO?

I have read the following pages,
http://wiki.bluez.org/wiki/Audio
http://wiki.bluez.org/wiki/HOWTO/AudioDevices

but everything described seems to do too much.  I would prefer to  
handle the RFCOMM channel, and SDP registration elsewhere.   
Presently, I just want to determine how to redirect the SCO traffic.

Thanks,
--robert

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

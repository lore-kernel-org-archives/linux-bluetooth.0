Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 29 Oct 2007 19:19:50 -0400
From: billy leung <vientito1@pppoe.ca>
To: bluez-users@lists.sourceforge.net
Message-Id: <20071029191950.f9f17f16.vientito1@pppoe.ca>
Mime-Version: 1.0
Subject: [Bluez-users] Error 22 when configurating device
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I am getting this error as i try to connect to my BH-600 headset on a BCM2045 USB dongle.  as i check out the pcm_bluetooth.c, i realize the error comes up from the fact of checking received packet.  I am wondering what's up with this.

BTW I see an audio.conf file in my audio directory but it never gets installed in my system.  what is this file and its usage?

And error 22 signifies what kind of a problem?  where could i find protocol documentation of this?

thanks in advance

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

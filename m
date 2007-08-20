Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <53BC229C-4E4E-4014-87EC-F093B1276DF0@cadvium.net>
To: bluez-devel@lists.sourceforge.net
From: robert <rbscott@cadvium.net>
Date: Mon, 20 Aug 2007 07:44:41 -0700
Subject: [Bluez-devel] handsfree profile
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

hello bluez-devel,

i am developing an implementation of the handsfree profile (The  
Handsfree side rather than the Audio Gateway).  So far I have  
traction in every area except for SCO connections.

What exactly does bluez-alsa project do?  I am a little unclear about  
what is an alsa driver, and what part is a daemon.  How would I get  
data from the cell phone to the speakers, and data from the  
microphone back to cell phone?  From everything I have read it  
appears to be the Audio Gateway portion of the handsfree profile, but  
after playing around with it, I am not sue.

thanks for any help,
robert

cadvium.net
an open source car stero

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

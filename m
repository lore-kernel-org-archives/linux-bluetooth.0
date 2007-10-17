Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 16 Oct 2007 19:26:13 -0700 (PDT)
From: Chris Dragga <chris_dragga@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <965195.67885.qm@web52102.mail.re2.yahoo.com>
Subject: [Bluez-users] Not finding services through D-Bus API
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

I'm trying to use the Bluez D-Bus API on XUbuntu to establish a PAN network connection, as described in the wiki page on creating network connections.  However, I inevitably get the error "No such service" upon trying to activate the network service with the Bluez Manager object.  Furthermore, calls to ListServices() return an empty array, and I've noticed that none of the .service files that come with Bluez-utils are installed on my computer.  sdptool works, though, allowing me to activate services that then show up using "sdptool browse local".  I currently have bluez-utils-3.20 and bluez-libs-3.20 installed, though I've also tried this with bluez-utils-3.9 and bluez-libs-3.9 (the packages available from Synaptic) with equally little success.  If anyone could provide any information that might help me, I'd greatly appreciate it, as I'm really not sure what to do.

Thanks,
Chris Dragga




       
____________________________________________________________________________________
Take the Internet to Go: Yahoo!Go puts the Internet in your pocket: mail, news, photos & more. 
http://mobile.yahoo.com/go?refer=1GNXIC

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

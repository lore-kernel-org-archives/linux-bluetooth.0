Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 21 Oct 2007 21:30:15 -0700 (PDT)
From: Chris Dragga <chris_dragga@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <521733.37689.qm@web52102.mail.re2.yahoo.com>
Subject: Re: [Bluez-users] Not finding services through D-Bus API
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

Disregard these questions.  Almost immediately after posting this, I realized that configure had an option --enable-network; after using this, my problem naturally went away.  Sorry to waste your time.

-Chris Dragga

----- Original Message ----
From: Chris Dragga <chris_dragga@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Sent: Sunday, October 21, 2007 10:42:58 PM
Subject: Re: [Bluez-users] Not finding services through D-Bus API


Thanks for the advice, but I went through the syslog, and wasn't able
to find any errors regarding this.  I did realize belatedly that I
lacked libusb, flex, and bison, but installing those made no
difference.  Does one have to install the different services manually,
or is it possible that my device is just broken somehow (I'm using a
Trendnet Compact Bluetooth USB 2.0 Adapter, which is probably not the
greatest piece of equipment in the world)?



In addition, I'm getting another problem where the device on my main
computer will not be recognized with the device on my laptop, though my
main computer will see the device on my laptop (my laptop also lacks
the service files).  I doubt this is related, but I thought I'd mention
it in the event that it was.



-Chris

----- Original Message ----
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Sent: Wednesday, October 17, 2007 9:22:27 AM
Subject: Re: [Bluez-users] Not finding services through D-Bus API


Hi Chris,

> I'm trying to use the Bluez D-Bus API on XUbuntu to establish a PAN
 network connection, as described in the wiki page on creating network
 connections.  However, I inevitably get the error "No such service"
 upon
 trying to activate the network service with the Bluez Manager object.
  Furthermore, calls to ListServices() return an empty array, and I've
 noticed that none of the .service files that come with Bluez-utils are
 installed on my computer.  sdptool works, though, allowing me to
 activate
 services that then show up using "sdptool browse local".  I currently
 have bluez-utils-3.20 and bluez-libs-3.20 installed, though I've also
 tried this with bluez-utils-3.9 and bluez-libs-3.9 (the packages
 available from Synaptic) with equally little success.  If anyone could
 provide
 any information that might help me, I'd greatly appreciate it, as I'm
 really not sure what to do.

the the syslog for any error messages.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

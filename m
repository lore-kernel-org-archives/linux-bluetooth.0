Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 5 Nov 2007 20:08:44 -0800 (PST)
From: Chris Dragga <chris_dragga@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <458114.83554.qm@web52109.mail.re2.yahoo.com>
Subject: Re: [Bluez-users] Creating connections with the network DBUS API
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

Hey,

Thanks for the information about the servers.  The servers only need to be enabled once per machine; they don't start disabled at the start of each session, correct?

Regarding the network service, I had been running 3.20, and have since upgraded to 3.22, though I've noticed no change in functionality.  I have been able to get a NAP connection to work successfully if the computer to which I'm connecting is running pand with options --listen and --role NAP; the client does not have to use pand to connect.  Without pand, the client will not connect, regardless of whether the NAP server is enabled on the server side.  Is this the correct functionality or am I doing something wrong?  Also, in order to get communication functioning properly, do I need the PANU server running on the client?  I've tried it both with and without, without being able to observe a difference in functionality.

Further, I've noticed that running pand seems to break any of the network service functionality.  Similarly, it appears running anything that uses the network service (or at least any code that interacts with the network servers) makes it impossible to start pand in listen mode, though connections can still be established with pand.  The error " Bind failed. Address already in use(98)" appears in the syslog when this happens.  Is this what should be happening?

Thanks for the help.
-Chris Dragga

----- Original Message ----
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Sent: Wednesday, October 31, 2007 11:30:13 AM
Subject: Re: [Bluez-users] Creating connections with the network DBUS API


Hi Chris,

> I'm back with another question about the network features of DBUS.
  Specifically, I'm trying to create a connection using NAP as described
 on the wiki, albeit in C, rather than Python, and when I execute the
 Connect method on the connection object, I get the error:  "Operation now
 in progresss."  In addition, I never get a Connected signal (though I
 do have it handled correctly, I'm pretty sure), and hcitool shows no
 connections active once I've done this.  Note that the same error also
 occurs with GN.  Is there some sort of setting for Bluetooth itself that
 I'm missing, or do I need to introduce a delay somewhere in the code?
  For what it's worth, the relevant sections of code are as follows:

I have used the network service and the connection creation works
perfectly fine. Don't see the problem. However make sure you are
 running
the latest release since there were some glitches.

> Also, when the documentation says that the Connect method returns the
 network interface, would this be something along the lines of bnep0?
  Finally, correct me if I'm wrong, but since there is no "CreateServer"
 method in the network manager object (despite what the wiki says), the
 servers that ListServers lists are the only ones available.  Any help
 would be appreciated.

By definition there are only 3 servers. NAP, GN and PANU and they are
all available, but disabled by default. I am even thinking about moving
these settings into a config file instead of a D-Bus interface.

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

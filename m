Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <578209.61831.qm@web52103.mail.re2.yahoo.com>
References: <578209.61831.qm@web52103.mail.re2.yahoo.com>
Date: Wed, 31 Oct 2007 17:30:13 +0100
Message-Id: <1193848213.32459.57.camel@violet>
Mime-Version: 1.0
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

Hi Chris,

> I'm back with another question about the network features of DBUS.  Specifically, I'm trying to create a connection using NAP as described on the wiki, albeit in C, rather than Python, and when I execute the Connect method on the connection object, I get the error:  "Operation now in progresss."  In addition, I never get a Connected signal (though I do have it handled correctly, I'm pretty sure), and hcitool shows no connections active once I've done this.  Note that the same error also occurs with GN.  Is there some sort of setting for Bluetooth itself that I'm missing, or do I need to introduce a delay somewhere in the code?  For what it's worth, the relevant sections of code are as follows:

I have used the network service and the connection creation works
perfectly fine. Don't see the problem. However make sure you are running
the latest release since there were some glitches.

> Also, when the documentation says that the Connect method returns the network interface, would this be something along the lines of bnep0?  Finally, correct me if I'm wrong, but since there is no "CreateServer" method in the network manager object (despite what the wiki says), the servers that ListServers lists are the only ones available.  Any help would be appreciated.

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

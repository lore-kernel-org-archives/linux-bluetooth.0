Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <003901c809c4$9acb3db0$0200a8c0@jester>
From: "Olivier Le Pogam" <olepogam@free.fr>
To: <bluez-devel@lists.sourceforge.net>
References: <46EFC921.30001@tfh-berlin.de>
Date: Mon, 8 Oct 2007 18:02:18 +0200
MIME-Version: 1.0
Subject: Re: [Bluez-devel] can't establish more than two rfcomm connections
Reply-To: Olivier Le Pogam <olepogam@free.fr>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi David,

I think your problem is not BlueZ related.
When your mobile tries to connect to the RFCOMM server, the mobile is in 
master mode (initiating the connection), thus the bluetooth dongle is in 
slave mode.
When you try to connect a second mobile phone concurrently, it will be the 
same but the bluetooth dongle can't have 2 slaves, it can be master with 7 
devices and slave with 1.
A solution would be a role-switching, i.e. once connected the mobile becomes 
slave & the bluetooth dongle master, however, role-switching is usually not 
implemented in mobile phones.
Basically, you can consider have only one RFCOMM connection per dongle from 
a mobile phone.
BlueZ experts, don't hesitate to flame me if i'm wrong.

Oli 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

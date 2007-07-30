Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <46AE782C.4070205@theforce.com.au>
Date: Tue, 31 Jul 2007 09:45:48 +1000
From: Grahame Jordan <gbj@theforce.com.au>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Bluetooth not always connecting
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

Hi,

I have a problem when I am connecting between a Linux Ubuntu PC and a 
Gumstix.
I have set the PC to GN
PAND_OPTIONS="--listen --role GN"
lm master;

On the Gumstix
PAND_OPTIONS="--role PANU --service GN --search --persist"
lm accept;

Sometimes the Gumstix connects to the PC OK but other times it refuses 
to connect.
To get it to connect I need to manually run l2ping [address]

I am using the standard kernel on ubuntu 2.6.20-16-generic
and 2.6.18gum on the Gumstix.

Any help appreciated.

Thanks

Grahame Jordan


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

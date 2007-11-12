Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY117-W20475FC961A6D4564AA606C0870@phx.gbl>
From: "" <semiyd@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 12 Nov 2007 01:43:18 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Does Bluez3.22 support SPP?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1923327102=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1923327102==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi All:
        im about to use bluez3.22 to connect my development-board(running montavista linux 2.6.18) to a GPS module that supports SPP.Does BlueZ3.22 support the SPP profile? I read on the wiki of bluez.org that the protocol stack supports serial service(RFCOMM).Also,after i cross-compiled bluez-utils-3.22,there's a program named"bluetoothd-service-serial" which seems like a daemon handles all theserial service.This programme is initiated by hcid when the system starts. But the SPP profile is based on the RFCOMM service.(maybe im wrong?) So supporting serial service/rfcomm doesn't necessarilymeans it supports SPP? 
          If bluez do supports SPP,how can i use it ? I saw a script named "test-serial" in bluez-utils-3.22/serial ,written in python. It seems like a demo script for running serial service.But i wasn't able to run it cause it came up with an error when it tried to "import dbus". It can't find dbus in /usr/lib/python2.4 . I've already installed dbus-1.0.2 into the system.So should a install yet another "dbus-python" to get "test-serial" running?



Thanks for any help!  



semiyd
_________________________________________________________________
Discover the new Windows Vista
http://search.msn.com/results.aspx?q=windows+vista&mkt=en-US&form=QBRE


--===============1923327102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1923327102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1923327102==--

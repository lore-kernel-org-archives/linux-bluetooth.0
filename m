Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAB+zXWiodQU+C/XbHBBtz8gEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1102968227.2143.16.camel@pegasus>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 14 Dec 2004 11:28:15 +0100

Hi Marcel,

##>maybe it is not a good idea to configure bnep0 with YaST at 
##>the moment and actually I never tried this. If your AP is 
##>configured in router mode then you should simply run "pand 
##>-n -c <bdadd>" and then "dhcpcd bnep0".

and here is the result

Linux-Notebook:~ # hcitool scan
Scanning ...
        00:0B:CE:00:01:8F       Bluetooth-Modul
Linux-Notebook:~ # pand -n -c 00:0B:CE:00:01:8F
pand[8102]: Bluetooth PAN daemon
pand[8102]: Connecting to 00:0B:CE:00:01:8F
pand[8102]: Connect to 00:0B:CE:00:01:8F failed. Connection refused(111)
Linux-Notebook:~ #

What means this, espacially refused(111)?

Regards
Peter




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

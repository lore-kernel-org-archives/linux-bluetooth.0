Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Fulvio <fulvio@pc.jaring.my>
To: bluez-users@lists.sourceforge.net
Date: Sun, 18 Nov 2007 20:43:44 +0800
References: <1190642401.6465.20.camel@localhost>
	<200709241909.50864.fulvio@pc.jaring.my>
In-Reply-To: <200709241909.50864.fulvio@pc.jaring.my>
MIME-Version: 1.0
Message-Id: <200711182043.44315.fulvio@pc.jaring.my>
Subject: [Bluez-users]  problem pairing, hcid die
Reply-To: fulvio@pc.jaring.my, BlueZ users <bluez-users@lists.sourceforge.net>
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

Hello there,

I still have a long way to go to understand what's going on with bluez 3.20, 
Arch Linux and KDE desktop manager.
As far as I could see the deamon die after a trial to set a link with the 
device which I want to connect.
Here's the syslog:

Nov 18 20:28:20 laptop hcid[11827]: link_key_request (sba=00:A0:96:xx:CE:34, 
dba=00:1A:xx:08:A5:F9)
Nov 18 20:28:28 laptop hcid[11827]: pin_code_request (sba=00:A0:96:xx:CE:34, 
dba=00:1A:xx:08:A5:F9)
Nov 18 20:28:31 laptop sdpd[11831]: Stopping SDP server
Nov 18 20:28:31 laptop sdpd[11831]: Exit
Nov 18 20:28:31 laptop hcid[11827]: Unregister path: /org/bluez/hci0
Nov 18 20:28:31 laptop hcid[11827]: Unregister path: /org/bluez
Nov 18 20:28:31 laptop hcid[11827]: Shutting down local server
Nov 18 20:28:31 laptop hcid[11827]: Exit

Therefore, is there a practical way to make the link/pairing, some simple 
script that will answer to the pin request?
What should I check if something goes wrong and it will kill the hcid?


F

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

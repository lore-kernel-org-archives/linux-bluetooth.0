Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: sjok1 <sjok1@student.cs.ucc.ie>
To: bluez-users@lists.sourceforge.net
Message-ID: <40573809@webmail.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [Bluez-users] SCO Connection
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Mar 2004 17:58:26 +0000

Hi,

I'm writing an application that emulates a BT Headset and I'm using a Siemens 
S55 and a Sitecom USB BT Adapter.  What I'm doing is the following:
Send a dial command to the phone to dial a number
Send an AT+CKPD=200 to the phone to request an audio link
Create a socket to listen for the SCO conncetion
Accept the connection when it arrives.

My problem is that after I accept the SCO connection no data is transmitted 
along the connection.  The phone recognises that a "headset" is in use, but if 
I try to read from the connection I just get -1 returned as the num of bytes 
read.

I checked my hciconfig revision and it shows that the SCO mapping is set to 
HCI.

Do I need to acknowledge the connection after I accept it?  Is the phone 
waiting for some "ready to receive" message or something?


Thanks.

Steven




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth and gps
From: Gene Imes <ebi7@ozob.net>
To: list-bluez <bluez-users@lists.sourceforge.net>
In-Reply-To: <40B67EB9.7080102@connectingyou.com.au>
References: <40B67EB9.7080102@connectingyou.com.au>
Content-Type: text/plain
Message-Id: <1085799548.31067.50.camel@go2>
Mime-Version: 1.0
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
Date: Fri, 28 May 2004 21:59:08 -0500

On Thu, 2004-05-27 at 18:50, Joseph Sirucka wrote:
> Hi All
> 
> I have a bluetooth gps unit and would like to know how do I get about 
> connecting the unit to my linux machine.
> 
> I can get the usb bluetooth working with
> 
> bfusb and hci_usb drivers with others like l2cap, bluez etc
> 
> I can hcitool scan the bluetooth unit.
> 
> what do I need to make a connection to the unit.
> 
> regards
> 
> Joseph

rfcomm -h shows the following:

rfcomm bind <dev> <bdaddr> <channel>

<dev> is rfcommX where X is 0,1,2... probably 0

<bdaddr> is the output of your device determined by hcitool scan. In my
case is:
root@tr1a:~# hcitool scan
Scanning ...
        00:02:C7:15:7A:2F       BTGPS 157A2F

<channel> is 0-13 depending on your location

So the command for me would be

rfcomm bind 0 00:02:C7:15:7A:2F 1

My /etc/bluetooth rfcomm.conf looks thus:

rfcomm0 {
        # Automatically bind the device at startup
        bind yes;
 
        # Bluetooth address of the device
        #device 11:22:33:44:55:66;
        device 00:02:C7:15:7A:2F;
 
        # RFCOMM channel for the connection
        channel 1;
 
        # Description of the connection
        comment "Example Bluetooth device";
}

So if you type 'rfcomm bind 0' your device should be connected. Then say
perhaps you have gpsdrive. Click the 'Start GPSD' button and you should
be connected.

Good luck.

Ciao,

Gene



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "David West" <dwest@cs.usyd.edu.au>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Connecting from pocket PC iPaq to linux box using LAN access profile (DUND)
Message-ID: <000701c4228c$13867040$0c0a4e81@chimpsky>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <Pine.LNX.4.44.0404150023340.1728-100000@data.home>
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
Date: Thu, 15 Apr 2004 11:50:48 +1000

I'm still trying to get this working.  I can't seem to get as far as
pppd being invoked.

When I look in my syslog (I'm running Debian with kernel 2.6.0-1-686)
and I run "pand --listen --role NAP", and then I connect from my iPaq, I
see:

Apr 15 11:15:58 pteradactyl pand[14522]: PAN daemon ver 1.1
Apr 15 11:16:17 pteradactyl hcid[14408]: link_key_request
(sba=00:0D:88:AC:D1:07 , dba=08:00:17:1E:35:4A) Apr 15 11:16:22
pteradactyl hcid[14408]: link_key_request (sba=00:0D:88:AC:D1:07 ,
dba=08:00:17:1E:35:4A) Apr 15 11:16:23 pteradactyl pand[14527]: New
connection from 08:00:17:1E:35:4A b Nep0

The connection is then working fine.

However, when I kill pand, and run "dund --listen --persist --msdun call
dun" instead (as described in
http://www-jcsu.jesus.cam.ac.uk/~ned21/tech/tungsten_linux.html) I see
after trying to connect:

Apr 15 11:17:29 pteradactyl dund[14718]: DUN daemon ver 1.1
Apr 15 11:17:38 pteradactyl hcid[14408]: link_key_request
(sba=00:0D:88:AC:D1:07 , dba=08:00:17:1E:35:4A)

The connection then fails on the iPaq.  Dund doesn't appear to output
any error information, nor does pppd ever seem to be started.

Can anyone offer any insight?

Thanks,
David

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Geoff
Shang
Sent: 15 April 2004 12:26 AM
To: David West
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Connecting from pocket PC iPaq to linux box
using LAN access profile (DUND)


On Wed, 14 Apr 2004, David West wrote:

> In my /etc/ppp/peers/dun file, I've given the IP addresses as the ip 
> address of eth0 on my linux box, and the IP address I want my iPaq to 
> have, is this correct?

No.  Each interface your computer has needs its own address, so using
your
eth0 value is no appropriate here.   Use some other address and make
sure
it will route properly.

Disclaimer: I've not yet set this up either, but I plan to soon.

Geoff.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

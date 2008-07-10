Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jul 2008 13:24:01 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <AE1FAD2818FF4B8E90DE8C156874A782@radon>
Message-ID: <alpine.LNX.1.10.0807101158320.25000@nge2.ngu.pk>
References: <AE1FAD2818FF4B8E90DE8C156874A782@radon>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Can't connect RFCOMM socket: Host is down
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


On Tue, 8 Jul 2008, Bram Jansen wrote:

-> I'm trying to connect my Debian Etch box to the DUN service to any phone I
-> have. For some reason rfcomm isn't happy and is not able to make a
-> connection.

-> 1.	passkey-agent -default 0000 
-> 2.	hcitool cc <bdaddr> 
-> 3.	hcitool auth <bdaddr> 
-> 
-> a.	pairing succeeded and my box are in the phones's paired devices list
-> 
-> 
-> 4.	rfcomm bind <bdaddr> 1 (channel is correctly found with sdptool)
-> works fine but gives a strange bdaddr for the phone it binds to. 
-> 
-> a.	rfcomm0: 01:00:00:00:00:00 channel 1 clean

Not sure if there are typo's or not here, but those aren't the correct command 
syntaxes as-written.

I'm assuming you have a phone that has a modem inside and is advertising the 
DUN service via bluetooth and you'd like to make the computer connect to the 
phone and cause the modem to dial out, taking the connection for the computer? 
This is the case with my LG cellphone. There are two ways, with the dund 
binary handling rfcomm itself, or with you calling the rfcomm binary to get 
the device, then giving that to pppd.


passkey-agent --default <PIN> <bt addr> &
auth-agent &
rfcomm bind 0 <bt addr> 1
   (to bind chan. 1 at /dev/rfcomm0. )

Then use /dev/rfcomm0 for the pppd connection. If I remember correctly, you 
don't have to do the 'hcitool cc/auth' part at all.






-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

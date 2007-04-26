Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070425154806.GG7988@sorvankyla.yok.utu.fi>
References: <20070425154806.GG7988@sorvankyla.yok.utu.fi>
Date: Thu, 26 Apr 2007 19:27:41 +0200
Message-Id: <1177608461.14980.104.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] More than two incoming rfcomm connections?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mikko,

> I just wrote this little program to serve gps data to
> several cellular phones:
> 
> http://users.utu.fi/mijutu/src/gpsBtHub/
> 
> I wrote it because typical bluetooth gps devices will
> only accept one connection at a time.
> 
> First I register an sdp service:
> sdptool add --handle=0x003 --channel=1 SP
> 
> And then run this program that will 
> connect to a gpsd (http://gpsd.berlios.de/) and
> socket, bind, listen and accept 
> incoming connections to rfcommchannel 1. 
> After each successful accept, a new thread is
> created for the client and accept is attempted again.
> 
> The program works fine except I can only connect two
> clients at a time.
> 
> For example I can connect one "bluetooth serial chat"
> and one phone and when I try to connect another kbtserialchat,
> I get "Connection error (112)."

run "hcidump -X -V" to see what is going on.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problem with l2test
From: Marcel Holtmann <marcel@holtmann.org>
To: Zbyszek <dzidoz@poczta.fm>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040228173402.ECDBD1EC7AB@front.interia.pl>
References: <20040228173402.ECDBD1EC7AB@front.interia.pl>
Content-Type: text/plain
Message-Id: <1077995657.2843.91.camel@pegasus>
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
Date: Sat, 28 Feb 2004 20:14:17 +0100

Hi Zbyszek,

> I have problem. This is my part of the simple program.
>  
> #include <netinet/in.h>
> #include <arpa/inet.h>
> #include <resolv.h>
> #include <netdb.h>
> #include <sys/socket.h>
> 
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/l2cap.h>
> //Domyslne
> bdaddr_t bdaddr;
> int main()
> {
>     struct sockaddr_l2 addr;
>     char buf[2048];
>     char str[18];
>     char *adres="00:10:60:A5:F4:4C";
>     int s,i;
>     uint8_t id;
> 
>     if (( s=socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_L2CAP)) < 0)
>     {
> 	perror("Can't create socket !!!");
> 	exit(1);
>     }
> }
> 
> Exactly at this moment error appears.
> Even when I try start the program "l2test" I see communique
> l2test[4045]: Can't create socket. No such file or directory(2)
> So I'm asking you, could you tell me where did I make mistake?

load the L2CAP kernel module.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

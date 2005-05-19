Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <1710546273@web.de>
MIME-Version: 1.0
From: "Mariusz Dziuba" <m.dziuba@web.de>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bluez-users] RFCOMM Connection Handy to Bluez Application on Linux
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
Date: Thu, 19 May 2005 14:07:59 +0200

Hello, 

I need some help. I try to connect my Java Handy Application with my Bluez Bluetooth Application on Linux. I will start a serial connection between both devices (RFCOMM).
For my Test I found this Code for an Bluetooth Server:

	#include <netinet/in.h>
	#include <arpa/inet.h>
	#include <sys/types.h>
	#include <sys/socket.h>
	
	#include <bluetooth/bluetooth.h>
	#include <bluetooth/rfcomm.h>
	
	#define CHANNEL 4
	#define QUEUE 10
	
	int main(void)
	{
		int sock, client, alen;
		struct sockaddr_rc addr;
		
		sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
		if(sock < 0)
		{
			perror("socket");
			exit(1);
		}
		
		addr.rc_family = AF_BLUETOOTH;
		bacpy(&addr.rc_bdaddr, BDADDR_ANY);
		addr.rc_channel = htobs(CHANNEL);
		alen = sizeof(addr);
		
		if(bind(sock, (struct sockaddr *)&addr, alen) < 0)
		{
			perror("bind");
			exit(1);
		}
		
		listen(sock,QUEUE);
		printf("Waiting for connections...\n\n");
		
		while(client = accept(sock, (struct sockaddr *)&addr, &alen))
		{
			printf("Got a connection attempt!\n");
			close(client);
		}
		
		close(sock);
		return 0;
	}

On my Handy I'm programming the Client in Java unsing JSR 82. In my Application I can find the Linux Device, but if I'm scanning for services (RFCOMM) there will be found no services!
If I scan my Windows Laptop with the same Application, there are many services. Like this:
btspp://000B7C59C010:1,encrypt=false;authenticate=false;master=false
btspp://000B7C59C010:2,encrypt=false;authenticate=false;master=false
btspp://000B7C59C010:3,encrypt=false;authenticate=false;master=false
...

What I'm doing wrong?!
Can some one help me with this problem. I'm really desperate.

Thanx Marius
______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

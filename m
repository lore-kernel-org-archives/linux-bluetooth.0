Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] help needed with rfcomm
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <259637e0508241221e7f081b@mail.gmail.com>
References: <259637e0508241221e7f081b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1124916916.8019.20.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 24 Aug 2005 22:55:16 +0200

Hi Rui,

> i tried to post these doubts under the bluez-users mailing list, but i
> did'nt have any response, and since it has a programing doubt, i'll
> try to explain my problem.
>=20
> i want to buil an aplication that listen on rfcomm bluetooth sockets
> and the same aplication receives information thru that socket. i kinda
> have a squeleton of the program as folows:
>=20
>=20
>         // cria o socket
>         if( (sock =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)=
)
> < 0){
>         perror("socket");
>         return(-1);
>         }
>=20
>         // op=E7=F5es do socket
>         addr.rc_family =3D AF_BLUETOOTH;
>         str2ba(argv[1],&addr.rc_bdaddr);
>         addr.rc_channel =3D htobs(CHANNEL);

the htobs() is wrong here. The channel is uint8 value and thus a endian
change is not needed.

>         alen =3D sizeof(addr);
>=20
>         //regista o socket no SO
>         if(bind(sock, (struct sockaddr *)&addr, alen) < 0){
>                 perror("bind");
>                 return(-1);
>         }
>         //poe o socket =E0 escuta
>         listen(sock,QUEUE);
>=20
>         printf("Waiting for connections...\n\n");
>=20
>         while (1){
>                 while((client =3D accept(sock, (struct sockaddr *)&addr=
,
> &alen)) !=3D -1){
>                         printf("Got a connection attempt!\n");
>=20
>                         memset(buffer, 0, TAM_BUFFER);
>=20
>                         if ( (r =3D read(client, buffer, TAM_BUFFER)) <=
 0
>  ){
>                                 perror("Read no server");
>                         }
>=20
> but i can't get the connections to this computer to work. a i don't kno=
w why.
>=20
> another problem that i had was that the SPP profile has not
> advertized, and i solved that problem by performing a "sdptool add
> SP".
>=20
> anyway, with or without my program, i can't get the computer to accept
> the connection attemps from other computers. these connections are
> made using rfcomm on channel 1, and i can't change that.
> my kernel was all the bluez stuff compiled in, not as modules.=20
>=20
> any sugestions will be apreciated
>=20
> so any ideia on how to solve this problem. I lacking time to
> accomplish this program so i would really aprecciate all the hep that
> you can give me..

Run "hcidump -X -V" to see what happens. Run "sdptool browse local" to
see what channel is advertised for your serial port service.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

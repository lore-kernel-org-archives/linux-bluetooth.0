Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I9R9DH$87B77B69F7EC05E925293D07675091B6@uol.com.br>
Subject: Re: [Bluez-devel] rfcomm socket and rfcomm tty
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "omap" <omap@uol.com.br>
To: "bluez-devel" <bluez-devel@lists.sourceforge.net>
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
Date: Mon,  3 Jan 2005 17:12:53 -0200


Hi Marcel, this is the complete code

int main(void)
{
		int sock, client, alen;
		struct sockaddr_rc addr;

		if (sock =3D socket(AF_BLUETOOTH,
SOCK_STREAM, BTPROTO_RFCOMM) < 0) {
 				perror("socket");
 				exit(1);
  		}

		addr.rc_family =3D AF_BLUETOOTH;
		bacpy(&addr.rc_bdaddr, BDADDR_ANY);
		addr.rc_channel =3D htobs(CHANNEL);
		alen =3D sizeof(addr);
 		
		
			if (bind(sock, (struct sockaddr
*)&addr, alen) < 0)  {
				perror("bind");
				exit(1);
			}

		listen(sock,QUEUE);
		printf("Waiting for
connections...\n\n");
		while(client =3D accept(sock, (struct
sockaddr *)&addr, &alen)) {
    		printf("Got a connection
attempt!\n");
			close(client);
		}

		close(sock);
		return 0;
}



> Hi,
> 
> > First of all i would like to say
> > thanks for you previuos help. Well, I
> > am having problems on RFCOMM
socket too.
> > 
> > 		if (bind(sock, (struct sockaddr
> > *)&addr, alen) < 0)  {
> >    			perror("bind");
> >     		exit(1);
> > 		}
> > 
> > can you tell me if there is anything
> > wrong is this code? I got a run time
> > error that says
> > 
> > bind:Socket operation on non socket
> 
> this code as-is looks correct, but
the context is missing. Show us the
> complete function.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> The SF.Net email is sponsored by:
Beat the post-holiday blues
> Get a FREE limited edition
SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well,
almost....http://www.thinkgeek.com/sfshirt
>
_______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-devel
> =0A =0A________________________________________________________________=
__________=0AAcabe com aquelas janelinhas que pulam na sua tela.=0AAntiPo=
p-up UOL - =C9 gr=E1tis!=0Ahttp://antipopup.uol.com.br/=0A



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

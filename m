Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I9R8AC$D0025DCFFC50085F41F683811995C5C2@uol.com.br>
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
Date: Mon,  3 Jan 2005 16:49:24 -0200


Hi Marcel,

First of all i would like to say
thanks for you previuos help. Well, I
am having problems on RFCOMM socket too.

		if (bind(sock, (struct sockaddr
*)&addr, alen) < 0)  {
   			perror("bind");
    		exit(1);
		}

can you tell me if there is anything
wrong is this code? I got a run time
error that says

bind:Socket operation on non socket



> Hi Mike,
> 
> >     Is it mean that rfcomm socket
can not connect to a rfcomm tty?
> >     If the answer is yes, Does it
mean that all program base on bluez 
> > should use rfcomm tty to connect
to bluetooth Serial Port profile?
> 
> you can use RFCOMM socket or RFCOMM
TTY to connect to the serial port
> profile. Nothing matters and
actually you can convert a socket into a
> TTY if it is needed later. However
if you don't need a TTY for legacy
> reasons then always use the RFCOMM
socket, because this will be much
> cleaner and easier.
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

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <I9YBGA$6FFE4EA1F7A0F5363F7A838C24BF7DDF@uol.com.br>
Subject: Re: [Bluez-devel] TCP/IP Connection
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
Date: Fri,  7 Jan 2005 12:40:58 -0200


Hi Murilo,

Thanks for the help, it helped to
connect them. But I am sorry if I was
not clear in my question. I would like
to know how i could write code (using
bluez api) to acomplish this task.

Thanks again for your help

> On Fri, Jan 07, 2005 at 11:50:00AM
-0200, omap wrote:
> > 
> > 
> > Hi folks,
> > 
> > 
> > Here I am with another dummy question
> > for those with more experience in
Bluez.
> > I am intending to build an application
> > to connect a Bluetooth device to PC
> > using TCP/IP. Well, can anyone help me
> > on finding any howto or samples where
> > i can find the necessary steps to
> > acomplish my task?
> > 
> 
> [Server Side] 
> # pand --master --listen role GN
> # ifconfig bnep0 192.168.0.1
> 
> [Client Side]
> # pand --connect 00:11:22:33:44:55 #
SERVER ADDR 
> # ifconfig bnep0 192.168.0.2
> # route add default gw 192.168.0.1
> 
> 
> I hope this help,
> 
> ./nelson -murilo
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

Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <1184762701.469e0b4d91d39@webmail.epfl.ch>
Date: Wed, 18 Jul 2007 14:45:01 +0200
From: steve.morard@epfl.ch
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1184683440.469cd5b0dacda@webmail.epfl.ch>
	<f7kto8$iqm$2@sea.gmane.org>
In-Reply-To: <f7kto8$iqm$2@sea.gmane.org>
MIME-Version: 1.0
Subject: Re: [Bluez-users] AT Commands
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

Thank you I'll take a look to that
> steve.morard@epfl.ch wrote:
>
> > I'm currently trying to write a program that would allow me to send SMS
> > via bluetooth through my mobile phone. The problem that I have is that I'm
> > not able to receive and decode correctly the responses from the mobile.
> > Here is a sample of the code I'm using, which should retrieve the IMSI of
> > the mobile:
> >
> > s = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
> > status = connect(s, (struct sockaddr *)&addr, sizeof(addr); // addr being
> > the address of my mobile
> >
> > char remote[1024] = {0};
> >
> > status = write(s, "AT+CIMI\r", 8);
> > read(s,remote,1024) // s being the socket
> > printf("received [%s]\n", remote);
> >
> > All what I get is
> > ]eceived [AT+CIMI
> >
> >
> > Does anyone have an idea of what I'm doing wrong ?
>
> I've no idea,
> but have you thought of looking at gnokii?
>
> --
> Timothy Murphy
> e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
> tel: +353-86-2336090, +353-1-2842366
> s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

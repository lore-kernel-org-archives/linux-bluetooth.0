Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <I1BFOA$6F8B55EA549C83F73724227F68765C33@bol.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "ra002890" <ra002890@bol.com.br>
To: "bluez-users" <bluez-users@lists.sourceforge.net>
Cc: "ra002890" <ra002890@itelefonica.com.br>
Subject: [Bluez-users] How to use rfcomm in a ppc
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
Date: Fri, 23 Jul 2004 14:38:34 -0300

Hello everybody, 

I'm back again... I have compiled bluez to my embedded
linux application that uses a ppc cpu to run my
aplications. Bluez works fine til l2cap layer; when I
try to use rfcomm I receive this message:

/mnt/flash/validador/aplicativo # rfcomm connect rfcomm1
00:01:24:00:30:de 1 &      ///trying to connect
/mnt/flash/validador/aplicativo # bcsp_timed_event:
Timeout, retransmitting 1 pkts   ///common message(if
anyone knows how to eliminate it, I would like to know)

And this is the killer message that I was talking:
Can't create RFCOMM TTY: Operation not supported

What I have to do to eliminate this error?
my bluez utils is version 2.4 and libs 2.5....


                    Thanks in advance...
                      Direct from Brasil, by Daniel Moraes.
=0A =0A__________________________________________________________________=
________=0AAcabe com aquelas janelinhas que pulam na sua tela.=0AAntiPop-=
up UOL - =C9 gr=E1tis!=0Ahttp://antipopup.uol.com.br/=0A



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

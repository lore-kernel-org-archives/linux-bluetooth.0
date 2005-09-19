Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Oliver <urnenfel@tiscali.es>
In-Reply-To: <432E9170.4050001@cyph.ath.cx>
Message-Id: <20050919145036.780.1@@vodafone.es>
Mime-Version: 1.0
References: <432D6F49.80304@cyph.ath.cx>
 <20050919092548.1173.2@@vodafone.es> <432E9170.4050001@cyph.ath.cx>
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain;
 charset="iso-8859-1"
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
Date: Mon, 19 Sep 2005 14:50:36 +0000

Ho,

> I am thinking more along the lines of "You just told me my BD_ADDR, why
> are you asking for it now?"

I dont understand you as well in here... :P
?? i have not asked

> However, like I said, l2ping works. sdptool also works fine. Perhaps it
> transmits packets with the correct address, just that it would not tell
> BlueZ its BD_ADDR?

I only did research on this problem over the HCI layer, but while the BCM2035 
initiates those l2cap/sdp connections, as it is needed the remote BD_ADDR not 
ours(phantom one) what you say is possible.

On other hand no other device should be albe to "l2ping" you and in general 
connect you. As well as you should not be visible to remote inquiry processes.
 
> Too late? You mean it will be stuck with this BD_ADDR?

hmmmm I meant, device dead, or with a serious handicap if sounds better as, 
it has no BD_ADDR.

thanks,

		
______________________________________________ 
Renovamos el Correo Yahoo! 
Nuevos servicios, más seguridad 
http://correo.yahoo.es



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

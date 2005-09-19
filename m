Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <432E9170.4050001@cyph.ath.cx>
From: Ho Ming Shun <cyph@cyph.ath.cx>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] BCM2035 over UART on the E680I
References: <432D6F49.80304@cyph.ath.cx> <20050919092548.1173.2@@vodafone.es>
In-Reply-To: <20050919092548.1173.2@@vodafone.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Mon, 19 Sep 2005 18:22:40 +0800

Oliver wrote:

>Ho,
>
> =20
>
>>However, the problem comes when BlueZ requests the Bluetooth address=20
>>back from the chip: it will reply with 00:00:00:00:00:00. Seems like it=
s=20
>>not a problem unheard of:=20
>>http://www.linuxquestions.org/questions/history/341892
>>l2ping and hcitool scan works despite BlueZ not knowing the correct=20
>>local address.
>>   =20
>>
>
>It is not a BlueZ problem but a device itself, with the BlueZ stack the=20
>chip uses to forget its BD_ADDR.
> =20
>
I am thinking more along the lines of "You just told me my BD_ADDR, why=20
are you asking for it now?"

> =20
>
>>Will this cause any problems BlueZ functionality or other applications?
>>   =20
>>
>
>AFAIK for example another devices could not connect to it, moreover the=20
>fact that a device identifies itself as 00:00:00:00:00:00.
> =20
>
However, like I said, l2ping works. sdptool also works fine. Perhaps it=20
transmits packets with the correct address, just that it would not tell=20
BlueZ its BD_ADDR?

> =20
>
>>Is this a sign that the chip is somehow configured wrongly?
>>   =20
>>
>
>Looks like, but I fear its too late for the the device. Would help a lot=
 if=20
>it can take again a valid BD_ADDR. The HCI_USB driver behaves different =
for=20
>this device it casts a reset hci command on it, before the intialitation=
=20
>commands. May there is a point to look at but you are talking over UART.=
..
> =20
>
Too late? You mean it will be stuck with this BD_ADDR?

> =20
>
>>Is this a common problem for this chip?
>>   =20
>>
>
>I had this problem, I could not make it get its previous BD_ADDR
>
>thanks,
>
>	=09
>______________________________________________=20
>Renovamos el Correo Yahoo!=20
>Nuevos servicios, m=E1s seguridad=20
>http://correo.yahoo.es
>
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by:
>Tame your development challenges with Apache's Geronimo App Server.=20
>Download it for free - -and be entered to win a 42" plasma tv or your ve=
ry
>own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.ph=
p
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
> =20
>



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

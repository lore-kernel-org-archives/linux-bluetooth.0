Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41AB1B6B.5010004@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hello
References: <41AA81F0.8080005@bielefeld.ccc.de>	 <1101694796.9527.13.camel@pegasus>  <41AB1804.8070807@Uni-Bielefeld.de> <1101732250.10115.3.camel@pegasus>
In-Reply-To: <1101732250.10115.3.camel@pegasus>
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
Date: Mon, 29 Nov 2004 13:51:55 +0100

well there is one tool:
get the csr reset utility, it contains source code to also alter the hci=20
mapping (which I used on my vaio):
http://www.soft.uni-linz.ac.at/_wiki/tiki-index.php?page=3DProjectBluezHa=
ndsfree
no guarantees given, no questions asked ;)
simon

Marcel Holtmann wrote:

>Hi Nick,
>
> =20
>
>>| check with "hciconfig hci0 revision" (as root) for the setting of
>>| the SCO routing. I think it is set to PCM.
>>
>>you were right:
>>
>>(0:1)root@Muramasa:~$ hciconfig hci0 revision
>>hci0:   Type: USB
>>~        BD Address: 00:60:57:02:95:FE ACL MTU: 192:8  SCO MTU: 64:8
>>~        HCI 12.7
>>~        Chip version: BlueCore01b
>>~        SCO mapping:  PCM
>>
>>so, is that the way it should be?
>>   =20
>>
>
>to use your dongle with a headset it must be set to HCI. This value is
>stored in the PS keys and it is changeable, but there exists no free
>tool for this job.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.=20
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Bluez-devel mailing list
>Bluez-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-devel
> =20
>


--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=FCr Pervasive Computing, Johannes Kepler Universit=E4t Linz =20
Altenberger Stra=DFe 69, A-4040 Linz, Austria =20
 =20
Tel: +43 732 2468-8517, Fax: +43 732 2468-8426 =20
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42407B38.7050900@debiancolombia.org>
From: "Fredy P." <digitalfredy@debiancolombia.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] connect T610 to PC problem
References: <20050322150335.73224.qmail@web60910.mail.yahoo.com>
In-Reply-To: <20050322150335.73224.qmail@web60910.mail.yahoo.com>
Content-Type: text/plain;
	charset=Big5
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
Date: Tue, 22 Mar 2005 15:08:24 -0500

Ka Kin Cheung escribio':
> Hi all!
>     I can connect T610 from PC successfully! The key
> point is: you have to set the same channel of SDP and
> rfcomm, and set the class in hciconfig as 0x200404
> i.e. headset. Then after typing "rfcomm listen 0
> <channel>", the phone can connect to Pc successfully.
> But then, I face a new problem. When I put the socket
> programming part in my main program, after I
> successfully connect T610 to the PC, it showed
> "dev/rfcomm0: no such device". Why is that?
>     Then I looked at rfcomm/main.c, and put the
> cmd_listen part in my main program, but after that,
> when I tried to connect T610 to PC, the T610 always
> showed "Bluetooth connection failed". Why is that?
It is becouse you have a lm master, i only have :

        lm accept;

and y can add the pc to movil from movil
> Please give any suggestion about it. If neccessary,
> any user can ask me to send my programs to you to have
> a look. Thank you very much for your kindness.
> Michael=20

--=20
Suerte and F.S.Fv.

ATT: Fredy P.
___________________________________________________
F.S.Fv. es acro'nimo de Free Software Forever
http://www.fsf.org/philosophy/free-sw.es.html

Normas ba'sicas de comportamiento en el ciberespacio
http://www.netiqueta.org/


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

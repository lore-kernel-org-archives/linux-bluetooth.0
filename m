Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: Leos Literak <leos.literak@systinet.com>
Cc: Bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] phillips fisio 825
References: <3F4F32E0.7050802@systinet.com>
From: Olivier Berger <olberger@club-internet.fr>
In-Reply-To: <3F4F32E0.7050802@systinet.com> (Leos Literak's message of
	"Fri, 29 Aug 2003 13:02:56 +0200")
Message-ID: <87smnbzk6i.fsf@club-internet.fr>
MIME-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 05 Sep 2003 10:57:57 +0200
Content-Type: text/plain; CHARSET=iso-8859-1

Leos Literak <leos.literak@systinet.com> writes:

> Hi,
>
> I have mandrake 9.1 with latest kernel 2.4.21 and latest bluez
> utilities. I try to connect phone $SUBJECT to my PC using
> USB BT card. After some experimantation I succeeded.
> But there are still some errors. So treat this as bugreport :-)
>
> sdptool browse - > segfaults
>
> rfcomm bind - it depends on order, in which I start BT / Receive
> on phone and invoke rfcomm bind. I have to run command on PC
> and then immediatelly start BT/Receive on phone. Usually it
> takes me many attempts, before I catch correct timing and these
> two devices become connected.
>
> I attach log, as I invoke commands command with hcidump.
>

I used to have a Fisio 820 (probably similar) and had some trouble too
sometimes.

In cas it would be usefull, you may still be able to find usefull
information in the docs I wrote (now updated for my new T68i) :

http://perso.club-internet.fr/olberger/btgprsfisio820orangefr.html

Hope this helps.

Regards,
-- 
Olivier BERGER (OpenPGP: 1024D/B4C5F37F)
APRIL (http://www.april.org) - Vive python (http://www.python.org)
Pétition contre les brevets logiciels : http://petition.eurolinux.org


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: neoclust <n1c0l4s.l3@wanadoo.fr>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ms explorer for bluetooth
References: <200410122022.30501.n1c0l4s.l3@wanadoo.fr> <200410131143.26811.n1c0l4s.l3@wanadoo.fr> <1097662706.4643.21.camel@notepaq>
In-Reply-To: <1097662706.4643.21.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200410140046.41141.n1c0l4s.l3@wanadoo.fr>
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
Date: Thu, 14 Oct 2004 00:46:40 +0200

i don't know how but when i wanted to scan my pocket pc doing :

hcitool scan 00:04:3E:45:A7:9F

the answer was :

$ hcitool scan 00:04:3E:45:A7:9F
Scanning ...
        00:50:F2:80:A1:2B       Microsoft Keyboard


but i don't find how to connect him with hciconfig :(


Le mercredi 13 Octobre 2004 12:18, Marcel Holtmann a =E9crit=A0:
> Hi Nicolas,
>
> > yes but the problem is that only the mouse works
>
> I misread your email. What I think is that maybe the keyboard will only
> work if you enforce the encryption. Is this the second generation of the
> Microsoft keyboard? Can you do a "hcitool info ..." as root to your
> keyboard? Run also "hcidump -x" as root and show it to us.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out mo=
re
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

=2D-=20
Mail compos=E9 sous Mandrakelinux 10.1
KDE 3.2.3
KMail 1.7
Kernel 2.6.8-1.12mdk


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: neoclust <n1c0l4s.l3@wanadoo.fr>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ms explorer for bluetooth
References: <200410122022.30501.n1c0l4s.l3@wanadoo.fr> <200410131224.13689.n1c0l4s.l3@wanadoo.fr> <1097668334.4643.24.camel@notepaq>
In-Reply-To: <1097668334.4643.24.camel@notepaq>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200410140042.12450.n1c0l4s.l3@wanadoo.fr>
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
Date: Thu, 14 Oct 2004 00:42:12 +0200

Le mercredi 13 Octobre 2004 13:52, Marcel Holtmann a =E9crit=A0:
> Hi Nicholas,
>
> > > I misread your email. What I think is that maybe the keyboard will on=
ly
> > > work if you enforce the encryption. Is this the second generation of
> > > the Microsoft keyboard?
> >
> > how can i know this info ?
>
> look at your box. What does it say and how does the keyboard look like?

my mouse: http://images.ldlc.com/photosldlc/00/00/41/13/LD0000411349_1.jpg
my KB       : http://images.ldlc.com/photos/00/00/24/16/ME0000241663_1.jpg
>
> > > Can you do a "hcitool info ..." as root to your
> > > keyboard?
> >
> > how can i know my <bdaddr> for my keabord  ?
>
> Press the "connect" button on the keyboard and run "hcitool scan".

if i let only the keyboard pluged it doesn't work better and when i plug th=
e=20
mouse it ( the mouse) work directly

I use a mdk kernel can it be a mdk bug ?

but i mh patches wasn't include in the kernel the mouse would not work isn'=
t=20
it ?


>
> > > Run also "hcidump -x" as root and show it to us.
> >
> > # hcidump -x
> > HCIDump - HCI packet analyzer ver 1.12
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> >
> > > HCI Event: Mode Change (0x14) plen 6
> >
> >   00 2A 00 00 00 00
> >
> > > HCI Event: Mode Change (0x14) plen 6
> >
> >   00 2A 00 02 70 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 03 FE 00
> >
> > > HCI Event: Mode Change (0x14) plen 6
> >
> >   00 2A 00 00 00 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 0C EC 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 00 FE 00
> >
> > > HCI Event: Mode Change (0x14) plen 6
> >
> >   00 2A 00 02 12 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 00 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 00 FF 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 FF 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 00 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 FF 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 02 FF 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 FF 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 FF 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 02 FD 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 00 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 02 FD 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 FE 00
> >
> > > ACL data: handle 0x002a flags 0x02 dlen 10
> >
> >     L2CAP(d): cid 0x0041 len 6 [psm 0]
> >       A1 02 00 01 00 00
> >
> > > HCI Event: Mode Change (0x14) plen 6
> >
> >   00 2A 00 00 00 00
> >
> > > HCI Event: Mode Change (0x14) plen 6
> >
> >   00 2A 00 02 70 00
>
> Please don't connect the mouse when doing any testing with the keyboard.
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

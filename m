Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Prepare patch bluez for the CoD in hci_conn
From: Chen Bin <binch@mobilesoft.com.cn>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1102315236.8510.55.camel@pegasus>
References: <1102340081.653.6.camel@debian>
	 <1102315236.8510.55.camel@pegasus>
Content-Type: text/plain; charset=gbk
Message-Id: <1102345868.2011.2.camel@debian>
Mime-Version: 1.0
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
Date: Mon, 06 Dec 2004 23:11:08 +0800

Hi Marcel,

I have done this. I searched the BT spec and find two places which will
let us know the CoD value, and I simply test it, it works find.

Ok, next step is to make an interface(maybe ioctl) to let the user get
the CoD value, is it needed(if there has been a interface which can get
the entire hci_conn structure)? If it is not needed, I will send you the
patch now.


Chen
=D4=DA 2004-12-06=D2=BB=B5=C4 07:40 +0100=A3=ACMarcel Holtmann=D0=B4=B5=C0=
=A3=BA
>                               =B7=A2=BC=FE=C8=CB:=20
> Marcel Holtmann
> <marcel@holtmann.org>
>                               =BB=D8=B8=B4=D6=C1:=20
> bluez-devel@lists.sourceforge.net
>                               =CA=D5=BC=FE=C8=CB:=20
> BlueZ Mailing List
> <bluez-devel@lists.sourceforge.net>
>                                =D6=F7=CC=E2:=20
> Re: [Bluez-devel] Prepare patch
> bluez for the CoD in hci_conn
>                                =C8=D5=C6=DA:=20
> Mon, 06 Dec 2004 07:40:36 +0100
> (14:40 CST)
>=20
> Hi Chen,
>=20
> > Do you remember that I have asked a CoD question in this list and
> you
> > ask me to do a patch to let the CoD value in hci_conn? Now I have
> time
> > to do this work and I have something to clarify for I am not a bluez
> > member before and I am not very fimiliar with BlueZ.
> >=20
> > This time I just want to keep the remote CoD value in hci_conn when
> a
> > connection is done. But as you know, sometimes it is impossible for
> us
> > to get the CoD of the remote class without a prestage inquiry. So,
> not
> > every CoD value in hci_conn is valid. I will check the BT spec to
> find a
> > right way to tell the user whether the CoD is valid.
> >=20
> > Is it enough that I add a field to hci_conn and when the connection
> is
> > done I update the field?
>=20
> you need only to add a "__u8 dev_class[3]" field to the data structure
> and if you don't know the current value for CoD. For example for an
> outgoing connection, where the value is not in the inquiry cache, then
> you simply put 0x000000 in there.
>=20
> Regards
>=20
> Marcel



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

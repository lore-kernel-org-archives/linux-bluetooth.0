Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41334BA2.3030603@c-s.fr>
From: "GUILLON Gabriel" <gabriel.guillon@c-s.fr>
MIME-Version: 1.0
To: bluez devel <bluez-devel@lists.sourceforge.net>,
   bluez users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-devel] PAN profile of bluetooth
References: <BAY1-F25PMxBZMBDC9p000456a6@hotmail.com>
In-Reply-To: <BAY1-F25PMxBZMBDC9p000456a6@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 30 Aug 2004 17:45:38 +0200

Hi! I newly subscribed to these ML.
I'm a lot interested by BT since I made my last year's projetc on that=20
("BT and the ad hod networks", actually. I'm french, so it's in french.=20
If someone want to read it ;) )
I have a lot of ideas about using BT, but for now I would like to know=20
more about how to use Bluez stack. I'm ready for testing anything you=20
want me to test: I have 2 usb BT dongles (CSR chipset), and Logitech BT=20
mouse and keyboard (yep, on windows)
My only exploit with BT was to make a pda connect to the net throught a=20
BT dongle connect to an Linux box.
It work pretty well :)

blookk - a =E9crit :
>=20
>=20
> Hello
>=20
> I have made a new try and it don't work.
>=20
> after  I do all things that you told me, when  I execute "ifconfig" the=
=20
> virtual interface Bnep0 don't appears.
>=20
> Why  do these things happen?
>=20
> How do  you make  this connection?
>=20
> Regards
>=20
>=20
>=20
> &gt;From: Marcel Holtmann &lt;marcel@holtmann.org&gt;
> &gt;To: blookk - &lt;blookk@hotmail.com&gt;
> &gt;CC: bluez-devel@lists.sf.net
> &gt;Subject: Re: [Bluez-devel] PAN profile of bluetooth
> &gt;Date: Mon, 30 Aug 2004 13:30:52 +0200
> &gt;
> &gt;Hi,
> &gt;
> &gt; &gt; I want to connect 2 pc using the PAN profile. I do this thing=
s:
> &gt; &gt;
> &gt; &gt; - In server and client:
> &gt; &gt;
> &gt; &gt; insmod rfcomm
> &gt; &gt; insmod l2cap
> &gt; &gt; insmod bnep
> &gt; &gt;
> &gt; &gt; hcid -n &amp;
> &gt; &gt; sdpd -n &amp;
> &gt; &gt; sdptool add LAN
> &gt;
> &gt;there is no &quot;sdptool add&quot;, because pand can do this by=20
> itself. And btw
> &gt;you said you wanted PAN and not LAN access using PPP.
> &gt;
> &gt; &gt; - In the server:
> &gt; &gt; The file hcid.conf :    lm accept,master;
> &gt; &gt; in the console     :    pand --listen --role GN
> &gt; &gt;
> &gt; &gt; - In the client:
> &gt; &gt; The file hcid.conf :    lm accept,master;
> &gt; &gt; in the console     :    pand --connect 00:11:22:33:44:55
> &gt;
> &gt;This will never work, because only one can be the master. Don't use=
 the
> &gt;hcid.conf for setting the master role. Use --master on the server s=
ide
> &gt;call of pand.
> &gt;
> &gt;Regards
> &gt;
> &gt;Marcel
> &gt;
> &gt;
> &gt;
> &gt;
> &gt;-------------------------------------------------------
> &gt;This SF.Net email is sponsored by BEA Weblogic Workshop
> &gt;FREE Java Enterprise J2EE developer tools!
> &gt;Get your free copy of BEA WebLogic Workshop 8.1 today.
> &gt;http://ads.osdn.com/?ad_id=3D5047&amp;alloc_id=3D10808&amp;op=3Dcli=
ck
> &gt;_______________________________________________
> &gt;Bluez-devel mailing list
> &gt;Bluez-devel@lists.sourceforge.net
> &gt;https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20
> _________________________________________________________________
> Hor=F3scopo, tarot, numerolog=EDa... Escucha lo que te dicen los astros=
.=20
> http://astrocentro.msn.es/
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by BEA Weblogic Workshop
> FREE Java Enterprise J2EE developer tools!
> Get your free copy of BEA WebLogic Workshop 8.1 today.
> http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>=20

--=20
"May peace prevail on Earth"

Gab

"Un mot aimable est comme un jour de printemps."
- Proverbe russe -


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

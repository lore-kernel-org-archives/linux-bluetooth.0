Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [Bluez-devel] PAN profile of bluetooth
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDCF7@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "blookk -" <blookk@hotmail.com>, <bluez-devel@lists.sf.net>
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
Date: Mon, 30 Aug 2004 11:51:08 -0400

Hello,

Did you make sure the /etc/bluetooth/pan/dev-up file is correct and =
present=20
on both your devices, master and slave ? If this file isn't there, you =
won't=20
get the bnep process started.

Regard,

Rich

-----Original Message-----
From: blookk - [mailto:blookk@hotmail.com]
Sent: Monday, August 30, 2004 11:19 AM
To: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] PAN profile of bluetooth




Hello

I have made a new try and it don't work.

after  I do all things that you told me, when  I execute "ifconfig" the=20
virtual interface Bnep0 don't appears.

Why  do these things happen?

How do  you make  this connection?

Regards



&gt;From: Marcel Holtmann &lt;marcel@holtmann.org&gt;
&gt;To: blookk - &lt;blookk@hotmail.com&gt;
&gt;CC: bluez-devel@lists.sf.net
&gt;Subject: Re: [Bluez-devel] PAN profile of bluetooth
&gt;Date: Mon, 30 Aug 2004 13:30:52 +0200
&gt;
&gt;Hi,
&gt;
&gt; &gt; I want to connect 2 pc using the PAN profile. I do this =
things:
&gt; &gt;
&gt; &gt; - In server and client:
&gt; &gt;
&gt; &gt; insmod rfcomm
&gt; &gt; insmod l2cap
&gt; &gt; insmod bnep
&gt; &gt;
&gt; &gt; hcid -n &amp;
&gt; &gt; sdpd -n &amp;
&gt; &gt; sdptool add LAN
&gt;
&gt;there is no &quot;sdptool add&quot;, because pand can do this by =
itself.=20
And btw
&gt;you said you wanted PAN and not LAN access using PPP.
&gt;
&gt; &gt; - In the server:
&gt; &gt; The file hcid.conf :    lm accept,master;
&gt; &gt; in the console     :    pand --listen --role GN
&gt; &gt;
&gt; &gt; - In the client:
&gt; &gt; The file hcid.conf :    lm accept,master;
&gt; &gt; in the console     :    pand --connect 00:11:22:33:44:55
&gt;
&gt;This will never work, because only one can be the master. Don't use =
the
&gt;hcid.conf for setting the master role. Use --master on the server =
side
&gt;call of pand.
&gt;
&gt;Regards
&gt;
&gt;Marcel
&gt;
&gt;
&gt;
&gt;
&gt;-------------------------------------------------------
&gt;This SF.Net email is sponsored by BEA Weblogic Workshop
&gt;FREE Java Enterprise J2EE developer tools!
&gt;Get your free copy of BEA WebLogic Workshop 8.1 today.
&gt;http://ads.osdn.com/?ad_id=3D5047&amp;alloc_id=3D10808&amp;op=3Dclick=

&gt;_______________________________________________
&gt;Bluez-devel mailing list
&gt;Bluez-devel@lists.sourceforge.net
&gt;https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
Hor=F3scopo, tarot, numerolog=EDa... Escucha lo que te dicen los astros. =

http://astrocentro.msn.es/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=3D5047&alloc_id=3D10808&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "blookk -" <blookk@hotmail.com>
To: bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] PAN profile of bluetooth
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY1-F25PMxBZMBDC9p000456a6@hotmail.com>
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
Date: Mon, 30 Aug 2004 15:18:36 +0000



Hello

I have made a new try and it don't work.

after  I do all things that you told me, when  I execute "ifconfig" the 
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
&gt; &gt; I want to connect 2 pc using the PAN profile. I do this things:
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
&gt;there is no &quot;sdptool add&quot;, because pand can do this by itself. 
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
&gt;This will never work, because only one can be the master. Don't use the
&gt;hcid.conf for setting the master role. Use --master on the server side
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
&gt;http://ads.osdn.com/?ad_id=5047&amp;alloc_id=10808&amp;op=click
&gt;_______________________________________________
&gt;Bluez-devel mailing list
&gt;Bluez-devel@lists.sourceforge.net
&gt;https://lists.sourceforge.net/lists/listinfo/bluez-devel

_________________________________________________________________
Horóscopo, tarot, numerología... Escucha lo que te dicen los astros. 
http://astrocentro.msn.es/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050217140257.16874.qmail@web60903.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: Trouble pairing with new phone... (FIXED!)
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1108409220.7780.15.camel@notepaq>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-880580346-1108648977=:16442"
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
Date: Thu, 17 Feb 2005 22:02:57 +0800 (CST)

--0-880580346-1108648977=:16442
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Jay!
    Sorry to interrupt. In order that SE T610 can search and add PC into "My device list", you should do like this:
# Authentication and Encryption
# auth enable;
# encrypt enable
    Or you can never let your T610 to search for and add your PC into the list.
    But then, do you know how to connect T610 to PC instead of from PC to T610 (as I know that the method is typing "rfcomm connect 0 <address>").
    Hope that this can help you and then you can have method to do the connection from T610 to PC as I wish to do it in a short time.
Cherrs,
Michael
Marcel Holtmann <marcel@holtmann.org> wrote:
Hi Jay,

> I figured out how to pair with my T610 phone.
> 
> Point 1: The computer must initiate the connection. (If you attempt to scan for 
> new devices on your phone and add it there, apparently bluez will not accept 
> incoming pairing requests. Something to do with roleswitch and bluez wanting to 
> be the master? Perhaps...)
> 
> Point 2: My version of blueZ ignores the /etc/bluetooth/pin file (even when in 
> "auto" mode) and I HAD to replace the pin_helper with a link to a script which 
> simply printed "PIN:1234" (replace number with your pin).
> 
> So, once I replace "pin_helper /usr/bin/bluepin" with "pin_helper /sbin/pintest" 
> (where the pintest file contained "echo "PIN:1234") and initiated an rfcomm 
> connection to the phone with my pppd chat script, I was able to type the pin 
> into my phone and pair.
> 
> [(going the other way, from the phone to the computer, didn't work...possibly a 
> problem with the phone, possibly a problem with bluez (as it works under 
> windows...)]
> 
> My hcid.conf options are as follows:
> Options:
> autoinit yes;
> security auto;
> pairing multi;
> pin_helper /sbin/pintest
> 
> Device:
> name "BlueZ (%d)";
> class 0x100;
> iscan enable;
> pscan enable;
> lp rswitch,hold,sniff,park;
> lm accept,master;
> # Authentication and Encryption
> auth enable;
> encrypt enable;

if you still wanna use security mode 3 then go with it. If you set
yourself to master then go with it. These are not defaults settings and
there is a reason why.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




---------------------------------
新年願望第一位 :  找到友緣人 

--0-880580346-1108648977=:16442
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>
<DIV>Hi Jay!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Sorry to interrupt. In order that SE T610 can search and add PC into "My device list", you should do like this:</DIV>
<DIV># Authentication and Encryption<BR># auth enable;<BR># encrypt enable<BR>&nbsp;&nbsp;&nbsp; Or you can never let your T610 to search for and add your PC into the list.</DIV>
<DIV>&nbsp;&nbsp;&nbsp; But then, do you know how to connect T610 to PC instead of from PC to T610 (as I know that the method is typing "rfcomm connect 0 &lt;address&gt;").</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Hope that this can help you and then you can have method to do the connection from&nbsp;T610 to PC as I wish to do it in a short time.</DIV>
<DIV>Cherrs,</DIV>
<DIV>Michael<BR><B><I>Marcel Holtmann &lt;marcel@holtmann.org&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Jay,<BR><BR>&gt; I figured out how to pair with my T610 phone.<BR>&gt; <BR>&gt; Point 1: The computer must initiate the connection. (If you attempt to scan for <BR>&gt; new devices on your phone and add it there, apparently bluez will not accept <BR>&gt; incoming pairing requests. Something to do with roleswitch and bluez wanting to <BR>&gt; be the master? Perhaps...)<BR>&gt; <BR>&gt; Point 2: My version of blueZ ignores the /etc/bluetooth/pin file (even when in <BR>&gt; "auto" mode) and I HAD to replace the pin_helper with a link to a script which <BR>&gt; simply printed "PIN:1234" (replace number with your pin).<BR>&gt; <BR>&gt; So, once I replace "pin_helper /usr/bin/bluepin" with "pin_helper /sbin/pintest" <BR>&gt; (where the pintest file contained "echo "PIN:1234") and initiated an rfcomm <BR>&gt; connection to the phone with my pppd chat script, I was able to type the
  pin
 <BR>&gt; into my phone and pair.<BR>&gt; <BR>&gt; [(going the other way, from the phone to the computer, didn't work...possibly a <BR>&gt; problem with the phone, possibly a problem with bluez (as it works under <BR>&gt; windows...)]<BR>&gt; <BR>&gt; My hcid.conf options are as follows:<BR>&gt; Options:<BR>&gt; autoinit yes;<BR>&gt; security auto;<BR>&gt; pairing multi;<BR>&gt; pin_helper /sbin/pintest<BR>&gt; <BR>&gt; Device:<BR>&gt; name "BlueZ (%d)";<BR>&gt; class 0x100;<BR>&gt; iscan enable;<BR>&gt; pscan enable;<BR>&gt; lp rswitch,hold,sniff,park;<BR>&gt; lm accept,master;<BR>&gt; # Authentication and Encryption<BR>&gt; auth enable;<BR>&gt; encrypt enable;<BR><BR>if you still wanna use security mode 3 then go with it. If you set<BR>yourself to master then go with it. These are not defaults settings and<BR>there is a reason why.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Pro
 duct
 Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE></DIV><p><br><hr size=1>新年願望第一位 :  <a href=http://hk.personals.yahoo.com>找到友緣人 </a><br>
--0-880580346-1108648977=:16442--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

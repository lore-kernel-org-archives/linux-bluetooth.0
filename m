Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <b5fcf2320709141048r751551cj6ef245f92493cfa@mail.gmail.com>
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
	<AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
	<b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
	<FC45259F-96B7-4513-B655-21C1AE4867CC@cadvium.net>
	<b5fcf2320709140039m1e16fbc3r453bb52c0e04e0dc@mail.gmail.com>
	<6D0501F2-3D13-4229-98A2-D710C0D5B085@cadvium.net>
	<b5fcf2320709141039mebf6c84vc07e53dee647d8d9@mail.gmail.com>
	<b5fcf2320709141048r751551cj6ef245f92493cfa@mail.gmail.com>
Message-Id: <CA642A1C-20A0-4DEA-9C14-4CA0E74272A3@cadvium.net>
From: robert <rbscott@cadvium.net>
Date: Fri, 14 Sep 2007 11:01:54 -0700
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] handsfree or headset support on pc
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0071861200=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0071861200==
Content-Type: multipart/alternative; boundary=Apple-Mail-1-1032317070


--Apple-Mail-1-1032317070
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

I am not sure if that will work, unless the phone recognizes your  
computer as a handsfree device.  Normally there is a step in the  
phone where you have to add a handsfree device, and then you have to  
go through a handshake on that channel.

Also, make sure that you are connecting to the correct channel.  If  
you run

 >sdptool browse <bluetooth address of phone>

One should look like
Service Name: Handsfree Voice Gateway
Service Description: Handsfree Voice Gateway
Service Provider: /a/mobile/system/cl.gif
Service RecHandle: 0x10007
Service Class ID List:
   "Handfree Audio Gateway" (0x111f)
   "Generic Audio" (0x1203)
Protocol Descriptor List:
   "L2CAP" (0x0100)
   "RFCOMM" (0x0003)
     Channel: 7
Language Base Attr List:
   code_ISO639: 0x656e
   encoding:    0x6a
   base_offset: 0x100
   code_ISO639: 0x6672
   encoding:    0x6a
   base_offset: 0xc800
   code_ISO639: 0x6573
   encoding:    0x6a
   base_offset: 0xc803
   code_ISO639: 0x7074
   encoding:    0x6a
   base_offset: 0xc806
Profile Descriptor List:
   "Handsfree" (0x111e)
     Version: 0x0101

You have to connect to (or bind in your case) to rfcomm channel 7 (in  
this example).  Otherwise, the phone will not recognize that you are  
trying to connect as a headset.

Second, you have to complete the handshake defined inside of the  
bluetooth headset profile.  Once again, otherwise the phone will not  
recognize you as a headset.

There are a lot of little gotchas like this that are kind of hard to  
track down.  Once I figure them all out, I hope to write an article  
on my site, alongside of the code I release.

cheers,
--robert

On Sep 14, 2007, at 10:48 AM, andrey larin wrote:

> well the things i want to make samethin like phonecontrol.net in  
> windows
>
> for managing telephone and other there is a good tool gammu
>
> and when the call comes or maked i want to establish audio connection
>
> so i want to make it work after HF profile is registred and  
> listening service is running
> as i understand the audio is channelles
>
> the listening service is the goal
>
>
>
> 2007/9/14, andrey larin <ubergitler@gmail.com>:
> well
> what i do..
> in gentoo and testing 2 phones SonyEricsson-w800 and Nokia 5200
>
> install bluez
>
> registered HF service using sdptool
>
> using hcitool and sdptool
> finding phone and it rfcomm channel
> on phone i set that my pc is can always connect to phone
> binding using rfcomm to /dev/rfcomm0
> and just using minicom
>
> i even make a stupid script in bash to connect to rfcomm on phone
>
> when the ring comes i try at command to request audio channel
>
> but nothing
>
> maybe same thing foget to tell
>
> 2007/9/14, robert < rbscott@cadvium.net>:
> Hello Andrey,
>
> let me back up for a second and ask how you are trying to access the
> handsfree?
>
> Is the phone paired with your computer?
> Is the phone paired with your computer as a Handsfree device?
> What kind of phone are you using?
> For your RFCOMM channel, are you connecting to the channel  channel
> are you connecting to on the phone?
> How are you handing the RFCOMM processing?
>
> I left out some steps about Service Discovery and Pairing that I
> assumed you already completed.
>
> --robert
>
> On Sep 14, 2007, at 12:39 AM, andrey larin wrote:
>
> > i try to do something similar but
> > last time a wrote programs was wery long ago so
> > i don't understud your code in proper :((
> > but i tried to do as you say
> >
> > and nothing happens
> >
> > coud you explain what your code exactly do ?
> >
> >
>
>
> ---------------------------------------------------------------------- 
> ---
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
> ---------------------------------------------------------------------- 
> ---
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/ 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


--Apple-Mail-1-1032317070
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space; ">I am not sure if that will =
work, unless the phone recognizes your computer as a handsfree device. =
=A0Normally there is a step in the phone where you have to add a =
handsfree device, and then you have to go through a handshake on that =
channel.<div><br class=3D"webkit-block-placeholder"></div><div>Also, =
make sure that you are connecting to the correct channel. =A0If you =
run=A0</div><div><br =
class=3D"webkit-block-placeholder"></div><div>&gt;sdptool browse =
&lt;bluetooth address of phone&gt;</div><div><br =
class=3D"webkit-block-placeholder"></div><div>One should look =
like</div><div><div>Service Name: Handsfree Voice =
Gateway</div><div>Service Description: Handsfree Voice =
Gateway</div><div>Service Provider: =
/a/mobile/system/cl.gif</div><div>Service RecHandle: =
0x10007</div><div>Service Class ID List:</div><div>=A0=A0"Handfree Audio =
Gateway" (0x111f)</div><div>=A0=A0"Generic Audio" =
(0x1203)</div><div>Protocol Descriptor List:</div><div>=A0=A0"L2CAP" =
(0x0100)</div><div>=A0=A0"RFCOMM" (0x0003)</div><div>=A0=A0 =A0Channel: =
7</div><div>Language Base Attr List:</div><div>=A0=A0code_ISO639: =
0x656e</div><div>=A0=A0encoding: =A0 =A00x6a</div><div>=A0=A0base_offset: =
0x100</div><div>=A0=A0code_ISO639: 0x6672</div><div>=A0=A0encoding: =A0 =
=A00x6a</div><div>=A0=A0base_offset: 0xc800</div><div>=A0=A0code_ISO639: =
0x6573</div><div>=A0=A0encoding: =A0 =A00x6a</div><div>=A0=A0base_offset: =
0xc803</div><div>=A0=A0code_ISO639: 0x7074</div><div>=A0=A0encoding: =A0 =
=A00x6a</div><div>=A0=A0base_offset: 0xc806</div><div>Profile Descriptor =
List:</div><div>=A0=A0"Handsfree" (0x111e)</div><div>=A0=A0 =A0Version: =
0x0101</div><div><br class=3D"webkit-block-placeholder"></div><div>You =
have to connect to (or bind in your case) to rfcomm channel 7 (in this =
example). =A0Otherwise, the phone will not recognize that you are trying =
to connect as a headset.</div><div><br =
class=3D"webkit-block-placeholder"></div><div>Second, you have to =
complete the handshake defined inside of the bluetooth headset profile. =
=A0Once again, otherwise the phone will not recognize you as a =
headset.</div><div><br class=3D"webkit-block-placeholder"></div><div>There=
 are a lot of little gotchas like this that are kind of hard to track =
down. =A0Once I figure them all out, I hope to write an article on my =
site, alongside of the code I release.</div><div><br =
class=3D"webkit-block-placeholder"></div><div>cheers,</div><div>--robert</=
div></div><div><br><div><div>On Sep 14, 2007, at 10:48 AM, andrey larin =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">well the things i want to make samethin like <a =
href=3D"http://phonecontrol.net">phonecontrol.net</a> in =
windows<br><br>for managing telephone and other there is a good tool =
gammu<br><br>and when the call comes or maked i want to establish audio =
connection <br><br>so i want to make it work after HF profile is =
registred and listening service is running<br>as i understand the audio =
is channelles<br> <br>the listening service is the =
goal<br><br><br><br><div><span class=3D"gmail_quote"> 2007/9/14, andrey =
larin &lt;<a =
href=3D"mailto:ubergitler@gmail.com">ubergitler@gmail.com</a>&gt;:</span><=
blockquote class=3D"gmail_quote" style=3D"margin-top: 0; margin-right: =
0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; =
border-left-color: #cccccc; border-left-width: 1px; border-left-style: =
solid; padding-left: 1ex"> well<br>what i do..<br>in gentoo and testing =
2 phones SonyEricsson-w800 and Nokia 5200<br><br>install =
bluez<br><br>registered HF service using sdptool<br><br>using hcitool =
and sdptool <br>finding phone and it rfcomm channel <br>on phone i set =
that my pc is can always connect to phone<br>binding using rfcomm to =
/dev/rfcomm0<br>and just using minicom<br><br>i even make a stupid =
script in bash to connect to rfcomm on phone<br><br>when the ring comes =
i try at command to request audio channel  <br><br>but =
nothing<br><br>maybe same thing foget to tell<br><br><div><span =
class=3D"q"><span class=3D"gmail_quote">2007/9/14, robert &lt;<a =
href=3D"mailto:rbscott@cadvium.net" target=3D"_blank" onclick=3D"return =
top.js.OpenExtLink(window,event,this)"> =
rbscott@cadvium.net</a>&gt;:</span></span><div><span class=3D"e" =
id=3D"q_115051ab5bcbcc63_2"><blockquote class=3D"gmail_quote" =
style=3D"margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: =
0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: =
1px; border-left-style: solid; padding-left: 1ex"> Hello =
Andrey,<br><br>let me back up for a second and ask how you are trying to =
access the<br>handsfree?<br><br>Is the phone paired with your =
computer?<br>Is the phone paired with your computer as a Handsfree =
device?<br>What kind of phone are you using? <br>For your RFCOMM =
channel, are you connecting to the channel=A0=A0channel<br>are you =
connecting to on the phone?<br>How are you handing the RFCOMM =
processing?<br><br>I left out some steps about Service Discovery and =
Pairing that I <br>assumed you already =
completed.<br><br>--robert<br><br>On Sep 14, 2007, at 12:39 AM, andrey =
larin wrote:<br><br>&gt; i try to do something similar but<br>&gt; last =
time a wrote programs was wery long ago so<br>&gt; i don't understud =
your code in proper :(( <br>&gt; but i tried to do as you =
say<br>&gt;<br>&gt; and nothing happens<br>&gt;<br>&gt; coud you explain =
what your code exactly do =
?<br>&gt;<br>&gt;<br><br><br>---------------------------------------------=
---------------------------- <br>This SF.net email is sponsored by: =
Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a =
href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" =
target=3D"_blank" onclick=3D"return =
top.js.OpenExtLink(window,event,this)"> =
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/ =
</a><br>_______________________________________________<br>Bluez-devel =
mailing list<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net" =
target=3D"_blank" onclick=3D"return =
top.js.OpenExtLink(window,event,this)"> =
Bluez-devel@lists.sourceforge.net</a><br><a =
href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" =
target=3D"_blank" onclick=3D"return =
top.js.OpenExtLink(window,event,this)"> =
https://lists.sourceforge.net/lists/listinfo/bluez-devel =
</a><br></blockquote></span></div></div><br></blockquote></div><br><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; =
">------------------------------------------------------------------------=
-</div><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: =
0px; margin-left: 0px; ">This SF.net email is sponsored by: =
Microsoft</div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Defy all challenges. =
Microsoft(R) Visual Studio 2005.</div><div style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/___________=
____________________________________">http://clk.atdmt.com/MRT/go/vse01200=
00070mrt/direct/01/_______________________________________________</a></di=
v><div style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Bluez-devel mailing list</div><div =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><a =
href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.source=
forge.net</a></div><div style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><a =
href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://=
lists.sourceforge.net/lists/listinfo/bluez-devel</a></div> =
</blockquote></div><br></div></body></html>=

--Apple-Mail-1-1032317070--


--===============0071861200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0071861200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0071861200==--

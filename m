Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <b5fcf2320709141048r751551cj6ef245f92493cfa@mail.gmail.com>
Date: Fri, 14 Sep 2007 21:48:42 +0400
From: "andrey larin" <ubergitler@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <b5fcf2320709141039mebf6c84vc07e53dee647d8d9@mail.gmail.com>
MIME-Version: 1.0
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
	<AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
	<b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
	<FC45259F-96B7-4513-B655-21C1AE4867CC@cadvium.net>
	<b5fcf2320709140039m1e16fbc3r453bb52c0e04e0dc@mail.gmail.com>
	<6D0501F2-3D13-4229-98A2-D710C0D5B085@cadvium.net>
	<b5fcf2320709141039mebf6c84vc07e53dee647d8d9@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0195868841=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0195868841==
Content-Type: multipart/alternative;
	boundary="----=_Part_3046_19448291.1189792122835"

------=_Part_3046_19448291.1189792122835
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

well the things i want to make samethin like phonecontrol.net in windows

for managing telephone and other there is a good tool gammu

and when the call comes or maked i want to establish audio connection

so i want to make it work after HF profile is registred and listening
service is running
as i understand the audio is channelles

the listening service is the goal



2007/9/14, andrey larin <ubergitler@gmail.com>:
>
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
> 2007/9/14, robert <rbscott@cadvium.net>:
> >
> > Hello Andrey,
> >
> > let me back up for a second and ask how you are trying to access the
> > handsfree?
> >
> > Is the phone paired with your computer?
> > Is the phone paired with your computer as a Handsfree device?
> > What kind of phone are you using?
> > For your RFCOMM channel, are you connecting to the channel  channel
> > are you connecting to on the phone?
> > How are you handing the RFCOMM processing?
> >
> > I left out some steps about Service Discovery and Pairing that I
> > assumed you already completed.
> >
> > --robert
> >
> > On Sep 14, 2007, at 12:39 AM, andrey larin wrote:
> >
> > > i try to do something similar but
> > > last time a wrote programs was wery long ago so
> > > i don't understud your code in proper :((
> > > but i tried to do as you say
> > >
> > > and nothing happens
> > >
> > > coud you explain what your code exactly do ?
> > >
> > >
> >
> >
> > -------------------------------------------------------------------------
> >
> > This SF.net email is sponsored by: Microsoft
> > Defy all challenges. Microsoft(R) Visual Studio 2005.
> > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > _______________________________________________
> > Bluez-devel mailing list
> > Bluez-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
>
>

------=_Part_3046_19448291.1189792122835
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

well the things i want to make samethin like <a href="http://phonecontrol.net">phonecontrol.net</a> in windows<br><br>for managing telephone and other there is a good tool gammu<br><br>and when the call comes or maked i want to establish audio connection
<br><br>so i want to make it work after HF profile is registred and listening service is running<br>as i understand the audio is channelles<br> <br>the listening service is the goal<br><br><br><br><div><span class="gmail_quote">
2007/9/14, andrey larin &lt;<a href="mailto:ubergitler@gmail.com">ubergitler@gmail.com</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
well<br>what i do..<br>in gentoo and testing 2 phones SonyEricsson-w800 and Nokia 5200<br><br>install bluez<br><br>registered HF service using sdptool<br><br>using hcitool and sdptool <br>finding phone and it rfcomm channel 
<br>on phone i set that my pc is can always connect to phone<br>binding using rfcomm to /dev/rfcomm0<br>and just using minicom<br><br>i even make a stupid script in bash to connect to rfcomm on phone<br><br>when the ring comes i try at command to request audio channel  
<br><br>but nothing<br><br>maybe same thing foget to tell<br><br><div><span class="q"><span class="gmail_quote">2007/9/14, robert &lt;<a href="mailto:rbscott@cadvium.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
rbscott@cadvium.net</a>&gt;:</span></span><div><span class="e" id="q_115051ab5bcbcc63_2"><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
 Hello Andrey,<br><br>let me back up for a second and ask how you are trying to access the<br>handsfree?<br><br>Is the phone paired with your computer?<br>Is the phone paired with your computer as a Handsfree device?<br>What kind of phone are you using? 
<br>For your RFCOMM channel, are you connecting to the channel&nbsp;&nbsp;channel<br>are you connecting to on the phone?<br>How are you handing the RFCOMM processing?<br><br>I left out some steps about Service Discovery and Pairing that I 
<br>assumed you already completed.<br><br>--robert<br><br>On Sep 14, 2007, at 12:39 AM, andrey larin wrote:<br><br>&gt; i try to do something similar but<br>&gt; last time a wrote programs was wery long ago so<br>&gt; i don&#39;t understud your code in proper :(( 
<br>&gt; but i tried to do as you say<br>&gt;<br>&gt; and nothing happens<br>&gt;<br>&gt; coud you explain what your code exactly do ?<br>&gt;<br>&gt;<br><br><br>------------------------------------------------------------------------- 
<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/ </a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br></blockquote></span></div></div><br></blockquote></div><br>

------=_Part_3046_19448291.1189792122835--


--===============0195868841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0195868841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0195868841==--

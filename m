Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <b5fcf2320709141131w9a65e34sadda702125374616@mail.gmail.com>
Date: Fri, 14 Sep 2007 22:31:48 +0400
From: "andrey larin" <ubergitler@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <CA642A1C-20A0-4DEA-9C14-4CA0E74272A3@cadvium.net>
MIME-Version: 1.0
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
	<AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
	<b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
	<FC45259F-96B7-4513-B655-21C1AE4867CC@cadvium.net>
	<b5fcf2320709140039m1e16fbc3r453bb52c0e04e0dc@mail.gmail.com>
	<6D0501F2-3D13-4229-98A2-D710C0D5B085@cadvium.net>
	<b5fcf2320709141039mebf6c84vc07e53dee647d8d9@mail.gmail.com>
	<b5fcf2320709141048r751551cj6ef245f92493cfa@mail.gmail.com>
	<CA642A1C-20A0-4DEA-9C14-4CA0E74272A3@cadvium.net>
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
Content-Type: multipart/mixed; boundary="===============1612230193=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1612230193==
Content-Type: multipart/alternative;
	boundary="----=_Part_3240_6022500.1189794708714"

------=_Part_3240_6022500.1189794708714
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

here is one of the moment
did i must bind rfcomm to phone channel where the serial port is shown or to
where the audio gateway is shown ?

2007/9/14, robert <rbscott@cadvium.net>:
>
> I am not sure if that will work, unless the phone recognizes your computer
> as a handsfree device.  Normally there is a step in the phone where you have
> to add a handsfree device, and then you have to go through a handshake on
> that channel.
> Also, make sure that you are connecting to the correct channel.  If you
> run
>
> >sdptool browse <bluetooth address of phone>
>
> One should look like
> Service Name: Handsfree Voice Gateway
> Service Description: Handsfree Voice Gateway
> Service Provider: /a/mobile/system/cl.gif
> Service RecHandle: 0x10007
> Service Class ID List:
>   "Handfree Audio Gateway" (0x111f)
>   "Generic Audio" (0x1203)
> Protocol Descriptor List:
>   "L2CAP" (0x0100)
>   "RFCOMM" (0x0003)
>     Channel: 7
> Language Base Attr List:
>   code_ISO639: 0x656e
>   encoding:    0x6a
>   base_offset: 0x100
>   code_ISO639: 0x6672
>   encoding:    0x6a
>   base_offset: 0xc800
>   code_ISO639: 0x6573
>   encoding:    0x6a
>   base_offset: 0xc803
>   code_ISO639: 0x7074
>   encoding:    0x6a
>   base_offset: 0xc806
> Profile Descriptor List:
>   "Handsfree" (0x111e)
>     Version: 0x0101
>
> You have to connect to (or bind in your case) to rfcomm channel 7 (in this
> example).  Otherwise, the phone will not recognize that you are trying to
> connect as a headset.
>
> Second, you have to complete the handshake defined inside of the bluetooth
> headset profile.  Once again, otherwise the phone will not recognize you as
> a headset.
>
> There are a lot of little gotchas like this that are kind of hard to track
> down.  Once I figure them all out, I hope to write an article on my site,
> alongside of the code I release.
>
> cheers,
> --robert
>
> On Sep 14, 2007, at 10:48 AM, andrey larin wrote:
>
> well the things i want to make samethin like phonecontrol.net in windows
>
> for managing telephone and other there is a good tool gammu
>
> and when the call comes or maked i want to establish audio connection
>
> so i want to make it work after HF profile is registred and listening
> service is running
> as i understand the audio is channelles
>
> the listening service is the goal
>
>
>
> 2007/9/14, andrey larin <ubergitler@gmail.com>:
> >
> > well
> > what i do..
> > in gentoo and testing 2 phones SonyEricsson-w800 and Nokia 5200
> >
> > install bluez
> >
> > registered HF service using sdptool
> >
> > using hcitool and sdptool
> > finding phone and it rfcomm channel
> > on phone i set that my pc is can always connect to phone
> > binding using rfcomm to /dev/rfcomm0
> > and just using minicom
> >
> > i even make a stupid script in bash to connect to rfcomm on phone
> >
> > when the ring comes i try at command to request audio channel
> >
> > but nothing
> >
> > maybe same thing foget to tell
> >
> > 2007/9/14, robert < rbscott@cadvium.net>:
> > >
> > > Hello Andrey,
> > >
> > > let me back up for a second and ask how you are trying to access the
> > > handsfree?
> > >
> > > Is the phone paired with your computer?
> > > Is the phone paired with your computer as a Handsfree device?
> > > What kind of phone are you using?
> > > For your RFCOMM channel, are you connecting to the channel  channel
> > > are you connecting to on the phone?
> > > How are you handing the RFCOMM processing?
> > >
> > > I left out some steps about Service Discovery and Pairing that I
> > > assumed you already completed.
> > >
> > > --robert
> > >
> > > On Sep 14, 2007, at 12:39 AM, andrey larin wrote:
> > >
> > > > i try to do something similar but
> > > > last time a wrote programs was wery long ago so
> > > > i don't understud your code in proper :((
> > > > but i tried to do as you say
> > > >
> > > > and nothing happens
> > > >
> > > > coud you explain what your code exactly do ?
> > > >
> > > >
> > >
> > >
> > > -------------------------------------------------------------------------
> > >
> > > This SF.net email is sponsored by: Microsoft
> > > Defy all challenges. Microsoft(R) Visual Studio 2005.
> > > http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> > > _______________________________________________
> > > Bluez-devel mailing list
> > > Bluez-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/bluez-devel
> > >
> >
> >
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
>
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/_______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2005.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>

------=_Part_3240_6022500.1189794708714
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

here is one of the moment<br>did i must bind rfcomm    to phone channel where the serial port is shown or to where the audio gateway is shown ?<br><br><div><span class="gmail_quote">2007/9/14, robert &lt;<a href="mailto:rbscott@cadvium.net">
rbscott@cadvium.net</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
<div>I am not sure if that will work, unless the phone recognizes your computer as a handsfree device. &nbsp;Normally there is a step in the phone where you have to add a handsfree device, and then you have to go through a handshake on that channel.
<div><br></div><div>Also, make sure that you are connecting to the correct channel. &nbsp;If you run&nbsp;</div><div><br></div><div>&gt;sdptool browse &lt;bluetooth address of phone&gt;</div><div><br></div><div>One should look like
</div><div><div>Service Name: Handsfree Voice Gateway</div><div>Service Description: Handsfree Voice Gateway</div><div>Service Provider: /a/mobile/system/cl.gif</div><div>Service RecHandle: 0x10007</div><div>Service Class ID List:
</div><div>&nbsp;&nbsp;&quot;Handfree Audio Gateway&quot; (0x111f)</div><div>&nbsp;&nbsp;&quot;Generic Audio&quot; (0x1203)</div><div>Protocol Descriptor List:</div><div>&nbsp;&nbsp;&quot;L2CAP&quot; (0x0100)</div><div>&nbsp;&nbsp;&quot;RFCOMM&quot; (0x0003)</div>
<div>&nbsp;&nbsp; &nbsp;Channel: 7</div><div>Language Base Attr List:</div><div>&nbsp;&nbsp;code_ISO639: 0x656e</div><div>&nbsp;&nbsp;encoding: &nbsp; &nbsp;0x6a</div><div>&nbsp;&nbsp;base_offset: 0x100</div><div>&nbsp;&nbsp;code_ISO639: 0x6672</div><div>&nbsp;&nbsp;encoding: &nbsp; &nbsp;0x6a</div><div>&nbsp;&nbsp;base_offset: 0xc800
</div><div>&nbsp;&nbsp;code_ISO639: 0x6573</div><div>&nbsp;&nbsp;encoding: &nbsp; &nbsp;0x6a</div><div>&nbsp;&nbsp;base_offset: 0xc803</div><div>&nbsp;&nbsp;code_ISO639: 0x7074</div><div>&nbsp;&nbsp;encoding: &nbsp; &nbsp;0x6a</div><div>&nbsp;&nbsp;base_offset: 0xc806</div><div>Profile Descriptor List:
</div><div>&nbsp;&nbsp;&quot;Handsfree&quot; (0x111e)</div><div>&nbsp;&nbsp; &nbsp;Version: 0x0101</div><div><br></div><div>You have to connect to (or bind in your case) to rfcomm channel 7 (in this example). &nbsp;Otherwise, the phone will not recognize that you are trying to connect as a headset.
</div><div><br></div><div>Second, you have to complete the handshake defined inside of the bluetooth headset profile. &nbsp;Once again, otherwise the phone will not recognize you as a headset.</div><div><br></div><div>There are a lot of little gotchas like this that are kind of hard to track down. &nbsp;Once I figure them all out, I hope to write an article on my site, alongside of the code I release.
</div><div><br></div><div>cheers,</div><div>--robert</div></div><div><br><div><div><span class="e" id="q_115052feb5c2a9d5_1"><div>On Sep 14, 2007, at 10:48 AM, andrey larin wrote:</div><br></span></div><blockquote type="cite">
<div><span class="e" id="q_115052feb5c2a9d5_3">well the things i want to make samethin like <a href="http://phonecontrol.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">phonecontrol.net</a> in windows
<br><br>for managing telephone and other there is a good tool gammu<br><br>and when the call comes or maked i want to establish audio connection <br><br>so i want to make it work after HF profile is registred and listening service is running
<br>as i understand the audio is channelles<br><br>the listening service is the goal<br><br><br><br><div><span class="gmail_quote"> 2007/9/14, andrey larin &lt;<a href="mailto:ubergitler@gmail.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
ubergitler@gmail.com</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
 well<br>what i do..<br>in gentoo and testing 2 phones SonyEricsson-w800 and Nokia 5200<br><br>install bluez<br><br>registered HF service using sdptool<br><br>using hcitool and sdptool <br>finding phone and it rfcomm channel 
<br>on phone i set that my pc is can always connect to phone<br>binding using rfcomm to /dev/rfcomm0<br>and just using minicom<br><br>i even make a stupid script in bash to connect to rfcomm on phone<br><br>when the ring comes i try at command to request audio channel  
<br><br>but nothing<br><br>maybe same thing foget to tell<br><br><div><span><span class="gmail_quote">2007/9/14, robert &lt;<a href="mailto:rbscott@cadvium.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
 rbscott@cadvium.net</a>&gt;:</span></span><div><span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
 Hello Andrey,<br><br>let me back up for a second and ask how you are trying to access the<br>handsfree?<br><br>Is the phone paired with your computer?<br>Is the phone paired with your computer as a Handsfree device?<br>What kind of phone are you using? 
<br>For your RFCOMM channel, are you connecting to the channel&nbsp;&nbsp;channel<br>are you connecting to on the phone?<br>How are you handing the RFCOMM processing?<br><br>I left out some steps about Service Discovery and Pairing that I 
<br>assumed you already completed.<br><br>--robert<br><br>On Sep 14, 2007, at 12:39 AM, andrey larin wrote:<br><br>&gt; i try to do something similar but<br>&gt; last time a wrote programs was wery long ago so<br>&gt; i don&#39;t understud your code in proper :(( 
<br>&gt; but i tried to do as you say<br>&gt;<br>&gt; and nothing happens<br>&gt;<br>&gt; coud you explain what your code exactly do ?<br>&gt;<br>&gt;<br><br><br>------------------------------------------------------------------------- 
<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
 http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/ </a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
 Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)"> https://lists.sourceforge.net/lists/listinfo/bluez-devel 
</a><br></blockquote></span></div></div><br></blockquote></div><br></span></div><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px">-------------------------------------------------------------------------
</div><span class="q"><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px">This SF.net email is sponsored by: Microsoft</div><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px">
Defy all challenges. Microsoft(R) Visual Studio 2005.</div><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px"><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/_______________________________________________" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/_______________________________________________</a></div><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px">Bluez-devel mailing list
</div><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px"><a href="mailto:Bluez-devel@lists.sourceforge.net" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Bluez-devel@lists.sourceforge.net
</a></div><div style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px"><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a></div></span></blockquote></div><br></div></div><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft
<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target="_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel" target="_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br><br></blockquote>
</div><br>

------=_Part_3240_6022500.1189794708714--


--===============1612230193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1612230193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1612230193==--

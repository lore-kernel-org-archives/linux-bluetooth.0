Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <b5fcf2320709140039m1e16fbc3r453bb52c0e04e0dc@mail.gmail.com>
Date: Fri, 14 Sep 2007 07:39:50 +0000
From: "andrey larin" <ubergitler@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FC45259F-96B7-4513-B655-21C1AE4867CC@cadvium.net>
MIME-Version: 1.0
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
	<AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
	<b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
	<FC45259F-96B7-4513-B655-21C1AE4867CC@cadvium.net>
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
Content-Type: multipart/mixed; boundary="===============0104782504=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0104782504==
Content-Type: multipart/alternative;
	boundary="----=_Part_594_23089080.1189755590710"

------=_Part_594_23089080.1189755590710
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i try to do something similar but
last time a wrote programs was wery long ago so
i don't understud your code in proper :((
but i tried to do as you say

and nothing happens

coud you explain what your code exactly do ?


2007/9/14, robert <rbscott@cadvium.net>:
>
> so here is a sample of the c part that I am writing.  (from your
> description, it seems that you and I are doing something similar).
> This is a pretty primitive code sample, and there are examples
> (probably better) in bluez-utils that do similar things.
> Furthermore, this presently only handles the speaker, not the mic.
> The second part is an easy addition.
>
> http://www.cadvium.net/files/source/sco-manager.tar.gz
>
>   gpl
>
> > make
> ## basically, you start it up with a file. (the bluetooth address is
> ignored but should be formatted properly).
> > sco-manager <bluetooth-address> <file-name>
>
> This will listen for an sco connection on the first bluetooth device
> that it finds.  It will then take any data that it receives and write
> it into the file specified on the command line.  (I think it also
> generates a tonne of debugging too).
>
> This is more useful if you specify a pipe for the file:
> > mkfifo test.sco
> ## Setup voice correctly
> > sudo hciconfig hci0 voice 0x0060
> > cat test.sco | aplay -f S16 &
> > sco-manager <bluetooth-address> test.sco
>
> At this point, if you make a call, it will send the audio through out
> your speakers.  (Make sure to turn them down, if something isn't
> setup properly it makes a terrible noise).
>
> hope this helps,
> --robert
>
>
>
>
>
>
>
>
> On Sep 13, 2007, at 10:17 PM, andrey larin wrote:
>
> > ok here is what i think:
> > there is no problem to create and communicate rfcomm
> >
> > i don't know what connection must be make to control the audio
> > ( special rfcomm to audiogateway on phone or usual  rfcomm to ssp
> > on phone)
> >
> > must unreserched area is how to handle the audio managment ( open,
> > support ,close, route audio from pc microphone to phone ,from phone
> > to pc speakers)
> >
> >
> > so
> >
> > when i connect on my phones spp
> > and make call to my cell phone
> > on terminal my phone says `RING`
> > i need to command the to make an audio connection (SCO)
> > and route this connections
> >
> > how to do this ?
> >
> >
> >
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

------=_Part_594_23089080.1189755590710
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

i try to do something similar but <br>last time a wrote programs was wery long ago so<br>i don&#39;t understud your code in proper :((<br>but i tried to do as you say<br><br>and nothing happens<br><br>coud you explain what your code exactly do ?
<br><br><br><div><span class="gmail_quote">2007/9/14, robert &lt;<a href="mailto:rbscott@cadvium.net">rbscott@cadvium.net</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
so here is a sample of the c part that I am writing.&nbsp;&nbsp;(from your<br>description, it seems that you and I are doing something similar).<br>This is a pretty primitive code sample, and there are examples<br>(probably better) in bluez-utils that do similar things.
<br>Furthermore, this presently only handles the speaker, not the mic.<br>The second part is an easy addition.<br><br><a href="http://www.cadvium.net/files/source/sco-manager.tar.gz">http://www.cadvium.net/files/source/sco-manager.tar.gz
</a><br><br>&nbsp;&nbsp;gpl<br><br> &gt; make<br>## basically, you start it up with a file. (the bluetooth address is<br>ignored but should be formatted properly).<br> &gt; sco-manager &lt;bluetooth-address&gt; &lt;file-name&gt;<br>
<br>This will listen for an sco connection on the first bluetooth device<br>that it finds.&nbsp;&nbsp;It will then take any data that it receives and write<br>it into the file specified on the command line.&nbsp;&nbsp;(I think it also<br>generates a tonne of debugging too).
<br><br>This is more useful if you specify a pipe for the file:<br> &gt; mkfifo test.sco<br>## Setup voice correctly<br> &gt; sudo hciconfig hci0 voice 0x0060<br> &gt; cat test.sco | aplay -f S16 &amp;<br> &gt; sco-manager &lt;bluetooth-address&gt; 
test.sco<br><br>At this point, if you make a call, it will send the audio through out<br>your speakers.&nbsp;&nbsp;(Make sure to turn them down, if something isn&#39;t<br>setup properly it makes a terrible noise).<br><br>hope this helps,
<br>--robert<br><br><br><br><br><br><br><br><br>On Sep 13, 2007, at 10:17 PM, andrey larin wrote:<br><br>&gt; ok here is what i think:<br>&gt; there is no problem to create and communicate rfcomm<br>&gt;<br>&gt; i don&#39;t know what connection must be make to control the audio
<br>&gt; ( special rfcomm to audiogateway on phone or usual&nbsp;&nbsp;rfcomm to ssp<br>&gt; on phone)<br>&gt;<br>&gt; must unreserched area is how to handle the audio managment ( open,<br>&gt; support ,close, route audio from pc microphone to phone ,from phone
<br>&gt; to pc speakers)<br>&gt;<br>&gt;<br>&gt; so<br>&gt;<br>&gt; when i connect on my phones spp<br>&gt; and make call to my cell phone<br>&gt; on terminal my phone says `RING`<br>&gt; i need to command the to make an audio connection (SCO)
<br>&gt; and route this connections<br>&gt;<br>&gt; how to do this ?<br>&gt;<br>&gt;<br>&gt;<br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft
<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________
<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel
</a><br></blockquote></div><br>

------=_Part_594_23089080.1189755590710--


--===============0104782504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0104782504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0104782504==--

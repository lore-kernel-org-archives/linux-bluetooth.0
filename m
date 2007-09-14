Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <b5fcf2320709132217x50ce9cbbsb55bd39b4239db80@mail.gmail.com>
Date: Fri, 14 Sep 2007 05:17:25 +0000
From: "andrey larin" <ubergitler@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
MIME-Version: 1.0
References: <E21A90CDB9591542899EFC7FB4ED5CC90576575C@tfmail02.TFMAIL.COM>
	<AE056821-FE53-4A5B-8761-81908AC41E70@cadvium.net>
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
Content-Type: multipart/mixed; boundary="===============0022875950=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0022875950==
Content-Type: multipart/alternative;
	boundary="----=_Part_283_29286957.1189747045480"

------=_Part_283_29286957.1189747045480
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok here is what i think:
there is no problem to create and communicate rfcomm

i don't know what connection must be make to control the audio( special
rfcomm to audiogateway on phone or usual  rfcomm to ssp on phone)

must unreserched area is how to handle the audio managment ( open, support
,close, route audio from pc microphone to phone ,from phone to pc speakers)


so

when i connect on my phones spp
and make call to my cell phone
on terminal my phone says `RING`
i need to command the to make an audio connection (SCO)
and route this connections

how to do this ?


2007/9/14, robert <rbscott@cadvium.net>:
>
> Hello Andrey Larin,
>
> The Headset profile has two sides to it.  There is the Audio Gateway
> (AG) which is typically a cell phone, and then the Hands-Free unit (HF).
>
> I think there has been a lot of development on the Audio Gateway(AG)
> side, because it is really useful to be able to play music on your
> computer and have it come out of your bluetooth headphones.
>
> As far as I can tell(and someone please correct me if I am wrong),
> there are not as many projects dedicated to implementing the HF side,
> this is the side one of the projects i am working on is
> implementing.  Essentially there are two channels, the RFCOMM channel
> which essentially acts as the control channel, and then the SCO
> channel which is for sending audio data back and forth.  I wrote a
> program to handle RFCOMM channel and service discovery in java, and
> presently have a basic SCO manager (in c) for the SCO data and am
> working on a way to actually play it.
>
> I hope to put the code online soon, but right now I am trying to
> learn how to use D-BUS in order to make the two parts communicate
> with one another.
>
> Hope that helps,
> --robert
>
>
> On Sep 13, 2007, at 6:45 PM, guoyun wrote:
>
> > Hi andrey larin
> >
> >> From your description,  the headset need to open visibility to be
> >> found. Hope this is not your tiny mistake. :-)
> >
> > Cheers
> >
> > -Gawain.
> >
> >
> > ________________________________
> >
> >       From: bluez-devel-bounces@lists.sourceforge.net [mailto:bluez-
> > devel-bounces@lists.sourceforge.net] On Behalf Of andrey larin
> >       Sent: Friday, September 14, 2007 4:49 AM
> >       To: BlueZ development
> >       Subject: Re: [Bluez-devel] handsfree or headset support on pc
> >
> >
> >       after all i see while serching
> >       i think this:
> >
> >       currently software is able to handle this
> >       but requred some tuning
> >
> >       but may be i wrong :)
> >
> >       so i more interested in technical details
> >
> >       if you could provide ... some :)
> >
> >       or say that i wrong and there is requerd a lot of coding
> >
> >
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

------=_Part_283_29286957.1189747045480
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok here is what i think:<br>there is no problem to create and communicate rfcomm<br><br>i don&#39;t know what connection must be make to control the audio( special rfcomm to audiogateway on phone or usual &nbsp;rfcomm to ssp on phone)
<br><br>must unreserched area is how to handle the audio managment (  open, support ,close, route audio from pc microphone to phone ,from phone to pc speakers)<br><br><br>so<br><br>when i connect on my phones spp<br>and make call to my cell phone 
<br>on terminal my  phone says `RING`<br>i need to command the to make an audio connection (SCO) <br>and route this connections<br><br>how to do this ?<br><br><br><div><span class="gmail_quote">2007/9/14, robert &lt;<a href="mailto:rbscott@cadvium.net">
rbscott@cadvium.net</a>&gt;:</span><blockquote class="gmail_quote" style="margin-top: 0; margin-right: 0; margin-bottom: 0; margin-left: 0; margin-left: 0.80ex; border-left-color: #cccccc; border-left-width: 1px; border-left-style: solid; padding-left: 1ex">
Hello Andrey Larin,<br><br>The Headset profile has two sides to it.&nbsp;&nbsp;There is the Audio Gateway<br>(AG) which is typically a cell phone, and then the Hands-Free unit (HF).<br><br>I think there has been a lot of development on the Audio Gateway(AG)
<br>side, because it is really useful to be able to play music on your<br>computer and have it come out of your bluetooth headphones.<br><br>As far as I can tell(and someone please correct me if I am wrong),<br>there are not as many projects dedicated to implementing the HF side,
<br>this is the side one of the projects i am working on is<br>implementing.&nbsp;&nbsp;Essentially there are two channels, the RFCOMM channel<br>which essentially acts as the control channel, and then the SCO<br>channel which is for sending audio data back and forth.&nbsp;&nbsp;I wrote a
<br>program to handle RFCOMM channel and service discovery in java, and<br>presently have a basic SCO manager (in c) for the SCO data and am<br>working on a way to actually play it.<br><br>I hope to put the code online soon, but right now I am trying to
<br>learn how to use D-BUS in order to make the two parts communicate<br>with one another.<br><br>Hope that helps,<br>--robert<br><br><br>On Sep 13, 2007, at 6:45 PM, guoyun wrote:<br><br>&gt; Hi andrey larin<br>&gt;<br>&gt;&gt; From your description,&nbsp;&nbsp;the headset need to open visibility to be
<br>&gt;&gt; found. Hope this is not your tiny mistake. :-)<br>&gt;<br>&gt; Cheers<br>&gt;<br>&gt; -Gawain.<br>&gt;<br>&gt;<br>&gt; ________________________________<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From: <a href="mailto:bluez-devel-bounces@lists.sourceforge.net">
bluez-devel-bounces@lists.sourceforge.net</a> [mailto:<a href="mailto:bluez-">bluez-</a><br>&gt; <a href="mailto:devel-bounces@lists.sourceforge.net">devel-bounces@lists.sourceforge.net</a>] On Behalf Of andrey larin<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sent: Friday, September 14, 2007 4:49 AM
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; To: BlueZ development<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Subject: Re: [Bluez-devel] handsfree or headset support on pc<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; after all i see while serching<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i think this:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; currently software is able to handle this
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but requred some tuning<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but may be i wrong :)<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; so i more interested in technical details<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if you could provide ... some :)<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; or say that i wrong and there is requerd a lot of coding
<br>&gt;<br>&gt;<br><br><br>-------------------------------------------------------------------------<br>This SF.net email is sponsored by: Microsoft<br>Defy all challenges. Microsoft(R) Visual Studio 2005.<br><a href="http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/">
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>_______________________________________________<br>Bluez-devel mailing list<br><a href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net
</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockquote></div><br>

------=_Part_283_29286957.1189747045480--


--===============0022875950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0022875950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0022875950==--

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5bab330d0602041925h53623f50h8560344f37a62d0d@mail.gmail.com>
From: Nigel Sim <nigel.sim@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP w/ Blueant headset
In-Reply-To: <43A9B384.5040202@xmission.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22099_9587040.1139109934498"
References: <5bab330d0512192018o281f89a6l242586c487297e8f@mail.gmail.com>
	 <43A78D40.7070209@xmission.com>
	 <5bab330d0512201659w8af0301r7fd09cba76c6ca92@mail.gmail.com>
	 <43A9B384.5040202@xmission.com>
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
Date: Sun, 5 Feb 2006 13:25:34 +1000

------=_Part_22099_9587040.1139109934498
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brad, I've just cracked it. For some reason the avdtp_discover is not
returning the codec list straight away (see the hci dump
http://hpc-external.jcu.edu.au/~nigel/uploads/Main/brokenHCIDump.txt).
Rather after the second command the required response is returned. This is
what happens after a2play decides the stream discovery has failed, and it
sends the disconnect signal. SO, I've just made it call this line twice:
a2play.c:848    size =3D read(cmdfd, &get_resp, sizeof(get_resp));

And then the headset works!

I wonder if the two byte reply means something like wait. The bytes are 0x0=
0
0x00, so I'm guessing that message_type =3D 0 and packet_type =3D 0.

However, I seem to have to totally reset the headset between sessions. I'm
not sure whats happening here. Is there a BT command I could send to make
the device reset?

Nigel


On 12/22/05, Brad Midgley <bmidgley@xmission.com> wrote:
>
> Nigel
>
> Your headset is misbehaving. We are supposed to be able to discover the
> stream endpoint id in the reply to the avdtp_discover request.
>
> You could try adding code to work around this problem and guess at the
> seid. The seid seems to always be 1 on my headsets.
>
> Brad
>
> > OK, new cvs version, I get this:
> > mpg123 --au - /home/nigel/03\ -\ They\ Got\ Lost.mp3 | ./a2play
> > 00:0A:56:00:B5:91 -
> > subbands =3D 8 blocks =3D 16 bitpool =3D 32
> > High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
> > Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
> > ...
> > MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo
> > len=3D2048
> > Header size=3D28
> > Sample Rate:44100
> > Channels:2
> > Using address: 00:0A:56:00:B5:91
> > Found A2DP Sink
> > Found A2DP Sink at the destination
> > Connected [imtu 672, omtu 672, flush_to 65535]
> > Sent the Stream End Point Discovery Command
> > couldn't get avdtp_discover (only 2 bytes read)
> >
> > On 12/20/05, *Brad Midgley* <bmidgley@xmission.com
> > <mailto:bmidgley@xmission.com>> wrote:
> >
> >     Nigel
> >
> >     > A2DP with the bluetooth-alsa project doesn't work with the Bluean=
t
> >     > stereo headphones, and by looking at this page it appears that it
> >     might
> >     > be because these headphones don't support AVDTP
> >     > (http://www.robertwebbe.nl/extendedA2DP.html
> >     <http://www.robertwebbe.nl/extendedA2DP.html>) Is this possible?
> >
> >     if I remember my alphabet soup correctly, avdtp is a fundamental
> part of
> >     a2dp.
> >
> >     > couldn't get avdtp_discover
> >     > Sent the Stream End Point Discovery Command
> >
> >     i'm not sure why it can't read this information back. perhaps the
> >     headset for some reason does not report any supported codecs?
> >
> >     i've improved the debug output somewhat. you could try it again.
> >
> >     brad
> >
> >
> >     -------------------------------------------------------
> >     This SF.net email is sponsored by: Splunk Inc. Do you grep through
> >     log files
> >     for problems?  Stop!  Download the new AJAX search engine that make=
s
> >     searching your log files as easy as surfing the  web.  DOWNLOAD
> SPLUNK!
> >     http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> >     <http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick>
> >     _______________________________________________
> >     Bluez-devel mailing list
> >     Bluez-devel@lists.sourceforge.net
> >     <mailto:Bluez-devel@lists.sourceforge.net>
> >     https://lists.sourceforge.net/lists/listinfo/bluez-devel
> >
> >
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_22099_9587040.1139109934498
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brad, I've just cracked it. For some reason the avdtp_discover is not retur=
ning the codec list straight away (see the hci dump <a href=3D"http://hpc-e=
xternal.jcu.edu.au/~nigel/uploads/Main/brokenHCIDump.txt">http://hpc-extern=
al.jcu.edu.au/~nigel/uploads/Main/brokenHCIDump.txt
</a>). Rather after the second command the required response is returned. T=
his is what happens after a2play decides the stream discovery has failed, a=
nd it sends the disconnect signal. SO, I've just made it call this line twi=
ce:
<br>a2play.c:848 &nbsp;&nbsp; size =3D read(cmdfd, &amp;get_resp, sizeof(ge=
t_resp));<br><br>And then the headset works!<br><br>I wonder if the two byt=
e reply means something like wait. The bytes are 0x00 0x00, so I'm guessing=
 that message_type =3D 0 and packet_type =3D 0.
<br><br>However, I seem to have to totally reset the headset between sessio=
ns. I'm not sure whats happening here. Is there a BT command I could send t=
o make the device reset?<br><br>Nigel<br><br><br><div><span class=3D"gmail_=
quote">
On 12/22/05, <b class=3D"gmail_sendername">Brad Midgley</b> &lt;<a href=3D"=
mailto:bmidgley@xmission.com">bmidgley@xmission.com</a>&gt; wrote:</span><b=
lockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 20=
4, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Nigel<br><br>Your headset is misbehaving. We are supposed to be able to dis=
cover the<br>stream endpoint id in the reply to the avdtp_discover request.=
<br><br>You could try adding code to work around this problem and guess at =
the
<br>seid. The seid seems to always be 1 on my headsets.<br><br>Brad<br><br>=
&gt; OK, new cvs version, I get this:<br>&gt; mpg123 --au - /home/nigel/03\=
 -\ They\ Got\ Lost.mp3 | ./a2play<br>&gt; 00:0A:56:00:B5:91 -<br>&gt; subb=
ands =3D 8 blocks =3D 16 bitpool =3D 32
<br>&gt; High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and=
 3.<br>&gt; Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.=
<br>&gt; ...<br>&gt; MPEG 1.0 layer III, 128 kbit/s, 44100 Hz stereo<br>
&gt; len=3D2048<br>&gt; Header size=3D28<br>&gt; Sample Rate:44100<br>&gt; =
Channels:2<br>&gt; Using address: 00:0A:56:00:B5:91<br>&gt; Found A2DP Sink=
<br>&gt; Found A2DP Sink at the destination<br>&gt; Connected [imtu 672, om=
tu 672, flush_to 65535]
<br>&gt; Sent the Stream End Point Discovery Command<br>&gt; couldn't get a=
vdtp_discover (only 2 bytes read)<br>&gt;<br>&gt; On 12/20/05, *Brad Midgle=
y* &lt;<a href=3D"mailto:bmidgley@xmission.com">bmidgley@xmission.com</a>
<br>&gt; &lt;mailto:<a href=3D"mailto:bmidgley@xmission.com">bmidgley@xmiss=
ion.com</a>&gt;&gt; wrote:<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Nigel<br=
>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; A2DP with the bluetooth-alsa pro=
ject doesn't work with the Blueant<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; stereo headphones, and by looking at this=
 page it appears that it<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; might<br>&gt;&nbsp=
;&nbsp;&nbsp;&nbsp; &gt; be because these headphones don't support AVDTP<br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; (<a href=3D"http://www.robertwebbe.nl/ex=
tendedA2DP.html">
http://www.robertwebbe.nl/extendedA2DP.html</a><br>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp; &lt;<a href=3D"http://www.robertwebbe.nl/extendedA2DP.html">http://www=
.robertwebbe.nl/extendedA2DP.html</a>&gt;) Is this possible?<br>&gt;<br>&gt=
;&nbsp;&nbsp;&nbsp;&nbsp; if I remember my alphabet soup correctly, avdtp i=
s a fundamental part of
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; a2dp.<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nb=
sp; &gt; couldn't get avdtp_discover<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &gt; S=
ent the Stream End Point Discovery Command<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp=
;&nbsp; i'm not sure why it can't read this information back. perhaps the<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; headset for some reason does not report any su=
pported codecs?<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; i've improved the d=
ebug output somewhat. you could try it again.<br>&gt;<br>&gt;&nbsp;&nbsp;&n=
bsp;&nbsp; brad<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; -----------=
--------------------------------------------
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; This SF.net email is sponsored by: Splunk =
Inc. Do you grep through<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; log files<br>&gt;&=
nbsp;&nbsp;&nbsp;&nbsp; for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download =
the new AJAX search engine that makes<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; searc=
hing your log files as easy as surfing the&nbsp;&nbsp;web.&nbsp;&nbsp;DOWNL=
OAD SPLUNK!
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"http://ads.osdn.com/?ad_id=3D76=
37&amp;alloc_id=3D16865&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7637&a=
mp;alloc_id=3D16865&amp;op=3Dclick</a><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &lt;=
<a href=3D"http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3D=
click">
http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a>&g=
t;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; ________________________________________=
_______<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Bluez-devel mailing list<br>&gt;&nb=
sp;&nbsp;&nbsp;&nbsp; <a href=3D"mailto:Bluez-devel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; &lt;m=
ailto:<a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@list=
s.sourceforge.net</a>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https:=
//lists.sourceforge.net/lists/listinfo/bluez-devel">
https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br>&gt;<br>&gt=
;<br><br><br><br>-------------------------------------------------------<br=
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log fil=
es
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes<br>searching your log files as easy as surfing the&nbsp;&=
nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad=
_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick">
http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a><b=
r>_______________________________________________<br>Bluez-devel mailing li=
st<br><a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@list=
s.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel=
">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br></blockqu=
ote></div><br>

------=_Part_22099_9587040.1139109934498--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

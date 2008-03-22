Return-Path: <cyrus@holtmann.org>
Message-ID: <1ffb4b070803220807o1c252ea0i34e3f6cffa1d368f@mail.gmail.com>
Date: Sat, 22 Mar 2008 11:07:03 -0400
From: "Mike Lee" <eemike@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100803220552r24e8ce6bl878fc3f3db98da4e@mail.gmail.com>
MIME-Version: 1.0
References: <1ffb4b070803202045w31d2ca9lcc66d0a51aef8c@mail.gmail.com>
	<2d5a2c100803210641h220d4de2md9392f7752796169@mail.gmail.com>
	<1ffb4b070803220226n35f4363dpd63491528914ab74@mail.gmail.com>
	<2d5a2c100803220552r24e8ce6bl878fc3f3db98da4e@mail.gmail.com>
Subject: Re: [Bluez-devel] Is there any bluez audio source(a2src)
	implementation
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1792409030=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1792409030==
Content-Type: multipart/alternative;
	boundary="----=_Part_11610_14989740.1206198423401"

------=_Part_11610_14989740.1206198423401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Luiz

I del the entry and try to use it. My setup like this
Nokia mobile phone (src) -> Thinkpad notebook (sink)

I make one more change on a2dp.c(1263) in order to make this work.
avdtp_get_seps(session, !type,....  =3D>  avdtp_get_seps(session, type...

And when i successfully connected to my notebook and play mp3 file in
mobile,
i find that my pc receive discover cmd again and again without play out
anything.
The mobile player seem to skip every songs.

by hcidump, the Audio Sink(PC) reply with "ACP SEID2 - Audio Sink(InUse)".D=
o
you have any idea on this?
> ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 5
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 25]
      AVDTP(s): Discover rsp: transaction 5
        ACP SEID 1 - Audio Source
        ACP SEID 2 - Audio Sink (InUse)
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 0B 00 01 00
> ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 6
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(d): cid 0x0040 len 6 [psm 25]
      AVDTP(s): Discover rsp: transaction 6
        ACP SEID 1 - Audio Source
        ACP SEID 2 - Audio Sink (InUse)
> HCI Event: Number of Completed Packets (0x13) plen 5
  01 0B 00 01 00

Regards,
Mike,Lee

On Sat, Mar 22, 2008 at 8:52 AM, Luiz Augusto von Dentz <
luiz.dentz@gmail.com> wrote:

> Hi there,
>
> My bad, I forgot to remove it from Makefile.am, for instance you can
> do it in order
> to compile. I will fix it when I resync with marcel's tree.
>
> --
> Luiz Augusto von Dentz
> Engenheiro de Computa=E7=E3o
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>



--=20
-----------
Mike Lee

------=_Part_11610_14989740.1206198423401
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Luiz<br><br>I del the entry and try to use it. My setup like this<br>Nok=
ia mobile phone (src) -&gt; Thinkpad notebook (sink)<br><br>I make one more=
 change on a2dp.c(1263) in order to make this work.<br>avdtp_get_seps(sessi=
on, !type,....&nbsp; =3D&gt;&nbsp; avdtp_get_seps(session, type...<br>
<br>And when i successfully connected to my notebook and play mp3 file in m=
obile,<br>i find that my pc receive discover cmd again and again without pl=
ay out anything.<br>The mobile player seem to skip every songs.<br><br>
by hcidump, the Audio Sink(PC) reply with &quot;ACP SEID2 - Audio Sink(InUs=
e)&quot;.Do you have any idea on this?<br>&gt; ACL data: handle 11 flags 0x=
02 dlen 6<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover cmd: transaction 5<br>
&lt; ACL data: handle 11 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d):=
 cid 0x0040 len 6 [psm 25]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Disc=
over rsp: transaction 5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP S=
EID 1 - Audio Source<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID=
 2 - Audio Sink (InUse)<br>&gt; HCI Event: Number of Completed Packets (0x1=
3) plen 5<br>
&nbsp; 01 0B 00 01 00 <br>&gt; ACL data: handle 11 flags 0x02 dlen 6<br>&nb=
sp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 2 [psm 25]<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; AVDTP(s): Discover cmd: transaction 6<br>&lt; ACL data: handle 1=
1 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 6 [psm =
25]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AVDTP(s): Discover rsp: transaction 6<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 1 - Audio Source<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ACP SEID 2 - Audio Sink (InUse)<br>&gt=
; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 01 0B 00 0=
1 00 <br><br>Regards,<br>
Mike,Lee<br><br><div class=3D"gmail_quote">On Sat, Mar 22, 2008 at 8:52 AM,=
 Luiz Augusto von Dentz &lt;<a href=3D"mailto:luiz.dentz@gmail.com">luiz.de=
ntz@gmail.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddi=
ng-left: 1ex;">
Hi there,<br>
<br>
My bad, I forgot to remove it from <a href=3D"http://Makefile.am" target=3D=
"_blank">Makefile.am</a>, for instance you can<br>
do it in order<br>
to compile. I will fix it when I resync with marcel&#39;s tree.<br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"Wj3C7c">Luiz Augusto von Dentz<br>
Engenheiro de Computa=E7=E3o<br>
<br>
-------------------------------------------------------------------------<b=
r>
This SF.net email is sponsored by: Microsoft<br>
Defy all challenges. Microsoft(R) Visual Studio 2008.<br>
<a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=
=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a><br>
_______________________________________________<br>
Bluez-devel mailing list<br>
<a href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sour=
ceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a><br=
>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>-----------=
<br>Mike Lee

------=_Part_11610_14989740.1206198423401--


--===============1792409030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1792409030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1792409030==--

Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v750)
In-Reply-To: <1148998994.11251.9.camel@localhost>
References: <822EACFA-537D-4382-BA97-4192E5EBCF4A@pepper.com>
	<1148908353.31689.28.camel@localhost>
	<CB055E3B-083D-4B4A-B42C-2ADB2E3DEFC6@pepper.com>
	<1148998994.11251.9.camel@localhost>
Message-Id: <D86403B9-8AD2-4EC8-AE3B-02FE7A4F2C0A@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Date: Tue, 30 May 2006 10:58:39 -0400
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluez Bluetooth certification tests?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1289261202=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1289261202==
Content-Type: multipart/alternative; boundary=Apple-Mail-4-1042711155


--Apple-Mail-4-1042711155
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi Marcel,

I think I am understanding.  Couple of more things.
We use a certified Bluetooth module (Insung module using a CSR chip)  
along  with Bluez. Do you know what testing will we need to do as a  
product to get certification? And how do we reference the Bluez stack  
in our certification?

Thanks,
Michael


On May 30, 2006, at 10:23 AM, Marcel Holtmann wrote:

> Hi Michael,
>
>> Are there any resulting test harness or supporting code from TomTom's
>> effort?  Or does the fact the if someone uses the Bluez stack, they
>> are by default certified?
>
> you can use the current BlueZ qualification to qualify your own  
> product.
> It will save you a lot of time, because most test have are already  
> been
> done. And I think we spent 4 days with the L2CAP, RFCOMM and SDP  
> testing
> and you don't wanna do it again normally.
>
> At some point the BlueZ qualification must be updated to PRD 2.0,  
> but I
> only wanna do that after the Lisbon specification has been  
> released. It
> makes no real sense to do it again now. With PRD 2.0 it should also
> include some kind of HCI qualification so you basically don't even  
> have
> to re-qualify your hardware. However I haven't fully looked into  
> the new
> qualification program. I will do that when the next specification
> version gets public and I have found a sponsor for it. We still  
> have to
> pay the listing fee.
>
> Regards
>
> Marcel
>
>
>
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


--Apple-Mail-4-1042711155
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=ISO-8859-1

<HTML><BODY style=3D"word-wrap: break-word; -khtml-nbsp-mode: space; =
-khtml-line-break: after-white-space; ">Hi Marcel,<DIV><BR =
class=3D"khtml-block-placeholder"></DIV><DIV>I think I am =
understanding.=A0 Couple of more things.</DIV><DIV><FONT =
class=3D"Apple-style-span" face=3D"Arial" size=3D"4"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13.3px;"><FONT =
class=3D"Apple-style-span" color=3D"#00000000"><SPAN =
class=3D"Apple-style-span" style=3D"background-color: transparent;">We =
use a certified Bluetooth module (Insung module using a CSR chip) along =
=A0with Bluez. Do you know what testing will we need to do as a product =
to get certification? And how do we reference the Bluez stack in our =
certification?</SPAN></FONT></SPAN></FONT></DIV><DIV><FONT =
class=3D"Apple-style-span" face=3D"Arial" size=3D"4"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13.3px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV><FONT =
class=3D"Apple-style-span" face=3D"Arial" size=3D"4"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: =
13.3px;">Thanks,</SPAN></FONT></DIV><DIV><FONT class=3D"Apple-style-span" =
face=3D"Arial" size=3D"4"><SPAN class=3D"Apple-style-span" =
style=3D"font-size: 13.3px;">Michael</SPAN></FONT></DIV><DIV><FONT =
class=3D"Apple-style-span" face=3D"Arial" size=3D"4"><SPAN =
class=3D"Apple-style-span" style=3D"font-size: 13.3px;"><BR =
class=3D"khtml-block-placeholder"></SPAN></FONT></DIV><DIV><FONT =
class=3D"Apple-style-span" color=3D"#00117A" face=3D"Arial" =
size=3D"4"><SPAN class=3D"Apple-style-span" style=3D"font-size: =
13.3px;"></SPAN></FONT><BR =
class=3D"khtml-block-placeholder"><DIV><DIV><DIV>On May 30, 2006, at =
10:23 AM, Marcel Holtmann wrote:</DIV><BR =
class=3D"Apple-interchange-newline"><BLOCKQUOTE type=3D"cite"><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Hi Michael,</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV> <BLOCKQUOTE type=3D"cite"><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">Are =
there any resulting test harness or supporting code from TomTom's <SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">effort?<SPAN class=3D"Apple-converted-space">=A0 </SPAN>Or does the =
fact the if someone uses the Bluez stack, they <SPAN =
class=3D"Apple-converted-space">=A0</SPAN></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">are by =
default certified?</DIV> </BLOCKQUOTE><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">you can use the current BlueZ =
qualification to qualify your own product.</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">It will =
save you a lot of time, because most test have are already =
been</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">done. And I think we spent 4 =
days with the L2CAP, RFCOMM and SDP testing</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">and you =
don't wanna do it again normally.</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">At some point the BlueZ =
qualification must be updated to PRD 2.0, but I</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">only wanna do that after the Lisbon specification =
has been released. It</DIV><DIV style=3D"margin-top: 0px; margin-right: =
0px; margin-bottom: 0px; margin-left: 0px; ">makes no real sense to do =
it again now. With PRD 2.0 it should also</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">include =
some kind of HCI qualification so you basically don't even =
have</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">to re-qualify your hardware. =
However I haven't fully looked into the new</DIV><DIV style=3D"margin-top:=
 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
">qualification program. I will do that when the next =
specification</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">version gets public and I have =
found a sponsor for it. We still have to</DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; ">pay the =
listing fee.</DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Regards</DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; ">Marcel</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: =
0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; =
min-height: 14px; "><BR></DIV><DIV style=3D"margin-top: 0px; =
margin-right: 0px; margin-bottom: 0px; margin-left: 0px; min-height: =
14px; "><BR></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; min-height: 14px; "><BR></DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; =
">_______________________________________________</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; ">Bluez-devel mailing list</DIV><DIV =
style=3D"margin-top: 0px; margin-right: 0px; margin-bottom: 0px; =
margin-left: 0px; "><A =
href=3D"mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.source=
forge.net</A></DIV><DIV style=3D"margin-top: 0px; margin-right: 0px; =
margin-bottom: 0px; margin-left: 0px; "><A =
href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://=
lists.sourceforge.net/lists/listinfo/bluez-devel</A></DIV> =
</BLOCKQUOTE></DIV><BR></DIV></DIV></BODY></HTML>=

--Apple-Mail-4-1042711155--


--===============1289261202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1289261202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1289261202==--

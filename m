Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7846f1440512090957t2f6cd767xc61ae8e19953993e@mail.gmail.com>
From: Arthur Chiu <arthurchiu@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] UART bluetooth chip problem
In-Reply-To: <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3761_25490553.1134151070066"
References: <7846f1440512071711x6c56c8er24edb8e3a8815ab9@mail.gmail.com>
	 <1134020677.3752.61.camel@blade>
	 <7846f1440512081019g4bbf588cta4f4d395b7be0d74@mail.gmail.com>
	 <1134074044.17592.13.camel@blade>
	 <7846f1440512081510w4ffff8cdoe25ae369e677144@mail.gmail.com>
	 <1134087822.17592.44.camel@blade>
	 <7846f1440512090946n58fbf3e8gfecd3ebeb270bf58@mail.gmail.com>
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
Date: Fri, 9 Dec 2005 09:57:50 -0800

------=_Part_3761_25490553.1134151070066
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ops, one more thing,
I'm not sure if this is what you're looking for when you say build id for
the chip, but this is what i see when I look at the back of the chip:

CE 0682
FCC ID: QOQWRAP2022-1-V2V
IC: 5132A-20221B2B
BlueGiga Technologies Inc.
20031219
WRAP THORNADO BTBM Ver.4.0

Thanks a lot!

  Arthur

On 12/9/05, Arthur Chiu <arthurchiu@gmail.com> wrote:
>
> Hi Marcel,
>
> I just received a reply from the support group of the company that we
> bought the chip from. Here's some answer to the questions I ask him with
> regards to how to change the chip such that the HCI will be ran by host
> processor (which is the case we need right?).
>
>
> -------------------------------------------------------------------------=
--------------------
>
> > PSKEY_HOST_INTERFACE how do I find out whether it is UART H4 or H5?
>
> H4 is that standard UART protocol and that's probably what you want to
> use.
>
> The "H5" host transport protocol is properly known as the "Three
> Wire Uart Transport Layer", but is commonly known as H5 within CSR.
>
> The value of this parameter defines the protocol. You can check/modify it
> with PSTool.
>
> > PSKEY_VM_DISABLE  change to true?
>
> Yes. This disables the internal Virtual Machine inside the chip. In our
> case it disables the iWRAP software.
> With BlueZ you need to use HCI module and not iWRAP.
>
> > PSKEY_UART_CONFIG      what should I set this as?
>
> H4 requires the usage of HW flow control.
>
> With H4 you need to modify  PSKEY_UART_CONFIG_H4. Suggested value is 08a8
> which enables HW flow control.
>
> > PSKEY_UART_BAUD_RATE    how do I find out what baud rate the serial
> > port is running?
>
> What serial port you mean? The one on your PC or something else?
>
> > PSKEY_ONCHIP_HCI_CLIENT     set this as 0000?
>
> Yes. That enables HCI firmware.
>
> > Is there any other things I need to change? Thanks a lot.
>
> No. With those settings you should be fine.
>
>
> -------------------------------------------------------------------------=
--------------------
>
> It seems to me that most of my settings are correct, besides the config i
> used 00a8 instead of 08a8.
> I will try again with these configurations:
>
> PSKEY_HOST_INTERFACE UART H4
> PSKEY_VM_DISABLE  true
> PSKEY_UART_CONFIG  08a8
> PSKEY_UART_BAUD_RATE  115200
> PSKEY_ONCHIP_HCI_CLIENT   0000
>
> #hciattach -s 115200 /dev/ttyS1 csr 115200 flow
>
> I tried using stty /dev/ttyS1 yesterday and it reads 115200 on my
> computer, so I suppose using that as 115200 for baud rate is correct.
>
> Any other ideas? Thanks a lot.
>
> Cheers,
>
>   Arthur
>
> On 12/8/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Arthur,
> >
> > > I used pstool, which is a tool bluegiga made to change settings of th=
e
> > > bluetooth chip via SPI interface. To be more specific, settings I
> > > changed on the bluetooth chip includes:
> > >
> > > PSKEY_HOST_INTERFACE UART H4
> > > PSKEY_VM_DISABLE  true
> > > PSKEY_UART_CONFIG  00a8
> > > PSKEY_UART_BAUD_RATE  115200
> > > PSKEY_ONCHIP_HCI_CLIENT   0000
> > >
> > > I tried noflow as well, but doesn't seem to help.
> > >
> > > When you say what chip the module manufacturer is using, what do you
> > > mean specifically?
> > > Do you mean the "type" option in hciattach (ericsson, digi, csr...
> > > etc) ?
> >
> > if you use pstool then this is a CSR chip. What is the build id of this
> > chip. The correct PS key for the UART config can differ for different
> > firmwares.
> >
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > This SF.net email is sponsored by: Splunk Inc. Do you grep through log
> > files
> > for problems?  Stop!  Download the new AJAX search engine that makes
> > searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> > http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>
>

------=_Part_3761_25490553.1134151070066
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Ops, one more thing, <br>
I'm not sure if this is what you're looking for when you say build id
for the chip, but this is what i see when I look at the back of the
chip: <br>
<br>
CE 0682<br>
FCC ID: QOQWRAP2022-1-V2V<br>
IC: 5132A-20221B2B<br>
BlueGiga Technologies Inc.<br>
20031219<br>
WRAP THORNADO BTBM Ver.4.0<br>
<br>
Thanks a lot!<br>
<br>
&nbsp; Arthur<br><br><div><span class=3D"gmail_quote">On 12/9/05, <b class=
=3D"gmail_sendername">Arthur Chiu</b> &lt;<a href=3D"mailto:arthurchiu@gmai=
l.com">arthurchiu@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail=
_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt=
 0pt 0.8ex; padding-left: 1ex;">
Hi Marcel,<br>
<br>
I just received a reply from the support group of the company that we
bought the chip from. Here's some answer to the questions I ask him
with regards to how to change the chip such that the HCI will be ran by
host processor (which is the case we need right?). <br>
<br>
<font face=3D"'PrimaSans BT,Verdana,sans-serif'">--------------------------=
-------------------------------------------------------------------<br>
<br>
</font><font face=3D"'PrimaSans BT,Verdana,sans-serif'">&gt; PSKEY_HOST_INT=
ERFACE how do I find out whether it is UART H4 or H5?<br><br>H4 is that sta=
ndard UART protocol and that's probably what you want to use.<br><br>The &q=
uot;H5&quot; host transport protocol is properly known as the &quot;Three
<br>Wire Uart Transport Layer&quot;, but is commonly known as H5 within CSR=
.<br><br>The value of this parameter defines the protocol. You can check/mo=
dify it with PSTool.<br><br>&gt; PSKEY_VM_DISABLE&nbsp; change to true?<br>
<br>
Yes. This disables the internal Virtual Machine inside the chip. In our cas=
e it disables the iWRAP software. <br>With BlueZ you need to use HCI module=
 and not iWRAP.<br><br>&gt; PSKEY_UART_CONFIG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 what should I set this as?
<br><br>H4 requires the usage of HW flow control. <br><br>With H4 you need =
to modify&nbsp; PSKEY_UART_CONFIG_H4. Suggested value is 08a8 which enables=
 HW flow control.<br><br>&gt; PSKEY_UART_BAUD_RATE&nbsp;&nbsp;&nbsp; how do=
 I find out what baud rate the serial
<br>&gt; port is running?<br><br>What serial port you mean? The one on your=
 PC or something else?<br><br>&gt; PSKEY_ONCHIP_HCI_CLIENT&nbsp;&nbsp;&nbsp=
;&nbsp; set this as 0000?<br><br>Yes. That enables HCI firmware.<br>&nbsp;<=
br>&gt; Is there any other things I need to change? Thanks a lot.
<br><br>No. With those settings you should be fine.<br>
<br>
---------------------------------------------------------------------------=
------------------<br>
<br>
It seems to me that most of my settings are correct, besides the config i u=
sed 00a8 instead of 08a8.<br>
I will try again with these configurations:<br>
<br>
</font><span class=3D"q">PSKEY_HOST_INTERFACE UART H4<br>
PSKEY_VM_DISABLE&nbsp;&nbsp;true<br></span>
PSKEY_UART_CONFIG&nbsp;&nbsp;08a8<span class=3D"q"><br>
PSKEY_UART_BAUD_RATE&nbsp;&nbsp;115200<br>
PSKEY_ONCHIP_HCI_CLIENT&nbsp;&nbsp; 0000<br>
</span><font face=3D"'PrimaSans BT,Verdana,sans-serif'"><br>
#hciattach -s 115200 /dev/ttyS1 csr 115200 flow<br>
<br>
I tried using stty /dev/ttyS1 yesterday and it reads 115200 on my
computer, so I suppose using that as 115200 for baud rate is correct. <br>
<br>
Any other ideas? Thanks a lot. <br>
<br>
Cheers,<br>
<br>
&nbsp; Arthur<br>
</font><br><div><span class=3D"q"><span class=3D"gmail_quote">On 12/8/05, <=
b class=3D"gmail_sendername">Marcel Holtmann</b> &lt;<a href=3D"mailto:marc=
el@holtmann.org" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(win=
dow,event,this)">
marcel@holtmann.org</a>&gt; wrote:</span></span><div><span class=3D"e" id=
=3D"q_10810a1980f00675_6"><blockquote class=3D"gmail_quote" style=3D"border=
-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-lef=
t: 1ex;">

Hi Arthur,<br><br>&gt; I used pstool, which is a tool bluegiga made to chan=
ge settings of the<br>&gt; bluetooth chip via SPI interface. To be more spe=
cific, settings I<br>&gt; changed on the bluetooth chip includes:<br>&gt;
<br>&gt; PSKEY_HOST_INTERFACE UART H4<br>&gt; PSKEY_VM_DISABLE&nbsp;&nbsp;t=
rue<br>&gt; PSKEY_UART_CONFIG&nbsp;&nbsp;00a8<br>&gt; PSKEY_UART_BAUD_RATE&=
nbsp;&nbsp;115200<br>&gt; PSKEY_ONCHIP_HCI_CLIENT&nbsp;&nbsp; 0000<br>&gt;<=
br>&gt; I tried noflow as well, but doesn't seem to help.
<br>&gt;<br>&gt; When you say what chip the module manufacturer is using, w=
hat do you<br>&gt; mean specifically?<br>&gt; Do you mean the &quot;type&qu=
ot; option in hciattach (ericsson, digi, csr...<br>&gt; etc) ?<br><br>
if you use pstool then this is a CSR chip. What is the build id of this
<br>chip. The correct PS key for the UART config can differ for different<b=
r>firmwares.<br><br>Regards<br><br>Marcel<br><br><br><br><br>--------------=
-----------------------------------------<br>This SF.net email is sponsored=
 by: Splunk Inc. Do you grep through log files
<br>for problems?&nbsp;&nbsp;Stop!&nbsp;&nbsp;Download the new AJAX search =
engine that makes<br>searching your log files as easy as surfing the&nbsp;&=
nbsp;web.&nbsp;&nbsp;DOWNLOAD SPLUNK!<br><a href=3D"http://ads.osdn.com/?ad=
_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick" target=3D"_blank" onclick=
=3D"return top.js.OpenExtLink(window,event,this)">

http://ads.osdn.com/?ad_id=3D7637&amp;alloc_id=3D16865&amp;op=3Dclick</a><b=
r>_______________________________________________<br>Bluez-users mailing li=
st<br><a href=3D"mailto:Bluez-users@lists.sourceforge.net" target=3D"_blank=
" onclick=3D"return top.js.OpenExtLink(window,event,this)">
Bluez-users@lists.sourceforge.net
</a><br><a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
" target=3D"_blank" onclick=3D"return top.js.OpenExtLink(window,event,this)=
">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockqu=
ote>
</span></div></div><br>

</blockquote></div><br>

------=_Part_3761_25490553.1134151070066--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

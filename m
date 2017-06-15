Return-Path: <marcos@scriven.org>
MIME-Version: 1.0
From: Marcos Scriven <marcos@scriven.org>
Date: Thu, 15 Jun 2017 23:17:34 +0100
Message-ID: <CA+zKUVJJZL-EH4wBxBHkfWnOtVqb1zvGhAFyRynsGWrnjnXoPg@mail.gmail.com>
Subject: Questions on event masks (specifically in tools/3dsp.c)
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/alternative; boundary="001a114900ba230cc4055207090a"
List-ID: <linux-bluetooth.vger.kernel.org>

--001a114900ba230cc4055207090a
Content-Type: text/plain; charset="UTF-8"

I've been trying out /tools/3dsp.c on a Raspberry Pi 3. There's some
background in this thread that Marcel mentioned
http://www.spinics.net/lists/linux-bluetooth/msg62198.html

The Raspberry Pi uses the Broadcom bcm43438 chip, which according to the
registration documents does support connectionless slave broadcast

I don't see any errors, but nothing seems to happen, so have been taking a
close look at the code, especially the start_glasses method.

In there I see the event masks:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n316

uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00,
0x00 };


I thus looked at the spec for set event mask page 2 (section 7.3.69) - but
this mask, especially evtmask2, doesn't seem to make sense. Here's the full
table:

Value

Parameter Description

0x0000000000000000

No events specified (default)

0x0000000000000001

Physical Link Complete Event

0x0000000000000002

Channel Selected Event

0x0000000000000004

Disconnection Physical Link Event

0x0000000000000008

Physical Link Loss Early Warning Event

0x0000000000000010

Physical Link Recovery Event

0x0000000000000020

Logical Link Complete Event

0x0000000000000040

Disconnection Logical Link Complete Event

0x0000000000000080

Flow Spec Modify Complete Event

0x0000000000000100

Number of Completed Data Blocks Event

0x0000000000000200

AMP Start Test Event

0x0000000000000400

AMP Test End Event

0x0000000000000800

AMP Receiver Report Event

0x0000000000001000

Short Range Mode Change Complete Event

0x0000000000002000

AMP Status Change Event

0xFFFFFFFFFFFFC0 00

Reserved for future use


Only the first two octets (by which I mean the rightmost four digits in the
table above, assuming little endianess) are in use.

So is it right to say 0xC0 => 8 + 4 + 0 + 0 for the 4th column, which only
contains options for 1 (Short range mode) and 2 (AMP Status change)

And 0x74 is even more confusing, as there doesn't seem to be any parameters
mapped to that.

Can anyone help here please?

Thanks

Marcos

--001a114900ba230cc4055207090a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I&#39;ve been trying out /tools/3dsp.c on a Raspberry Pi 3=
. There&#39;s some background in this thread that Marcel mentioned=C2=A0<a =
href=3D"http://www.spinics.net/lists/linux-bluetooth/msg62198.html">http://=
www.spinics.net/lists/linux-bluetooth/msg62198.html</a>=C2=A0<div><br></div=
><div>The Raspberry Pi uses the Broadcom bcm43438 chip, which according to =
the registration documents does support connectionless slave broadcast<div>=
<div><div><br></div><div>I don&#39;t see any errors, but nothing seems to h=
appen, so have been taking a close look at the code, especially the start_g=
lasses method.</div><div><br></div><div>In there I see the event masks: <a =
href=3D"https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.=
c#n316">https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.=
c#n316</a></div><div><div><br></div></div><blockquote style=3D"margin:0px 0=
px 0px 40px;border:none;padding:0px"><pre style=3D"padding:0px;margin-top:0=
px;margin-bottom:0px;color:rgb(0,0,0);font-size:13.3333px"><pre style=3D"pa=
dding:0px;margin-top:0px;margin-bottom:0px;font-size:13.3333px"><code><span=
 class=3D"gmail-hl gmail-kwb" style=3D"color:rgb(0,87,174)">uint8_t</span> =
evtmask1<span class=3D"gmail-hl gmail-opt">[] =3D {</span> <span class=3D"g=
mail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x1c</span><span class=3D=
"gmail-hl gmail-opt">,</span> <span class=3D"gmail-hl gmail-num" style=3D"c=
olor:rgb(176,126,0)">0xe0</span><span class=3D"gmail-hl gmail-opt">,</span>=
 <span class=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x00</sp=
an><span class=3D"gmail-hl gmail-opt">,</span> <span class=3D"gmail-hl gmai=
l-num" style=3D"color:rgb(176,126,0)">0x00</span><span class=3D"gmail-hl gm=
ail-opt">,</span> <span class=3D"gmail-hl gmail-num" style=3D"color:rgb(176=
,126,0)">0x00</span><span class=3D"gmail-hl gmail-opt">,</span> <span class=
=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x00</span><span cla=
ss=3D"gmail-hl gmail-opt">,</span> <span class=3D"gmail-hl gmail-num" style=
=3D"color:rgb(176,126,0)">0x00</span><span class=3D"gmail-hl gmail-opt">,</=
span> <span class=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x0=
0</span> <span class=3D"gmail-hl gmail-opt">};</span>
<span class=3D"gmail-hl gmail-kwb" style=3D"color:rgb(0,87,174)">uint8_t</s=
pan> evtmask2<span class=3D"gmail-hl gmail-opt">[] =3D {</span> <span class=
=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x00</span><span cla=
ss=3D"gmail-hl gmail-opt">,</span> <span class=3D"gmail-hl gmail-num" style=
=3D"color:rgb(176,126,0)">0xc0</span><span class=3D"gmail-hl gmail-opt">,</=
span> <span class=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x7=
4</span><span class=3D"gmail-hl gmail-opt">,</span> <span class=3D"gmail-hl=
 gmail-num" style=3D"color:rgb(176,126,0)">0x00</span><span class=3D"gmail-=
hl gmail-opt">,</span> <span class=3D"gmail-hl gmail-num" style=3D"color:rg=
b(176,126,0)">0x00</span><span class=3D"gmail-hl gmail-opt">,</span> <span =
class=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)">0x00</span><spa=
n class=3D"gmail-hl gmail-opt">,</span> <span class=3D"gmail-hl gmail-num" =
style=3D"color:rgb(176,126,0)">0x00</span><span class=3D"gmail-hl gmail-opt=
">,</span> <span class=3D"gmail-hl gmail-num" style=3D"color:rgb(176,126,0)=
">0x00</span> <span class=3D"gmail-hl gmail-opt">};</span></code></pre></pr=
e></blockquote><font color=3D"#000000" face=3D"monospace"><span style=3D"fo=
nt-size:13.3333px;white-space:pre"><br></span></font>I thus looked at the s=
pec for set event mask page 2 (section 7.3.69) - but this mask, especially =
evtmask2, doesn&#39;t seem to make sense. Here&#39;s the full table:</div><=
div><br></div><div>
	=09
=09
=09
		<div class=3D"gmail-page" title=3D"Page 902">
			<table style=3D"border-collapse:collapse"><colgroup><col style=3D"width:=
26.1618%"><col style=3D"width:73.8382%">
				</colgroup><tbody><tr>
					<td style=3D"border-style:solid;border-width:0.24pt;border-color:rgb(0=
,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:Arial;font-weight:700"=
>Value
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0.24pt;border-color:rgb(0=
,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:Arial;font-weight:700"=
>Parameter Description
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0.24pt 0.24pt 0pt;border-=
top-color:rgb(0,0,0);border-right-color:rgb(0,0,0);border-left-color:rgb(0,=
0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00000
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0.24pt 0.24pt 0pt;border-=
top-color:rgb(0,0,0);border-right-color:rgb(0,0,0);border-left-color:rgb(0,=
0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">No events spe=
cified (</span><span style=3D"font-size:10pt;font-family:Arial;font-weight:=
700">default</span><span style=3D"font-size:10pt;font-family:ArialMT">)
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00001
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Physical Link=
 Complete Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00002
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Channel Selec=
ted Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00004
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Disconnection=
 Physical Link Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00008
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Physical Link=
 Loss Early Warning Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00010
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Physical Link=
 Recovery Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00020
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Logical Link =
Complete Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00040
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Disconnection=
 Logical Link Complete Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00080
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Flow Spec Mod=
ify Complete Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00100
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Number of Com=
pleted Data Blocks Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00200
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">AMP Start Tes=
t Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00400
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">AMP Test End =
Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
00800
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">AMP Receiver =
Report Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
01000
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Short Range M=
ode Change Complete Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0x00000000000=
02000
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt;border-right-c=
olor:rgb(0,0,0);border-left-color:rgb(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">AMP Status Ch=
ange Event
</span></p>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt 0.24pt;border-=
right-color:rgb(0,0,0);border-bottom-color:rgb(0,0,0);border-left-color:rgb=
(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">0xFFFFFFFFFFF=
FC0
00
</span></p>
							</div>
						</div>
					</td>
					<td style=3D"border-style:solid;border-width:0pt 0.24pt 0.24pt;border-=
right-color:rgb(0,0,0);border-bottom-color:rgb(0,0,0);border-left-color:rgb=
(0,0,0)">
						<div class=3D"gmail-layoutArea">
							<div class=3D"gmail-column">
								<p><span style=3D"font-size:10pt;font-family:ArialMT">Reserved for =
future use
</span></p>
							</div>
						</div>
					</td>
				</tr>
			</tbody></table><br>
		</div></div><div class=3D"gmail-page" title=3D"Page 902"><br></div><div c=
lass=3D"gmail-page" title=3D"Page 902">Only the first two octets (by which =
I mean the rightmost four digits in the table above, assuming little endian=
ess) are in use.</div><div class=3D"gmail-page" title=3D"Page 902"><br></di=
v><div class=3D"gmail-page" title=3D"Page 902">So is it right to say 0xC0 =
=3D&gt; 8 + 4 + 0 + 0 for the 4th column, which only contains options for 1=
 (Short range mode) and 2 (AMP Status change)</div><div class=3D"gmail-page=
" title=3D"Page 902"><br></div><div class=3D"gmail-page" title=3D"Page 902"=
>And 0x74 is even more confusing, as there doesn&#39;t seem to be any param=
eters mapped to that.</div><div class=3D"gmail-page" title=3D"Page 902"><br=
></div><div class=3D"gmail-page" title=3D"Page 902">Can anyone help here pl=
ease?</div><div class=3D"gmail-page" title=3D"Page 902"><br></div><div clas=
s=3D"gmail-page" title=3D"Page 902">Thanks</div><div class=3D"gmail-page" t=
itle=3D"Page 902"><br></div><div class=3D"gmail-page" title=3D"Page 902">Ma=
rcos</div><div><br></div><div><br><div><font color=3D"#000000" face=3D"mono=
space"><span style=3D"font-size:13.3333px;white-space:pre"><br></span></fon=
t></div></div></div></div></div>

--001a114900ba230cc4055207090a--

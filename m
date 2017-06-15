Return-Path: <marcos@scriven.org>
MIME-Version: 1.0
References: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
In-Reply-To: <CA+zKUVLFdP4ho91ZkykW0gnEQw-3gOFLPd0YnuqLLp2UqROcfQ@mail.gmail.com>
From: Marcos Scriven <marcos@scriven.org>
Date: Thu, 15 Jun 2017 23:06:11 +0000
Message-ID: <CA+zKUVLSBoUdFnWx-_XJi4dqgtOH_xY8=366U4vCmc9gSsA-vw@mail.gmail.com>
Subject: Re: Questions on event masks (specifically in tools/3dsp.c)
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/alternative; boundary="94eb2c056478951fe6055207b705"
List-ID: <linux-bluetooth.vger.kernel.org>

--94eb2c056478951fe6055207b705
Content-Type: text/plain; charset="UTF-8"

Oops - I meant to say I was looking at the start_display method, not
start_glasses


On Thu, 15 Jun 2017 at 23:20, Marcos Scriven <marcos@scriven.org> wrote:

> Hi
>
> (NB I've resent this as plain text)
>
> I've been trying out /tools/3dsp.c on a Raspberry Pi 3. There's some
> background in this thread that Marcel mentioned
> http://www.spinics.net/lists/linux-bluetooth/msg62198.html
>
> The Raspberry Pi uses the Broadcom bcm43438 chip, which according to
> the registration documents does support connectionless slave broadcast
>
> I don't see any errors, but nothing seems to happen, so have been
> taking a close look at the code, especially the start_glasses method.
>
> In there I see the event masks:
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3dsp.c#n316
>
> uint8_t evtmask1[] = { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> uint8_t evtmask2[] = { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };
>
>
> I thus looked at the spec for set event mask page 2 (section 7.3.69) -
> but this mask, especially evtmask2, doesn't seem to make sense. Here's
> the full table (edit resending as plain text):
>
> Value
>
> Parameter Description
>
> 0x0000000000000000
>
> No events specified (default)
>
> 0x0000000000000001
>
> Physical Link Complete Event
>
> 0x0000000000000002
>
> Channel Selected Event
>
> 0x0000000000000004
>
> Disconnection Physical Link Event
>
> 0x0000000000000008
>
> Physical Link Loss Early Warning Event
>
> 0x0000000000000010
>
> Physical Link Recovery Event
>
> 0x0000000000000020
>
> Logical Link Complete Event
>
> 0x0000000000000040
>
> Disconnection Logical Link Complete Event
>
> 0x0000000000000080
>
> Flow Spec Modify Complete Event
>
> 0x0000000000000100
>
> Number of Completed Data Blocks Event
>
> 0x0000000000000200
>
> AMP Start Test Event
>
> 0x0000000000000400
>
> AMP Test End Event
>
> 0x0000000000000800
>
> AMP Receiver Report Event
>
> 0x0000000000001000
>
> Short Range Mode Change Complete Event
>
> 0x0000000000002000
>
> AMP Status Change Event
>
> 0xFFFFFFFFFFFFC0 00
>
> Reserved for future use
>
>
>
> Only the first two octets (by which I mean the rightmost four digits
> in the table above, assuming little endianess) are in use.
>
> So is it right to say 0xC0 => 8 + 4 + 0 + 0 for the 4th column, which
> only contains options for 1 (Short range mode) and 2 (AMP Status
> change)
>
> And 0x74 is even more confusing, as there doesn't seem to be any
> parameters mapped to that.
>
> Can anyone help here please?
>
> Thanks
>
> Marcos
>

--94eb2c056478951fe6055207b705
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops - I meant to say I was looking at the start_display method, not start_=
glasses<br><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Thu, 15 J=
un 2017 at 23:20, Marcos Scriven &lt;<a href=3D"mailto:marcos@scriven.org">=
marcos@scriven.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">H=
i<br>
<br>
(NB I&#39;ve resent this as plain text)<br>
<br>
I&#39;ve been trying out /tools/3dsp.c on a Raspberry Pi 3. There&#39;s som=
e<br>
background in this thread that Marcel mentioned<br>
<a href=3D"http://www.spinics.net/lists/linux-bluetooth/msg62198.html" rel=
=3D"noreferrer" target=3D"_blank">http://www.spinics.net/lists/linux-blueto=
oth/msg62198.html</a><br>
<br>
The Raspberry Pi uses the Broadcom bcm43438 chip, which according to<br>
the registration documents does support connectionless slave broadcast<br>
<br>
I don&#39;t see any errors, but nothing seems to happen, so have been<br>
taking a close look at the code, especially the start_glasses method.<br>
<br>
In there I see the event masks:<br>
<a href=3D"https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/tools/3d=
sp.c#n316" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/pub/=
scm/bluetooth/bluez.git/tree/tools/3dsp.c#n316</a><br>
<br>
uint8_t evtmask1[] =3D { 0x1c, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };<=
br>
uint8_t evtmask2[] =3D { 0x00, 0xc0, 0x74, 0x00, 0x00, 0x00, 0x00, 0x00 };<=
br>
<br>
<br>
I thus looked at the spec for set event mask page 2 (section 7.3.69) -<br>
but this mask, especially evtmask2, doesn&#39;t seem to make sense. Here&#3=
9;s<br>
the full table (edit resending as plain text):<br>
<br>
Value<br>
<br>
Parameter Description<br>
<br>
0x0000000000000000<br>
<br>
No events specified (default)<br>
<br>
0x0000000000000001<br>
<br>
Physical Link Complete Event<br>
<br>
0x0000000000000002<br>
<br>
Channel Selected Event<br>
<br>
0x0000000000000004<br>
<br>
Disconnection Physical Link Event<br>
<br>
0x0000000000000008<br>
<br>
Physical Link Loss Early Warning Event<br>
<br>
0x0000000000000010<br>
<br>
Physical Link Recovery Event<br>
<br>
0x0000000000000020<br>
<br>
Logical Link Complete Event<br>
<br>
0x0000000000000040<br>
<br>
Disconnection Logical Link Complete Event<br>
<br>
0x0000000000000080<br>
<br>
Flow Spec Modify Complete Event<br>
<br>
0x0000000000000100<br>
<br>
Number of Completed Data Blocks Event<br>
<br>
0x0000000000000200<br>
<br>
AMP Start Test Event<br>
<br>
0x0000000000000400<br>
<br>
AMP Test End Event<br>
<br>
0x0000000000000800<br>
<br>
AMP Receiver Report Event<br>
<br>
0x0000000000001000<br>
<br>
Short Range Mode Change Complete Event<br>
<br>
0x0000000000002000<br>
<br>
AMP Status Change Event<br>
<br>
0xFFFFFFFFFFFFC0 00<br>
<br>
Reserved for future use<br>
<br>
<br>
<br>
Only the first two octets (by which I mean the rightmost four digits<br>
in the table above, assuming little endianess) are in use.<br>
<br>
So is it right to say 0xC0 =3D&gt; 8 + 4 + 0 + 0 for the 4th column, which<=
br>
only contains options for 1 (Short range mode) and 2 (AMP Status<br>
change)<br>
<br>
And 0x74 is even more confusing, as there doesn&#39;t seem to be any<br>
parameters mapped to that.<br>
<br>
Can anyone help here please?<br>
<br>
Thanks<br>
<br>
Marcos<br>
</blockquote></div>

--94eb2c056478951fe6055207b705--

Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <fe0a97c20604042223o7c59fb5fq871a004292ac1c55@mail.gmail.com>
From: "Sowmya Gattupalli" <sowmya.gattupalli@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO transparent transmission
In-Reply-To: <9ec07a230604041044j6b1b91f4ue25b44f2ed6f7c55@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12208_17784144.1144214623796"
References: <9ec07a230604041044j6b1b91f4ue25b44f2ed6f7c55@mail.gmail.com>
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
Date: Wed, 5 Apr 2006 10:53:43 +0530

------=_Part_12208_17784144.1144214623796
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey Israel,
How did u use CVSD when transmitting over sco?? U mean u used some sort of
function to convert the voice you input from /dev/dsp into CVSD codec??
Can u also throw some light on CVSD and SCO... I mean how are u transmittin=
g
the packets over SCO??

Soumya

On 4/4/06, Israel Gu=EDo <israzar@gmail.com> wrote:
>
> Hi.
>
> I'm trying to write an app for voice transmission between two laptops.
> When using CVSD, the communication performs ok. However, I would need to
> transmit the PCM samples in a transparent mode, for after receiving a voi=
ce
> frame, I must process the samples.
>
> I have read in Bluetooth 2.0 specification that this can be done, for
> example, with 0x0063 as voice settings. I have tried it with my Bluetooth
> 2.0+EDR dongles but it doesn't work properly. I transmit continuously a
> frame with values 0x01 through 0x30, but in the receiver side and using
> hcidump, I see that a brust of 0 is inserted in the middle of some frames
> and there are hops in the sequence. For instance, I send 0x00 0x01 0x02 0=
x03
> 0x04 .... 0x29 0x30, but I receive 0x2e 0x2f 0x30 0x00 0x01 0x02 0x2f 0x3=
0
> 0x00 0x01.....
>
> Have any of you tested it? Is there any solution to make what I try?
>
> Thanks.
>

------=_Part_12208_17784144.1144214623796
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hey Israel, <br>How did u use CVSD when transmitting over sco?? U mean u us=
ed some sort of function to convert the voice you input from /dev/dsp into =
CVSD codec?? <br>Can u also throw some light on CVSD and SCO... I mean how =
are u transmitting the packets over SCO??
<br><br>Soumya<br><br><div><span class=3D"gmail_quote">On 4/4/06, <b class=
=3D"gmail_sendername">Israel Gu=EDo</b> &lt;<a href=3D"mailto:israzar@gmail=
.com">israzar@gmail.com</a>&gt; wrote:</span><blockquote class=3D"gmail_quo=
te" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt=
 0.8ex; padding-left: 1ex;">
<div style=3D"direction: ltr;">Hi.<br>
<br>
I'm trying to write an app for voice transmission between two laptops.
When using CVSD, the communication performs ok. However, I would need
to transmit the PCM samples in a transparent mode, for after receiving
a voice frame, I must process the samples.<br>
<br>
I have read in Bluetooth 2.0 specification that this can be done, for
example, with 0x0063 as voice settings. I have tried it with my
Bluetooth 2.0+EDR dongles but it doesn't work properly. I transmit
continuously a frame with values 0x01 through 0x30, but in the receiver
side and using hcidump, I see that a brust of 0 is inserted in the
middle of some frames and there are hops in the sequence. For instance,
I send 0x00 0x01 0x02 0x03 0x04 .... 0x29 0x30, but I receive 0x2e 0x2f
0x30 0x00 0x01 0x02 0x2f 0x30 0x00 0x01.....<br>
<br>
Have any of you tested it? Is there any solution to make what I try?<br>
<br>
Thanks. <br>

</div></blockquote></div><br>

------=_Part_12208_17784144.1144214623796--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

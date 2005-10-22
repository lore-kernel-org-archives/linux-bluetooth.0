Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <de37400f0510220640n3e596aa1ofc04e7508986eb26@mail.gmail.com>
From: Tomasz Urbanowicz <tomasz.urbanowicz@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO USB isoc transfer
In-Reply-To: <4359109D.9050502@csr.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_14635_6900473.1129988409506"
References: <de37400f0510210807s3df4b697sab237041cd30c6e1@mail.gmail.com>
	 <4359109D.9050502@csr.com>
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
Date: Sat, 22 Oct 2005 15:40:09 +0200

------=_Part_14635_6900473.1129988409506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks Steven for your prompt and complete reply.
 I've noticed that one SCO packet consists of three 17 bytes long USB
packets, and now I also understand that USB isoc packets might get lost and
resynchronization policy is required. I have two doubts left though.
 1) Does BlueZ employ a resynchronization scheme similar to the one you
mentioned ? From what I found out from reading BlueZ usb driver code it
seems that it assumes that SCO header is always there where it's supposed t=
o
be.
The __recv_frame() function which is called for each usb isoc packet that
comes from the device, builds up the SCO packet. It looks like it doesn't
really care that the SCO header might not be there. Correct me if I'm wrong=
.
 2) Isn't it odd that in my driver it's only the very first SCO packet that
comes from the device that is incomplete, missing either 17(one usb packet)
or 34 (two usb packets) starting bytes ? Packets that follow in the stream
seem to be OK.
 thanks,
Tomasz


 On 10/21/05, Steven Singer <steven.singer@csr.com> wrote:
>
> Tomasz Urbanowicz wrote:
> > Now I'm working on enabling SCO transfer which takes place over
> isochronous endpoints in
> > the usb device. Now to the point. After establishing the SCO connection
> when I read from
> > the device isoc endpoint I've noticed that the data that is returned
> sometimes starts
> > with the SCO header and sometimes it doesn't.When it doesn't the first
> SCO
> > Header appears somewhere later in the data.
>
> This is a fundamental problem with SCO over USB.
>
> One HCI SCO packet is broken into three USB packet. Only the first of
> these packets has a header.
>
> Unfortuantely, the USB isochronous stream is not reliable and packets
> can get lost. This means that the header may not be where you expect
> them.
>
> For a single SCO link with 16 bit data, the Bluetooth spec recommends
> that the data be packed into HCI packets containing 48 payload bytes
> (24 samples). The three byte HCI header brings the total PDU size up to
> 51 bytes. This is then split into three 17 byte packets which are sent
> on successive milliseconds.
>
> The first packet contains the three byte header and 14 bytes of payload.
> The last two contain 17 bytes of payload.
>
> You will need generic resynchronisation code that detects that a header
> was not received where it was expected and then reads individual USB
> packets until it finds one that starts with a header.
>
> If you wanted to be really robust, you'd look for a USB packet with a
> header followed by two without as, in theory, the header sequence could
> appear in the sample stream.
>
> In practice, if you just take the next packet with a header then if you
> did accidentally match in the packet stream, you'll probably find the
> next header isn't where you expected (as it's unlikely that the three
> bytes 48 bytes further along the data stream also match the header).
> You can then try and resynchronise again and keep trying until you get
> the right match (which should never take more than 3 attempts).
>
> > But it's not always like that. Somtimes the result buffer will start
> with
> > some garbage data, and the proper SCO header appears somewhere later in
> that
> > buffer. For example :
> > **)
> > 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22
> > 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10
> > 2C 00 30 22 10 22 10 22 10 22 10 22 10 22 10 22 10
> > Here first 34 bytes are not preceeded with the SCO Header. A properly
> > structured packet starts at the 3rd line here with 2C 00 30.
>
> 34 bytes is 2 x 17 bytes which means you started reading from the second
> packet of the three making up the full HCI packet.
>
> - Steven
> --
>
>
> This message has been scanned for viruses by BlackSpider MailControl -
> www.blackspider.com <http://www.blackspider.com>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

------=_Part_14635_6900473.1129988409506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Thanks Steven for your prompt and complete reply.</div>
<div>&nbsp;</div>
<div>I've noticed&nbsp;that one SCO packet consists of three 17 bytes long =
USB packets, and&nbsp;now&nbsp;I also understand that USB isoc packets migh=
t get lost and resynchronization policy is required. I have two doubts&nbsp=
;left though.</div>

<div>&nbsp;</div>
<div>1) Does BlueZ employ a resynchronization scheme similar to the one you=
 mentioned ? From what&nbsp;I&nbsp;found out from&nbsp;reading BlueZ usb dr=
iver code it seems that it assumes that SCO&nbsp;header is always there whe=
re it's supposed&nbsp;to be.
</div>
<div>The __recv_frame() function which is called for each usb isoc packet t=
hat comes from the device, builds up the SCO packet. It looks like it doesn=
't really care that the&nbsp;SCO header might not be there. Correct me if I=
'm wrong.
</div>
<div>&nbsp;</div>
<div>2) Isn't it odd that in my driver it's&nbsp;only the very first SCO pa=
cket that comes from the device&nbsp;that is&nbsp;incomplete, missing eithe=
r&nbsp;17(one usb packet)&nbsp;or 34 (two usb packets) starting&nbsp;bytes =
?&nbsp;Packets that follow in the stream seem to be OK.
</div>
<div>&nbsp;</div>
<div>thanks,</div>
<div>Tomasz&nbsp;&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp;<br><br>&nbsp;</div>
<div><span class=3D"gmail_quote">On 10/21/05, <b class=3D"gmail_sendername"=
>Steven Singer</b> &lt;<a href=3D"mailto:steven.singer@csr.com">steven.sing=
er@csr.com</a>&gt; wrote:</span>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Tomasz Urbanowicz wrote:<br>&gt;=
 Now I'm working on enabling SCO transfer which takes place over isochronou=
s endpoints in
<br>&gt; the usb device. Now to the point. After establishing the SCO conne=
ction when I read from<br>&gt; the device isoc endpoint I've noticed that t=
he data that is returned sometimes starts<br>&gt; with the SCO header and s=
ometimes it doesn'
t.When it doesn't the first SCO<br>&gt; Header appears somewhere later in t=
he data.<br><br>This is a fundamental problem with SCO over USB.<br><br>One=
 HCI SCO packet is broken into three USB packet. Only the first of<br>these=
 packets has a header.
<br><br>Unfortuantely, the USB isochronous stream is not reliable and packe=
ts<br>can get lost. This means that the header may not be where you expect<=
br>them.<br><br>For a single SCO link with 16 bit data, the Bluetooth spec =
recommends
<br>that the data be packed into HCI packets containing 48 payload bytes<br=
>(24 samples). The three byte HCI header brings the total PDU size up to<br=
>51 bytes. This is then split into three 17 byte packets which are sent
<br>on successive milliseconds.<br><br>The first packet contains the three =
byte header and 14 bytes of payload.<br>The last two contain 17 bytes of pa=
yload.<br><br>You will need generic resynchronisation code that detects tha=
t a header
<br>was not received where it was expected and then reads individual USB<br=
>packets until it finds one that starts with a header.<br><br>If you wanted=
 to be really robust, you'd look for a USB packet with a<br>header followed=
 by two without as, in theory, the header sequence could
<br>appear in the sample stream.<br><br>In practice, if you just take the n=
ext packet with a header then if you<br>did accidentally match in the packe=
t stream, you'll probably find the<br>next header isn't where you expected =
(as it's unlikely that the three
<br>bytes 48 bytes further along the data stream also match the header).<br=
>You can then try and resynchronise again and keep trying until you get<br>=
the right match (which should never take more than 3 attempts).<br><br>
&gt; But it's not always like that. Somtimes the result buffer will start w=
ith<br>&gt; some garbage data, and the proper SCO header appears somewhere =
later in that<br>&gt; buffer. For example :<br>&gt;&nbsp;&nbsp;**)<br>&gt; =
22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22
<br>&gt; 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10 22 10<br>&gt; 2C 00 3=
0 22 10 22 10 22 10 22 10 22 10 22 10 22 10<br>&gt;&nbsp;&nbsp;Here first 3=
4 bytes are not preceeded with the SCO Header. A properly<br>&gt; structure=
d packet starts at the 3rd line here with 2C 00 30.
<br><br>34 bytes is 2 x 17 bytes which means you started reading from the s=
econd<br>packet of the three making up the full HCI packet.<br><br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; - Steven<br>--<br><br><br>This message has bee=
n scanned for viruses by BlackSpider MailControl -=20
<a href=3D"http://www.blackspider.com">www.blackspider.com</a><br><br><br>-=
------------------------------------------------------<br>This SF.Net email=
 is sponsored by:<br>Power Architecture Resource Center: Free content, down=
loads, discussions,
<br>and more. <a href=3D"http://solutions.newsforge.com/ibmarch.tmpl">http:=
//solutions.newsforge.com/ibmarch.tmpl</a><br>_____________________________=
__________________<br>Bluez-devel mailing list<br><a href=3D"mailto:Bluez-d=
evel@lists.sourceforge.net">
Bluez-devel@lists.sourceforge.net</a><br><a href=3D"https://lists.sourcefor=
ge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/list=
info/bluez-devel</a><br></blockquote></div><br>

------=_Part_14635_6900473.1129988409506--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

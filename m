Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5f34bf160604040157t6d0f812eq86ee775602864eff@mail.gmail.com>
From: "elad wertzberger" <wertzber@gmail.com>
To: bluez-devel@lists.sourceforge.net, yklinger@gmail.com
In-Reply-To: <20060404031315.0349E894AD@sc8-sf-spam1.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20060404031315.0349E894AD@sc8-sf-spam1.sourceforge.net>
Subject: [Bluez-devel] Re: Bluez-devel digest, Vol 1 #1975 - 6 msgs
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
Date: Tue, 4 Apr 2006 01:57:48 -0700

hi all

1.thanks for the answer.
we still did not figured how to establish connection between a->b->c
simultounsly.
we also did not succeed to open 2 minicom simultounslly.
2. we have new major problem :
we  generlly need to establish RS232 with the bluettoth 1.1 devices.
it is mean that we need to deal also with mouse,ups,printer or any
other possibole device and to "continue" his activity on other
computer.
for example : with mouse we need to develoop somethig like "wireleess
mouse",it is mean that if i will move the mouse in one computer then
in the far computer i will see the movements.
we do not have any idea how to do it!!!!!1

waiting desperatlly for some help
wertzberger elad













On 4/3/06, bluez-devel-request@lists.sourceforge.net
<bluez-devel-request@lists.sourceforge.net> wrote:
> Send Bluez-devel mailing list submissions to
> =09bluez-devel@lists.sourceforge.net
>
> To subscribe or unsubscribe via the World Wide Web, visit
> =09https://lists.sourceforge.net/lists/listinfo/bluez-devel
> or, via email, send a message with subject or body 'help' to
> =09bluez-devel-request@lists.sourceforge.net
>
> You can reach the person managing the list at
> =09bluez-devel-admin@lists.sourceforge.net
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Bluez-devel digest..."
>
>
> Today's Topics:
>
>    1. Segmentation fault hcid in textfile.c (Herman Meerlo)
>    2. HCRP (Mayank Batra)
>    3. Headsets that support sniff mode? (Ulisses Furquim)
>    4. Fw: bluez-devel (jopqbrrjtz)
>    5. Re: Broadcom + SCO MTU patch, only beeps, raises noiselevel
>        but no sound... (Brad Midgley)
>
> --__--__--
>
> Message: 1
> Date: Mon, 03 Apr 2006 08:59:15 +0200
> From: Herman Meerlo <herman@service2media.com>
> To:  bluez-devel@lists.sourceforge.net
> Subject: [Bluez-devel] Segmentation fault hcid in textfile.c
> Reply-To: bluez-devel@lists.sourceforge.net
>
> This is a multi-part message in MIME format.
> --------------050501020907030302010300
> Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
> Content-Transfer-Encoding: 7bit
>
> Hi All,
>
> this weekend I have been testing with a directional antenna and
> therefore I have seen a lot of bluetooth devices. I have witnessed a
> segmentation fault in common/textfile.c twice. After examining the core
> file of the hcid I found out where the problem is and I have made a
> patch for it.
> The problem is that the textfile is mapped into memory with an mmap call
> on line 153, but the file I was writing to (once it was the lastseen
> file and once the names file) was exactly 8192 bytes. So an exact
> multiple of the page size. Therefore there is no terminating NULL
> character in the memory map and the find_key call on line 159, which
> uses a strstr, will read beyond the boundaries of the memory mapped
> segment -> SEGV.
> I have made a change to the find_key call and added an extra parameter
> to indicate the length of the map. It works fine for me but maybe it is
> not an optimal solution. I have attached the patch.
>
> Regards,
> Herman Meerlo
>
> --------------050501020907030302010300
> Content-Type: text/plain;
>  name=3D"hcid.patch"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline;
>  filename=3D"hcid.patch"
>
> Index: textfile.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/bluez/utils/common/textfile.c,v
> retrieving revision 1.16
> diff -u -r1.16 textfile.c
> --- textfile.c=0924 Mar 2006 14:36:28 -0000=091.16
> +++ textfile.c=093 Apr 2006 06:58:46 -0000
> @@ -86,9 +86,17 @@
>  =09return 0;
>  }
>
> -static inline char *find_key(char *map, const char *key, size_t len)
> +static inline char *find_key(char *map, size_t maplen, const char *key,
> size_t len)
>  {
> -=09char *off =3D strstr(map, key);
> +=09char *off =3D NULL;
> +=09int start=3D0;
> +=09while (start < (maplen - len)) {
> +=09=09if (0 =3D=3D strncmp(map+start, key, len)) {
> +=09=09=09off =3D map + start;
> +=09=09=09break;
> +=09=09}
> +=09=09start++;
> +=09}
>
>  =09while (off && ((off > map && *(off - 1) !=3D '\r' &&
>  =09=09=09=09*(off - 1) !=3D '\n') || *(off + len) !=3D ' '))
> @@ -156,7 +164,7 @@
>  =09=09goto unlock;
>  =09}
>
> -=09off =3D find_key(map, key, strlen(key));
> +=09off =3D find_key(map, size, key, strlen(key));
>  =09if (!off) {
>  =09=09if (value) {
>  =09=09=09munmap(map, size);
> @@ -265,7 +273,7 @@
>  =09}
>
>  =09len =3D strlen(key);
> -=09off =3D find_key(map, key, len);
> +=09off =3D find_key(map, size, key, len);
>  =09if (!off) {
>  =09=09err =3D EILSEQ;
>  =09=09goto unmap;
>
> --------------050501020907030302010300--
>
>
> --__--__--
>
> Message: 2
> Date: Mon, 3 Apr 2006 15:21:55 +0530
> From: "Mayank Batra" <mayankbatra@gmail.com>
> To: bluez-devel@lists.sourceforge.net
> Subject: [Bluez-devel] HCRP
> Reply-To: bluez-devel@lists.sourceforge.net
>
> ------=3D_Part_1406_8650129.1144057915062
> Content-Type: text/plain; charset=3DISO-8859-1
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
>
> Hello all,
>
> I want to test the HCRP profile as present in the bluez-utils-2.25/cups.
> Can you suggest any application that will emulate an HCRP printer ( and o=
f
> course be interoperable with the one with this client application)?
>
> Thanks.
>
> Regards,
>              Mayank.
>
> ------=3D_Part_1406_8650129.1144057915062
> Content-Type: text/html; charset=3DISO-8859-1
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
>
> <div>Hello all,</div>
> <div>&nbsp;</div>
> <div>I want to test the HCRP profile as present in the bluez-utils-2.25/c=
up=3D
> s.</div>
> <div>Can you suggest any application that will emulate an HCRP printer ( =
an=3D
> d of course be interoperable with the one with this client application)?<=
/d=3D
> iv>
> <div>&nbsp;</div>
> <div>Thanks.</div>
> <div>&nbsp;</div>
> <div>Regards,</div>
> <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bs=3D
> p; Mayank.</div>
>
> ------=3D_Part_1406_8650129.1144057915062--
>
>
> --__--__--
>
> Message: 3
> Date: Mon, 3 Apr 2006 11:56:56 -0300
> From: "Ulisses Furquim" <ulissesf@gmail.com>
> To: bluez-devel@lists.sourceforge.net
> Subject: [Bluez-devel] Headsets that support sniff mode?
> Reply-To: bluez-devel@lists.sourceforge.net
>
> Hi,
>
> I'm looking for headsets that support sniff mode. Are there any
> devices that you could recommend to me?
>
> Best regards,
>
> -- Ulisses
>
>
> --__--__--
>
> Message: 4
> From:   "jopqbrrjtz" <jopqbrrjtz@travelnow.com>
> To: bluez-devel@lists.sourceforge.net
> Date:   Mon, 3 Apr 2006 19:59:40 -0000
> Subject: [Bluez-devel] Fw: bluez-devel
> Reply-To: bluez-devel@lists.sourceforge.net
>
> ------=3D_NextPart_000_0010_01C65759.247B8B20
> Content-Type: multipart/alternative;
> =09boundary=3D"----=3D_NextPart_001_0011_01C65759.247B8B20"
>
>
> ------=3D_NextPart_001_0011_01C65759.247B8B20
> Content-Type: text/plain;
> =09charset=3D"Windows-1252"
> Content-Transfer-Encoding: quoted-printable
>
>
> ----- Original Message -----=3D20
> From: Walls Stephan=3D20
> To: izaqqkrovc@bbraun.com=3D20
> Sent: Saturday, April 01, 2006 11:12 PM
> Subject: bluez-devel
>
>
>
> ------=3D_NextPart_001_0011_01C65759.247B8B20
> Content-Type: text/html;
> =09charset=3D"Windows-1252"
> Content-Transfer-Encoding: quoted-printable
>
> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
> <HTML><HEAD>
> <META http-equiv=3D3DContent-Type content=3D3D"text/html;
> charset=3D3DWindows-1252">
> <META content=3D3D"MSHTML 6.00.2900.2769" name=3D3DGENERATOR>
> <STYLE></STYLE>
> </HEAD>
> <BODY bgColor=3D3D#ffffff>
> <DIV><FONT face=3D3DArial size=3D3D2></FONT>&nbsp;</DIV>
> <DIV style=3D3D"FONT: 10pt arial">----- Original Message -----=3D20
> <DIV style=3D3D"BACKGROUND: #e4e4e4; font-color: black"><B>From:</B> <A=
=3D20
> title=3D3DWalls Stephan =3D
> href=3D3D"mailto:phesjksq@ontelproducts.com ">Walls Stephan</A>=3D20
> </DIV>
> <DIV><B>To:</B> <A title=3D3Dizaqqkrovc@bbraun.com=3D20
> href=3D3D"mailto:izaqqkrovc@bbraun.com">izaqqkrovc@bbraun.com</A> </DIV>
> <DIV><B>Sent:</B> Saturday, April 01, 2006 11:12 PM</DIV>
> <DIV><B>Subject:</B> bluez-devel</DIV></DIV>
> <DIV><FONT face=3D3DArial size=3D3D2></FONT><BR></DIV>
> <DIV align=3D3Dcenter><FONT face=3D3DArial size=3D3D2></FONT>&nbsp;</DIV>
> <DIV align=3D3Dcenter><IMG =3D
> alt=3D3D"" hspace=3D3D0=3D20
> src=3D3D"cid:000f01c65748$60f2bb20$5f5bcf57@privatea694a51" =3D
> align=3D3Dbaseline=3D20
> border=3D3D0></DIV></BODY></HTML>
>
> ------=3D_NextPart_001_0011_01C65759.247B8B20--
>
> ------=3D_NextPart_000_0010_01C65759.247B8B20
> Content-Type: image/gif;
> =09name=3D"bluez-devel.gif"
> Content-Transfer-Encoding: base64
> Content-ID: <000f01c65748$60f2bb20$5f5bcf57@privatea694a51>
>
> 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
>
>
>
> ------=3D_NextPart_000_0010_01C65759.247B8B20--
>
>
>
> --__--__--
>
> Message: 5
> Date: Mon, 03 Apr 2006 15:20:57 -0600
> From: Brad Midgley <bmidgley@xmission.com>
> To:  bluez-devel@lists.sourceforge.net
> Subject: Re: [Bluez-devel] Broadcom + SCO MTU patch, only beeps, raises
> noiselevel
>  but no sound...
> Reply-To: bluez-devel@lists.sourceforge.net
>
> Jeroen
>
> > As it seems the problem is really with the Broadcom chip and it's drive=
r
> > source availability, thus I guess a better and easier question than
> > asking why it doesn't work etc, is to simply ask which one of the
> > following adapters is a CSR
>
> The d-link dbt-120 uses CSR. It's likely the 122 does too.
>
> If you can go elsewhere, the adapter that does it all is the Bluetake
> BT007EX. Class 1, CSR, edr.
>
> Brad
>
>
>
> --__--__--
>
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
> End of Bluez-devel Digest
>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

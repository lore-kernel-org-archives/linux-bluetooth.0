Received: from sonic307-54.consmr.mail.ir2.yahoo.com (sonic307-54.consmr.mail.ir2.yahoo.com [87.248.110.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D136F8F5
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 21:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.248.110.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361609; cv=none; b=H32CSOWa7nVLdN8YHr5ovEfiBsf0MI7Prt80apEF1sJD/gSNVQUQ3rXAU+8IVL5c6MmyoUKGSIPq3h5s8/REHZEOpknIxrw/JvDm5uWFDA7jOJ8opQVj+AAwQISYGJ7p2AfnMxDd5ktSW4WdoNCAouR58zw/c+F/QRmeYn+wagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361609; c=relaxed/simple;
	bh=+bLyAtTp9Ai2yl/czpoabxqh9acjey5V+RDw75oUtvs=;
	h=Date:From:To:Cc:Message-ID:References:Subject:MIME-Version:
	 Content-Type; b=sVnbM9vAffDqf2paFZbYMln3/Q8hAO0mP1UGF38drxAg7woty//+Whm4Ni5rZUvcl/3C0O72jkjo3eITRbd5eels+h22hAKOsn3Swxo6n08bSt9ydVcZy9HjGLszfmShz/3oA1AiHLZAX8RjHvveu11ZbtN29f4K5+yKpzqnESE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com; spf=pass smtp.mailfrom=ymail.com; dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b=stem6+cb; arc=none smtp.client-ip=87.248.110.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ymail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ymail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ymail.com header.i=@ymail.com header.b="stem6+cb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ymail.com; s=s2048; t=1785361604; bh=WBJ5t9wZYg2bwln4jqu0jUKtDdw4UwLSnNeaP8/aGtg=; h=Date:From:Reply-To:To:Cc:References:Subject:From:Subject:Reply-To; b=stem6+cbgANjEBM5tKaDCb3+lTAUSAjqeUA/+83jGkL5LUo1Q1aCC11VzXIOfxHrqkRX+CC7FBU4RQX9LSrBcJ2FflCgM3fyiwKko4uGjGh/wS6LyUoYqqRJulJsaLi59hNyGAiBdartiUNLH7hvYu/WaBp0QLa9IyX1mO0/RFmkqiO2a3S6lY2L094uPb2qWm6CKLyD6AOeIrS8ppz69eZYvcZhzE2RT2n2UGg31W/SByOdYYu8w8RljibGkgKAVXz/R/koudS8A2vvdh5e33xynbOJixcSVSI2VD9XzOfuHTchQ3B4pC55Rw392h8vsJ59pKtztd71CKV0Ch+jjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1785361604; bh=OvXetijvMp5BFpYglq0z9p87GGOLERwMmFXM2Qqq0UD=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=OcGAxILw9mbCoY23yQwJsRTCDx4EB4GaUS8gmo77V1AIdEYfpiX8xRI56F5Ic1blRnWiVWRcJDDWGYH34pM9zxY+8ApEp9cmwIbuoVpK8Zdu2XH7182kYx7Y4GbiM8gx+1CE1QyiKsGYy+X1FJDohJAE/a1QP2/wEoUqPu4N52vM/gc5HZFeP4PSbt7DFdjlTr4K1Yfgn0k/2asOAORnQXcGVFlrSPQvqtYGDAqtPVJLex/6EkT7K5aVR1J/CUoA167RXi4KvN+ojWcrG0jHxz+vg4cvJakOVUVcG9OwqxZOdv+6leNLja/pROLzzMtkyzs3HOcxcc/z9LxgruDfbQ==
X-YMail-OSG: PEk07OkVM1m21byja8HQ1d6FuPSu9x7dJ_Uk.aMEQgqNBZtiGvrSt8s_FsWRw2f
 w7QtdcPwjTnwQLSYll7N8gShqA.iEJryGNWIU61lDeH25v8xVMCX109DQOzr1VdwRUyim4xXUf_6
 Ek9.LZIseX.jp1NVJLqoEKOqRc5PtrnwJ24c1pXXqmaduC.Ry.xxP1.LrcxBLWsmuPeXZEa2N404
 l.8TUo1sn9B7fZt_ALlzYyDMbRJQoXci5L60SvRqz1Ciswr8xYovgXEl5lBMcCtHN71VMGvK7JHQ
 RL3PjeqAUQRE17jC5DHmTybRNJgU2gtMDKFN5FZWaf3nU0kT_p4BXLCQoo9DUbjuvlz5edL1egh4
 QRgECYl8mfwXujSUssc_gfO7Abbdnosh6tbei2l9TpDHQ1yPO4deC3Lp5GmWYB.3n2_VDm2TiMm0
 Ym09CryG45TJXLFC9CLvW5wNNxEl8SwNjcrxh9H1etXUvbd7pimu.E_3QPT.xR8_uFPNn1F75zOQ
 glKk59ceD6J6bzQuNHgylh8dPEIvZeEZCWZjG4iQvLNzkgJZoMtz3zzwUJq0xUaousPT3BXtgelu
 vAiPoH1gsiRjL2lFAJ4JmwHHdoxxR0iPogvu_gZHyP8kPR0.fXSUoecqHa2tHi88qwPraGUZtqaX
 Mcnt5rTywVAytdjZX5ViDlLGDfNXnqcNETnNe1BXCtmZsiRPJ5TCL0L46Fi7dfv48k4smAP.cXKh
 x0M8AqXMVXF19v5XvYla4FahCHFeruwNH3znQMVeHnqe1gzrDEFcdGjW.KI4tH0jJWBDntzvgfcZ
 laPJITgSR.vwA70mDWFXkuQQ.5xVx9D5CNieyQKTxr99Pp3rm6kT8Dq6DNCkdBV4BWA7kW24Qe99
 hAY.t1lnrr_H1WBcEzWpfpQ1jOkzMu_fi5C0CRpqWJqBx8WlTjfXXgBEh0pldZB6QYkkxrh4_cHm
 Sqmoay5xOiCKEnU9bwbXUbHmTJrwfPTMeEMjkldG7ZDs6e8vgC8uS5vxS5AITsIWNlUJb6ttnEDF
 nLXqTBNY00lPg.VkhafdQEEm4y5ZFEcZNfyMzyCDNa0iGFTJc.w866RQKazWNNXNsnnU_9zp0itd
 ZYXNNNhePo.3bQfGlpl2nlGdkKBolPktAH7_5Tp9rXHEvVNuSFqTZ0rzFgi6_Q_J3L4UcefFrvmo
 kYDhBhumAk0c76ycDf_.B4QT..SY7WqQHkDaDNP.FSU5qelLcZe18uK4DMbf37ILUhxuX7aoHoGj
 aXzVMQDnxHG.6UUhW0Hz3v2tO9NQ2T1xmKCvcrI4LpLbsCjCzOuytGTqLAcHYCv8ro1Ah01fWEHR
 J2RrgWrIZNKjTe13FTEM6Izd06WCMFH1gvWBgFySA5I3LIXxL.e3aNdBVxQgJvusHRk5cOqn6CPS
 jRz72lGzTGJVfHStyHEV6lvr6kZdEjm6Zgzrf4hMok1iDyYz43ddHO_y_1hSgpOc83xPHRrjkOBK
 2bPNQ2l2UVPgLU2aF3JLsDLsiEr9S36jBknjXML3UuOO1DD.OHad8R8LSZ2vFiWHVeIS8z391f.S
 uPpjnfBh.rpQxLAOb.U.wuqpvzxz9S7lUGvy9VcKBlJifMfAokmKgJQ6FSDfsKplfEetCLlPjvZM
 83CuYK_ix9.H8m_.F0XigpNBX6WaXCh0anq3ZdeoPfddQQ63RTlg_acSMxZgJTn35LazXVLc5eIY
 OHbSALEmEC3zjKu9aWI3ywHHEIfiKi5LIkigdHMdeaaCUv_ij5yVPg2pA7eT.47MLgkvmhfYcqfT
 ktCaROR0eKWl4liCebgAz5slwxx.rheMpzHeEikQGXui2FgqFno2F_kz2SB8NqxB6l1vo6I1feb9
 dlKHDhX.A3bgRRSu4Qi1Hi_P2A7rBUKnQofq97T19MEJ4jg87FBt4MrPrdzZvFxFNuDmnZkDVSOW
 6j9UG6yxjQ3RZMmOv3TsP_rw2jOeQDblnN__irdCM4nDPrLGVQWnokzyWJ8O3c1CItRk8cPKLg3Z
 BxcQVEONbp6WWNtgaSpHodJLeEgSSud1aAdP9w8BkVNHfI3tEUm_X37oSrIjOJl8o9V4ofSL1XbP
 mgOdCu6YbNKiumd7wfv55bFbG3I0U0FO6Ece3EFsvWs0udYFwaMyBTMk4Xy0eiTPEg4oDe1tkhnq
 iJnYVNbEmYoOAVOnqbhExIvxA8w5_gSy7LdUljbF8u20LjU7tLoyQyKNtAfv1K4vbbJhK86tOYKt
 sz_1NHYKHxyom8nKvnZ9N99wolmANNieG37enD1IUAhkDqw7bLdg7xlQ32XHbpo1YjDF1agLZ9ug
 X6l4d8jaxhg0DmFpktttGvQzrPP5kgHylvkwMYUjkHR8d8jCHB0bEydjxlXXCS779mfi5Ebo-
X-Sonic-MF: <oakkaya@ymail.com>
X-Sonic-ID: f0344bc2-e46e-4b78-b359-331b434f7b0b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ir2.yahoo.com with HTTP; Wed, 29 Jul 2026 21:46:44 +0000
Date: Wed, 29 Jul 2026 21:15:19 +0000 (UTC)
From: =?UTF-8?Q?O=C4=9Fuzhan_Akkaya?= <oakkaya@ymail.com>
Reply-To: =?UTF-8?Q?O=C4=9Fuzhan_Akkaya?= <oakkaya@ymail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, 
	"marcel@holtmann.org" <marcel@holtmann.org>
Message-ID: <1660735014.5089519.1785359719739@mail.yahoo.com>
References: <1660735014.5089519.1785359719739.ref@mail.yahoo.com>
Subject: [PATCH sbc] sbc: fix 1-byte heap-OOB read in
 sbc_unpack_frame_internal
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5089518_809481494.1785359719738"
X-Mailer: WebService/1.1.26180 YMailNovation

------=_Part_5089518_809481494.1785359719738
Content-Type: multipart/alternative; 
	boundary="----=_Part_5089517_1874306251.1785359719727"

------=_Part_5089517_1874306251.1785359719727
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Hi BlueZ maintainers,
While fuzzing libsbc with a libFuzzer + ASan harness exercising thepublic s=
bc_decode() entry point, I found a 1-byte heap-buffer-overflowREAD in sbc_u=
npack_frame_internal() at sbc/sbc.c:489. The off-by-one isin the bound chec=
k at line 486:
=C2=A0 =C2=A0 for (bit =3D 0; bit < bits[ch][sb]; bit++) {=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (consumed > len * 8)=C2=A0 =C2=A0 =C2=A0 =C2=A0 <-- should be=
 `>=3D`=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((data[consumed >> 3] >> (7 - (consumed & 0x=
7))) & 0x01)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 audio_sample |=3D 1 <=
< (bits[ch][sb] - bit - 1);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 consumed++;=C2=A0 =C2=A0 }
When `consumed =3D=3D len * 8` the guard does not fire and the next linerea=
ds `data[len]`, one byte past the input buffer.
The bug has been live since commit feb1bd57 (2011-10-19) =E2=80=94 survivin=
g theadjacent hardening in b3ae4260 ("sbc: Fix stack overflow read insbc_cr=
c8.", 2018) which fixed a similar pattern in the CRC helper.
Reproducer:
- Standalone PoC (compiles against system libsbc, ASan-enabled): attached=
=C2=A0 as poc_standalone.c- A 14-byte input is enough to reach the off-by-o=
ne:=C2=A0 =C2=A0 9c bd b0 36 7d f2 f2 f2 f2 f2 f2 f2 f2 f2
The proposed fix is a single-character change (`>` =E2=86=92 `>=3D`); patch=
attached as 0001-sbc-fix-1-byte-heap-OOB-read-in-sbc_unpack_frame_int.patch=
.
Verified on git HEAD b3deb8a ("Release 2.2"). After the patch the sameinput=
 is rejected cleanly by sbc_decode() (returns -1).
Impact assessment:
- Reachable via any A2DP audio frame (the SBC codec is mandatory for=C2=A0 =
A2DP); also reachable via libsbc users such as PulseAudio/PipeWire BT=C2=A0=
 modules, GStreamer's sbcparse/sbcdec, ofono, and most embedded BT=C2=A0 au=
dio gateways that link libsbc.- Primitive is a 1-byte out-of-bounds READ; i=
n a long-lived audio=C2=A0 pipeline the chunk neighborhood is attacker-shap=
eable across frames,=C2=A0 so the strongest immediate use is a probabilisti=
c info-leak / heap=C2=A0 layout oracle. CVSSv3.1 (proposed):=C2=A0 =C2=A0 A=
V:A/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N=C2=A0 (4.3 Medium)- AOSP/Android does NO=
T ship libsbc =E2=80=94 Android's BT stack uses the OI=C2=A0 Codec at blued=
roid/embdrv/sbc/, which is a structurally different=C2=A0 implementation an=
d not affected by this exact bug.
This issue has been assigned CVE-2026-16473 (via Red Hat SecurityResponse T=
eam). Public references:
-=C2=A0https://access.redhat.com/security/cve/CVE-2026-16473=C2=A0-=C2=A0ht=
tps://bugzilla.redhat.com/show_bug.cgi?id=3D2503650
I am including the id here for the commit record; please reference itwhen t=
he fix is merged.
Thanks,
---Attachments:
- 0001-sbc-fix-1-byte-heap-OOB-read-in-sbc_unpack_frame_int.patch- poc_stan=
dalone.c


Oguzhan Akkaya

Security Engineer

Per.Mail:=C2=A0oakkaya@ymail.com

LinkedIn=C2=A0|=C2=A0Twitter=C2=A0|=C2=A0Reddit=C2=A0|=C2=A0Github=C2=A0|=
=C2=A0Researchgate=C2=A0|


------=_Part_5089517_1874306251.1785359719727
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"ydpd834c2c4yahoo-style-wrap" style=
=3D"font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:13px=
;"><div id=3D"ydpd834c2c4yiv8529593384"><div style=3D"font-family:Helvetica=
 Neue, Helvetica, Arial, sans-serif;font-size:13px;" class=3D"ydpd834c2c4yi=
v8529593384ydp4f3a7d27yahoo-style-wrap"><div dir=3D"ltr" data-setdir=3D"fal=
se"> <div><div dir=3D"ltr" data-setdir=3D"false">Hi BlueZ maintainers,</div=
><div><br></div><div>While fuzzing libsbc with a libFuzzer + ASan harness e=
xercising the</div><div>public sbc_decode() entry point, I found a 1-byte h=
eap-buffer-overflow</div><div>READ in sbc_unpack_frame_internal() at sbc/sb=
c.c:489. The off-by-one is</div><div>in the bound check at line 486:</div><=
div><br></div><div>&nbsp; &nbsp; for (bit =3D 0; bit &lt; bits[ch][sb]; bit=
++) {</div><div>&nbsp; &nbsp; &nbsp; &nbsp; if (consumed &gt; len * 8)&nbsp=
; &nbsp; &nbsp; &nbsp; &lt;-- should be `&gt;=3D`</div><div>&nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; return -1;</div><div><br></div><div>&nbsp; &nbsp=
; &nbsp; &nbsp; if ((data[consumed &gt;&gt; 3] &gt;&gt; (7 - (consumed &amp=
; 0x7))) &amp; 0x01)</div><div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; au=
dio_sample |=3D 1 &lt;&lt; (bits[ch][sb] - bit - 1);</div><div><br></div><d=
iv>&nbsp; &nbsp; &nbsp; &nbsp; consumed++;</div><div>&nbsp; &nbsp; }</div><=
div><br></div><div>When `consumed =3D=3D len * 8` the guard does not fire a=
nd the next line</div><div>reads `data[len]`, one byte past the input buffe=
r.</div><div><br></div><div>The bug has been live since commit feb1bd57 (20=
11-10-19) =E2=80=94 surviving the</div><div>adjacent hardening in b3ae4260 =
("sbc: Fix stack overflow read in</div><div>sbc_crc8.", 2018) which fixed a=
 similar pattern in the CRC helper.</div><div><br></div><div>Reproducer:</d=
iv><div><br></div><div>- Standalone PoC (compiles against system libsbc, AS=
an-enabled): attached</div><div>&nbsp; as poc_standalone.c</div><div>- A 14=
-byte input is enough to reach the off-by-one:</div><div>&nbsp; &nbsp; 9c b=
d b0 36 7d f2 f2 f2 f2 f2 f2 f2 f2 f2</div><div><br></div><div>The proposed=
 fix is a single-character change (`&gt;` =E2=86=92 `&gt;=3D`); patch</div>=
<div>attached as 0001-sbc-fix-1-byte-heap-OOB-read-in-sbc_unpack_frame_int.=
patch.</div><div><br></div><div>Verified on git HEAD b3deb8a ("Release 2.2"=
). After the patch the same</div><div>input is rejected cleanly by sbc_deco=
de() (returns -1).</div><div><br></div><div>Impact assessment:</div><div><b=
r></div><div>- Reachable via any A2DP audio frame (the SBC codec is mandato=
ry for</div><div>&nbsp; A2DP); also reachable via libsbc users such as Puls=
eAudio/PipeWire BT</div><div>&nbsp; modules, GStreamer's sbcparse/sbcdec, o=
fono, and most embedded BT</div><div>&nbsp; audio gateways that link libsbc=
.</div><div>- Primitive is a 1-byte out-of-bounds READ; in a long-lived aud=
io</div><div>&nbsp; pipeline the chunk neighborhood is attacker-shapeable a=
cross frames,</div><div>&nbsp; so the strongest immediate use is a probabil=
istic info-leak / heap</div><div>&nbsp; layout oracle. CVSSv3.1 (proposed):=
</div><div>&nbsp; &nbsp; AV:A/AC:L/PR:N/UI:N/S:U/C:L/I:N/A:N&nbsp; (4.3 Med=
ium)</div><div>- AOSP/Android does NOT ship libsbc =E2=80=94 Android's BT s=
tack uses the OI</div><div>&nbsp; Codec at bluedroid/embdrv/sbc/, which is =
a structurally different</div><div>&nbsp; implementation and not affected b=
y this exact bug.</div><div><br></div><div>This issue has been assigned CVE=
-2026-16473 (via Red Hat Security</div><div>Response Team). Public referenc=
es:</div><div><br></div><div>-&nbsp;<a href=3D"https://access.redhat.com/se=
curity/cve/CVE-2026-16473" rel=3D"nofollow" target=3D"_blank">https://acces=
s.redhat.com/security/cve/CVE-2026-16473</a>&nbsp;</div><div>-&nbsp;<a href=
=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D2503650" rel=3D"nofollow"=
 target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D2503650</a=
></div><div><br></div><div>I am including the id here for the commit record=
; please reference it</div><div>when the fix is merged.</div><div><br></div=
><div>Thanks,</div><div><br></div><div>---</div><div>Attachments:</div><div=
><br></div><div>- 0001-sbc-fix-1-byte-heap-OOB-read-in-sbc_unpack_frame_int=
.patch</div><div>- poc_standalone.c</div><div><br></div></div></div><div cl=
ass=3D"ydpd834c2c4yiv8529593384ydp4f3a7d27signature"><div style=3D"margin:0=
cm 0cm 0.0001pt;font-family:Helvetica, Arial, sans-serif;font-size:13px;" c=
lass=3D"ydpd834c2c4yiv8529593384ydp22d665ffMsoNormal"><div style=3D"margin:=
0cm 0cm 0.0001pt;" class=3D"ydpd834c2c4yiv8529593384ydp22d665ffMsoNormal"><=
div style=3D"font-size:medium;"><strong><br></strong></div><p style=3D"font=
-size:medium;"><strong>Oguzhan Akkaya</strong></p><p style=3D"font-size:med=
ium;"><span style=3D"text-decoration-line:underline;color:rgb(255, 0, 0);">=
<em><strong>Security Engineer</strong></em></span></p><p style=3D"font-size=
:medium;">Per.Mail:&nbsp;<strong><a href=3D"mailto:oakkaya@ymail.com" rel=
=3D"nofollow" target=3D"_blank">oakkaya@ymail.com</a></strong></p><p style=
=3D"font-size:medium;"><a href=3D"http://tr.linkedin.com/in/oguzhanakkaya" =
rel=3D"nofollow" target=3D"_blank">LinkedIn</a>&nbsp;|&nbsp;<a href=3D"http=
://twitter.com/smashthekernel" rel=3D"nofollow" target=3D"_blank">Twitter</=
a>&nbsp;|&nbsp;<a href=3D"https://www.reddit.com/user/Pwnerintheshell/" rel=
=3D"nofollow" target=3D"_blank">Reddit</a>&nbsp;|&nbsp;<a href=3D"https://g=
ithub.com/oakkaya" rel=3D"nofollow" target=3D"_blank">Github</a>&nbsp;|&nbs=
p;<a href=3D"https://www.researchgate.net/profile/Oguzhan_Akkaya" rel=3D"no=
follow" target=3D"_blank">Researchgate</a>&nbsp;|<br></p></div></div></div>=
</div></div></div></body></html>
------=_Part_5089517_1874306251.1785359719727--

------=_Part_5089518_809481494.1785359719738
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-sbc-fix-1-byte-heap-OOB-read-in-sbc_unpack_frame_int.patch"
Content-ID: <76d2b962-ebbf-6708-d950-3dd6e368df02@yahoo.com>

RnJvbSBmNGEyYmM2NGZhZWU0MDhmOTI1YWU3ODAwZmMxOGE5MjEzZTFjYzc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPxJ91emhhbiBBa2theWEgPG9ha2theWFAeW1haWwuY29tPgpE
YXRlOiBXZWQsIDI5IEp1bCAyMDI2IDE2OjI3OjAzIC0wNDAwClN1YmplY3Q6IFtQQVRDSCBzYmNd
IHNiYzogZml4IDEtYnl0ZSBoZWFwLU9PQiByZWFkIGluIHNiY191bnBhY2tfZnJhbWVfaW50ZXJu
YWwKVG86IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcKQ2M6IEx1aXogQXVndXN0byB2
b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPgpDYzogbWFyY2VsQGhvbHRtYW5uLm9yZwoK
VGhlIHBlci1zYW1wbGUgYml0LXJlYWRlciBhdCBzYmMuYzo0ODUtNDkzIGhhcyBhbiBvZmYtYnkt
b25lIGJvdW5kIGNoZWNrCnRoYXQgYWxsb3dzIHRoZSBidWZmZXItZW5kIHRvIGJlIHJlYWNoZWQg
YW5kIG9uZSBieXRlIHRvIGJlIHJlYWQgcGFzdAp0aGUgYXR0YWNrZXItY29udHJvbGxlZCBTQkMg
ZnJhbWUgYnVmZmVyLgoKV2hlbiB0aGUgY3VtdWxhdGl2ZSBgY29uc3VtZWRgIGJpdC1wb3NpdGlv
biByZWFjaGVzIGxlbio4IGV4YWN0bHksIHRoZQpndWFyZCBgaWYgKGNvbnN1bWVkID4gbGVuICog
OClgIGRvZXMgbm90IGZpcmUsIGFuZCB0aGUgbmV4dCBzdGF0ZW1lbnQKaW5kZXhlcyBgZGF0YVtj
b25zdW1lZCA+PiAzXWAgPT0gYGRhdGFbbGVuXWAsIG9uZSBieXRlIHBhc3QgdGhlCmVuZCBvZiB0
aGUgaW5wdXQgYnVmZmVyLiBBZGRyZXNzU2FuaXRpemVyIHJlcG9ydHM6CgogIEVSUk9SOiBBZGRy
ZXNzU2FuaXRpemVyOiBoZWFwLWJ1ZmZlci1vdmVyZmxvdwogIFJFQUQgb2Ygc2l6ZSAxCiAgICAj
MCBzYmNfdW5wYWNrX2ZyYW1lX2ludGVybmFsIHNiYy5jOjQ4OQogICAgIzEgc2JjX2RlY29kZSAg
ICAgICAgICAgICAgICBzYmMuYzoxMjI1CgpUaGUgYnVnIGhhcyBiZWVuIHByZXNlbnQgc2luY2Ug
Y29tbWl0IGZlYjFiZDU3ICgyMDExLTEwLTE5LCAnc2JjOgpSZWR1Y2UgZm9yLWxvb3AgaW5kdWNl
ZCBpbmRlbnRhdGlvbiBpbiBzYmNfdW5wYWNrX2ZyYW1lJykuIEl0IHdhcwpub3QgYWRkcmVzc2Vk
IGJ5IHRoZSBhZGphY2VudCBoYXJkZW5pbmcgaW4gYjNhZTQyNjAgKCdzYmM6IEZpeCBzdGFjawpv
dmVyZmxvdyByZWFkIGluIHNiY19jcmM4LicsIDIwMTgpIHdoaWNoIGZpeGVkIGEgc2ltaWxhciAx
LWJ5dGUKb3Zlci1yZWFkIGluIHNiY19jcmM4LgoKVGhlIGZpeCBjaGFuZ2VzIHRoZSBjb21wYXJp
c29uIHRvIGA+PWAgc28gdGhhdCB0aGUgZ3VhcmQgZmlyZXMgd2hlbgpgY29uc3VtZWRgIHdvdWxk
IHJlYWNoIHRoZSBieXRlIGJleW9uZCB0aGUgYnVmZmVyLgoKQ1ZFOiBDVkUtMjAyNi0xNjQ3MwpT
aWduZWQtb2ZmLWJ5OiBPxJ91emhhbiBBa2theWEgPG9ha2theWFAeW1haWwuY29tPgotLS0KRm91
bmQgdmlhIGEgbGliRnV6emVyICsgQWRkcmVzc1Nhbml0aXplciBoYXJuZXNzIGFyb3VuZCB0aGUg
cHVibGljCnNiY19kZWNvZGUoKSBlbnRyeSBwb2ludC4KCkhvdyB0byB0cmlnZ2VyIOKAlCBhIDE0
LWJ5dGUgZnJhbWUgaXMgZW5vdWdoIHRvIHJlYWNoIHRoZSBvZmYtYnktb25lOgoKICAgIDljIGJk
IGIwIDM2IDdkIGYyIGYyIGYyIGYyIGYyIGYyIGYyIGYyIGYyCgpPbiBhbiBBU2FuIGJ1aWxkLCBz
YmNfZGVjb2RlKCkgb24gdGhpcyBpbnB1dCByZXBvcnRzOgoKICAgIEVSUk9SOiBBZGRyZXNzU2Fu
aXRpemVyOiBoZWFwLWJ1ZmZlci1vdmVyZmxvdyAgUkVBRCBvZiBzaXplIDEKICAgICAgIzAgc2Jj
X3VucGFja19mcmFtZV9pbnRlcm5hbCBzYmMuYzo0ODkKICAgICAgIzEgc2JjX2RlY29kZSAgICAg
ICAgICAgICAgICBzYmMuYzoxMjI1CgpBZnRlciB0aGUgcGF0Y2ggdGhlIHNhbWUgaW5wdXQgaXMg
cmVqZWN0ZWQgY2xlYW5seSAoc2JjX2RlY29kZSByZXR1cm5zIC0xKS4KVmVyaWZpZWQgb24gZ2l0
IEhFQUQgYjNkZWI4YSAoIlJlbGVhc2UgMi4yIikuCgpJbXBhY3Q6IHJlYWNoYWJsZSB2aWEgYW55
IEEyRFAgYXVkaW8gZnJhbWUgKFNCQyBpcyBtYW5kYXRvcnkgZm9yIEEyRFApIGFuZAp2aWEgbGli
c2JjIHVzZXJzIHN1Y2ggYXMgUHVsc2VBdWRpby9QaXBlV2lyZSBCVCBtb2R1bGVzLCBHU3RyZWFt
ZXIKc2JjcGFyc2Uvc2JjZGVjLCBhbmQgZW1iZWRkZWQgQlQgYXVkaW8gZ2F0ZXdheXMuIFRoZSBw
cmltaXRpdmUgaXMgYSAxLWJ5dGUKb3V0LW9mLWJvdW5kcyBSRUFEOyBpbiBhIGxvbmctbGl2ZWQg
YXVkaW8gcGlwZWxpbmUgdGhlIG5laWdoYm91cmluZyBoZWFwIGlzCmF0dGFja2VyLXNoYXBlYWJs
ZSBhY3Jvc3MgZnJhbWVzLCBzbyB0aGUgc3Ryb25nZXN0IGltbWVkaWF0ZSB1c2UgaXMgYQpwcm9i
YWJpbGlzdGljIGluZm8tbGVhayAvIGhlYXAtbGF5b3V0IG9yYWNsZS4KQ1ZTU3YzLjEgKHByb3Bv
c2VkKTogQVY6QS9BQzpML1BSOk4vVUk6Ti9TOlUvQzpML0k6Ti9BOk4gKDQuMyBNZWRpdW0pLgoK
Tm90ZTogQU9TUC9BbmRyb2lkIGRvZXMgbm90IHNoaXAgbGlic2JjIOKAlCBBbmRyb2lkJ3MgQlQg
c3RhY2sgdXNlcyB0aGUgT0kKY29kZWMgYXQgYmx1ZWRyb2lkL2VtYmRydi9zYmMvLCBhIHN0cnVj
dHVyYWxseSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24gbm90CmFmZmVjdGVkIGJ5IHRoaXMgYnVn
LgoKQXNzaWduZWQgQ1ZFLTIwMjYtMTY0NzMgKHZpYSB0aGUgUmVkIEhhdCBTZWN1cml0eSBSZXNw
b25zZSBUZWFtKToKICBodHRwczovL2FjY2Vzcy5yZWRoYXQuY29tL3NlY3VyaXR5L2N2ZS9DVkUt
MjAyNi0xNjQ3MwogIGh0dHBzOi8vYnVnemlsbGEucmVkaGF0LmNvbS9zaG93X2J1Zy5jZ2k/aWQ9
MjUwMzY1MAoKQSBzdGFuZGFsb25lIH42MC1saW5lIEFTYW4gcmVwcm9kdWNlciAocG9jX3N0YW5k
YWxvbmUuYykgaXMgYXZhaWxhYmxlIG9uCnJlcXVlc3QuCgogc2JjL3NiYy5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
c2JjL3NiYy5jIGIvc2JjL3NiYy5jCmluZGV4IDJmYWIzNjYuLmZmZTI4MWEgMTAwNjQ0Ci0tLSBh
L3NiYy9zYmMuYworKysgYi9zYmMvc2JjLmMKQEAgLTQ4Myw3ICs0ODMsNyBAQCBzdGF0aWMgaW50
IHNiY191bnBhY2tfZnJhbWVfaW50ZXJuYWwoY29uc3QgdWludDhfdCAqZGF0YSwKIAogCQkJCWF1
ZGlvX3NhbXBsZSA9IDA7CiAJCQkJZm9yIChiaXQgPSAwOyBiaXQgPCBiaXRzW2NoXVtzYl07IGJp
dCsrKSB7Ci0JCQkJCWlmIChjb25zdW1lZCA+IGxlbiAqIDgpCisJCQkJCWlmIChjb25zdW1lZCA+
PSBsZW4gKiA4KQogCQkJCQkJcmV0dXJuIC0xOwogCiAJCQkJCWlmICgoZGF0YVtjb25zdW1lZCA+
PiAzXSA+PiAoNyAtIChjb25zdW1lZCAmIDB4NykpKSAmIDB4MDEpCi0tIAoyLjUzLjAKCg==

------=_Part_5089518_809481494.1785359719738
Content-Type: application/octet-stream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="poc_standalone.c"
Content-ID: <cd03009a-6971-1602-4b63-23240c9ac9e1@yahoo.com>

LyoKICogbGlic2JjIChCbHVlWiBTQkMgY29kZWMpIOKAlCBoZWFwLWJ1ZmZlci1vdmVyZmxvdyBS
RUFEIGluIHNiY191bnBhY2tfZnJhbWVfaW50ZXJuYWwKICogU3RhbmRhbG9uZSByZXByb2R1Y2Vy
LgogKgogKiBCdWlsZCAoRGViaWFuL1VidW50dS9GZWRvcmEg4oCUIG5lZWRzIGxpYnNiYy1kZXYg
LyBzYmMtZGV2ZWwpOgogKiAgIGdjYyAtTzAgLWcgLWZzYW5pdGl6ZT1hZGRyZXNzIHBvY19zdGFu
ZGFsb25lLmMgLWxzYmMgLW8gcG9jCiAqCiAqIE9yIGFnYWluc3QgYSBmcmVzaGx5IGJ1aWx0IHVw
c3RyZWFtIHRyZWU6CiAqICAgZ2NjIC1PMCAtZyAtZnNhbml0aXplPWFkZHJlc3MgXAogKiAgICAg
ICAtSS9wYXRoL3RvL3NiYy9zYmMgcG9jX3N0YW5kYWxvbmUuYyBcCiAqICAgICAgIC9wYXRoL3Rv
L3NiYy9zYmMvLmxpYnMvbGlic2JjLmEgLWxtIC1vIHBvYwogKgogKiBSdW46CiAqICAgLi9wb2MK
ICoKICogRXhwZWN0ZWQgb24gYSB2dWxuZXJhYmxlIGJ1aWxkIChsaWJzYmMgPD0gMi4yIC8gZ2l0
IEhFQUQgYjNkZWI4YSBhcyBvZgogKiAyMDI2LTA1LTAyKTogQWRkcmVzc1Nhbml0aXplciBwcmlu
dHMKICogICAiRVJST1I6IEFkZHJlc3NTYW5pdGl6ZXI6IGhlYXAtYnVmZmVyLW92ZXJmbG93IC4u
LiBSRUFEIG9mIHNpemUgMSAuLi4KICogICAgaW4gc2JjX3VucGFja19mcmFtZV9pbnRlcm5hbCBz
YmMuYzo0ODkiCiAqCiAqIEV4cGVjdGVkIG9uIGEgcGF0Y2hlZCBidWlsZDogY2xlYW4gZXhpdCAo
c2JjX2RlY29kZSByZXR1cm5zIC0xKS4KICovCgojaW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRl
IDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c2JjL3NiYy5oPgoKLyogMTQtYnl0ZSB0cmlnZ2Vy
IOKAlCBmaXJzdCBieXRlIDB4OUMgaXMgdGhlIFNCQyBzeW5jIHdvcmQ7IHRoZSByZW1haW5kZXIg
aXMKICogY3JhZnRlZCBzbyB0aGF0IHRoZSBwZXItc2FtcGxlIGJpdC1yZWFkZXIncyBgY29uc3Vt
ZWRgIGNvdW50ZXIgcmVhY2hlcwogKiBleGFjdGx5IGxlbio4IG9uIHRoZSBmaW5hbCBpdGVyYXRp
b24sIGFuZCB0aGUgb2ZmLWJ5LW9uZSBib3VuZCBjaGVjayBhdAogKiBzYmMuYzo0ODYgKGBjb25z
dW1lZCA+IGxlbiAqIDhgKSBsZXRzIHRoZSBuZXh0IHJlYWQgZmFsbCBvbmUgYnl0ZSBwYXN0CiAq
IHRoZSBpbnB1dCBidWZmZXIgZW5kLiAqLwpzdGF0aWMgY29uc3QgdW5zaWduZWQgY2hhciBUUklH
R0VSWzE0XSA9IHsKICAgIDB4OWMsIDB4YmQsIDB4YjAsIDB4MzYsIDB4N2QsIDB4ZjIsIDB4ZjIs
IDB4ZjIsCiAgICAweGYyLCAweGYyLCAweGYyLCAweGYyLCAweGYyLCAweGYyLAp9OwoKaW50IG1h
aW4odm9pZCkgewogICAgc2JjX3Qgc2JjOwogICAgaWYgKHNiY19pbml0KCZzYmMsIDBMKSA8IDAp
IHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgInNiY19pbml0IGZhaWxlZFxuIik7CiAgICAgICAg
cmV0dXJuIDE7CiAgICB9CgogICAgLyogVXNlIGEgaGVhcCBhbGxvY2F0aW9uIHNvIEFkZHJlc3NT
YW5pdGl6ZXIncyByZWR6b25lIGltbWVkaWF0ZWx5IGZvbGxvd3MKICAgICAqIHRoZSBidWZmZXIg
ZW5kIOKAlCB0aGF0IGlzIHdoYXQgbWFrZXMgdGhlIDEtYnl0ZSBvdmVyLXJlYWQgdmlzaWJsZS4g
ICAgICAgKi8KICAgIHVuc2lnbmVkIGNoYXIgKmluID0gKHVuc2lnbmVkIGNoYXIgKiltYWxsb2Mo
c2l6ZW9mIFRSSUdHRVIpOwogICAgaWYgKCFpbikgeyBzYmNfZmluaXNoKCZzYmMpOyByZXR1cm4g
MTsgfQogICAgbWVtY3B5KGluLCBUUklHR0VSLCBzaXplb2YgVFJJR0dFUik7CgogICAgdW5zaWdu
ZWQgY2hhciBvdXRbNDA5Nl07CiAgICBzaXplX3Qgd3JpdHRlbiA9IDA7CiAgICBzc2l6ZV90IHIg
PSBzYmNfZGVjb2RlKCZzYmMsIGluLCBzaXplb2YgVFJJR0dFUiwgb3V0LCBzaXplb2Ygb3V0LCAm
d3JpdHRlbik7CgogICAgZnByaW50ZihzdGRlcnIsICJzYmNfZGVjb2RlIHJldHVybmVkICV6ZCwg
d3JpdHRlbj0lenVcbiIsIHIsIHdyaXR0ZW4pOwoKICAgIGZyZWUoaW4pOwogICAgc2JjX2Zpbmlz
aCgmc2JjKTsKICAgIHJldHVybiAwOwp9Cg==

------=_Part_5089518_809481494.1785359719738--

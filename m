Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558861F4180
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Aug 2026 04:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785643610; cv=pass; b=CK8bf1J2sPwhHGD89sug1pDmyrWFKcTK5zY4KCN2tnh9Ak5rkSVwj12wgcge3IELm6XWVLnB7BqatD1H4R0kSlfAl03RgDIFZpj4Z3DKtU0HpFiUIR+PoIvLx+OBpI4jAB6vos7UG4IKJFkcXHpuj5/uETOlByrIflhT1Og+z/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785643610; c=relaxed/simple;
	bh=zskK1liV9D335xYbSwEmmf8eaD6c/q+mCjpnQ9Dl41Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BRD0hSy/1M2tELIUgRm+kReUZAT69CnxbXuHDCNiOCbfa5Ca+QNi1jkN9C4ZD/bRaXT1SwRBGlAQnoEGCvZs5z+FRTACjtDnDkb+QqL+j6CR+0T4wbgH2Kc4UJpK/FXKEqV/PiMeWjHhQeUM8TQXgbb1aJlEEpcM9TXCXwVulbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW9pGn08; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW9pGn08"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6682259cb3dso3959610d50.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 21:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785643607; cv=none;
        d=google.com; s=arc-20260327;
        b=Bhb0L5pKutwmb2jPIU+Ho/JyCR8ZpbyaQdu+J48JiZT2/74SkfKJi8CEGOK4VYkeKs
         tliyY2Q16NZpHWeAAXHnKL//SBSBa+2KoiJrZz5gyO+abh4HCXLdBa4XAc1sQY78X0Wu
         1X9D2yZTdII91ezNkNuZjzh2g61s+pkiFLpriabSgMEh/e6Gfqf80Ob8xoQc9CRppYb3
         Z2kaVR8bAygvvAMFw1AiKb9vou5ryd5qFDc4EBp/Ibk5g+YSOl6JMD60gkL8Mq8k4eqV
         /xVdWXXqt09zbDjkHrE8Te2yjl58O1HMRxzJIpYXzJ148VHpMk3ThpZZ4OXMvhEp2+KT
         UTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u/DT7d7D1EALdbkQ51WhowdK92efWULbCq/Wnc41jGc=;
        fh=JHJZrUcJnIwW/yBvORnbfCI/G+1d0U3CACqtTc34AJM=;
        b=l5AEj/Lj08qKoW5HrVoyu27T9XaocScrONqyfIBabnuGEe87Zh9K/9dBxdz6HZVRMz
         oQQjJLYUo5knlDuuVyEb96yPuqVZauYRs/3Wx973ePo5ZTsbMKu4DQi2kegS2tftToQC
         lrfPRV56zUntJQPF04y07K+5g/J0h9ULkehglpgTSKOyu2RO7fJgZ+CRTSWJqnOJU5PJ
         jDucC2+sYOtutG9FC+RfdQD+qWLJlLgkd/Y/ou+E8a0ZgW5OmcjAMDHJLD0o+RHPckIf
         HinWRRMeLx+HvK/N7Z02OKnEg++M3zaNrFWHgXrAJc6et8PzixrYGs1SiDFo10DuaRey
         4P6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785643607; x=1786248407; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/DT7d7D1EALdbkQ51WhowdK92efWULbCq/Wnc41jGc=;
        b=NW9pGn08rPVTC+TkBYGHcpzNNN79BkyGBmickp3wnrcNG2/jan+Ac2SvBFWYsO4Vey
         +IPpIUvMOm+mHDjuiDONMWifee4h4YJkSHgSs6ztiqBd1l7jp6afSuoyYLdnRELPpZp+
         Lu85zd2y8NmpvD3RMevmAH4A8r7jMAQUjdLxu84vV50CQoIRnYD2Qpn1g3fJED3D/RSY
         X7ZpfsZq8we84Fn1QdxRVPMIK0XzqwNRSm2VHNp95ZFR3ka2h0jVSbKCmmNEDn0mGHUF
         2JWF8/OE3kPSFyQt/uA7ZRofU2EcvaMfNSad2PG7wiPevDEAyI+47Adiz9Y14fSZXGth
         f49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785643607; x=1786248407;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u/DT7d7D1EALdbkQ51WhowdK92efWULbCq/Wnc41jGc=;
        b=VDVPi5uydA94NvAl3nO9Knmm5ozbHoWLMhEmavYZhKimqSbHcEw4CaYIDBIx37BBN2
         DiozViUC16jjankoTomgnErR69H0Z//ipJxY3WdGSmUiAltMpYuJZPfO1HlRZqk70Qur
         5ZcnO2Rt0K6d6xveBkBp2W5tlyOEKVQMmtDsEROZ8axlaBkAZvfILvBkENt9Y9iQTZzM
         5Vefx2/DrvEfv7Tjjdvl90hIpNDDnGnA/Bk5wGw5zE6SXpvQJYrVMhokOHRgg4BAT/XC
         jnjKJnorVl6x3mLapSTUvSW58tmwXcSUbDjF+QWGF8wdVeZWeo96hvN7yN9xcC+cyLQ5
         rWRw==
X-Gm-Message-State: AOJu0YwiwJIxQkMRrwWUGT5MQWX3jnNFwf0chbN8kcTkamomQbYQdQTn
	BLhwcRqLqdR53AXvh+XSUiog4S1Wvk4foxurDmJuGhJgYQEKaPsQjWwVwKNULga2KFm1UVlwS+3
	hwSrJBRFl3Wceccgm/5tkg4FMnXG0fplh2WFlfYK7ag==
X-Gm-Gg: AR+sD11WXNLX0+OZfMkIQxLIw+MkdqxsqaOXt9vzNSIqGVtXfVMX56hQAsfe5BLmGLX
	7ZpasLixECToCAyWkGtYUWwZnQtIo5vnS+CjYflvJS6IBzxLzJq0Pc4sLL26BLGaVEJ/jDfa18T
	N1S7siUCS7iJiumNVSxuEprzrQn6//xSxSQH4Fc6LJcL9RuJMRAs/IQtB3BbHPTmLpopfFVNyL9
	CDmiuKB/msC8pcthACFVlEd/opnjKkxQk6YOrM+4DIbA2HAxq/TWqDit8i+ywBFa4zuIV/f8MP4
	72iOkBh86s8daGvRZJwQ21pf3S2w/pBTVAeGp28P0USAhw==
X-Received: by 2002:a05:690e:4848:b0:667:ef7f:c37e with SMTP id
 956f58d0204a3-6694f89bb4amr5367496d50.8.1785643607042; Sat, 01 Aug 2026
 21:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elman Shahbazov <shahbazovelman97@gmail.com>
Date: Sun, 2 Aug 2026 08:06:35 +0400
X-Gm-Features: AUfX_mzHfG6wk619G29SRFP9Rgm3W4HY9tzc-xcmzSZs9D8XZWNG35lGCJ7wAas
Message-ID: <CADE-WFdQ+35ePBX35mQt6o61dyz7tBkKByVe1BnKzXxpb-njAw@mail.gmail.com>
Subject: [PATCH] Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing
To: linux-bluetooth@vger.kernel.org
Cc: secalert@redhat.com, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000e4e6c10658088c30"

--000000000000e4e6c10658088c30
Content-Type: multipart/alternative; boundary="000000000000e4e6bf0658088c2e"

--000000000000e4e6bf0658088c2e
Content-Type: text/plain; charset="UTF-8"

Hello BlueZ maintainers and Red Hat Security team,

This is v2 of the patch fixing an Out-of-Bounds Read vulnerability in the
AVRCP profile. The previous submission (v1) was automatically rejected by
Patchwork due to email client formatting corrupting the diff (spaces
replacing
tabs). To resolve this, the patch is now attached as a standard .patch file
generated by git format-patch.

Below is a detailed technical analysis of the vulnerability, the threat
model,
and instructions for reproducing the issue.

 1. Vulnerability Details
* Component: profiles/audio/avrcp.c
* Functions: parse_media_element (line 2618), parse_media_folder (line 2652)
* CWE: CWE-125 (Out-of-bounds Read)

During a source code audit of the AVRCP Browsing profile, a logical flaw was
discovered in the parsing of the GetFolderItems response.

The vulnerable functions extract the length of the media item name (namesize
or namelen) directly from the network packet (controlled by the remote
device)
and use it to copy data into a local stack buffer char name[255] via memcpy.

While the code attempts to prevent a stack-based buffer overflow by
limiting the
copy length using MIN(namesize, sizeof(name) - 1), it completely fails to
validate this extracted length against the actual size of the incoming
packet (len).

 2. Root Cause Analysis
In parse_media_element, the code proceeds as follows:

    if (len < 13)
            return NULL;

    namesize = get_be16(&operands[11]); // Attacker controlled value (e.g.,
1000)
    namelen = MIN(namesize, sizeof(name) - 1); // namelen becomes 254

    if (namelen > 0) {
            // OOB READ: reads 254 bytes from a buffer that might only be
14 bytes long
            memcpy(name, &operands[13], namelen);
            strtoutf8(name, namelen);
    }

    // OOB READ: 13 + 1000 = 1013. Reads far beyond the packet boundary
    count = operands[13 + namesize];

If a remote device sends a packet where the namesize field is large (e.g.,
1000)
but the actual packet length (len) is very small (e.g., 14 bytes), the
memcpy
will read 254 bytes starting from &operands[13]. Since the packet is only
14 bytes
long, this results in a 253-byte Out-of-Bounds Read.

Furthermore, the subsequent access operands[13 + namesize] attempts to read
a byte
at offset 1013, which guarantees a segmentation fault if the memory is
unmapped.

A similar flaw exists in parse_media_folder where namelen is not bounded by
len:
    namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
    if (namelen > 0)
            memcpy(name, &operands[14], namelen); // OOB READ if len < 268

 3. Impact and Threat Model
* Attack Vector: Adjacent Network (Bluetooth)
* User Interaction: Required (UI:R) - The victim must connect to the
malicious device.
* Impact: Denial of Service (DoS) / Potential Information Disclosure.

A remote Bluetooth device acting as an AVRCP controller (e.g., a malicious
car kit,
headphones, or speaker) can send a specially crafted GetFolderItems
response. When
a Linux client connects and requests the media list, bluetoothd will
attempt to read
unallocated memory. This results in a SIGSEGV and an immediate crash of the
Bluetooth
daemon (DoS). In certain heap configurations, the read data could be
processed and
leaked, leading to Information Disclosure.

4. Proof of Concept (PoC)
I have attached poc_avrcp_obb.c which extracts the vulnerable logic and
simulates
the attack using a 14-byte malicious packet with an inflated namesize of
1000.

To verify the vulnerability:
1. Compile with AddressSanitizer:
   gcc -fsanitize=address -g -o poc_avrcp_oob poc_avrcp_obb.c
2. Run the binary:
   ./poc_avrcp_oob

ASan will immediately detect the out-of-bounds access and abort:
=================================================================
==113741==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x...
READ of size 254 at 0x... thread T0
    #0 0x... in memcpy
    #1 0x... in parse_media_element_vuln
    #2 0x... in main
SUMMARY: AddressSanitizer: stack-buffer-overflow in parse_media_element_vuln

[ 5. Proposed Fix
The attached patch ensures that the length extracted from the packet is
strictly
validated against the remaining bytes in the packet buffer (len) before
being
used in memcpy. It also adds boundary checks before accessing subsequent
offsets.

Please review the attached .patch file. I am requesting a CVE assignment for
this issue given its impact on system availability.

Best regards,

Elman Shahbazov
Security Researcher

--000000000000e4e6bf0658088c2e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello BlueZ maintainers and Red Hat Security team,<br><br>=
This is v2 of the patch fixing an Out-of-Bounds Read vulnerability in the<b=
r>AVRCP profile. The previous submission (v1) was automatically rejected by=
<br>Patchwork due to email client formatting corrupting the diff (spaces re=
placing<br>tabs). To resolve this, the patch is now attached as a standard =
.patch file<br>generated by git format-patch.<br><br>Below is a detailed te=
chnical analysis of the vulnerability, the threat model,<br>and instruction=
s for reproducing the issue.<br><br>=C2=A01. Vulnerability Details<br>* Com=
ponent: profiles/audio/avrcp.c<br>* Functions: parse_media_element (line 26=
18), parse_media_folder (line 2652)<br>* CWE: CWE-125 (Out-of-bounds Read)<=
br><br>During a source code audit of the AVRCP Browsing profile, a logical =
flaw was<br>discovered in the parsing of the GetFolderItems response.<br><b=
r>The vulnerable functions extract the length of the media item name (names=
ize<br>or namelen) directly from the network packet (controlled by the remo=
te device)<br>and use it to copy data into a local stack buffer char name[2=
55] via memcpy.<br><br>While the code attempts to prevent a stack-based buf=
fer overflow by limiting the<br>copy length using MIN(namesize, sizeof(name=
) - 1), it completely fails to<br>validate this extracted length against th=
e actual size of the incoming packet (len).<br><br>=C2=A02. Root Cause Anal=
ysis<br>In parse_media_element, the code proceeds as follows:<br><br>=C2=A0=
 =C2=A0 if (len &lt; 13)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retur=
n NULL;<br><br>=C2=A0 =C2=A0 namesize =3D get_be16(&amp;operands[11]); // A=
ttacker controlled value (e.g., 1000)<br>=C2=A0 =C2=A0 namelen =3D MIN(name=
size, sizeof(name) - 1); // namelen becomes 254<br><br>=C2=A0 =C2=A0 if (na=
melen &gt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // OOB READ: r=
eads 254 bytes from a buffer that might only be 14 bytes long<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(name, &amp;operands[13], namelen);<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strtoutf8(name, namelen);<br>=
=C2=A0 =C2=A0 }<br><br>=C2=A0 =C2=A0 // OOB READ: 13 + 1000 =3D 1013. Reads=
 far beyond the packet boundary<br>=C2=A0 =C2=A0 count =3D operands[13 + na=
mesize];<br><br>If a remote device sends a packet where the namesize field =
is large (e.g., 1000)<br>but the actual packet length (len) is very small (=
e.g., 14 bytes), the memcpy<br>will read 254 bytes starting from &amp;opera=
nds[13]. Since the packet is only 14 bytes<br>long, this results in a 253-b=
yte Out-of-Bounds Read.<br><br>Furthermore, the subsequent access operands[=
13 + namesize] attempts to read a byte<br>at offset 1013, which guarantees =
a segmentation fault if the memory is unmapped.<br><br>A similar flaw exist=
s in parse_media_folder where namelen is not bounded by len:<br>=C2=A0 =C2=
=A0 namelen =3D MIN(get_be16(&amp;operands[12]), sizeof(name) - 1);<br>=C2=
=A0 =C2=A0 if (namelen &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 memcpy(name, &amp;operands[14], namelen); // OOB READ if len &lt; 268<br><=
br>=C2=A03. Impact and Threat Model<br>* Attack Vector: Adjacent Network (B=
luetooth)<br>* User Interaction: Required (UI:R) - The victim must connect =
to the malicious device.<br>* Impact: Denial of Service (DoS) / Potential I=
nformation Disclosure.<br><br>A remote Bluetooth device acting as an AVRCP =
controller (e.g., a malicious car kit,<br>headphones, or speaker) can send =
a specially crafted GetFolderItems response. When<br>a Linux client connect=
s and requests the media list, bluetoothd will attempt to read<br>unallocat=
ed memory. This results in a SIGSEGV and an immediate crash of the Bluetoot=
h<br>daemon (DoS). In certain heap configurations, the read data could be p=
rocessed and<br>leaked, leading to Information Disclosure.<br><br>4. Proof =
of Concept (PoC)<br>I have attached poc_avrcp_obb.c which extracts the vuln=
erable logic and simulates<br>the attack using a 14-byte malicious packet w=
ith an inflated namesize of 1000.<br><br>To verify the vulnerability:<br>1.=
 Compile with AddressSanitizer:<br>=C2=A0 =C2=A0gcc -fsanitize=3Daddress -g=
 -o poc_avrcp_oob poc_avrcp_obb.c<br>2. Run the binary:<br>=C2=A0 =C2=A0./p=
oc_avrcp_oob<br><br>ASan will immediately detect the out-of-bounds access a=
nd abort:<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>=3D=3D11374=
1=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on address 0x...<br>R=
EAD of size 254 at 0x... thread T0<br>=C2=A0 =C2=A0 #0 0x... in memcpy<br>=
=C2=A0 =C2=A0 #1 0x... in parse_media_element_vuln<br>=C2=A0 =C2=A0 #2 0x..=
. in main<br>SUMMARY: AddressSanitizer: stack-buffer-overflow in parse_medi=
a_element_vuln<br><br>[ 5. Proposed Fix<br>The attached patch ensures that =
the length extracted from the packet is strictly<br>validated against the r=
emaining bytes in the packet buffer (len) before being<br>used in memcpy. I=
t also adds boundary checks before accessing subsequent offsets.<br><br>Ple=
ase review the attached .patch file. I am requesting a CVE assignment for<b=
r>this issue given its impact on system availability.<br><br>Best regards,<=
br><br>Elman Shahbazov<br>Security Researcher<br></div>

--000000000000e4e6bf0658088c2e--
--000000000000e4e6c10658088c30
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Fix-Out-of-Bounds-Read-in-AVRCP-GetFolderItems-parsi.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-Out-of-Bounds-Read-in-AVRCP-GetFolderItems-parsi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msba2xhk0>
X-Attachment-Id: f_msba2xhk0

RnJvbSBiZDJkZDE5YjI5OWU4Yzc5NzgwYzgyNjIxYTdiMDY0OWI1ODViYzY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbG1hbiBTaGFoYmF6b3YgPHNoYWhiYXpvdmVsbWFuOTdAZ21h
aWwuY29tPgpEYXRlOiBTdW4sIDIgQXVnIDIwMjYgMDc6NTc6NTMgKzA0MDAKU3ViamVjdDogW1BB
VENIXSBGaXggT3V0LW9mLUJvdW5kcyBSZWFkIGluIEFWUkNQIEdldEZvbGRlckl0ZW1zIHBhcnNp
bmcKClNpZ25lZC1vZmYtYnk6IEVsbWFuIFNoYWhiYXpvdiA8c2hhaGJhem92ZWxtYW45N0BnbWFp
bC5jb20+Ci0tLQogcHJvZmlsZXMvYXVkaW8vYXZyY3AuYyB8IDkgKysrKysrKy0tCiAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3By
b2ZpbGVzL2F1ZGlvL2F2cmNwLmMgYi9wcm9maWxlcy9hdWRpby9hdnJjcC5jCmluZGV4IDIxOTRh
OTEzNS4uMTllYTEzYzE2IDEwMDY0NAotLS0gYS9wcm9maWxlcy9hdWRpby9hdnJjcC5jCisrKyBi
L3Byb2ZpbGVzL2F1ZGlvL2F2cmNwLmMKQEAgLTI2MjUsOCArMjYyNSwxMiBAQCBzdGF0aWMgc3Ry
dWN0IG1lZGlhX2l0ZW0gKnBhcnNlX21lZGlhX2VsZW1lbnQoc3RydWN0IGF2cmNwICpzZXNzaW9u
LAogCXVpZCA9IGdldF9iZTY0KCZvcGVyYW5kc1swXSk7CiAKIAltZW1zZXQobmFtZSwgMCwgc2l6
ZW9mKG5hbWUpKTsKLQluYW1lc2l6ZSA9IGdldF9iZTE2KCZvcGVyYW5kc1sxMV0pOworCW5hbWVz
aXplID0gTUlOKGdldF9iZTE2KCZvcGVyYW5kc1sxMV0pLCBsZW4gLSAxMyk7CiAJbmFtZWxlbiA9
IE1JTihuYW1lc2l6ZSwgc2l6ZW9mKG5hbWUpIC0gMSk7CisKKwlpZiAobGVuIDwgMTMgKyBuYW1l
c2l6ZSkKKwkJcmV0dXJuIE5VTEw7CisKIAlpZiAobmFtZWxlbiA+IDApIHsKIAkJbWVtY3B5KG5h
bWUsICZvcGVyYW5kc1sxM10sIG5hbWVsZW4pOwogCQlzdHJ0b3V0ZjgobmFtZSwgbmFtZWxlbik7
CkBAIC0yNjY5LDcgKzI2NzMsOCBAQCBzdGF0aWMgc3RydWN0IG1lZGlhX2l0ZW0gKnBhcnNlX21l
ZGlhX2ZvbGRlcihzdHJ1Y3QgYXZyY3AgKnNlc3Npb24sCiAJcGxheWFibGUgPSBvcGVyYW5kc1s5
XTsKIAogCW1lbXNldChuYW1lLCAwLCBzaXplb2YobmFtZSkpOwotCW5hbWVsZW4gPSBNSU4oZ2V0
X2JlMTYoJm9wZXJhbmRzWzEyXSksIHNpemVvZihuYW1lKSAtIDEpOworCW5hbWVsZW4gPSBNSU4o
Z2V0X2JlMTYoJm9wZXJhbmRzWzEyXSksIGxlbiAtIDE0KTsKKwluYW1lbGVuID0gTUlOKG5hbWVs
ZW4sIHNpemVvZihuYW1lKSAtIDEpOwogCWlmIChuYW1lbGVuID4gMCkKIAkJbWVtY3B5KG5hbWUs
ICZvcGVyYW5kc1sxNF0sIG5hbWVsZW4pOwogCi0tIAoyLjUzLjAKCg==
--000000000000e4e6c10658088c30
Content-Type: text/x-csrc; charset="UTF-8"; name="poc_avrcp_obb.c"
Content-Disposition: attachment; filename="poc_avrcp_obb.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msba39ce1>
X-Attachment-Id: f_msba39ce1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8c3RkbGliLmg+CgovLyDQmNC80LjRgtC40YDRg9C10Lwg0LzQsNC60YDQvtGB
0Ysg0Lgg0YLQuNC/0YsgQmx1ZVoKI2RlZmluZSBNSU4oYSwgYikgKChhKSA8IChiKSA/IChhKSA6
IChiKSkKdHlwZWRlZiB1aW50OF90IHU4Owp0eXBlZGVmIHVpbnQxNl90IHUxNjsKdHlwZWRlZiB1
aW50NjRfdCB1NjQ7CgovLyDQktGB0L/QvtC80L7Qs9Cw0YLQtdC70YzQvdGL0LUg0YTRg9C90LrR
htC40Lgg0YfRgtC10L3QuNGPINC40Lcg0YHQtdGC0LggKEJpZyBFbmRpYW4pCnUxNiBnZXRfYmUx
Nihjb25zdCB2b2lkICpwdHIpIHsKICAgIGNvbnN0IHU4ICpwID0gcHRyOwogICAgcmV0dXJuIChw
WzBdIDw8IDgpIHwgcFsxXTsKfQoKdTY0IGdldF9iZTY0KGNvbnN0IHZvaWQgKnB0cikgewogICAg
Y29uc3QgdTggKnAgPSBwdHI7CiAgICB1NjQgdmFsID0gMDsKICAgIGZvciAoaW50IGkgPSAwOyBp
IDwgODsgaSsrKQogICAgICAgIHZhbCA9ICh2YWwgPDwgOCkgfCBwW2ldOwogICAgcmV0dXJuIHZh
bDsKfQoKLy8g0KPRj9C30LLQuNC80LDRjyDQu9C+0LPQuNC60LAsINC00L7RgdC70L7QstC90L4g
0YHQutC+0L/QuNGA0L7QstCw0L3QvdCw0Y8g0LjQtyBwcm9maWxlcy9hdWRpby9hdnJjcC5jCnZv
aWQgcGFyc2VfbWVkaWFfZWxlbWVudF92dWxuKHU4ICpvcGVyYW5kcywgdTE2IGxlbikgewogICAg
dTE2IG5hbWVsZW4sIG5hbWVzaXplOwogICAgY2hhciBuYW1lWzI1NV07CiAgICB1NjQgdWlkOwog
ICAgdTggY291bnQ7CgogICAgaWYgKGxlbiA8IDEzKQogICAgICAgIHJldHVybjsKCiAgICB1aWQg
PSBnZXRfYmU2NCgmb3BlcmFuZHNbMF0pOwoKICAgIG1lbXNldChuYW1lLCAwLCBzaXplb2YobmFt
ZSkpOwogICAgCiAgICAvLyDQl9C70L7Rg9C80YvRiNC70LXQvdC90LjQuiDQv9GA0LjRgdGL0LvQ
sNC10YIgbmFtZXNpemUgPSAxMDAwCiAgICBuYW1lc2l6ZSA9IGdldF9iZTE2KCZvcGVyYW5kc1sx
MV0pOyAKICAgIAogICAgLy8gbmFtZWxlbiDQvtCz0YDQsNC90LjRh9C40LLQsNC10YLRgdGPIDI1
NCwg0L3QviDQvdC1INC/0YDQvtCy0LXRgNGP0LXRgtGB0Y8g0L/RgNC+0YLQuNCyIGxlbiEKICAg
IG5hbWVsZW4gPSBNSU4obmFtZXNpemUsIHNpemVvZihuYW1lKSAtIDEpOwogICAgCiAgICBpZiAo
bmFtZWxlbiA+IDApIHsKICAgICAgICAvLyBCVUcgMTogT09CIFJFQUQuINCf0YvRgtCw0LXQvNGB
0Y8g0L/RgNC+0YfQuNGC0LDRgtGMIDI1NCDQsdCw0LnRgtCwINC40Lcg0LHRg9GE0LXRgNCwINGA
0LDQt9C80LXRgNC+0Lwg0LLRgdC10LPQviAxNCDQsdCw0LnRgiEKICAgICAgICBtZW1jcHkobmFt
ZSwgJm9wZXJhbmRzWzEzXSwgbmFtZWxlbik7IAogICAgfQoKICAgIC8vIEJVRyAyOiBPT0IgUkVB
RC4gMTMgKyAxMDAwID0gMTAxMy4g0KfQuNGC0LDQtdC8INCx0LDQudGCINC/0L4g0YHQvNC10YnQ
tdC90LjRjiAxMDEzIQogICAgY291bnQgPSBvcGVyYW5kc1sxMyArIG5hbWVzaXplXTsgCiAgICAK
ICAgIHByaW50ZigiUmVhZCBjb3VudDogJTAyeFxuIiwgY291bnQpOwp9CgppbnQgbWFpbigpIHsK
ICAgIC8vINCk0L7RgNC80LjRgNGD0LXQvCDQstGA0LXQtNC+0L3QvtGB0L3Ri9C5INC/0LDQutC1
0YIuCiAgICAvLyDQoNC10LDQu9GM0L3QsNGPINC00LvQuNC90LAg0L/QsNC60LXRgtCwIChsZW4p
ID0gMTQg0LHQsNC50YIuCiAgICB1OCBtYWxpY2lvdXNfcGFja2V0WzE0XSA9IHswfTsgCiAgICAK
ICAgIC8vINCj0LrQsNC30YvQstCw0LXQvCBuYW1lc2l6ZSA9IDEwMDAgKDB4MDNFOCDQsiBCaWcg
RW5kaWFuKSDQv9C+INGB0LzQtdGJ0LXQvdC40Y4gMTEKICAgIG1hbGljaW91c19wYWNrZXRbMTFd
ID0gMHgwMzsKICAgIG1hbGljaW91c19wYWNrZXRbMTJdID0gMHhFODsKCiAgICBwcmludGYoIlsq
XSDQl9Cw0L/Rg9GB0LogUG9DLiDQn9C10YDQtdC00LDRkdC8INC/0LDQutC10YIg0LTQu9C40L3Q
vtC5IDE0INCx0LDQudGCLCDQvdC+IG5hbWVzaXplPTEwMDAuLi5cbiIpOwogICAgCiAgICAvLyDQ
ktGL0LfRi9Cy0LDQtdC8INGD0Y/Qt9Cy0LjQvNGD0Y4g0YTRg9C90LrRhtC40Y4KICAgIHBhcnNl
X21lZGlhX2VsZW1lbnRfdnVsbihtYWxpY2lvdXNfcGFja2V0LCBzaXplb2YobWFsaWNpb3VzX3Bh
Y2tldCkpOwogICAgCiAgICBwcmludGYoIlsqXSDQldGB0LvQuCDRgtGLINCy0LjQtNC40YjRjCDR
jdGC0L4g0YHQvtC+0LHRidC10L3QuNC1LCBBU2FuINC90LUg0YHRgNCw0LHQvtGC0LDQuyAo0YfR
gtC+INC80LDQu9C+0LLQtdGA0L7Rj9GC0L3QvikuXG4iKTsKICAgIHJldHVybiAwOwp9Cg==
--000000000000e4e6c10658088c30--

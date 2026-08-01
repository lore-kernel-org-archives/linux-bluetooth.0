Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B32374190
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617665; cv=pass; b=gDeC5m1ZyBxK+deA4VAv0qBdyPkOwBx3c1QaVw4r6tRmZwYrhrcvp/KpUtRKc37+2SUBEHzvtJghYHsNpLMlPuF3HRLm+mZkYbmeikXr/7QoedJasWMEH8BZKmvoPfCvHAfYKgfXrEhfqeWeAIohblJKcp/txfBzzCmWriaOBZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617665; c=relaxed/simple;
	bh=rlIRypMFNx3uiNjNPmlpMVK9Jn16Mp1wnbk75wLGW74=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L5Pl1mgOzlmUDcMn2GHBQ+tulgJzeG5G0M7CnKBYCtEgK/vrOEN9Kd6VYIoU+qcRmxE+fSOvnRvDyyAVXeyvExGSPyuR2OxE5A4+HxRz1K75T3HAStqlFq1GkBMe0rW8Ezfz+llQC4iljvly/cHYPfQJCk8kzRYv805qduvTfUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzTyAXw+; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzTyAXw+"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66843304cbaso3005109d50.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 13:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785617663; cv=none;
        d=google.com; s=arc-20260327;
        b=N9qKQmtJjsW7Fn0fwZXTGe6KITBUrjOoprxfVBX0AEXZjVRshDtsYuobWJSXYA/BwQ
         +PHAF+Bbltr0LKhR2k1gCB5ax+A7YbINnL+CUk3pPCU1bloaa0hL8FOUZEnZA7cDuNsR
         NpnEjqKs7utpoWS93OHT3geJXIl5UkHakHzW63UZr96R3/uCH+Vd8mrosJT2OWbeZpdc
         EYT86FKht+oTV1kNkdDvshPuoikmZk/UEyd2uiOdZ0GIU75yfdEL7mPCvBPre05Lo+03
         b2a3V3Og/NU50nFo32M/vvBHtVxfb/O49wxmG3ihHI0YcK6h78FaNdBbX8RWvm+K6Z4U
         IcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=QStMUK4CovvOe3LAMbC6kyTyzPeP5Hy3bY6Ba3+02wU=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=kVKvHB760Mk2kL2PfGeMTTU4rKDNC7xSpsMQlT8vkd4x+BYnMa1N7EgLXLsHQiwpO+
         6wP4WK1jTHIJwvNQcerR/1LkX98OcjHrJmNTdlFvJ8ZmzYYyLyvc7BRqeayXjqcW/T6v
         azPwe8cDnH5d9T6aNzIUxcrWy6OlSPxk+i87zJJfQEJuTHsm5O5INaAiUXe61LKRem7u
         bOVfUSa9eM2EgCj2MyG3opFqr+AoURhJHBDBiNPPQKJSRpBkwsY/TepDGsRgdWOgxcp7
         4iCX2QyfTfOv4qdziP3T10U0faDBKa7mXtkA7SuvKOBfogELw0TM5ucwGVNMk99wPvaZ
         Zcyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617663; x=1786222463; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QStMUK4CovvOe3LAMbC6kyTyzPeP5Hy3bY6Ba3+02wU=;
        b=jzTyAXw+EroORgq/Ut8BC4ljpGE2ywoqc7eU0GANRWhdAlSr0ptnhepnWmVv5HnlFa
         TRy5/wegE2jAG0B8oOa5XVANFzDVVvY9zzF6MUuIjBi/a5vekNInL/LFDQmHM/CaudGJ
         6vbIc0TqWY9TYsMfZTic/ldI+zhsfVF5HGZ3QOqzwmj82ML78fSWWQg4cVu0IIfJnHKJ
         34Q1lRhEaR5VTsQTwQlR+toXwIflD41JLjenjcCNitcNglMaYk4nrsih6qKR4mf6XMfZ
         QMxQdRdgUACWybKWXWltLkt6tRxk550GJU3G/eC9YmKY7hALVGwXA6k/jXi0DtKx14Hf
         N5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617663; x=1786222463;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QStMUK4CovvOe3LAMbC6kyTyzPeP5Hy3bY6Ba3+02wU=;
        b=FswSFPf1k6lJgpveSf4pbM8Syqe5IpzjWfNJKy+OA3hn6Ewf08g5RJTVR88/45uMDp
         5lFocR2lBTFaq7OIWEI36JAEe38Vqf0YtiscLlF/8EW8bPbEyp5L9Rh4uCoxLNxDJRJJ
         0tBaPBHKDLLuOOsrCzUxYjy5cNMawVqFOOBqDG2JRE7WmCRKNMvYFkyim2FSkGbjojVO
         EHiiEWW+hHMiauu927CrGepAmNPtbKwh8P12+KaXT+5XbZZghpxpUwKzGzs7BrQnV5zA
         n9Fnj43M5mFz5wO08sea+5kfM4ekHqB9z66tznva2pCQnfDjoxysGq9jOQamThjW2DvC
         Zvlw==
X-Gm-Message-State: AOJu0YyTxuDEFkUIu6xJrnFuDR31Rwvh6KHW7uSOBtZVAx4nXafq6H07
	VzI9TkjgTi+Zc5iFK2AbfJUGTdxCyZ61fu1NqUH2mLzzKjDMFRSyOHCJmFZ2sCL1jA5M8O1Ehak
	iNDP36BWHGyfO/KudO4heN61Pwg8o/znowC7fIL8=
X-Gm-Gg: AR+sD1284NGFrFX5v2w5oTkUrLQYLM/NO9CBxkOdYfCwK+U6YCgyDWczLNG/LcSqifH
	94UDv5vFHWTPS8U5nUflf+R/pSkQS+EBDGHWhXn+XXPw4YpG5ZwJcT7dg+Tz2I0LttHqbn+fgd8
	kIALvNTanpxeXFlET6N51GUH2W6I/QmqQMwR5/mXVrtzFf8SVRs1hfH+05CTcAJqM5Fb0ADY3Uf
	uTKtSX+0wBVR5ur/so0GbIpMZD57Rpvj4PdcF+txuD/aPpslCaHAVl+efc8cBwE832utwGu/G53
	QU9B9EAO9vaNPB0v6/x7rukKg+MehQ6rK8zm+RnUg1RQUA==
X-Received: by 2002:a05:690e:144d:b0:668:43f8:a83a with SMTP id
 956f58d0204a3-6694f01d1d1mr6687965d50.15.1785617662635; Sat, 01 Aug 2026
 13:54:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elman Shahbazov <shahbazovelman97@gmail.com>
Date: Sun, 2 Aug 2026 00:54:11 +0400
X-Gm-Features: AUfX_mzxBabHGyfqIqciliFQ4YCwrhpExfSJjL0UWx96wnLv2FdIUO_bsh_J_4Q
Message-ID: <CADE-WFfZvGe+khqhxRtdGQOzSZVp4ZXoFoAFNvahsjS_obu7DQ@mail.gmail.com>
Subject: [SECURITY REPORT] Out-of-Bounds Read (CWE-125) in BlueZ AVRCP
 Browsing Profile leading to DoS / Memory Leak
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000007cab210658028210"

--0000000000007cab210658028210
Content-Type: multipart/alternative; boundary="0000000000007cab1f065802820e"

--0000000000007cab1f065802820e
Content-Type: text/plain; charset="UTF-8"

Hello BlueZ maintainers and Red Hat Security team,

During a source code audit of the BlueZ project (master branch, commit
e45128f02),
I discovered an Out-of-Bounds Read vulnerability (CWE-125) in the AVRCP
Browsing
profile. This flaw can be exploited by a malicious Bluetooth device to
crash the
bluetoothd daemon (Denial of Service) or potentially leak process memory.

Below are the detailed technical findings, a Proof of Concept (PoC), and a
proposed patch.

 1. Vulnerability Details
* Component: profiles/audio/avrcp.c
* Functions: parse_media_element (line 2618), parse_media_folder (line 2652)
* CWE: CWE-125 (Out-of-bounds Read)

The vulnerability exists in the parsing logic of the AVRCP GetFolderItems
response.
The functions extract the length of the media item name (namesize /
namelen) directly
from the network packet and use it to copy data into a local stack buffer
char name[255]
using memcpy.

While the code uses MIN(..., sizeof(name) - 1) to prevent overflowing the
local name
buffer itself, it completely fails to validate this length against the
actual size of the
incoming packet (len). If an attacker sends a packet where the namesize
field is large
(e.g., 1000) but the actual packet length is very small (e.g., 14 bytes),
the memcpy will
read far beyond the boundaries of the allocated packet buffer.

Vulnerable code snippet in parse_media_element:

if (len < 13) return NULL;

uid = get_be64(&operands[0]);

memset(name, 0, sizeof(name));
namesize = get_be16(&operands[11]); // Attacker controlled value (e.g.,
1000)
namelen = MIN(namesize, sizeof(name) - 1); // namelen becomes 254

if (namelen > 0) {
    // OOB READ: reads 254 bytes from a 14-byte buffer
    memcpy(name, &operands[13], namelen);
    strtoutf8(name, namelen);
}

// OOB READ: reads at offset 1013, far beyond the packet boundary
count = operands[13 + namesize];
A similar logical flaw is present in parse_media_folder:
if (len < 12) return NULL;
// ...
namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1); // namelen
limited to 254
if (namelen > 0)
    // OOB READ: copies 254 bytes if len < 268
    memcpy(name, &operands[14], namelen);
     Impact and Threat Model

CVSS 3.1 (Estimated): 6.0 (Medium) - AV:A/AC:L/PR:N/UI:R/S:U/C:N/I:N/A:H
Attack Vector: Adjacent Network (Bluetooth)
A remote Bluetooth device acting as an AVRCP controller (e.g., a malicious
car kit,
headphones, or speaker) can send a specially crafted GetFolderItems
response. When a
Linux client connects and requests the media list, bluetoothd will attempt
to read
unallocated memory resulting in a segmentation fault (Denial of Service).
In certain heap
configurations, the read data could be processed and leaked, leading to
Information Disclosure.
Proof of Concept (PoC)
I have attached a minimal C program (poc_avrcp_obb.c) that extracts the
vulnerable
function and simulates the attack using a 14-byte malicious packet with an
inflated
namesize of 1000.

To verify the vulnerability:

Compile the PoC with AddressSanitizer:
gcc -fsanitize=address -g -o poc_avrcp_oob poc_avrcp_obb.c
Run it:
./poc_avrcp_oob
ASan will immediately detect the out-of-bounds access and abort the
execution:
==113741==ERROR: AddressSanitizer: stack-buffer-overflow on address 0x...
READ of size 254 at 0x... thread T0
#0 0x... in memcpy
#1 0x... in parse_media_element_vuln
#2 0x... in main
...
SUMMARY: AddressSanitizer: stack-buffer-overflow in parse_media_element_vuln
Proposed Remediation (Patch)
To fix this issue, the length extracted from the packet must be validated
against the
remaining bytes in the packet buffer before being used in memcpy.
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2629,8 +2629,11 @@ static struct media_item *parse_media_element(struct
avrcp *session,
         uid = get_be64(&operands[0]);

         memset(name, 0, sizeof(name));
-        namesize = get_be16(&operands[11]);
-        namelen = MIN(namesize, sizeof(name) - 1);
+        namesize = MIN(get_be16(&operands[11]), len - 13); // Limit by
packet size
+        namelen = MIN(namesize, sizeof(name) - 1);
+
+        if (len < 13 + namesize) // Verify bounds before reading 'count'
+                return NULL;
+
         if (namelen > 0) {
                 memcpy(name, &operands[13], namelen);
                 strtoutf8(name, namelen);
@@ -2672,7 +2675,8 @@ static struct media_item *parse_media_folder(struct
avrcp *session,
         memset(name, 0, sizeof(name));
-        namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
+        namelen = MIN(get_be16(&operands[12]), len - 14); // Limit by
packet size
+        namelen = MIN(namelen, sizeof(name) - 1);
         if (namelen > 0)
                 memcpy(name, &operands[14], namelen);
Please let me know if you need any further information or assistance with
testing.

Best regards,Elman
Security Researcher

--0000000000007cab1f065802820e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello BlueZ maintainers and Red Hat Security team,<br><br>=
During a source code audit of the BlueZ project (master branch, commit e451=
28f02), <br>I discovered an Out-of-Bounds Read vulnerability (CWE-125) in t=
he AVRCP Browsing <br>profile. This flaw can be exploited by a malicious Bl=
uetooth device to crash the <br>bluetoothd daemon (Denial of Service) or po=
tentially leak process memory.<br><br>Below are the detailed technical find=
ings, a Proof of Concept (PoC), and a proposed patch.<br><br>=C2=A01. Vulne=
rability Details<br>* Component: profiles/audio/avrcp.c<br>* Functions: par=
se_media_element (line 2618), parse_media_folder (line 2652)<br>* CWE: CWE-=
125 (Out-of-bounds Read)<br><br>The vulnerability exists in the parsing log=
ic of the AVRCP GetFolderItems response. <br>The functions extract the leng=
th of the media item name (namesize / namelen) directly <br>from the networ=
k packet and use it to copy data into a local stack buffer char name[255]<b=
r>using memcpy. <br><br>While the code uses MIN(..., sizeof(name) - 1) to p=
revent overflowing the local name <br>buffer itself, it completely fails to=
 validate this length against the actual size of the <br>incoming packet (l=
en). If an attacker sends a packet where the namesize field is large <br>(e=
.g., 1000) but the actual packet length is very small (e.g., 14 bytes), the=
 memcpy will <br>read far beyond the boundaries of the allocated packet buf=
fer.<br><br>Vulnerable code snippet in parse_media_element:<br><br>if (len =
&lt; 13) return NULL;<br><br>uid =3D get_be64(&amp;operands[0]);<br><br>mem=
set(name, 0, sizeof(name));<br>namesize =3D get_be16(&amp;operands[11]); //=
 Attacker controlled value (e.g., 1000)<br>namelen =3D MIN(namesize, sizeof=
(name) - 1); // namelen becomes 254<br><br>if (namelen &gt; 0) {<br>=C2=A0 =
=C2=A0 // OOB READ: reads 254 bytes from a 14-byte buffer<br>=C2=A0 =C2=A0 =
memcpy(name, &amp;operands[13], namelen); <br>=C2=A0 =C2=A0 strtoutf8(name,=
 namelen);<br>}<br><br>// OOB READ: reads at offset 1013, far beyond the pa=
cket boundary<br>count =3D operands[13 + namesize]; <br>A similar logical f=
law is present in parse_media_folder:<br>if (len &lt; 12) return NULL;<br>/=
/ ...<br>namelen =3D MIN(get_be16(&amp;operands[12]), sizeof(name) - 1); //=
 namelen limited to 254<br>if (namelen &gt; 0)<br>=C2=A0 =C2=A0 // OOB READ=
: copies 254 bytes if len &lt; 268<br>=C2=A0 =C2=A0 memcpy(name, &amp;opera=
nds[14], namelen); <br>=C2=A0 =C2=A0 =C2=A0Impact and Threat Model<br><br>C=
VSS 3.1 (Estimated): 6.0 (Medium) - AV:A/AC:L/PR:N/UI:R/S:U/C:N/I:N/A:H<br>=
Attack Vector: Adjacent Network (Bluetooth)<br>A remote Bluetooth device ac=
ting as an AVRCP controller (e.g., a malicious car kit,<br>headphones, or s=
peaker) can send a specially crafted GetFolderItems response. When a<br>Lin=
ux client connects and requests the media list, bluetoothd will attempt to =
read<br>unallocated memory resulting in a segmentation fault (Denial of Ser=
vice). In certain heap<br>configurations, the read data could be processed =
and leaked, leading to Information Disclosure.<br>Proof of Concept (PoC)<br=
>I have attached a minimal C program (poc_avrcp_obb.c) that extracts the vu=
lnerable<br>function and simulates the attack using a 14-byte malicious pac=
ket with an inflated<br>namesize of 1000.<br><br>To verify the vulnerabilit=
y:<br><br>Compile the PoC with AddressSanitizer:<br>gcc -fsanitize=3Daddres=
s -g -o poc_avrcp_oob poc_avrcp_obb.c<br>Run it:<br>./poc_avrcp_oob<br>ASan=
 will immediately detect the out-of-bounds access and abort the execution:<=
br>=3D=3D113741=3D=3DERROR: AddressSanitizer: stack-buffer-overflow on addr=
ess 0x...<br>READ of size 254 at 0x... thread T0<br>#0 0x... in memcpy<br>#=
1 0x... in parse_media_element_vuln<br>#2 0x... in main<br>...<br>SUMMARY: =
AddressSanitizer: stack-buffer-overflow in parse_media_element_vuln<br>Prop=
osed Remediation (Patch)<br>To fix this issue, the length extracted from th=
e packet must be validated against the<br>remaining bytes in the packet buf=
fer before being used in memcpy.<br>--- a/profiles/audio/avrcp.c<br>+++ b/p=
rofiles/audio/avrcp.c<br>@@ -2629,8 +2629,11 @@ static struct media_item *p=
arse_media_element(struct avrcp *session,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uid =3D get_be64(&amp;operands[0]);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0memset(name, 0, sizeof(name));<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0namesize =3D get_be16(&amp;operands[11]);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0namelen =3D MIN(namesize, sizeof(name) - 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0namesize =3D MIN(get_be16(&amp;operands[11]), len - 13); // Limit by =
packet size<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0namelen =3D MIN(namesize, sizeo=
f(name) - 1);<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (len &lt; 13 + namesi=
ze) // Verify bounds before reading &#39;count&#39;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>+<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (namelen &gt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(name, &amp;operands[13], namelen);=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strtoutf8=
(name, namelen);<br>@@ -2672,7 +2675,8 @@ static struct media_item *parse_m=
edia_folder(struct avrcp *session,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mem=
set(name, 0, sizeof(name));<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0namelen =3D MIN=
(get_be16(&amp;operands[12]), sizeof(name) - 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0namelen =3D MIN(get_be16(&amp;operands[12]), len - 14); // Limit by p=
acket size<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0namelen =3D MIN(namelen, sizeof(=
name) - 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (namelen &gt; 0)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(name, &am=
p;operands[14], namelen);<br>Please let me know if you need any further inf=
ormation or assistance with testing.<br><br>Best regards,Elman<br>Security =
Researcher<br><br></div>

--0000000000007cab1f065802820e--
--0000000000007cab210658028210
Content-Type: text/x-csrc; charset="UTF-8"; name="poc_avrcp_obb.c"
Content-Disposition: attachment; filename="poc_avrcp_obb.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msaun5e30>
X-Attachment-Id: f_msaun5e30

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
--0000000000007cab210658028210--

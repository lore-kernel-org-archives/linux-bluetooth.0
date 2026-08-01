Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285E3CB568
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617095; cv=pass; b=JiLVc86/dtM5sMD+7gnMB5ZFa6b0t3h7wt4xcmn5i1sIcJqZFlha+BEoQQVUYmOdHZTytRoDk5ZDZzO4KPI0T31WRLEBRQQ5fiDQyUmvl81NKkVXkU19WDBg1vPO0fZnpXPmUlsRThH078lUtbzqsStrjtl6+530ZMIFndfNtN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617095; c=relaxed/simple;
	bh=PGllhvbrIsp+d1HQZeBOK2Yw9nRHEwMZYqZ1XnwQCpo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VCPkuO85PcuvRWl3PXB8Qn75A3DqjGdqW7nT65u89sfH2YG6GuaJGLHTheCyeBBg18j5qWkLQYMSZM5MjgnYq9zdy2WKcEmW2LPoGu/FNd6q295rDUdJJ1o66kHcZAj8WzWdZWTwbeCewqoQFj0zlUYsU+BF7q4u9zLucb6WB/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNls/LSS; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNls/LSS"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66899c7b57bso3091249d50.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 13:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785617091; cv=none;
        d=google.com; s=arc-20260327;
        b=XGO//MCCadHAeybRoSimnE8CM/eltOGIMT/dJR5Rf07fILb5tDsCekorIXYQl3wWX3
         aSd1G/kOkO4uoluYd7dXi5JYNWozT5Ol5HPVXTfZSkHwCMqJtYK+1q6/mi47C4H3mtIA
         rlskFb1Q0SwhfanecIFtOkKarv5SrAQcHoSTS/3ai/cUHTyZLZi/5BUzz5JUYF0K8q6/
         dJPy1jbDouyavmqnVYioDjQ2PHwB/5RgfH4O5J2tCW1IjFYTmF+1/NzsgGZXaaRp8kFI
         ihHqg3VAFmqCu/fwOrm+omaVIE/DOyeZxpWd+Y38wJV9xfokJ2K5PBqCgck6euONSczi
         AStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=au2k0W6YIn/6NuFlxH8U3lRmchAfVAxi0Wqwzf2i54c=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=nblAFX4Q1Gz3fghetQ2mz0F9MhtMUf8sNIu2+Sb2bsml/yMwkL/u5qubulOu2Bfjmh
         iv5Uurh/o5iB/0Q7vyLqAYVk5Ys56jXZquNEED41WV/AD6ncq0pYaDPcdx2chuRREitR
         S758rglcKC3ayYBQ1kvix1LJBfnTbAvzb1zcclQmVFfA6gZDcYuPukTTI6pcFJh7x3KB
         L3AevJVTkZjgbiEVomMOCVCNNhAe/s7uzx78MfVpyKo+ELnfminravGW2v3ySSZuCJWD
         Z7wLJo5pE15qRdJHU4L+9FQK9Hdo5Aqglg32smF/9mtecsrCWkTUuNyOWUCyoIFLsILP
         TcRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617091; x=1786221891; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=au2k0W6YIn/6NuFlxH8U3lRmchAfVAxi0Wqwzf2i54c=;
        b=WNls/LSSEdZE13jg/d9gLnmOLEd/5rf5adGTW9yopvmS0QCxftDSnojqVzfOMhmPmQ
         XXMBdpwN3MumcPaLSKoLWCJs4Zpjeb0waANl+/9Bw/yL8vIlFXwld9UkBaIIRrSp8Ua6
         vxIqCC31DAdA+tQuxztf45uaic2HjZVV1gjlh6jaJ14FnEfBIH3SWJAKQQKWSjeEBRzC
         WD61fG8pNkdForlJH++zs59nKOnkLMHr29LB+xW07e4foo2AKUipeNNE3o6x31W5XSWb
         uX5eLgJ9eRq4D811BLEpTdazjOy4MrzKl0pKNZrIp7pRDOT9xM0ObOpKMa1uKf4MoiQA
         JLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617091; x=1786221891;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=au2k0W6YIn/6NuFlxH8U3lRmchAfVAxi0Wqwzf2i54c=;
        b=sJFOBKBNFVNtBCF2lHYkgHa1IOF8a1KUdpLAE9Yd9nn08whaBcAkD5DWJyRJt1v7vu
         TR3JS5pyEuGXFXEr/MeRhrZ6Qyf6fQ7l3JCuQC+MFC+7dA3FmYbGyO7PqqeN4A7SqK27
         eHCFhOBrOec5GU6gy97VX3NJzhYigET7krBve7N6DrT2Amx8y4AuTePFzHajjxB0TbVh
         pDQCSynx/HkJIjdaPAgeqo16dZBtjGjhRK44ZVedrLW+3CsBU3nWWiRols/AVHv3vXdc
         s3Z7K5Z9F7N6y2lkHDXJ/cKSLN5rPJ3IukfQ4XQdEPhP+489dqQdDzfvxidAJ6MNeQXG
         t3sw==
X-Gm-Message-State: AOJu0YyBQYKtWDQ++4r2fkvrOtzWjKfB3Ugv7oze9nYgtRC3kr5c+ZQN
	BAP6N4q6pv+4R0NpXve2Ny3GHSsOOcluW3DuJ8Z4URy8IOdkh8h64/l/PkwPyVKUVT9fG3nmmRc
	TADZsJe0fV/MXZl+KBYDXgH3ElcoTZZgzCH5i5SU=
X-Gm-Gg: AR+sD11BYxihd/lP47RkfXLo4rH45fOqyX1cCpHABuvDwI4n34lu7EXLi3F5obEblU4
	xaMtOgQGGOpfJQs7FDD949r3tPZRVH6cHOUGNjUv6wdXWCGS+/37u1SsxlapEKABgVmGS9+2IKs
	SoAMz4suq515nShKElrfkEemKiVBrzGIw3muneLQuXJz5i2epNtRSnPTQP3Y81OlMC9QgqJzM4q
	UINcO0w176k5+zpuIHdqKrnYQ7xUpaNJpu/EiSfBKf/Ddl9vPefATSy4axut04igPiE9jn5h4PC
	H2O4394Yfk/PsTH9qXVqT1PwDGxDOjyAUubBB2/XMGXpkg==
X-Received: by 2002:a05:690e:4848:b0:668:9d0f:ab70 with SMTP id
 956f58d0204a3-6694f079ea9mr4653338d50.18.1785617091555; Sat, 01 Aug 2026
 13:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Elman Shahbazov <shahbazovelman97@gmail.com>
Date: Sun, 2 Aug 2026 00:44:39 +0400
X-Gm-Features: AUfX_mx72UL7L8jDBg774sqs5FYxIdEhW73lydsmUBo9lix_jN-Uh2fecPhGm7U
Message-ID: <CADE-WFdXcgeq=7gyzufLDwTh3cY+ECbqCtjPymkcyh30Mz8yMg@mail.gmail.com>
Subject: [SECURITY] Out-of-Bounds Read (CWE-125) in BlueZ AVRCP GetFolderItems
 parsing (with PoC)
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000072ad94065802605c"

--00000000000072ad94065802605c
Content-Type: multipart/alternative; boundary="00000000000072ad93065802605a"

--00000000000072ad93065802605a
Content-Type: text/plain; charset="UTF-8"

Hello BlueZ maintainers and Red Hat Security team,

During a source code audit of the BlueZ project (master branch, commit
e45128f02),
I discovered an Out-of-Bounds Read vulnerability (CWE-125) in the AVRCP
Browsing
profile. This flaw can be exploited by a malicious Bluetooth device to
crash the
bluetoothd daemon (Denial of Service) or potentially leak process memory.

--=[ Vulnerability Details
* File: profiles/audio/avrcp.c
* Functions: parse_media_element (line 2618), parse_media_folder (line 2652)

The vulnerability exists in the parsing logic of the AVRCP `GetFolderItems`
response.
The functions extract the length of the media item name (`namesize` /
`namelen`) directly
from the network packet and use it to copy data into a local stack buffer
`char name[255]`
using `memcpy`.

While the code uses `MIN(..., sizeof(name) - 1)` to prevent overflowing the
`name` buffer
itself, it completely fails to validate this length against the actual size
of the incoming
packet (`len`). If an attacker sends a packet where the `namesize` field is
large (e.g., 1000)
but the actual packet length is very small (e.g., 14 bytes), the `memcpy`
will read far
beyond the boundaries of the allocated packet buffer.

Vulnerable code snippet in `parse_media_element`:
```c
if (len < 13) return NULL;
namesize = get_be16(&operands[11]); // Attacker controlled value (e.g.,
1000)
namelen = MIN(namesize, sizeof(name) - 1); // namelen becomes 254
if (namelen > 0) {
    memcpy(name, &operands[13], namelen); // OOB READ: reads 254 bytes from
a 14-byte buffer
}
count = operands[13 + namesize]; // OOB READ: reads at offset 1013
 Impact A remote Bluetooth device acting as an AVRCP controller (e.g., a
car kit or speaker) can send a specially crafted GetFolderItems response.
When a Linux client connects and requests the media list, bluetoothd will
attempt to read unallocated memory, resulting in a segmentation fault
(Denial of Service). Proof of Concept (PoC) I have attached a minimal C
program (poc_avrcp_obb.c) that simulates the vulnerable function and
triggers the bug.  To verify the vulnerability:

   1. Compile the PoC with AddressSanitizer: gcc -fsanitize=address -g -o
   poc_avrcp_oob poc_avrcp_obb.c
   2. Run it: ./poc_avrcp_oob

ASan will immediately report a stack-buffer-overflow and abort the
execution, confirming the Out-of-Bounds read.  Proposed Patch To fix this
issue, the length extracted from the packet must be validated against the
remaining bytes in the packet buffer before being used in memcpy.  ---
a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2629,8 +2629,11 @@ static struct media_item *parse_media_element(struct
avrcp *session,
         uid = get_be64(&operands[0]);

         memset(name, 0, sizeof(name));
-        namesize = get_be16(&operands[11]);
-        namelen = MIN(namesize, sizeof(name) - 1);
+        namesize = MIN(get_be16(&operands[11]), len - 13);
+        namelen = MIN(namesize, sizeof(name) - 1);
+
+        if (len < 13 + namesize)
+                return NULL;
+
         if (namelen > 0) {
                 memcpy(name, &operands[13], namelen);
                 strtoutf8(name, namelen);
@@ -2672,7 +2675,8 @@ static struct media_item *parse_media_folder(struct
avrcp *session,
         memset(name, 0, sizeof(name));
-        namelen = MIN(get_be16(&operands[12]), sizeof(name) - 1);
+        namelen = MIN(get_be16(&operands[12]), len - 14);
+        namelen = MIN(namelen, sizeof(name) - 1);
         if (namelen > 0)
                 memcpy(name, &operands[14], namelen);
Please let me know if you need any further information. I am requesting a
CVE assignment for this vulnerability. Best regards, Elman

--00000000000072ad93065802605a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello BlueZ maintainers and Red Hat Security team,<br><br>=
During a source code audit of the BlueZ project (master branch, commit e451=
28f02), <br>I discovered an Out-of-Bounds Read vulnerability (CWE-125) in t=
he AVRCP Browsing <br>profile. This flaw can be exploited by a malicious Bl=
uetooth device to crash the <br>bluetoothd daemon (Denial of Service) or po=
tentially leak process memory.<br><br>--=3D[ Vulnerability Details<br>* Fil=
e: profiles/audio/avrcp.c<br>* Functions: parse_media_element (line 2618), =
parse_media_folder (line 2652)<br><br>The vulnerability exists in the parsi=
ng logic of the AVRCP `GetFolderItems` response. <br>The functions extract =
the length of the media item name (`namesize` / `namelen`) directly <br>fro=
m the network packet and use it to copy data into a local stack buffer `cha=
r name[255]` <br>using `memcpy`. <br><br>While the code uses `MIN(..., size=
of(name) - 1)` to prevent overflowing the `name` buffer <br>itself, it comp=
letely fails to validate this length against the actual size of the incomin=
g <br>packet (`len`). If an attacker sends a packet where the `namesize` fi=
eld is large (e.g., 1000) <br>but the actual packet length is very small (e=
.g., 14 bytes), the `memcpy` will read far <br>beyond the boundaries of the=
 allocated packet buffer.<br><br>Vulnerable code snippet in `parse_media_el=
ement`:<br>```c<br>if (len &lt; 13) return NULL;<br>namesize =3D get_be16(&=
amp;operands[11]); // Attacker controlled value (e.g., 1000)<br>namelen =3D=
 MIN(namesize, sizeof(name) - 1); // namelen becomes 254<br>if (namelen &gt=
; 0) {<br>=C2=A0 =C2=A0 memcpy(name, &amp;operands[13], namelen); // OOB RE=
AD: reads 254 bytes from a 14-byte buffer<br>}<br>count =3D operands[13 + n=
amesize]; // OOB READ: reads at offset 1013<br><span style=3D"color:rgb(13,=
13,13);font-family:Geist,&quot;PingFang SC&quot;,-apple-system,BlinkMacSyst=
emFont,&quot;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,Cantarell,&quot;Fira Sans&=
quot;,&quot;Droid Sans&quot;,&quot;Helvetica Neue&quot;,&quot;Microsoft YaH=
ei&quot;,sans-serif;font-size:16px;white-space:pre-line;background-color:rg=
b(248,248,248)">=C2=A0Impact
A remote Bluetooth device acting as an AVRCP controller (e.g., a car kit or=
 speaker) can
send a specially crafted </span><code class=3D"gmail-cursor-pointer gmail-c=
odespan" style=3D"box-sizing:border-box;border:0px solid rgb(13,13,13);marg=
in:0px;padding:5px 4px;font-family:GeistMono,ui-monospace,SFMono-Regular,Me=
nlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier New&quot;,mon=
ospace;font-feature-settings:normal;font-size:0.8em;width:auto;overflow-x:a=
uto;border-radius:6px;background-color:rgb(236,236,236);font-weight:600;col=
or:rgb(13,13,13);white-space:pre-line">GetFolderItems</code><span style=3D"=
color:rgb(13,13,13);font-family:Geist,&quot;PingFang SC&quot;,-apple-system=
,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,Cantarell,&qu=
ot;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helvetica Neue&quot;,&quot;=
Microsoft YaHei&quot;,sans-serif;font-size:16px;white-space:pre-line;backgr=
ound-color:rgb(248,248,248)"> response. When a Linux client connects and re=
quests
the media list, bluetoothd will attempt to read unallocated memory, resulti=
ng in a segmentation
fault (Denial of Service).=C2=A0</span><span style=3D"color:rgb(13,13,13);f=
ont-family:Geist,&quot;PingFang SC&quot;,-apple-system,BlinkMacSystemFont,&=
quot;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,Cantarell,&quot;Fira Sans&quot;,&q=
uot;Droid Sans&quot;,&quot;Helvetica Neue&quot;,&quot;Microsoft YaHei&quot;=
,sans-serif;font-size:16px;white-space:pre-line;background-color:rgb(248,24=
8,248)">Proof of Concept (PoC)
I have attached a minimal C program (</span><code class=3D"gmail-cursor-poi=
nter gmail-codespan" style=3D"box-sizing:border-box;border:0px solid rgb(13=
,13,13);margin:0px;padding:5px 4px;font-family:GeistMono,ui-monospace,SFMon=
o-Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&quot;Courier N=
ew&quot;,monospace;font-feature-settings:normal;font-size:0.8em;width:auto;=
overflow-x:auto;border-radius:6px;background-color:rgb(236,236,236);font-we=
ight:600;color:rgb(13,13,13);white-space:pre-line">poc_avrcp_obb.c</code><s=
pan style=3D"color:rgb(13,13,13);font-family:Geist,&quot;PingFang SC&quot;,=
-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,=
Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helvetica Neue=
&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font-size:16px;white-space:pr=
e-line;background-color:rgb(248,248,248)">) that simulates the vulnerable
function and triggers the bug.
</span><span style=3D"color:rgb(13,13,13);font-family:Geist,&quot;PingFang =
SC&quot;,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxyge=
n,Ubuntu,Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helve=
tica Neue&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font-size:16px;white=
-space:pre-line;background-color:rgb(248,248,248)">=C2=A0</span><span style=
=3D"background-color:rgb(248,248,248);color:rgb(13,13,13);font-family:Geist=
,&quot;PingFang SC&quot;,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&qu=
ot;,Roboto,Oxygen,Ubuntu,Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&q=
uot;,&quot;Helvetica Neue&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font=
-size:16px;white-space:pre-line">To verify the vulnerability:</span><ol dir=
=3D"auto" start=3D"1" style=3D"box-sizing:border-box;border:0px solid rgb(1=
3,13,13);margin:0px 0px 16px;padding:0px 0px 0px 16px;list-style:decimal;co=
lor:rgb(13,13,13);font-family:Geist,&quot;PingFang SC&quot;,-apple-system,B=
linkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,Cantarell,&quot=
;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helvetica Neue&quot;,&quot;Mi=
crosoft YaHei&quot;,sans-serif;font-size:16px;white-space:pre-line;backgrou=
nd-color:rgb(248,248,248)"><li class=3D"gmail-text-start" style=3D"box-sizi=
ng:border-box;border:0px solid rgb(13,13,13);margin:0.5em 0px;padding:0px">=
Compile the PoC with AddressSanitizer:
<code class=3D"gmail-cursor-pointer gmail-codespan" style=3D"box-sizing:bor=
der-box;border:0px solid rgb(13,13,13);margin:0px;padding:5px 4px;font-fami=
ly:GeistMono,ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,&quot;Libera=
tion Mono&quot;,&quot;Courier New&quot;,monospace;font-feature-settings:nor=
mal;font-size:0.8em;width:auto;overflow-x:auto;border-radius:6px;background=
-color:rgb(236,236,236);font-weight:600">gcc -fsanitize=3Daddress -g -o poc=
_avrcp_oob poc_avrcp_obb.c</code></li><li class=3D"gmail-text-start" style=
=3D"box-sizing:border-box;border:0px solid rgb(13,13,13);margin:0.5em 0px;p=
adding:0px">Run it:
<code class=3D"gmail-cursor-pointer gmail-codespan" style=3D"box-sizing:bor=
der-box;border:0px solid rgb(13,13,13);margin:0px;padding:5px 4px;font-fami=
ly:GeistMono,ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,&quot;Libera=
tion Mono&quot;,&quot;Courier New&quot;,monospace;font-feature-settings:nor=
mal;font-size:0.8em;width:auto;overflow-x:auto;border-radius:6px;background=
-color:rgb(236,236,236);font-weight:600">./poc_avrcp_oob</code></li></ol><d=
iv style=3D"box-sizing:border-box;border:0px solid rgb(13,13,13);margin:0px=
;padding:0px;color:rgb(13,13,13);font-family:Geist,&quot;PingFang SC&quot;,=
-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,=
Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helvetica Neue=
&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font-size:16px;white-space:pr=
e-line;background-color:rgb(248,248,248)"></div><p dir=3D"auto" class=3D"gm=
ail-svelte-4sys19" style=3D"box-sizing:border-box;border:0px solid rgb(13,1=
3,13);margin:0px 0px 16px;padding:0px;color:rgb(13,13,13);font-family:Geist=
,&quot;PingFang SC&quot;,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&qu=
ot;,Roboto,Oxygen,Ubuntu,Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&q=
uot;,&quot;Helvetica Neue&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font=
-size:16px;white-space:pre-line;background-color:rgb(248,248,248)">ASan wil=
l immediately report a stack-buffer-overflow and abort the execution, confi=
rming
the Out-of-Bounds read.=C2=A0 Proposed Patch
To fix this issue, the length extracted from the packet must be validated a=
gainst the
remaining bytes in the packet buffer before being used in <code class=3D"gm=
ail-cursor-pointer gmail-codespan" style=3D"box-sizing:border-box;border:0p=
x solid rgb(13,13,13);margin:0px;padding:5px 4px;font-family:GeistMono,ui-m=
onospace,SFMono-Regular,Menlo,Monaco,Consolas,&quot;Liberation Mono&quot;,&=
quot;Courier New&quot;,monospace;font-feature-settings:normal;font-size:0.8=
em;width:auto;overflow-x:auto;border-radius:6px;background-color:rgb(236,23=
6,236);font-weight:600">memcpy</code>.
=C2=A0<span style=3D"white-space:normal"><span style=3D"font-family:Arial,H=
elvetica,sans-serif;font-size:small;background-color:transparent;color:rgb(=
34,34,34)">--- a/profiles/audio/avrcp.c</span></span></p>+++ b/profiles/aud=
io/avrcp.c<br>@@ -2629,8 +2629,11 @@ static struct media_item *parse_media_=
element(struct avrcp *session,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uid =3D=
 get_be64(&amp;operands[0]);<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0memset(name, 0, sizeof(name));<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0namesize =
=3D get_be16(&amp;operands[11]);<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0namelen =
=3D MIN(namesize, sizeof(name) - 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0namesi=
ze =3D MIN(get_be16(&amp;operands[11]), len - 13);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0namelen =3D MIN(namesize, sizeof(name) - 1);<br>+<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (len &lt; 13 + namesize)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>+<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (namelen &gt; 0) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(name, &amp;operands[13], namelen);<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strtoutf8(name, =
namelen);<br>@@ -2672,7 +2675,8 @@ static struct media_item *parse_media_fo=
lder(struct avrcp *session,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(nam=
e, 0, sizeof(name));<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0namelen =3D MIN(get_be=
16(&amp;operands[12]), sizeof(name) - 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0n=
amelen =3D MIN(get_be16(&amp;operands[12]), len - 14);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0namelen =3D MIN(namelen, sizeof(name) - 1);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (namelen &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(name, &amp;operands[14], namelen);<br=
><span style=3D"color:rgb(13,13,13);font-family:Geist,&quot;PingFang SC&quo=
t;,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxygen,Ubun=
tu,Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helvetica N=
eue&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font-size:16px;white-space=
:pre-line;background-color:rgb(248,248,248)">Please let me know if you need=
 any further information. I am requesting a CVE assignment
for this vulnerability.=C2=A0</span><span style=3D"color:rgb(13,13,13);font=
-family:Geist,&quot;PingFang SC&quot;,-apple-system,BlinkMacSystemFont,&quo=
t;Segoe UI&quot;,Roboto,Oxygen,Ubuntu,Cantarell,&quot;Fira Sans&quot;,&quot=
;Droid Sans&quot;,&quot;Helvetica Neue&quot;,&quot;Microsoft YaHei&quot;,sa=
ns-serif;font-size:16px;white-space:pre-line;background-color:rgb(248,248,2=
48)">Best regards, Elman
</span><span style=3D"color:rgb(13,13,13);font-family:Geist,&quot;PingFang =
SC&quot;,-apple-system,BlinkMacSystemFont,&quot;Segoe UI&quot;,Roboto,Oxyge=
n,Ubuntu,Cantarell,&quot;Fira Sans&quot;,&quot;Droid Sans&quot;,&quot;Helve=
tica Neue&quot;,&quot;Microsoft YaHei&quot;,sans-serif;font-size:16px;white=
-space:pre-line;background-color:rgb(248,248,248)">=C2=A0</span></div>

--00000000000072ad93065802605a--
--00000000000072ad94065802605c
Content-Type: text/x-csrc; charset="UTF-8"; name="poc_avrcp_obb.c"
Content-Disposition: attachment; filename="poc_avrcp_obb.c"
Content-Transfer-Encoding: base64
Content-ID: <f_msauaxt10>
X-Attachment-Id: f_msauaxt10

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
--00000000000072ad94065802605c--

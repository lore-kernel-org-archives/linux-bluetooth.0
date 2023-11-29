Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5KN56ql"
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4687810E3
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 07:09:08 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4219f89ee21so37946321cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 07:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701270547; x=1701875347; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNBMPqnIAFgG4chgKIt/IAtltz919Toh1hIasjKqxw0=;
        b=R5KN56qlQRjZznYVa/u7l+0OJQZYM8VjdbizKAzmB8+XF26D9ur36XNP25EccOhKVa
         Ftifwtn/dMdH20xllT69IE/YbuRe3t5S4+1C6HbK2Z9dYSbl9PgZaMX98KsIu+sTcRSH
         z8JWj/Jswiqsj50203SakJUlmI7UZLKGe2BWnJjpTaknea/y9XSx7fRb/gZS/7GBBFnJ
         QtMzhdltk6A2NuA6VX/oLzUc1KbQnKPuStEmteicG+tFt4E386V4jIlU7DXtTThxKGq7
         Abd0bFqT5MtjgEs+49sQclmqHpjOrBOxM9q2C+einfXVzA0luYtIGCby0HITXkm32UhS
         uPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701270547; x=1701875347;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNBMPqnIAFgG4chgKIt/IAtltz919Toh1hIasjKqxw0=;
        b=VAhs8lGb8lTUGwvP9iBbi7gyHWsDm+hrp2r1LUqhB/1IIbgRGSEuqcm2i1EYwXioKw
         MpKz4vAci/+JDT1zTqcnEq2j5XjukCk0q/o6QxvsLQdmGB6aneQIlrEvX0titMeheiF2
         g6btC1lEEBESR9QYWD9iicS8lSgYUmeysnv4yXM0UvJwHRziyPl0mTBVp32JgAxzKyuE
         INFbOmHdUkTB7Ey1vdGMeBZIHVr6CLgskoXKkYU2H/IblrwUFApPCu3KxMKRe/j+sUw9
         KCnCtLxPlqD4HrnLdp5y1kxHjgyT9gCEx88Y25c7IZziBNWraxciTYN/J5lLQED8JXVZ
         bBAQ==
X-Gm-Message-State: AOJu0YyPd9Gt925j8vk/m8yFw4gvLuuxp4Qi4ZtWuWZkOW999W3jh2nR
	AlIEHn3KE74yVOttQpSJ7YIycGwStMQ=
X-Google-Smtp-Source: AGHT+IE2r8N/YjmJdwqUinHDkhtl+bV/y+wQuq6uwp0XuT2HqkNhK5Ws2gf09XAkUCkakSI+nvlDKA==
X-Received: by 2002:a05:622a:1055:b0:421:c349:73f6 with SMTP id f21-20020a05622a105500b00421c34973f6mr21513888qte.22.1701270547083;
        Wed, 29 Nov 2023 07:09:07 -0800 (PST)
Received: from [172.17.0.2] ([40.76.254.131])
        by smtp.gmail.com with ESMTPSA id eq9-20020a05622a5e0900b00423f1f9a76esm295173qtb.38.2023.11.29.07.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 07:09:06 -0800 (PST)
Message-ID: <65675412.050a0220.36254.22b2@mx.google.com>
Date: Wed, 29 Nov 2023 07:09:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1218497108600694466=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Implementation of AICS
In-Reply-To: <20231129134058.70612-2-mahesh.talewad@nxp.com>
References: <20231129134058.70612-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1218497108600694466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9ODA1Mjg0CgotLS1U
ZXN0IHJlc3VsdC0tLQoKVGVzdCBTdW1tYXJ5OgpDaGVja1BhdGNoICAgICAgICAgICAgICAgICAg
ICBQQVNTICAgICAgMS40NCBzZWNvbmRzCkdpdExpbnQgICAgICAgICAgICAgICAgICAgICAgIEZB
SUwgICAgICAwLjgzIHNlY29uZHMKQnVpbGRFbGwgICAgICAgICAgICAgICAgICAgICAgUEFTUyAg
ICAgIDI0LjEzIHNlY29uZHMKQmx1ZXpNYWtlICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAg
IDU4My4yNyBzZWNvbmRzCk1ha2VDaGVjayAgICAgICAgICAgICAgICAgICAgIEZBSUwgICAgICAx
MC42OSBzZWNvbmRzCk1ha2VEaXN0Y2hlY2sgICAgICAgICAgICAgICAgIEZBSUwgICAgICAxMzUu
MDUgc2Vjb25kcwpDaGVja1ZhbGdyaW5kICAgICAgICAgICAgICAgICBGQUlMICAgICAgMjEwLjU1
IHNlY29uZHMKQ2hlY2tTbWF0Y2ggICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDMxNi40NiBz
ZWNvbmRzCmJsdWV6bWFrZWV4dGVsbCAgICAgICAgICAgICAgIFBBU1MgICAgICA5Ni40OSBzZWNv
bmRzCkluY3JlbWVudGFsQnVpbGQgICAgICAgICAgICAgIFBBU1MgICAgICAxMDQ5LjE0IHNlY29u
ZHMKU2NhbkJ1aWxkICAgICAgICAgICAgICAgICAgICAgUEFTUyAgICAgIDkxNC41MSBzZWNvbmRz
CgpEZXRhaWxzCiMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBHaXRMaW50IC0g
RkFJTApEZXNjOiBSdW4gZ2l0bGludApPdXRwdXQ6CltCbHVlWix2MSwxLzJdIC0gQWRkZWQgQUlD
UyBDaGFyYWN0ZXJpc3RpY3MgVVVJRChzKS4KCldBUk5JTkc6IEkzIC0gaWdub3JlLWJvZHktbGlu
ZXM6IGdpdGxpbnQgd2lsbCBiZSBzd2l0Y2hpbmcgZnJvbSB1c2luZyBQeXRob24gcmVnZXggJ21h
dGNoJyAobWF0Y2ggYmVnaW5uaW5nKSB0byAnc2VhcmNoJyAobWF0Y2ggYW55d2hlcmUpIHNlbWFu
dGljcy4gUGxlYXNlIHJldmlldyB5b3VyIGlnbm9yZS1ib2R5LWxpbmVzLnJlZ2V4IG9wdGlvbiBh
Y2NvcmRpbmdseS4gVG8gcmVtb3ZlIHRoaXMgd2FybmluZywgc2V0IGdlbmVyYWwucmVnZXgtc3R5
bGUtc2VhcmNoPVRydWUuIE1vcmUgZGV0YWlsczogaHR0cHM6Ly9qb3Jpc3Jvb3ZlcnMuZ2l0aHVi
LmlvL2dpdGxpbnQvY29uZmlndXJhdGlvbi8jcmVnZXgtc3R5bGUtc2VhcmNoCjE6IFQzIFRpdGxl
IGhhcyB0cmFpbGluZyBwdW5jdHVhdGlvbiAoLik6ICJbQmx1ZVosdjEsMS8yXSAtIEFkZGVkIEFJ
Q1MgQ2hhcmFjdGVyaXN0aWNzIFVVSUQocykuIgpbQmx1ZVosdjEsMi8yXSAtIENvZGUgSW1wbGVt
ZW50YXRpb24gcmVsYXRlZCBTZXJ2aWNlLSBBSUNTLiAtIFNwZWNpZmljYXRpb24gcmVmZXJyZWQg
Zm9yIGltcGxlbWVudGF0aW9uOiBBSUNTX3YxLjAucGRmIC0gVmVyaWZpY2F0aW9uOiBUZXN0ZWQg
YWxsIE1hbmRhdG9yeSBQVFMgdGVzdGNhc2VzIGFuZCBhbGwgbWFuZGF0b3J5IHRlc3RjYXNlcyBw
YXNzZWQuCgpXQVJOSU5HOiBJMyAtIGlnbm9yZS1ib2R5LWxpbmVzOiBnaXRsaW50IHdpbGwgYmUg
c3dpdGNoaW5nIGZyb20gdXNpbmcgUHl0aG9uIHJlZ2V4ICdtYXRjaCcgKG1hdGNoIGJlZ2lubmlu
ZykgdG8gJ3NlYXJjaCcgKG1hdGNoIGFueXdoZXJlKSBzZW1hbnRpY3MuIFBsZWFzZSByZXZpZXcg
eW91ciBpZ25vcmUtYm9keS1saW5lcy5yZWdleCBvcHRpb24gYWNjb3JkaW5nbHkuIFRvIHJlbW92
ZSB0aGlzIHdhcm5pbmcsIHNldCBnZW5lcmFsLnJlZ2V4LXN0eWxlLXNlYXJjaD1UcnVlLiBNb3Jl
IGRldGFpbHM6IGh0dHBzOi8vam9yaXNyb292ZXJzLmdpdGh1Yi5pby9naXRsaW50L2NvbmZpZ3Vy
YXRpb24vI3JlZ2V4LXN0eWxlLXNlYXJjaAoxOiBUMSBUaXRsZSBleGNlZWRzIG1heCBsZW5ndGgg
KDIwNT44MCk6ICJbQmx1ZVosdjEsMi8yXSAtIENvZGUgSW1wbGVtZW50YXRpb24gcmVsYXRlZCBT
ZXJ2aWNlLSBBSUNTLiAtIFNwZWNpZmljYXRpb24gcmVmZXJyZWQgZm9yIGltcGxlbWVudGF0aW9u
OiBBSUNTX3YxLjAucGRmIC0gVmVyaWZpY2F0aW9uOiBUZXN0ZWQgYWxsIE1hbmRhdG9yeSBQVFMg
dGVzdGNhc2VzIGFuZCBhbGwgbWFuZGF0b3J5IHRlc3RjYXNlcyBwYXNzZWQuIgoxOiBUMyBUaXRs
ZSBoYXMgdHJhaWxpbmcgcHVuY3R1YXRpb24gKC4pOiAiW0JsdWVaLHYxLDIvMl0gLSBDb2RlIElt
cGxlbWVudGF0aW9uIHJlbGF0ZWQgU2VydmljZS0gQUlDUy4gLSBTcGVjaWZpY2F0aW9uIHJlZmVy
cmVkIGZvciBpbXBsZW1lbnRhdGlvbjogQUlDU192MS4wLnBkZiAtIFZlcmlmaWNhdGlvbjogVGVz
dGVkIGFsbCBNYW5kYXRvcnkgUFRTIHRlc3RjYXNlcyBhbmQgYWxsIG1hbmRhdG9yeSB0ZXN0Y2Fz
ZXMgcGFzc2VkLiIKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVj
ayAtIEZBSUwKRGVzYzogUnVuIEJsdWV6IE1ha2UgQ2hlY2sKT3V0cHV0OgoKLi90ZXN0LWRyaXZl
cjogbGluZSAxMDc6IDMxOTAzIEFib3J0ZWQgICAgICAgICAgICAgICAgIChjb3JlIGR1bXBlZCkg
IiRAIiA+ICRsb2dfZmlsZSAyPiYxCm1ha2VbM106ICoqKiBbTWFrZWZpbGU6MTE2MzM6IHRlc3Qt
c3VpdGUubG9nXSBFcnJvciAxCm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6MTE3NDE6IGNoZWNrLVRF
U1RTXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIxNzA6IGNoZWNrLWFtXSBFcnJv
ciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIxNzI6IGNoZWNrXSBFcnJvciAyCiMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBNYWtlRGlzdGNoZWNrIC0gRkFJTApEZXNjOiBSdW4g
Qmx1ZXogTWFrZSBEaXN0Y2hlY2sKT3V0cHV0OgoKLi4vLi4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3
OiA1NDExMyBBYm9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9n
X2ZpbGUgMj4mMQptYWtlWzRdOiAqKiogW01ha2VmaWxlOjExNjMzOiB0ZXN0LXN1aXRlLmxvZ10g
RXJyb3IgMQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNzQxOiBjaGVjay1URVNUU10gRXJyb3Ig
MgptYWtlWzJdOiAqKiogW01ha2VmaWxlOjEyMTcwOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlWzFd
OiAqKiogW01ha2VmaWxlOjEyMTcyOiBjaGVja10gRXJyb3IgMgptYWtlOiAqKiogW01ha2VmaWxl
OjEyMDkzOiBkaXN0Y2hlY2tdIEVycm9yIDEKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
ClRlc3Q6IENoZWNrVmFsZ3JpbmQgLSBGQUlMCkRlc2M6IFJ1biBCbHVleiBNYWtlIENoZWNrIHdp
dGggVmFsZ3JpbmQKT3V0cHV0OgoKdG9vbHMvbWdtdC10ZXN0ZXIuYzogSW4gZnVuY3Rpb24g4oCY
bWFpbuKAmToKdG9vbHMvbWdtdC10ZXN0ZXIuYzoxMjc2Mzo1OiBub3RlOiB2YXJpYWJsZSB0cmFj
a2luZyBzaXplIGxpbWl0IGV4Y2VlZGVkIHdpdGgg4oCYLWZ2YXItdHJhY2tpbmctYXNzaWdubWVu
dHPigJksIHJldHJ5aW5nIHdpdGhvdXQKMTI3NjMgfCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAq
YXJndltdKQogICAgICB8ICAgICBefn5+Ci4vdGVzdC1kcml2ZXI6IGxpbmUgMTA3OiA3MzgzMSBB
Ym9ydGVkICAgICAgICAgICAgICAgICAoY29yZSBkdW1wZWQpICIkQCIgPiAkbG9nX2ZpbGUgMj4m
MQptYWtlWzNdOiAqKiogW01ha2VmaWxlOjExNjMzOiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMQpt
YWtlWzJdOiAqKiogW01ha2VmaWxlOjExNzQxOiBjaGVjay1URVNUU10gRXJyb3IgMgptYWtlWzFd
OiAqKiogW01ha2VmaWxlOjEyMTcwOiBjaGVjay1hbV0gRXJyb3IgMgptYWtlOiAqKiogW01ha2Vm
aWxlOjEyMTcyOiBjaGVja10gRXJyb3IgMgoKCi0tLQpSZWdhcmRzLApMaW51eCBCbHVldG9vdGgK
Cg==

--===============1218497108600694466==--

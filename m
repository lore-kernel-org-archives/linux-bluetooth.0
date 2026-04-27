Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0137AA7A
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777272067; cv=none; b=Q32NreA9vuANt0p54HfjcO0nRzLjFuEN1IGQ+uEs9fqLbCgNQrg2CobwhpHs0FfiGUEOdGrdPVUtbViB1GgG/Y2oiJF/6j3LC1H1g4k66BUf18WbXqlb30Jwj+JMtF6mrKtg1f3MHgNQ+ahWyZpn54bGZGzM2GYvXDQ6U1BDVSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777272067; c=relaxed/simple;
	bh=3jB3tu4QXaAILMB1EOgvYu0Kv/z27R7XgBSS+45x1PA=;
	h=Date:Subject:Message-ID:From:To:Cc:MIME-Version:Content-Type; b=PMMftwnCVwwrqLvamiciARBJ4N6NcpFkJHgX/MME9RJ+VCgqndf1N02frIKqb65nuWtHwAMLc5rS8DRzQQ1PqcFcgrwrq+azaKWGy/h0okm4ka4fDVm2Rw7KgJvTfQvJlSs+rrmndxTqLsbBWHe9a+5xsIxg03+CzfPAcYavFyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AMRH09Pg; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AMRH09Pg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:Subject:Message-ID:From:To:MIME-Version:
	Content-Type; bh=3jB3tu4QXaAILMB1EOgvYu0Kv/z27R7XgBSS+45x1PA=;
	b=AMRH09Pg94P+92srYzgbkzG3Mn86tzmiN2BjoB3hXpXpWPmuLBF+ObSZ4Yya+2
	c26xknhN0xywEjyNk6/xJ/1vmYMrCkV4BAvotfVPWpRXt1rCDtKSpqhhxhv0Yv4i
	DeLJrAkK2NlGcx4ITmUPW6Nymegp9aOjabEzmDrNoVCu8=
Received: from [IPv6:240e:45c:1410:527:18aa:bbc:ab6a:5208] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3QrD4BO9pld9pBg--.96S2;
	Mon, 27 Apr 2026 14:40:58 +0800 (CST)
Date: Mon, 27 Apr 2026 14:40:55 +0800
Subject: About Kernel limitation HCI_MAX_FRAME_SIZE (1024 + 4)
Message-ID: <lot3ns12vglamg8c0b87iaoe.1777272055182@email.vivo.com>
From: yjg0107 <yjg0107@163.com>
To: "luiz.dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="--_com.android.email_5033273815367680"
X-CM-TRANSID:QCgvCgA3QrD4BO9pld9pBg--.96S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr43ZF47JF1ftr4kWw13twb_yoWxtrbEkr
	43G3yxXF4UtF48Z3WUKF13CF4ayrWfWF1xA3yqq3y7ZFZ8Ww47XF48XFn7u3WxGa1DJr1Y
	ya1Dtr4qkrn3XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKXdbDUUUUU==
X-CM-SenderInfo: x1mjiiiqx6il2tof0z/xtbC-xuV2WnvBPsUfwAA36

----_com.android.email_5033273815367680
Content-Type: multipart/alternative; boundary="--_com.android.email_5033273815453842"

----_com.android.email_5033273815453842
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGkgTHVpeiwKClF1ZXN0aW9uIGlzIHNhbWUgYXMgaHR0cHM6Ly9naXRodWIuY29tL2JsdWV6L2Js
dWV6L2lzc3Vlcy8yMDczLgpBYm91dCBLZXJuZWwgbGltaXRhdGlvbiBIQ0lfTUFYX0ZSQU1FX1NJ
WkUgKDEwMjQgKyA0KSwgeW91IHNhaWQgdGhhdCB0aGlzIHdpbGwgYmUgZml4ZWQgdG8gZW5hYmxl
IHVzZXIgc3BhY2UgY2hhbmdlZCwgZnJvbSAjMjAxIChjb21tZW50KS4KVGhlIHBhdGNoIGNvbW1p
dCBpcyB0b3J2YWxkcy9saW51eEAwOTU3MmZjLCByaWdodD8KCkhvd2V2ZXIsIHdoeSBIQ0lfQ0hB
Tk5FTF9VU0VSIHR5cGUgY2FuIG5vdCBjaGFuZ2UgTVRVIHZhbHVlPyBHb29nbGUgYmx1ZXRvb3Ro
IGFpZGwgdXNlcyBIQ0lfQ0hBTk5FTF9VU0VSIHR5cGUgZnJvbSBodHRwczovL2NzLmFuZHJvaWQu
Y29tL2FuZHJvaWQvcGxhdGZvcm0vc3VwZXJwcm9qZWN0LysvYW5kcm9pZC1sYXRlc3QtcmVsZWFz
ZTpoYXJkd2FyZS9pbnRlcmZhY2VzL2JsdWV0b290aC9haWRsL2RlZmF1bHQvbmV0X2JsdWV0b290
aF9tZ210LmNwcCBsaW5lIDI4Mi4KCkNvdWxkIGtlcm5lbCByZW1vdmUgdGhlIGxpbWl0YXRpb24g
dGhhdCBIQ0lfQ0hBTk5FTF9VU0VSIGNhbiBub3QgY2hhbmdlIE1UVT8KClRoYW5rcy4KQi5SLgpK
aWdvbmcgWWluCgoKCuWPkeiHqnZpdm/nlLXlrZDpgq7ku7Y=
----_com.android.email_5033273815453842
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PCFET0NUWVBFIGh0bWw+CjxodG1sPgogICAgPGhlYWQ+CiAgICAgICAgPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPgogICAg
ICAgIDwhLS08bWV0YSBuYW1lPSJ2aWV3cG9ydCIgY29udGVudD0id2lkdGg9ZGV2aWNlLXdpZHRo
LCBpbml0aWFsLXNjYWxlPTEiIC8+LS0+CiAgICAgICAgPHRpdGxlPkFib3V0IEtlcm5lbCBsaW1p
dGF0aW9uIEhDSV9NQVhfRlJBTUVfU0laRSAoMTAyNCArIDQpPC90aXRsZT4KICAgICAgICA8c3R5
bGU+CiAgICAgICAgYXt0ZXh0LWRlY29yYXRpb246bm9uZX0KICAgICAgICA8L3N0eWxlPgogICAg
PC9oZWFkPgogICAgPGJvZHk+CiAgICAgICAgPGRpdiBpZD0idml2b0NvbnRhaW5lciIgPgogICAg
ICAgICAgICA8ZGl2IGlkPSJ2aXZvQm9keSI+PGRpdiBkaXI9Imx0ciI+SGkgTHVpeiw8L2Rpdj4K
PGJyPgo8ZGl2IGRpcj0ibHRyIj5RdWVzdGlvbiBpcyBzYW1lIGFzIDxhIGhyZWY9aHR0cHM6Ly9n
aXRodWIuY29tL2JsdWV6L2JsdWV6L2lzc3Vlcy8yMDczLj5odHRwczovL2dpdGh1Yi5jb20vYmx1
ZXovYmx1ZXovaXNzdWVzLzIwNzMuPC9hPjwvZGl2Pgo8ZGl2IGRpcj0ibHRyIj5BYm91dCBLZXJu
ZWwgbGltaXRhdGlvbiBIQ0lfTUFYX0ZSQU1FX1NJWkUgKDEwMjQgKyA0KSwgeW91IHNhaWQgdGhh
dCB0aGlzIHdpbGwgYmUgZml4ZWQgdG8gZW5hYmxlIHVzZXIgc3BhY2UgY2hhbmdlZCwgZnJvbSAj
MjAxIChjb21tZW50KS48L2Rpdj4KPGRpdiBkaXI9Imx0ciI+VGhlIHBhdGNoIGNvbW1pdCBpcyB0
b3J2YWxkcy9saW51eEAwOTU3MmZjLCByaWdodD88L2Rpdj4KPGJyPgo8ZGl2IGRpcj0ibHRyIj5I
b3dldmVyLCB3aHkgSENJX0NIQU5ORUxfVVNFUiB0eXBlIGNhbiBub3QgY2hhbmdlIE1UVSB2YWx1
ZT8gR29vZ2xlIGJsdWV0b290aCBhaWRsIHVzZXMgSENJX0NIQU5ORUxfVVNFUiB0eXBlIGZyb20g
PGEgaHJlZj1odHRwczovL2NzLmFuZHJvaWQuY29tL2FuZHJvaWQvcGxhdGZvcm0vc3VwZXJwcm9q
ZWN0LysvYW5kcm9pZC1sYXRlc3QtcmVsZWFzZTpoYXJkd2FyZS9pbnRlcmZhY2VzL2JsdWV0b290
aC9haWRsL2RlZmF1bHQvbmV0X2JsdWV0b290aF9tZ210LmNwcD5odHRwczovL2NzLmFuZHJvaWQu
Y29tL2FuZHJvaWQvcGxhdGZvcm0vc3VwZXJwcm9qZWN0LysvYW5kcm9pZC1sYXRlc3QtcmVsZWFz
ZTpoYXJkd2FyZS9pbnRlcmZhY2VzL2JsdWV0b290aC9haWRsL2RlZmF1bHQvbmV0X2JsdWV0b290
aF9tZ210LmNwcDwvYT4gbGluZSAyODIuPC9kaXY+Cjxicj4KPGRpdiBkaXI9Imx0ciI+Q291bGQg
a2VybmVsIHJlbW92ZSB0aGUgbGltaXRhdGlvbiB0aGF0IEhDSV9DSEFOTkVMX1VTRVIgY2FuIG5v
dCBjaGFuZ2UgTVRVPzwvZGl2Pgo8YnI+CjxkaXYgZGlyPSJsdHIiPlRoYW5rcy48L2Rpdj4KPGRp
diBkaXI9Imx0ciI+Qi5SLjwvZGl2Pgo8ZGl2IGRpcj0ibHRyIj5KaWdvbmcgWWluPC9kaXY+Cjxi
cj4KPGJyPgo8YnI+CjxkaXYgZGlyPSJsdHIiPuWPkeiHqnZpdm/nlLXlrZDpgq7ku7Y8L2Rpdj4K
PC9kaXY+CiAgICAgICAgICAgIDxkaXYgaWQ9InZpdm9TaWduIiBzdHlsZT0ibWFyZ2luLXRvcDog
MWVtOyI+PC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICA8L2JvZHk+CjwvaHRtbD4=
----_com.android.email_5033273815453842--
----_com.android.email_5033273815367680--


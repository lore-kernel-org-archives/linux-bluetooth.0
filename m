Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E061397691
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583817; cv=none; b=JRjFpR+ZAxKKpjD54Lho73SF2RXmByb2abtBSXYIHKpU3I81BEvxNsyrmlDjaN6wFsBhd2DsDEVTF/PVU3dHFjPpgobdtWEoX7yAqDxbQMzAhG7SRcfFf1K0NA+HoZ+wSmLOudBP5+e+QlwP/z1eOSmE4yYmMAuqz0o5szFzxXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583817; c=relaxed/simple;
	bh=Mek7FOsegavnoQNNUT3LNVqBd3C5+QRsno4CKtgNIiM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChIFCV8IIOMtN5qF8NZZACt2ylCk6LIANxWgAj0RkO6d89YwKp2L70JZV5KFwaOKc2l+gRokXkkEHAj3yNRB0OIuLD4tE67oZVXGLnWPTJiBmaYC4+bKTRdxYlsx3bRq92/Dj1j6T2RClLe+ofnQarSl7kG0t5A3/FRzMgS4JgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 233F93E962;
	Thu,  4 Jun 2026 14:36:53 +0000 (UTC)
Message-ID: <e028618b386e849f676ede750281ed0c81e53587.camel@hadess.net>
Subject: Re: [BlueZ,v2] profiles/ranging: Read measured_freq_offset field-16
 bit as per Core Spec
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Date: Thu, 04 Jun 2026 16:36:52 +0200
In-Reply-To: <6a2168f8.a4791f72.24ac8d.29ee@mx.google.com>
References: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
	 <6a2168f8.a4791f72.24ac8d.29ee@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: dmFkZTETCOEulpHqoJ+j7ldkcObMnqOlVqHKIRAnd01Tzr2CG4RIAqW8LW26beStfO28TexLTOwHVnPjyox5elvnqe3oxhYl7fTWx/VNw83ObUzhzQhYAEGzJQhlvqwdFQSDP0SfMgaYWnfFSwjuZNs3ZE6WxlaU/oIZGyB56i8mzAWTr1w4n8TOnr0XUQYfY79/TZG7AjQfRvJfN9HyqVVdsJpY3FQ6HfNBNb/nJbsZwUqrwQ0v4Fnnni1+WNAtg58nfVYSGCaMSitsC0EXJIqNk0cxIMDLzLXLZjMjn7C5nkKkDrHkhZ3lGCQZC2aHEl5oFaakWkVkO0yGcZ9DGrwmUS1CjjadJpIFrIbzgSVJ86yqStU2qGzCg90iJTcX9qhWUTzmo5pAiq+5OP3A5+miv29jzGTJe+KyXe7CSLXzfzrSO5zZgxT4rJOhgLCFCZDy3SaEuqPWmR3YZW7ZTKPomFi40r3JLB1poO+InIV3q9S5t5OS/fjJBFnKmpYiIQ1k2oxTm0OuBXZq05FAzYwd2/VeQcGkz0aRDsvqbDc0f5Ukxv1QUcadRYh3rtf6d7haW68Ruf9qmmg6D88mqA07Ly5zkGpJ4DISWfKeoPkzDJ8uB+5gwDOTOUwIwOhEywF1I3X2eUhbeGTUAkVJEETo49C8RdaeRsdG25M2Hs/lPN4CEA

T24gVGh1LCAyMDI2LTA2LTA0IGF0IDA1OjAwIC0wNzAwLCBibHVlei50ZXN0LmJvdEBnbWFpbC5j
b20gd3JvdGU6Cj4gVGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVw
bHkgdG8gdGhpcyBlbWFpbCEKPiAKPiBEZWFyIHN1Ym1pdHRlciwKPiAKPiBUaGFuayB5b3UgZm9y
IHN1Ym1pdHRpbmcgdGhlIHBhdGNoZXMgdG8gdGhlIGxpbnV4IGJsdWV0b290aCBtYWlsaW5nCj4g
bGlzdC4KPiBUaGlzIGlzIGEgQ0kgdGVzdCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6
Cj4gUFcKPiBMaW5rOmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9ibHVldG9v
dGgvbGlzdC8/c2VyaWVzPTExMDUKPiA4NTMKPiAKPiAtLS1UZXN0IHJlc3VsdC0tLQo+IAo+IFRl
c3QgU3VtbWFyeToKPiBDaGVja1BhdGNowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgUEFTU8KgwqDCoMKgwqAgMC4zOSBzZWNvbmRzCj4gR2l0TGludMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZBSUzCoMKgwqDCoMKgIDAuMjggc2Vjb25k
cwo+IEJ1aWxkRWxswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBB
U1PCoMKgwqDCoMKgIDE1LjkyIHNlY29uZHMKPiBCbHVlek1ha2XCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBBU1PCoMKgwqDCoMKgIDQ5My43OSBzZWNvbmRzCj4gQ2hl
Y2tTbWF0Y2jCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUEFTU8KgwqDCoMKg
wqAgMjUyLjYwIHNlY29uZHMKPiBibHVlem1ha2VleHRlbGzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFBBU1PCoMKgwqDCoMKgIDEyOC41MSBzZWNvbmRzCj4gSW5jcmVtZW50YWxCdWlsZMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFBBU1PCoMKgwqDCoMKgIDQ4Ni42NiBzZWNvbmRzCj4g
U2NhbkJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBQQVNTwqDC
oMKgwqDCoCA3MTMuNDkgc2Vjb25kcwo+IAo+IERldGFpbHMKPiAjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKPiBUZXN0OiBHaXRMaW50IC0gRkFJTAo+IERlc2M6IFJ1biBnaXRsaW50Cj4g
T3V0cHV0Ogo+IFtCbHVlWix2Ml0gcHJvZmlsZXMvcmFuZ2luZzogUmVhZCBtZWFzdXJlZF9mcmVx
X29mZnNldCBmaWVsZC0xNiBiaXQKPiBhcyBwZXIgQ29yZSBTcGVjCj4gCj4gMTogVDEgVGl0bGUg
ZXhjZWVkcyBtYXggbGVuZ3RoICg4ND44MCk6ICJbQmx1ZVosdjJdIHByb2ZpbGVzL3Jhbmdpbmc6
Cj4gUmVhZCBtZWFzdXJlZF9mcmVxX29mZnNldCBmaWVsZC0xNiBiaXQgYXMgcGVyIENvcmUgU3Bl
YyIKCkkgdGhpbmsgdGhhdCB0aGlzIGdpdGxpbnQgZXJyb3IgaXMgd3JvbmcsIGFuZCBmaWxlZDoK
aHR0cHM6Ly9naXRodWIuY29tL2pvcmlzcm9vdmVycy9naXRsaW50L2lzc3Vlcy81NjYKCkNoZWVy
cwoKPiAKPiAKPiBodHRwczovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovcHVsbC8yMTc4Cj4gCj4g
LS0tCj4gUmVnYXJkcywKPiBMaW51eCBCbHVldG9vdGgK


Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A69C3B840F
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840963; cv=none; b=ud4cRUmsMckodKR0yddkTh5L+GwJaJJkZ4JAaqD2YXn3cI6t2VMs8EfUAIw9bpE5W5VNDiFDNc4QWsZ+Hc+lWxjDoCW5S82Zsv/+1PLWfVejmRtZsHV8KRfXgyvP6+ZIrQ7JcJZFjCxUz6qDBLAmi8I2+qavlas2KRL5iqWSk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840963; c=relaxed/simple;
	bh=O14uupD4hxjc3LS8STUk+P1/hwWWkrpczTl4g39IdcE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject; b=GqTntA9tMWpFxp2vv1O7ppjpIVIFvb/5e6uJRKrwBOGdYOGjH3sQiO3Fp/6pG2O/GO9VZvHHjGC0VZZBOoV9+3ztGEfGkV34CEv+8wSwfYyTGXDllQn44CnJ5bi6uhBhbJJbz+SIDdmWa9qqJWEujGIUzCl2vYvJc1r6GkgwNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbK7noTS; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbK7noTS"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so318491866b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778840960; x=1779445760; darn=vger.kernel.org;
        h=subject:cc:to:from:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O14uupD4hxjc3LS8STUk+P1/hwWWkrpczTl4g39IdcE=;
        b=bbK7noTSgmU0KtOycsq5KJuAZz4KgiHTYM4/x4c0I7NUvfzfcErKpEqWkJDncAGwwd
         xqtHwRhRtrixzrFuEPcdwBSOp7AKBjwkUFymFx8an/H+9glS/6Z7u5cxvst6uLBGlR5i
         VrNYTA/MSLf08k4g1lrFob/rrfWC59DjIgEeJYImRSu/EJEbH26v2A695UEZXDhkBmPA
         3vgK4caiUVbVbE5payWKbtGGI+3Xroihz7ABCOCszBldBVzaWgF+82UryYx6eNmAxjqX
         b17+IdQ5f7GdJXok3Z/DkrPBfk/qO2WUQZ6xFL7BzrnBYce2YO9A0x7dVS7VEpAuoqhg
         8d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840960; x=1779445760;
        h=subject:cc:to:from:content-transfer-encoding:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O14uupD4hxjc3LS8STUk+P1/hwWWkrpczTl4g39IdcE=;
        b=olEririF/xzQVxj8B0Rtbvwnt0Ug9GCWsL0Fax+le8ITyaUipfW9B56E4Sd16UW+el
         BwE/WikYmm5TCuUBxJ6r2BHr9DYBr75ZCNG+EadF494olHU2aTusawj3we/Iaax9+uGG
         BaIhRvJK48c80gC0E3l21q6bUpjNKLHUF1lBoFo8913wbtSroXvEPColbburn8e5z9lz
         40UhG1eIhATPSSUxqqte1jPO1hVPqqxIWDIqbp5LYCaT7X92Qe9+VgjQ0mYyvU2abJwh
         tlx6DVkYK/ZJlRN2Nqg5w5+7OIEaLocHZotHueJs7F7HDHaQdquCCa+p4hMi0EBRyWxy
         QL2g==
X-Gm-Message-State: AOJu0YzBiB92xDHy5lXQajsmkvWAsb3VPc8VoAJESaoREVCOTQ0gqeWz
	9sqLtHqU7hEIkMbKO5S1S4+PbqKkaI+EKls9VAN07Lb25scZYHpOAKjejmlnEBkP
X-Gm-Gg: Acq92OFtNTWtef32anaOjKcpeMNolQUoQNW0Fyk07lxvw7q2N/UP68EMRCCirljdd08
	MwSa8kqgUH1TXBnGXI7C3nLnz3CmGF4jnFWK6CToCz/6FX4vB6gWY1Ct4lIw8kK5sVzan+2WCHW
	YfImiOZo7Ox9HE7HwyvrwDq/BXPFPCZvc7sBl1KwYIdd5v4P4eGFTmiXjHUqLeGbE33gcJTPaZP
	texVX5B1BXycenOVLj983yTRgVtxgLcMYWnA4fu6eDsYCNHd8vsPRZo/ckodvZ7ckFVohBWg9Dj
	K//u3ClFHplTYCEdUQI+2Tz8mNPC1+tNMD/1UMNyVmo/1Yib3I3g0CC/tS9YRQCP8ScjYxSkcu+
	eMYfNVrw4shJghXb/niswYxEzIjDvkAXu4bEzOLUoJrI94gv5NgiaUDFMS+WHldrV5YrdA1nkCs
	qJ+efFTS9ymp61Syya3qOEeRPiVeLTWZXkXATkdEiDpIstyYw9QINGfudqVM6WS8WGDwQvtC8U0
	uMaMIjqVeJ6hxuKBx6hrZaMli9fFLcMB8BXmVFZED5P/6wYACvXYTnPmFOuBbS0C+gSltnJAe6H
	epUFrzIe/RP9gEYlX2ZaVviLbcp5dba+kTQysQ8=
X-Received: by 2002:a17:907:ea5:b0:bd1:ba57:ec8d with SMTP id a640c23a62f3a-bd5178458abmr167176866b.17.1778840960055;
        Fri, 15 May 2026 03:29:20 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea93dsm201976566b.38.2026.05.15.03.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:29:19 -0700 (PDT)
Message-ID: <6a06f57f.07ac1395.28395d.c7d8@mx.google.com>
Date: Fri, 15 May 2026 03:29:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: Bluetooth: ISO: null ptr deref in iso_recv() on ISO_END without prior ISO_START

SGksCgpJIGZvdW5kIGEgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIGlzb19yZWN2KCkgaW4g
bmV0L2JsdWV0b290aC9pc28uYy4KCkF0IGxpbmUgMjU5NS0yNTk2OgoKICAgIGNhc2UgSVNPX0VO
RDoKICAgICAgICBza2JfY29weV9mcm9tX2xpbmVhcl9kYXRhKHNrYiwKICAgICAgICAgICAgc2ti
X3B1dChjb25uLT5yeF9za2IsIHNrYi0+bGVuKSwgc2tiLT5sZW4pOwoKY29ubi0+cnhfc2tiIGlz
IHBhc3NlZCB0byBza2JfcHV0KCkgd2l0aG91dCBhIE5VTEwgY2hlY2suCgpJdCBjYW4gYmUgTlVM
TCBpbiB0d28gY2FzZXMuIEZpcnN0LCBpZiBJU09fRU5EIGFycml2ZXMgd2l0aG91dCBhIHByaW9y
CklTT19TVEFSVCBmcmFtZSwgY29ubi0+cnhfc2tiIHdhcyBuZXZlciBhbGxvY2F0ZWQuIFNlY29u
ZCwgdGhlIElTT19DT05UCm92ZXJmbG93IGVycm9yIHBhdGggYXQgbGluZSAyNTgxLTI1ODcgY2Fs
bHMga2ZyZWVfc2tiKGNvbm4tPnJ4X3NrYikgYW5kCnNldHMgaXQgdG8gTlVMTC4gQSBzdWJzZXF1
ZW50IElTT19FTkQgaGl0cyB0aGUgc2FtZSBwYXRoLgoKVGhlIElTT19DT05UIGNhc2UgYXQgbGlu
ZSAyNTc1IGhhcyBhIGd1YXJkOgoKICAgIGlmICghY29ubi0+cnhfbGVuKSB7CiAgICAgICAgZ290
byBkcm9wOwogICAgfQoKSVNPX0VORCBoYXMgbm8gZXF1aXZhbGVudCBwcm90ZWN0aW9uLgoKU3Vn
Z2VzdGVkIGZpeDoKCiAgICBjYXNlIElTT19FTkQ6CiAgICAgICAgaWYgKCFjb25uLT5yeF9za2Ip
CiAgICAgICAgICAgIGdvdG8gZHJvcDsKICAgICAgICBza2JfY29weV9mcm9tX2xpbmVhcl9kYXRh
KHNrYiwKICAgICAgICAgICAgc2tiX3B1dChjb25uLT5yeF9za2IsIHNrYi0+bGVuKSwgc2tiLT5s
ZW4pOwoKQXR0YWNrIHN1cmZhY2U6IENJUyByZXF1aXJlcyBhbiBlc3RhYmxpc2hlZCBBQ0wgY29u
bmVjdGlvbi4gQklTIHJlcXVpcmVzCnRoZSB2aWN0aW0gdG8gc3luYyB0byBhIG1hbGljaW91cyBi
cm9hZGNhc3Rlci4gTm90IHplcm8tY2xpY2sgYnV0IHJlYWNoYWJsZQpmcm9tIGFuIGFkamFjZW50
IHVuYXV0aGVudGljYXRlZCBzb3VyY2Ugb24gQ0lTIHBhdGhzLgoKVGVzdGVkIG9uIGxpbnV4LW5l
eHQgY29tbWl0IGU5OGQyMWMxNzBiMCAoMjAyNi0wNS0wOCkuCgpBbGV4YW5kcnUK

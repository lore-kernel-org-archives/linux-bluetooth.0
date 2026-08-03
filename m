Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3423A641F
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792551; cv=none; b=s6rJBrcgLoad6Sky86YYDGGM0AsVoPUBZO9ZB92xN09f6RogOKv2OP8CkULTie9eVWU2CETX1wcAbVlpc3VAsQRHTzDOye64vZJQeiyB5FHDmHxVhTykcU7Oa9uKGngzgLxZpwA95QtyqKPUaYqH7YBFCzlr9WJCGNyHgyxLOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792551; c=relaxed/simple;
	bh=9JRbCV/V/QVqctpGF2oqn57FLFo4wTlsPEDcgZWv7cE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dv5a5+Vfr6HZ09vOab/QtQgRBFdH0uiLuzl56FFGCjaXHEmVZNe9b3AJc0o5FT6IWHtCyMcseKx1EMT5ch6nFrDUjk5ufxjuRtzca1/Hwjz0qUhbeVfK2fySYs4ukc9maYL/hFCsNU7dfPoVvw2WAeA2Olz8Q+GBITqTZxvm458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ucs7MAXA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ucs7MAXA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so2939878a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2026 14:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785792550; x=1786397350; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7aMbFPHfhqkJwAGDi+KoYmnsNHcfgvwMB4Zbid/pk28=;
        b=Ucs7MAXAsB7d+Cy0r5DaBYXDISJSfxViOl+k4Y2aJwDidnCeFkUQg+joakxqedOruY
         QufmU8HJvHbTEwnXX6VvIt36wkB718guUqaVw1Afriv4TsVi4KoNp0nNCHCu944VINvp
         whNmg4mJG6hJrkDEXGhb0BlHDo0t9uKJY42t/PvEaQtfO1dzowSDi1OSUs1d60U2HJF9
         yb8HZfGPCDPUO1Zl3/Dg/yvYnztPzNO0bqp82mewNeuBWuNOu8cnAR2Ca5YC68uoMJJO
         4jwp6igk9/WFFrTQWlVM8CSPZyaJPWAdazLIxMDQtjXEQe12Z0/9ZqnZoBGMF1QbVvqS
         B95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785792550; x=1786397350;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7aMbFPHfhqkJwAGDi+KoYmnsNHcfgvwMB4Zbid/pk28=;
        b=Gr0ZZ5fwrkmPRHpQPrMCzxLWwy7X7MbTgfz8oBzMxk6CYClpugWr9mh3lEYzE93SfP
         R82Rg/0j+FetahKRncAc80H3nSHhy1LjyWT8qfMwIglVg/i4AgvQJuOCzXS9iYQl7ht6
         MZt/QuGFhy2YbPAXMqNzkQg0E3CRm4k6eCVEfLAkWcVePFVWPxgQ4DXLuI/7HUFdeC10
         nap48ogd337eanFFT5tiNsHnGi0R6b0mMIAnfSvIhoJ6w1egYUhh1ZmIrmO9V6YsPWN5
         7eanzbvN//5IZwHEtxYlKlmLJnf8ng4CpY6rpc8nLMvsAMaVneVZDKlnEOWqZXVOph7v
         wxyA==
X-Gm-Message-State: AOJu0YyhcrNUUaZxKtVmy9Q8uxH8fuU9M7zGCrUT1/48fIlpBXDiVhzN
	sZt2BnB9fwMDv1CFI8sYj3gQsONVwxRpgFrefNcY+Pqwuaj33qgyDWAtTAkPD91v
X-Gm-Gg: AR+sD13wTeYXr3Px2iG/fSWKbb7um99nNa3nQWzzV/GZfRDKbFAd7Y7gtW2gj3i8mWi
	LfvI/FkQs2CDGCavRTw+H9gh5jTZf+OrzPd92fz4uOatsEPdAZ5wjUqJ+HsSphH0cMgAjudEd9V
	w8rQu6i2Cx1LXMUdACsg7OdAhlfbfhKjdpdwPanmQtO+sGEIVkRjzIzjdRuKOxbBDLLwYgECqvT
	BohYzInSwXJIudFZBgvew8xM54AxoRAdAUTMkZcCzkCnTBtQ49hcQbsmmdWC+3yIydJvYIcxO/G
	DTDAgF5+KzO/97ZkrDoUW2WBu8NrlmtyVhGYfkM+jAX6tMHyPQ69aoVdoKhHPkX9QZKc4xKBFRj
	hGczCTNwEZAZvT4TgrzlH9FJgl338UwwqO80P/0PxN6nmVp5/0ULkNu2pMhPgpsii4Dbh5y2eoQ
	pgp/EUVPgzpEI07AxZ9k/DdjPdf+E+0ep69S08wq+EBUvcGjgllF8UEXTW+9EkxA/CsGg=
X-Received: by 2002:a05:6a20:d80f:b0:3ba:cd5b:3dc8 with SMTP id adf61e73a8af0-3c92a5f1c89mr11260496637.31.1785792549590;
        Mon, 03 Aug 2026 14:29:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.247.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9be04sm38665824eec.9.2026.08.03.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:29:08 -0700 (PDT)
Message-ID: <6a710824.c56fb102.15e4aa.742c@mx.google.com>
Date: Mon, 03 Aug 2026 14:29:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2432660462367317764=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jan.brummer@tabos.org
Subject: RE: Add cover art support
In-Reply-To: <20260803195620.255866-2-jan.brummer@tabos.org>
References: <20260803195620.255866-2-jan.brummer@tabos.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2432660462367317764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1139642

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      20.82 seconds
BluezMake                     PASS      559.76 seconds
MakeCheck                     PASS      18.59 seconds
MakeDistcheck                 PASS      162.14 seconds
CheckValgrind                 PASS      233.65 seconds
CheckSmatch                   PASS      318.88 seconds
bluezmakeextell               PASS      104.34 seconds
IncrementalBuild              PASS      553.71 seconds
ScanBuild                     PASS      1009.10 seconds



https://github.com/bluez/bluez/pull/2370

---
Regards,
Linux Bluetooth


--===============2432660462367317764==--

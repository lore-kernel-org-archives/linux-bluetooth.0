Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D72EEE83
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Aug 2026 07:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568181; cv=pass; b=qAHwFG/ILGAoKpH4HPS1mZ8jfUypLAwWyseRg3NRtzZ/DiLPUnWwaXhEH1PF/iAQcWFmriKCwD74GTqteRb3Ha0BL3lZ7QCk2MU90HLV5HQSUE1nsZFgAsWftw0jhkCTdr+3VVPt+KsI9yRNsEptsKorq0+ZSIFVgk6h4vZdv1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568181; c=relaxed/simple;
	bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYMPxZKPk7WgPRTVTR6MqgV202TBp5Ogbdo5jDv6LBekz5fB0aLVIzD6KV62yZvIfq6wckj+o3hN8hKMCKvafv0NdenvvW4ypsBR3DR+Mao1rKazHpmeSI7buhUjpUqwumHqoHCISYCtjG6ii44gfEuDRLltmS8wbAkztrXNPHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbZ/nbBu; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbZ/nbBu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-69f734cd461so418780a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Aug 2026 00:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785568179; cv=none;
        d=google.com; s=arc-20260327;
        b=AtASdHq5C5RHMbfU7hj4hUGvsvNkwCtsOoToyGXh4u1YS1stPhtXUPuhMDBFioGGHw
         2te4nBxdeAX6Ff0bmqU9dWvC+XHx80mjzTrP4eOCoVrLX3zSEZ6HuAZ5Lvnsd/KjwdHX
         SG7UmAAadgvXWXGt5SosMLhhA6hTAE4q1v+Mt7utPpIXpd5MP7gsqBZEpZTufCMGDgDY
         c2c+0zIlhJmW0vaJmu6/hLnPo/hekh77OJs7Io3+RUUNuAl4l9/zNvAw1qOylxNO4RuZ
         /w1fEMdL85vFdq+vm97rr8UMKd91ZSaq/7IfNcOVbNu5dtMQT/qZjZRmpRyFuYau+Vgd
         l+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
        fh=+0ADAdrloTqkJn5ddMJKKdoxYNeFxGL6cQEg8+g7b48=;
        b=KFW97FKRiEkJyb4Oz1kjF8DG0enFiuk8KMOSG2LVUIa51X2E9CeWPErFaRwLnmH/6J
         BKdX/MYE+gnDFlEOnpcW/HFnUt5HX7KMjozNywYYANP/VK3TMWSkHzEbhkLkE6r8V8N9
         YU3SgOQTIpydPsMqwG5boPBwI650kVwS622pL8XP0Memti70jR1WvW3uWgPSE76CkDXE
         gwLsGfH9fjWAOhVNGfphOmpDsXqI5S0IVMQbZXBnr/jx3/Fc1MO0YU0oPr/N1msTxRmF
         cQFXDCyT7z8TOjYWBKpOnIdpgErX1jye/D4YBVwp1U+mzlIbbbPyUiu4CVdiW71zCzJ4
         XSjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785568179; x=1786172979; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
        b=NbZ/nbBu1y50qgiqWf3daONzVPV/aQ2PfFZxQsHZUkPq7900zEI29RzYOrD5FUuBrp
         Boi6gOkVBmdv24qW9EhRk8WJjQTRGGKiaFPteRtgxcEkqD9OTHpxO0e+5ru8F8eGXqdN
         VHXWGpwPDHFmyTKVIvlEAufxy3dl+7I9URK9L8yNZk3cruz89xN+bC3KdwOUOIpo8Q9u
         rlxnfebTRWfJynwMdzQYApF8VIXb3hu2mUxS+rhEy0dVfcp6qdCNSTpZMeWKwBB96L1h
         wt7/8YV6MdzeU8nFw2WAdxBmOGMJC5yuaEhnNR6bs3/2zUujDF/P4gWij5cT49je+Uhx
         LyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785568179; x=1786172979;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=86+C5my5h7svLUe+SYOW2syp44/3E44wPf3m+bJSTm4=;
        b=YCzf80WchONg+Q9WtWV4CsQHESWBCtbrxrDIFB+ZD/q3MbB7ObMp7xRJHFmu0bo/6D
         x37SotWZsLNEJwfCJ2Q6BdlNkejgCALgJDqqhipgQPj4QrEkmHhkLcR3r0qDOL0sbhU3
         p853S1Gd6bpbBoTdI6HV0EvN3CdfdDU60fz4ikbYQPCF5zzctfMDrsZgf9xSNLrQSyoq
         Ck3UGXrXkbquqwpOdeKYsJT26KdcjUMnqT3nJ4yy1HclxkZgiji8UfYbFVQ6ktY20/MU
         fKUL0XtF/TjnqkuBxaccxVbs2FzN2DqdYvlkKYKvmddCXHKBdR0SfUxB2MHjr+9bVcuc
         zKoQ==
X-Forwarded-Encrypted: i=1; AHgh+RqHfi5vaJO/EPjRicKc7iL5+XvB93wWHHser5veWL4717ybAvUKDiqO+P9yC0r99yCIU6ARklc5KPRa8DGjolw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu+gmy2DJXF4kxV9QbkwUN9yzYqY6vCaNzHQlnih5mOPEwpMGM
	g/RITed5qTktKk/tzCQYXvIP7v20f4iAVCvfXCHHUdeTszxK3zyEd5AT8z4JTlyXplGng+vLRFx
	J7M12edXUQS5OYqN3JwxCeRfP/sxZ3Wo=
X-Gm-Gg: AR+sD12FgJJkTSXDCaTQ/8KZ6shgyDohBkYBhTMjbrGcyga6FxQHv/0w7Lngs3tN6e0
	SputS/FYCvdDKjL0E8ujwwI+RjyjyOrJfYiAb4u60lbnwCaA2pXaIcQzwZT4k4ebBXbH/R5/S1k
	lQRJvxfh1IGmG6+Z67MkHrzFsJovMJgC4azteYyM3881TKUaVvRf6M6j27xEotF/xFl0TJ/B/0N
	wpBJp+QBSdp5BQl1CdHai5j5g9vR4Hnd1FEyWCFxQjitPgvbla0MTtCRKkLiht4S0XkOpuoqYYX
	VdxRj1qTplpDCtIKd/z6cyOZAzDcB0ZjKtpYLgtZKNAo5+xSb7HW9Nq/BMwvp2Z93eu+aF2kVg=
	=
X-Received: by 2002:a05:6402:3225:b0:69c:794d:4866 with SMTP id
 4fb4d7f45d1cf-6a0a7cfa5ecmr1146962a12.4.1785568178487; Sat, 01 Aug 2026
 00:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730092331.2069741-1-nicoyip.dev@gmail.com> <CABBYNZKgxz4JbKv8fgTeWGEGV0P_pPmcy_YG=rLDroc_1wu==g@mail.gmail.com>
In-Reply-To: <CABBYNZKgxz4JbKv8fgTeWGEGV0P_pPmcy_YG=rLDroc_1wu==g@mail.gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sat, 1 Aug 2026 15:09:27 +0800
X-Gm-Features: AUfX_mxuzcrXs9LVaK8RQ1P98mW6v5EMpHWj4MnqI6Wi_83WEfb4xA_oCB8RnfM
Message-ID: <CAAo+4rVpfTkGL39Od6NM03bOCoeJZ5dt2R6bWR+M52-Z7FP4rw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for your review. I have sent a v2 to ensure
hci_clear_event_filter_sync() is called first. But I have not got a
clear way to solve the issue without iterating the list twice, so I
just add a bail out when num_entries == 0 to skip the second
iteration. Let me know if the patch should be further refined.

Best,
Chengfeng

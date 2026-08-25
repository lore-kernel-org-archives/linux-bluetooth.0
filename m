Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3F481640
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 13:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665254; cv=pass; b=qd2UF1ws0xXFsk7QREPC+W/FZkCWJPp+WVppjDwXGmkMzW8xUUgzba9HywZL63TmD68VpdHOG/YPr1Z8ZLiZrOU5YV6V2aBA8vkQIqGWt0pI+W9RAL7sFTypYPuOH9QCF/CmaIAstXVVCG9VfNyjxQT5/E9hUiXsmXmURbvGscg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665254; c=relaxed/simple;
	bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg+JvgyPh0Xy11N+oS6t3V6pfQ/Bn5tSkO3DlbYBvjuxZjc0ZMYa8P6LSLHu0EB2qNeOCcgJRifRJpPUivQ+Dx+0ALpbaAf6FOtYKOTRX1N3WyzkhLCfPAQgUt1jzXx9KLK2VIgevTSeDeZOj6U7CPvq+WqE7d+k/RK/SIZRyoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eByTozo4; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eByTozo4"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso4561032e87.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 06:40:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665250; cv=none;
        d=google.com; s=arc-20260327;
        b=YnSkIzRWihb0x1kWtQpxw9LRh5CwbJvXTLFvBK2hbuiKNL8LcaY2qVaIUcKJ8uPpeU
         rRYByo6sZDpoCz/tEBtg/w76iwYAqDB8zMTQGfMGmDuS0ebWWS6vtefVUaYRu3l20gat
         Fu6SJXu4cfe+Q3wCtt5ecj7fES9D8l+q9aFVtgkQ7aXtBuswDu9ICT7E8tWqLg6yhyTU
         SfeRlrRrBHTyaV/Ko09Ilbz5sECi/3y6ngCvuIu8gqONfEVBwOmPDd9iNeLsJG5C4EqD
         9SOnzdDZ15oewXuON7n97RMmCOy+uXRqFF1ftQEVyHjk3sfX9AR4o4OS8IkvHcEL1XN/
         b7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:dkim-signature;
        bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
        fh=uqwdSeWg/5GHftLlRRVJKeb6lqWvWD5q09NOjkqbqZk=;
        b=MmatU2GsC9rNR0fdX0u0SnyEP3ene8n9XIbteYVz/rq07HQLPFFgEiTFsa2IwfyO8U
         ui0wfqRN2SzYs2EHu1YBqSwc+B+9Abi0UvytqQbySXq0eq/6TBkZvEOcyq0I/WLZOU2z
         ECR5H4L7w1xOskcmyFsKFPIhLpo842JQBTC0JTVgf4WDkFPa36FMqEvt0vblwBIWaxTP
         jLrmmXEC49KznICHNVg6oUz1EdFsHKqRIpZBE4idmHlniCUECLNPhmgiAxc/l99usolu
         UDBFv8NTZ2GIliTpEI86NlpA4kGu4PulSo1Rgz72lrMjqYPO5AuH5RKsiIjYRlzHlwwO
         sYuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787665250; x=1788270050; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:references
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
        b=eByTozo4EwWCk5mAcBWZaktfPVnJehwLLuPYKY4OnfQA5UM/D9zqZejfFJ7dxXYqw0
         921HEW33MSY8pzRmcm7enTI4KBkkph2l0obH2vZgOS9kBnuM+V8sAphs+DmkrkCdvROY
         CDfF+4M56UsFofGmLY+Ao4OF+XPP9ZSWcs88/Ydeqe9SxJZDx67GY9CtyeGHYOrh5M1X
         tyTq621MQCuOlYGu53TCM1M5ULNalrpBTplWcDzi73Y9UiIaB32xekhS6MW0ATenInpK
         RJW8w9HYvYflSdmKhDq8tCV16rsDgAZpwh9PN6s4/CsoGjKFcK1yJM2UA2E6gtgdZynN
         fing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665250; x=1788270050;
        h=content-type:cc:to:subject:message-id:date:in-reply-to:references
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hvKyXzgJppJMaaEEyd99Thc93IbcMAS25L7bMTUdZT4=;
        b=dZVz/FO3isynToXuJ7dXg4S0uV+G4VIdkmay5/s+8F0JBvnQFdDPEx6bWRuMNuvSEX
         HBcdF/qoDLSdmq/llDbVKmEApnw0sadgHxC/vytsTsFWdHQNTqfOWBKhUp4sAQ5vUDtj
         BxLdReYvxCnrnyux0UvRQx9TZ9Ko1Jtl1Q9ZefMQxtEMAMePL5BU5hRifaGI72PDSjxt
         m+adSrD8I3zL3DvMgPCNo6vcflGGSzsX9oa/wEk1OnNFC1SPtLKel+QY1LitSvdekOcN
         r6NgBaVW2ptf9dQF3/na1x81g4zSciVzdBdLKXjhPZTe+7rPd1V+OZBG19AfKuWEiftp
         bgng==
X-Forwarded-Encrypted: i=1; AHgh+Rp6eXmnTaKDynVy/E4rqegej5qb7QxjAkPYKflzux/wD1t07v41Sejd3zgg5CqF9gQHTdGUYyqhDgCqO5WoF+M=@vger.kernel.org
X-Gm-Message-State: AFuF++leBpqz1G0iL6qd1pzgmx+TGf4xBb6Bs2YjJC2z5/U2NA+GRINW
	Mn0+XLMBphLymFsk2lPqgO8z2ZXKhdBrb4VRerTEHG5UjrjnW0W1+pqkxA1xg8s1yYNtqq5zm5X
	o1Xpjb2kgNp+C9FBQWxxuSgK6KAFya6Zs7gT/
X-Gm-Gg: AR+sD10+MwlwX3KCZNHRcoUz0bNXaXWOUJy8k/EM9GXcfvaY+N/PPVxiRpTes4mdF1T
	G3L2JZHU/KVFDgUA11vjYmSdrv7E93H1evzXCiqh0FeG6z8mcle2X6ob4jFJtRgHyHmUsZJeUbL
	n+bSNrKq606+P4MlK1EpX2rzFMheFojyZpxZaJslVbzFKf6hbvXw6pNvJeBeAEGbIltu0tITfHQ
	wYbE2Ioobus5/ijSKLhtKi7cCEHqrD+ydMHFg6hGYDuWK9xDSQNhHO+dZeefnUqhmDthv6w7mZ+
	KKXUCPNWBHm56s9CFCW+EGmvGWVWbdRB5jR2wbkTDfwEPwAGTRLxEb0BRXD6qdXdZDHqHwaKwtW
	GK5xPaTqRTQk8lH7D/kpHxuQF7e9oeQVTVWX9+YVSofVf3lQrTAvo0OSKtwoK
X-Received: by 2002:a05:6512:3d1d:b0:5b1:5a31:86b2 with SMTP id
 2adb3069b0e04-5b4842513bcmr10922031e87.16.1787665250199; Tue, 25 Aug 2026
 06:40:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 08:40:49 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 08:40:49 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Kamil Serwus <kserwus@gmail.com>
X-Mailer: aerc 0.22.0
References: <20260824053227.317496-1-junjie.cao@intel.com> <77f94165-3d5f-41de-8969-c7318284fd6a@leemhuis.info>
 <CABBYNZK9ax+iw7xKBtdZTSERsdhQ7t41Bg_1EnG88KOYj6kFHg@mail.gmail.com>
In-Reply-To: <CABBYNZK9ax+iw7xKBtdZTSERsdhQ7t41Bg_1EnG88KOYj6kFHg@mail.gmail.com>
Date: Tue, 25 Aug 2026 08:40:49 -0500
X-Gm-Features: AcwNN1Wug9vDtoOA1TaKYTIovtZeS8SWGR2PbmXd3NJe-LYW9VPQ6Emgzep44ig
Message-ID: <CAO+VTThX-p5sT7sDVsr+Yqf-rWBdWHEBdEyWvDNbqZnwdwhfvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to 0bda:a728
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Junjie Cao <junjie.cao@intel.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexej Sidorenko <alexej@sidorenko.cz>, regressions@lists.linux.dev, 
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Kamil Serwus <kserwus@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Dear Luiz,

Yes I use this version 1-2 days. It works for me (with reverted code).
(as the same as before commit 5ead2063611ae56809b1b113ac44cef9547c81d7)

Thanks
Kamil

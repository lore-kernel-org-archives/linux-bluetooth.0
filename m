Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788119;
	b=vtCDnJtiqFu1h1qHxXclZQcdaCbO2vKF+k7YP/A0Br1KGA5PRu1fcUXLgT8MN98ox/JZ
	 NovlQyN0rpry+DBYVVuVQ2VGYyEkNGYpc6i5ffXRDrzvF4n9wGdnGYECASwa2pz1+fBh6
	 3A1topNpMcMor5BBtkxp14AGxi+nizsaqDIusqs0+x5Rm9pFW7hQUWOgAiYTJ1lNMsBQv
	 3SIJVQwWNoKTQpaH4qjfNHswIMao+wJhktf86aJDOSoC6uoOtBPE9b6jxhdYg8TE+a5X5
	 0gCoZixNoiFYLpBmAqWEdwutUCoHwdkmB3hfd0vpuXLC287cd3cRiWINXJlWvcOAFVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=RZBOB0tObjhQBtMIQsLmhl611OEppZ8hFC0Ae6hO2pU=;
	b=M8xSzXTR08YORlVoKI/45DJdhZNkAjqHjsfI/r/KQdUXc8+uV9D10rzMX0PPUmuBlkqj
	 /H0yy9lp2jz36BxsQKha8aee+2mWbNP7rJ9/kdA1+DymEo/FOg+3+dxs497KZ1R7lhvKl
	 M3O72JS8O1mMOLMVIrMzmmgIe3reb4S8q8HOEqWgJEzFVFstdAg3t8Viplfcu9hUK6MRd
	 XsI3gqE2nZdilQRgFvFhwH6LcpKjD4HTu0TgJ4Fwx61QPNnM8wxqwZANhNVoNMo5Z1Q60
	 I0btH1ROlcOT5MES6kb2zDZZyjRvMX2JElaDBh3nPSpPerIz3XYC49T8YMa6HtwOFRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+zUmi4V;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A8606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 14:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C2A8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+zUmi4V
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-844a8bf7e25so4380334a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Nov 2026 06:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795788117; x=1796392917; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZBOB0tObjhQBtMIQsLmhl611OEppZ8hFC0Ae6hO2pU=;
        b=x+zUmi4VXhxnEme8SQbAlDK1YU+i3Cy8FhDovBIh3oSC+LVdEW1eckaX3CRtIVUXCQ
         lk4iPTFKBMWm5fY0TrFmBD0GlsYRKmJ/lJg9a+/Gd8ijAmk8E8mVk0LAvCI/+l2WN3YA
         ySV9ycqBkWL4jIZRBDxC0r2CIbJXXOFyMEdLHOy6yLCeMUHb9ptmr6sms4bFMsL3mqoe
         5BjcdcJXZskZla/f1WrI4LV7z8qkOnnkqus54xRou+tv6KY6xFKUi+an8VObL4IrLvgJ
         77PFZQgbUnVxuPn5DfqkvOwCjWiS6B/UJR1kI+2gEjbmWr8lWKlJUMec5kFeZsnqOsV+
         cvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795788117; x=1796392917;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RZBOB0tObjhQBtMIQsLmhl611OEppZ8hFC0Ae6hO2pU=;
        b=m0GOLE+LwE9Lal/aWuYPVSLBDX0rjOittcYKwVIPqmFG5BgfDsvNUno8iEPL74tkkI
         pvXYOA3zRmrZFbzAHUF9Ey6vIi2ESY1FjXAdv616SPFtB1shPMfisGJ8iawWhb31vGWC
         g/1eBaAqEdMQdriAn3Ai0zjvrxdQ2lCtvwG81hA+vMXzwBuAdwjXqotA3TpwhXEzmkCt
         2zsgQPVPWyE20zEzlQTdTDIMGmhM1y8JGRCg/ZvnYc1JbwD4SrOE+7Wqvg/QHryESk6C
         wCO9+kaSjtZTYx3LnDsng4Tsbm6UGnGT8k3NXGZwa/IXCcpqFvsRrpfNeuOPbQZbrADR
         tEhw==
X-Gm-Message-State: APuU4Z9deImLduk4jCPxpoFWvCQk6/Zy82pOZ8fSkYVPUk8F1QXX50op
	m2YmjCSzUNSgujY8rIzB64ABLuI/bPN5Cs8U6HCZIExWgt+e24ADiOZ9VNn7SQ==
X-Gm-Gg: AZFdTZdY8cgT13xUQucrYsosP0sp2sNcIhoHiNxwbIWmd1eAFnUCdMwhQnDwpotl3pK
	7ndLZX6Upl+DwdP4/fmAoNJsNZKr61Fp/QQVzjjP+Iez7GPparmngF7YvI0tv0O3z9wV8Axv6Kx
	vatTmyxw10TlONyMPKoet0NQro0GDpqMCoFx55K/GwBRvtmRVuEoJIvfmL7PG3c2UNj9OycsRBB
	0IpFaYKBvCwLiT5y8e0wUE+OhKIK9EQIsC2IJPTH1QsIxCf58PktMw50b1fyQ632dDHUJtNIthH
	c6DeF7hEaOVpNW7gkxzImi0AX/9wpOTZEZHCrZFPrdI+bPhvcbz63aQ8PMFlQTsCvZoC2TM6z9g
	xisqUl/+Cp6Q5yt3uoSSx3l3Es28GZT36rdvkJrI5oJ7Hz0JFfuyDBmUJkfDEXJIl6uCd2cWNhN
	561qTHOTPe43UnddsIFOHfIZ+RHFeCf/4y7S8TJr+IFZe581qYW+zswk+aExl2EbHEFuuUcLhwg
	dmS6KI97cLijGehlJt/mBjMyUgstNJ1nVXmVRgI9IwZTKImXVm9N7NpfEAm6zrq
X-Received: by 2002:a05:6830:2b2a:b0:834:b015:ae9e with SMTP id 46e09a7af769-86315928296mr28254025a34.12.1795788117356;
        Fri, 27 Nov 2026 06:01:57 -0800 (PST)
Received: from [172.17.0.2] ([52.242.242.182])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dcf38sm16976549a34.9.2026.11.27.06.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:01:56 -0800 (PST)
Message-ID: <6b098d54.be725b5d.1246c2.7077@mx.google.com>
Date: Fri, 27 Nov 2026 06:01:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0058716114314758569=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: L2CAP: Don't lower the MPS of a credit based channel
In-Reply-To: <20261127121317.2377676-1-simon.mikuda@streamunlimited.com>
References: <20261127121317.2377676-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0058716114314758569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1224429/

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.27 seconds
CheckAllWarning               PASS      36.11 seconds
CheckSparse                   PASS      39.35 seconds
BuildKernel32                 PASS      31.83 seconds
CheckKernelLLVM               PASS      35.45 seconds
TestRunnerSetup               PASS      767.05 seconds
TestRunner_l2cap-tester       PASS      14.97 seconds
IncrementalBuild              PASS      30.50 seconds



https://github.com/bluez/bluetooth-next/pull/1243

---
Regards,
Linux Bluetooth


--===============0058716114314758569==--

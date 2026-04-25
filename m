Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2EE301465
	for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142305; cv=none; b=K8fH7sDtj6GFqdH64wIRn9ZIkz32yEZmeer49hFFrJENZG1VbF0EF3NGkz53dCyPSJsO6kyGBSl7Zz58yFo8aQu5ajjVV+kf5T8O4GdH9j2x+AqpdEsGMFRZblmrjFISK3tB3l8tM2FueKoFTANMBKE/xUNDOxaDmmaP3RVr7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142305; c=relaxed/simple;
	bh=c4wcY4DflAkXei5Wpn1ze9ubgruKYXYEM6TZPtWvUnA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RIwzAhx8qN50uBcsic7OkHjHVi4iDg3c8hPvTQ5cqyzYS2/MlB7M78N6M7HJXGASIikoaq/iGny5SbBMh1mySF0xuEOKbDHO8c+zQg0etbfK0RUcd/nWMfZXoERumRDC2340H2EgU9ZqUhjN31ZxwX8x0dWfRb/i5w0ppoHnnKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUajOIIz; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUajOIIz"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89f87257904so74495516d6.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Apr 2026 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777142303; x=1777747103; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ9wdAeOL+GA/f4KGRhpJDO6dodiNyShVvQldXMgar4=;
        b=KUajOIIz+Jz7qI66FWbjpwXQZgUJoKdP5MiwQSb9YJV6q+FqmuEkOaOZquBerw6gDA
         IN63lEWR14quYIAw/Am4h7zA4TdM1phLqf4ye672bxSKksKE+w0mj3sl0c4v7nNr/ONT
         3Z1Wxuo+VJahwrwYUwShCIZlieI6wBcK5dDNjNrjMyU3rQop7ksk4+HmvcOAgoX+eTyr
         jD82BlBawVDhyf4DKAv7+l4rrkZrPgOxNRTHhIFieW4TuCVbrMYC6mynT6MKCCA4uMwS
         Czg6X51bNDi9quJ12b5whz246rT8n9QSfIBUFwsXdXjq3r0byYLqHk8ygQLTbnG3z4Hm
         NJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777142303; x=1777747103;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ9wdAeOL+GA/f4KGRhpJDO6dodiNyShVvQldXMgar4=;
        b=GvlX8aveHLcv/wMOR4r3V5pgZsitTajLDLevE0GTZLt73hzlWj/UsiFNoAuQVhEOsv
         vsGOFxeW4wU9hC5Naxvtmq1fyydq5X3/02NccI2ZqgQnlVK1It2mCmZmMoO8yaSrHupR
         YZJqbcnRwAcdsiGvWSezLlJG0Z3jaU/isvaelMKc3RWi+SSknXJ/oZrHcXkumwlwKrPj
         gRNrDhcEKzhRFUea5z1deYvU2A6xd8zO/TdqR1TeBiVx/BSzoPts7+EsoWTNjclJFNXT
         OesuCPuOfsblxc5zRsLA8kY4v0FhbTCcHtU33vdqkRqAHPApua1YEynaTIa7zNbROSw9
         UZEw==
X-Gm-Message-State: AOJu0Yz4sT3dc8nqzJJWEJWR8VpFMP71nj2S9LECmidU8zk7cW5UrFfq
	Q/clDUGIt/E5+mGPhwSXJpFqFXQ0M+1knplsVHVSWldYaaaWqCP6WSyrr6+8KA==
X-Gm-Gg: AeBDievGNl/+WjpIXQL9hoFfytw2yyt4yUmuEeMxFDxWszuc52p6uxwTEXogqUw3pHu
	tdZFllcTJlwz3z+rASug97qk/uGXgu7lEJqb1YigOxMgjfMCwJLzJ4Y1bgan3PhqUYzmbwwpbHL
	ax+bgeCuyqJQw31Zs7oTLbKVxvMDJab/COY+Y+KG/UiCNpclxgLjq2sNplO2+JgPMYdqz7oudN7
	BzQFu4q1QcU0t5rzdCgmIbvZxApxAphb5yavhC2CKom8tqvKsTYefuT6L9LV16Du/WO15bVumX0
	ZF1fZu2T3lPwsZJA9FdkI+vjogT63S/H6kcpvKP4KlUjokvQjpgGtJxQ/edRnFs+Gw3TQqxZ10E
	7R9+otlozZmOEblCvA/NSHUGfLP+He4bfpjl5Bzygz+2VimMEyjhj3U6WqriuEo2t6PAy4Emosm
	95EB0utFyZ7m/QwQ7iHWV6s2YSV7+E5+dT78Baysjc
X-Received: by 2002:a05:6214:4a84:b0:8ac:a5a7:2888 with SMTP id 6a1803df08f44-8b0281491e7mr543546756d6.50.1777142303351;
        Sat, 25 Apr 2026 11:38:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.47.50])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac77546sm205423836d6.17.2026.04.25.11.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:38:22 -0700 (PDT)
Message-ID: <69ed0a1e.d40a0220.210c42.5940@mx.google.com>
Date: Sat, 25 Apr 2026 11:38:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2803606557709507229=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, agarrigues@riseup.net
Subject: RE: Bluetooth: btrtl: fix uninitialized scalar value
In-Reply-To: <aez_LiwkX9oS_Nty@lal>
References: <aez_LiwkX9oS_Nty@lal>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2803606557709507229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085529

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.84 seconds
CheckAllWarning               PASS      29.70 seconds
CheckSparse                   PASS      28.22 seconds
BuildKernel32                 PASS      26.14 seconds
TestRunnerSetup               PASS      577.33 seconds
IncrementalBuild              PASS      26.22 seconds



https://github.com/bluez/bluetooth-next/pull/126

---
Regards,
Linux Bluetooth


--===============2803606557709507229==--

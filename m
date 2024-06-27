Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841401946DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497935; cv=none; b=SaEAwYW2qzjVCrGi3/46ykYGGW6dluSzz94BEkFBI9QMKLyU/uPFij2wmIHSScMtNVC2G33IU6Tmu6QiDVUrFtBjyADtJ1YqoB2dWZM5ObhfuEix+xg0usgRs2KLouB6xPId9DIeq48EuKJBD7eybPRAegN9l87kKwUo5eDNdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497935; c=relaxed/simple;
	bh=zLLAqEHw5dCF5OXIygnlXNqoTgJKhxXqJj65WHH8xpA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qXJBhE7/5Qk58kAsMJ/u+F9Fwp2EGnj6zM0hSTIPC08xHYxTlVIX1yvDHYNEOM2A2fiHf/dS5WG83V30+qW7x6TFl3xta0q626GlpciDbL71Mz2Zdov6w5A0JRb4c2HuJS03lLP15oYM//CIMqTPvp6zrI+9MEF+6IHYaN+aFs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLk5Fxza; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLk5Fxza"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79c03abfb18so174248885a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719497933; x=1720102733; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/DSa+ivVnC523XvP9hIazoqu7XulX5PcSFtSzPR1OAU=;
        b=QLk5FxzadkU8P9ke5HqvI2jmr9G6sIo4DtFNLWhPT2K/yLMdH5JxJsBksaZvB5og5P
         leiiZ53RosB8pSJlRmuzFhPpgfSn5PRV7WCrkkNYFAEBvBpdFVCEGv+fQYh9SvBGnROf
         TDivGoZsPX9+CvkVh2n4iiINLlYdjSaF8/TxPHCl0FMnkANv2P+kOSgytJClFpb1yHRE
         XyWxJFRWAgNsQ9qW0u2M5KsV6blrdckLuDilhp9EKlEeVlUvXEs2PecRUtD+JmezpFHv
         epAx05ynaYKGrKVYhJRHEPlG1Gl++VxmLxjTePC3VYZm86oGcCJCok/bOE7kw4wFwEcD
         jmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719497933; x=1720102733;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DSa+ivVnC523XvP9hIazoqu7XulX5PcSFtSzPR1OAU=;
        b=kKUF6W4/iU+gRcNJnPhgweyfc6xWE1Svb+PCMfDwrkhT1+LrUEbqbLRBHaqiRHEaTm
         UgUCe47R3T+sssUx26+OgW1ClgyF/UqPnGgSljeOSYb+Z+SOQD+4V8fvMszTppGxNnWu
         dTmTD3tTK5UizJfEp+9Y1SLznAykq7bufhH3GohmcdBhrhEPUidOWSmzIMzALydYQJcz
         PpNJVaNO68TINNfB9FT9XlTjKRy2Ca5bDGYxVuQQyHkYrs6sjEWcD9SgGL1GWLpvlcl8
         u8z5P4Mgv0Mm516hVq0XimH3/K6yq31ZgH4dzz7le4wpqOfDPEgJKjz1OzEJiFeZLZkT
         aziw==
X-Gm-Message-State: AOJu0Yy6q5lN/Hwq8qeQp/T0kS3FUbEQ3HOYKPxYUmjzwVllr53sUUGG
	l5YTGzSggXd8wJUy3pWMqnMBXER3oXWsBy/xlsMOGlhXvQb40qF8dZNAZQ==
X-Google-Smtp-Source: AGHT+IGsLdxZ5aL3sNBmeCzFw14kORy8opYPRzb704PyE09FaUz/fKFDMu3YYn4wMxGOUx4xqyWaWw==
X-Received: by 2002:a05:620a:1998:b0:79d:5428:22be with SMTP id af79cd13be357-79d5428496dmr447019085a.31.1719497933370;
        Thu, 27 Jun 2024 07:18:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.191.39])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c7fcd48sm59063585a.31.2024.06.27.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 07:18:53 -0700 (PDT)
Message-ID: <667d74cd.050a0220.33ee8.255f@mx.google.com>
Date: Thu, 27 Jun 2024 07:18:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0202882453525030100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] plugins/sixaxis: add NULL check in setup_device()
In-Reply-To: <20240627123935.67784-1-r.smirnov@omp.ru>
References: <20240627123935.67784-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0202882453525030100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866143

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.69 seconds
BluezMake                     PASS      1672.82 seconds
MakeCheck                     PASS      13.57 seconds
MakeDistcheck                 PASS      178.25 seconds
CheckValgrind                 PASS      253.30 seconds
CheckSmatch                   PASS      355.08 seconds
bluezmakeextell               PASS      120.44 seconds
IncrementalBuild              PASS      1448.99 seconds
ScanBuild                     PASS      1009.64 seconds



---
Regards,
Linux Bluetooth


--===============0202882453525030100==--

Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE615821D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370123; cv=none; b=d5Ny5SLmDUX8j2VVfinIPG0okJCGtV1AVlXhEKqwdo3rvCsviqStBA99+4KMze8SpLB/34MXzoV3ZUahBMEZUiwp1ukxHM1zDEkTCp/3epXIRwlD/9Dz06NKvIJmgPNHHdPO6p/RHJuO3pyJaALya+XBKK4F6FgV++2Z+6bvShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370123; c=relaxed/simple;
	bh=jYThFcYRSiGL8Rb9W8ocbvHrq0g9wc49VWGVg2trR0Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ymrh4K2n7PjW8dcJWoJuRJmhLbMHqvJSQUOQWgLiG3iHy1UUWGQ0fThj5RH8W6lc+hB3gn7FJf0NG7gURs1SvplYmCOqQzT/uJPtAkEYbs0M9pJC7Ffyi9N+Oyv52pAv7c+MQjfP3QJeP7280Nvj96wOYhzxEPB0eBXVfGIGm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTsEwB+2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTsEwB+2"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609fc742044so45477357b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711370121; x=1711974921; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RO8jwIikbuqZKNhm3AdnZ0vbvgwsHdvDCyfdoquQmYI=;
        b=MTsEwB+2qc05q4lDebPUxUqVyd9j37UevPlImdkFCsQMyd6iWtPOj8kTdOh5RWCOl5
         Lhz7wGxCVVQ2SKrZKe7xRL5mB7pR04zvPn0mK9fEXgPKImfdhkX0S2pE22HDOUb6qfHh
         +vrcOR4qohMoNkd8dk0f9vhrJG0dxqDiRv74f5cr4rICSYcpjrjyttSAkxkcHhbzRaJ9
         g04kuIpAgwNjviiiYjqs4UN4sW62HBUr4JU0lpP7P83ZnlDN3D8Bkz7Rjrqlbmx6C3pg
         hPh1oCl1FiLhA7kiXa9RRMbaE5SQ5a+zRd3qN3Q1iiDbBV7foPfCDUC8Sr5FUx8BSZaE
         LGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711370121; x=1711974921;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO8jwIikbuqZKNhm3AdnZ0vbvgwsHdvDCyfdoquQmYI=;
        b=omZ7k5AvI6m4i2oDT4NXoUFO67V3Ot/9wTdGTcFzgozt5myuy4G3rjD+v4NroH+k3O
         nyHxdA9OcDAoXEYw1jbSMeTxuPKr0EBLnWwaNzv9z3fWIUTviCF8tzaR2KHGscfYuDK5
         R6+JHgOnyEnJR+0jtosbbbpvPSQVJZA4BRGB+Q/H5pTxnAdomDISKt2jV8ZWZaBfC3KW
         Cl3hTUfkZHuLe4DejqUZK47+x4Cl5zBYd62lAEiNO4z0OZWzFZgsYvkzwpWFr/9tZdWD
         VQxDVBRtSH4UuRbl6wBg5vRN8QOO5fiOfLLttBYEAgVixHaNelDgPeJ/jTPWHuL8gaqU
         6dJw==
X-Gm-Message-State: AOJu0YxMh0BfZHgrlVmKmwzzhvJscz6ehLC6O6ORuBTXswuuPtVX2bpT
	DHpRUXDak2i0dC/xqrqYKuRiyARZWTd421ZhRvhl2ZqmFIgQWkuzKFNfEzyd
X-Google-Smtp-Source: AGHT+IFJ7q5P4X8GRz6IHEKW5vu2EsbkEU9BSFSGs2wcK439qmD865dFKZKXU73CqtoFWYnuYKYZOQ==
X-Received: by 2002:a05:690c:f16:b0:611:3b60:d2f9 with SMTP id dc22-20020a05690c0f1600b006113b60d2f9mr5427665ywb.4.1711370121001;
        Mon, 25 Mar 2024 05:35:21 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.161.192])
        by smtp.gmail.com with ESMTPSA id kc5-20020a056214410500b006968a6fb010sm1388810qvb.91.2024.03.25.05.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:35:20 -0700 (PDT)
Message-ID: <66016f88.050a0220.5e8aa.2dbe@mx.google.com>
Date: Mon, 25 Mar 2024 05:35:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1531166577135420795=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, howardchung@google.com
Subject: RE: [Bluez] Advertising: Emit features property update
In-Reply-To: <20240325181004.Bluez.1.I8b0ed6ef2fa5a273f990a5c9f0872aaa539b8b39@changeid>
References: <20240325181004.Bluez.1.I8b0ed6ef2fa5a273f990a5c9f0872aaa539b8b39@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1531166577135420795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837824

---Test result---

Test Summary:
CheckPatch                    PASS      0.40 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      23.75 seconds
BluezMake                     PASS      1595.64 seconds
MakeCheck                     PASS      17.50 seconds
MakeDistcheck                 PASS      172.32 seconds
CheckValgrind                 PASS      242.30 seconds
CheckSmatch                   PASS      342.79 seconds
bluezmakeextell               PASS      116.93 seconds
IncrementalBuild              PASS      1471.63 seconds
ScanBuild                     PASS      956.57 seconds



---
Regards,
Linux Bluetooth


--===============1531166577135420795==--

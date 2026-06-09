Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EF3FB07E
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023957; cv=none; b=BrPcvMVAyu4ApfpmlVrIPjhCEeSCeogBu3OU2PLN2vddnvS7HTeT/pugCrSrN0aBaVEHtd/UP7HVXfOhFZUJSwuhDfVkWdKhwDLqDPl2vSD8uGpKueG4ClI3pRiNZpB/ycM+CNCJKiIt0AzU2VWW+b4JeCo9cmd1zmX5k83yf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023957; c=relaxed/simple;
	bh=HNyL1Tn9+3aewgDbSuppuIo4SZph+n97quIEidUGSbo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YgMTpdLKM3EcmJJGoX/wraek+G3yDe2kCMCbpYRW8DNfM1jSHd1PszKc69BCxD9kBVu94y93nghaX6WLJwXIkewlHHAEAsvIjKFunNbKRdygXYPCCGduEJ8zPG6z/IdHui52SrDs3BwfRvkyZaSlyjJLrcS5RdAQh1kSginWtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwdPQFZg; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwdPQFZg"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137335bc3caso7132125c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023954; x=1781628754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HNyL1Tn9+3aewgDbSuppuIo4SZph+n97quIEidUGSbo=;
        b=LwdPQFZgnKSM5fboIJJCHaK1t3yhzMGRoPEH4/RuaN/SrEIF4N4IqcWkSuzOhu7rYD
         Yx0MRrqEiQ/Z59gPqUbeiwISCM25fcs8yu0ciJaqWmpau1T+4YFfLmtOt9NbIMMamaWT
         OHHxDnAf+SUWBcfe5H4ABOgfNKqCU8bEms/SFpatN2znMgvCw4GQ+3tsoQx2Q3ghf99g
         2qDwNQzSWQld8cbWeyl8CXb/zR6qaKCxbzCq4lvQ/6h88/2aJgkT3joOqRzO5sAGS9bT
         hxxdTRXInB0vf3Bec+YYhRGkiUeXjF1mwEAXeJ+uUIQD13Za+K/KByuBBEYRJMgndIs/
         aZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023954; x=1781628754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNyL1Tn9+3aewgDbSuppuIo4SZph+n97quIEidUGSbo=;
        b=i4neH66j9EtsdPbNifXDxvUDFo/Kvb70IzD38us0Pf0mEIIEa/eZLxbjT0/uIS3BSa
         gtrnqLXP7c2EpcWktbI4Y88CGPgIWwDb4O67NiU8wtDeF+rNZaZBzVaZKKm5Mx1Cj/Xg
         1A7wWR2oDwYBSTcWDlmlHKFSKCWffLzVQCvA4kSid2X3MaxJRL4PXogS26AUm1F9vt+9
         Rmg9G9Tvr+3Zsw1jiLurT6YQ7w36Y9eA+V9weMwMfzBD2/e4WnVogFCa+NWQc7o2wmaW
         N76fOHcpCUiV569oCvySGflSgYsgxbgbvoryUGOnA7R1O84v9lvUy/Y7JZ6biIrN7aPh
         f2NQ==
X-Gm-Message-State: AOJu0YzqpkDRT1/D4mdvYmMfopbPvFzwwiAvICr98LopVF2MDrlLb/4R
	ga3HGkqyl7hABDqPVL5FG6FowjVfA149VPISFsc5KlXRjZ5jnRx7T/EhK1WeXQ==
X-Gm-Gg: Acq92OHf/hO1Ml2sbzB5VUHQ8k91IM8slMdpdgevKhd9PyJTqPsc5Q86rVbc92oMxg0
	M+zz0U0absaTdl3CRVN8xvwYazgIF8mJkM4jEHe+BMl/dUjQ92QJBjlTlr7Gr5Q9V7DW9XqRN9T
	1u7+5s5xqb/YIjn860R0l7lSOOtddXmqACgNljlthysuZo8aF5tH1KO3rVki2jDomolwbGasORq
	SGCgqAZdJXTZw2uPq91tt+x84qiMiBp/RF/5ljkU0JyD7GAsftpnLBAZr81JFPUHM1dkMxQ/Npp
	x7/Ax9ZCwfQ5yDGA3GDYDBt/+7Yrpozqsr0nliolyu4JrU/OMDz+X3dQJ791ZotK7iPd2dC2Otb
	wvetDhBmph0ZwFVzFdazmccfmN3gbFYagB/6TS+3xyw4Zk7G1WLuNeYmQ7Ddh4E9Tg7DgQ7Va80
	30BbQcPEa1TunS5fxpHO38jQQRpK8C5jU/Ng/Jhg==
X-Received: by 2002:a05:7022:485:b0:137:9ee5:208d with SMTP id a92af1059eb24-13806708cc7mr10528138c88.33.1781023953992;
        Tue, 09 Jun 2026 09:52:33 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.42.72])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13803eb106esm12353274c88.5.2026.06.09.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:52:32 -0700 (PDT)
Message-ID: <6a2844d0.3d0beb03.183b45.aa8f@mx.google.com>
Date: Tue, 09 Jun 2026 09:52:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0592358469238059420=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Separate coredump work from RX work
In-Reply-To: <20260609154617.218747-1-kiran.k@intel.com>
References: <20260609154617.218747-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0592358469238059420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:1426
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0592358469238059420==--

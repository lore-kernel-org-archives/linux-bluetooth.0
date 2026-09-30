Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF474F85D1
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777378; cv=none; b=ahdNzxC4YCKqjjQ2Y1fge4w4NF+Hxu3qV6FUiPZJ4Z6THrFKzFPE2IWxXwPuO1hpL/1fH1Bt/5eeUmoCL6Q/44GFkalTotZ+ZfkSIxWNsggvi0M/peLsVhqZnzRRzls424XAfA+shSBrSUR23cLfaWc5lNrC1+2cnHNa8a191Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777378; c=relaxed/simple;
	bh=crs4U5AcE5IAWSQGhzCCqlRY1X3K9RRsue7u4LiRl8E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ACqos2TrnxnyCXS2X0MtCRRzXyKXMQZ+6+1+Deb834Slh8avGe7/e7v2tOV6vl8pmjPTCBQyoGs2fstryS2gmE0YCochGwK0UrLO+5BCPeOw3CE2lPcQRfrXBynYCHxCY2WFiW6ZDYzsMTH93BgpnzGTpVQv5CPY+UsASGqz1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdhwtGOd; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdhwtGOd"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-34c4a0868b6so946770eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790777359; x=1791382159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rPL/eNuFpH95GYM1aYlZ/lshv8Tc23MsYJFjCb/qZ1Q=;
        b=pdhwtGOdULkacJ2zStTSqW02YH9MSgRptsa/B99xdeQswrBI2wIvJ8lqihEXNnV8H2
         lucxHy6H0e8fIh1MA4M7oifD1RncnvWF4UOEL23RA9+YFsb/8gsXeTZ6pAeTFqyIbet+
         KVe82sUb7mGS9EQKHv/CU4/DAud+tc6pkpb7OSXk6cxsB1YznkYYROuV+YNi74sk53za
         FYHeM/ss1S/vKkhmUSmxGSlfAh9Ys3XGsl4GZKvZKABzqA2QV7JMhbezSyrPGzBtviR2
         CmSbM4vVGnpkWmt5OnunQdVRDcBwbKYOWGcTErt6UNp9ykqB65Q4AdG7nN/agv+P7f1O
         i/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790777359; x=1791382159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rPL/eNuFpH95GYM1aYlZ/lshv8Tc23MsYJFjCb/qZ1Q=;
        b=NUGg0IJi7sunED03CY19WNdWMnIPuaXiOdWbLCxDLSUbWUtqYym/yCKLXP/BcyK0XS
         DTx86ZGGI7OrEpIT7aV/4tXdDP0QlOlJtMJu4dvdWCMv3i0Lwvi4fVqhwpUss2paQ+b2
         RVygHtxrzCfxet2ZR/k9/YfQWgkraUzRc+ROLiDKf6cjx9pYmJBvcj+v9HwoKUq6mg3/
         oAzk0FpK7cLllv7eXVryPjrjCsje3py6DISc9t7ZnA92CFire+p6gGMlzu4e839HIabl
         20hUnaziqGL1ouS/kR5xksNvpWE8LrHN90VMZzZuMGed53z38wvS7Ngf3jPj4NMTyvEW
         D9zw==
X-Gm-Message-State: AFq9FYJEp9JFeMkuWCGD9Zxh3nmmcKdZ45FwkesuoX8eoNSllg2dKWxa
	5kBURX+qqTDsVK4zRj5MCuO27PtYioB0aXIG0uVEcdewJ7otOkGrZQGeuzJsEQ==
X-Gm-Gg: AYBFou1d1vLZ/DVStb8ow9U4iadIrIub1TxZJFxQOZYMG8aqMpmufO/3t37UcX/QKA8
	M509MCybfmxlERn5fEJIRc6Klw2W28s/dEC/CdQYGtX+mP+uIEER6IypGG/DqyUPQH3OjA0HJXr
	54OQEFjNaUKcDJoM0rCTZ292ihs5FUr2z2ZGptsPxc2U46HMsMgQmYScVvOgO2zGh3dV3kJik56
	lomCbBMc7uLyqKxuowFxKfqfhGO27j9musF7wNocLq9Dc5BrVZ0sMdOHWbt4qokofxSYExcfeO3
	nSzUgKo0q2tk9ddT55E8bbdZ4pcWhxoIUPCujspf/zURAEvjW410HzHf036sKVPYJEbDtB0E8W4
	cQfqdn4VAPsG1pSr7vPDZqLrOKqNbSbh5cJu2tAbMmInKVKMhdY7MUe6cpJ+GNZKi/+dd6oPHTy
	DuOx5yuA5mwzJ4QKhavMoKkmfPX2t1pRSbB8XFEB6cmh7aN1PwJVcYywwZ0FWcgYGbFK4anVnAf
	Q==
X-Received: by 2002:a05:7301:648f:b0:348:201a:6c88 with SMTP id 5a478bee46e88-34cddf74b81mr1476653eec.13.1790777358992;
        Wed, 30 Sep 2026 07:09:18 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.6.7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf572e6b4sm5438855eec.19.2026.09.30.07.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 07:09:18 -0700 (PDT)
Message-ID: <6abd180e.de43c058.f8a5e.8466@mx.google.com>
Date: Wed, 30 Sep 2026 07:09:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7029112824109667135=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: monitor: Fix heap-buffer-overflows triggered by HCI devcoredump
In-Reply-To: <20260915-fix_heap_overflow-v1-1-8fc39dbcb303@oss.qualcomm.com>
References: <20260915-fix_heap_overflow-v1-1-8fc39dbcb303@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7029112824109667135==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       monitor: Fix heap-buffer-overflows triggered by HCI devcoredump
   Pull Request: https://github.com/bluez/bluez/pull/2530
   Created:      2026-09-15 10:23:13+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7029112824109667135==--

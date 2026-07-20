Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F9719049B
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 00:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784508856; cv=pass; b=RP/p6rjziGhRUZS+PV4LuyczgTvHS3gIe6RlGVmfOvkuzbeGec/xz4s4CmUHSSXA1s8TDO5Hyc/B8An1zkM32tdMGuYkl55puu+ZDNv+IBDkSlPFgDaUrLi1eZub1GELtj6JjBtZ+Uo5Dz1XGhCqXri6kyKdJxpIsXBUl9ubk2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784508856; c=relaxed/simple;
	bh=ADSPjehMEaU7lOzYmsbDQc8djB+9wNDlIm27a0gOccQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PPanaqJE+lWnaQwE0Md8Ze+fndsiCpD0KUCafYxfuk522389mvTprJ42OO5UB569ngHF74hSJMLAIo78usD4r4N00ijtguBtdXfFxTB3I915++kzy7cZfrCTzUfVSyN7OeFKGQbbYxl/s/3wTp0RYIfANTlWkGPfSOx19jSIqSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tz8FiQx3; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tz8FiQx3"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81dfdbd86d1so57992617b3.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 19 Jul 2026 17:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784508853; cv=none;
        d=google.com; s=arc-20260327;
        b=ND4lRhBCl7cxXCtCbA8Zv697bG3SuplTjzlWKIjJ58GyfV9kGqQzk2RiKZNPmZbUlI
         6afj2cM+ewtYTXQYIAzlc/qCfAx7i54Xn+PCk+bTJmkvBMsSLhXb9Fd0QRQ1MX+YlsSc
         JjWszjf96a/ncMZfVjJaGaD0ZhSEDaWfJl38uloymQTzH8pWoTX4SJAZ2YzfNI8qCof8
         +1SKJkfWI47hNSHwkpkXBO28OUTTVa+G+HldtUioiJE5n/xQKnYztHP5ZMoiYRTY9BTt
         ggAAMJhTEmwYrQB7lwl1xm3c9RgOJPKBovTKyC7PN/F9hKfy+bu/QDEWm62qyQkBdgRC
         0GGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ADSPjehMEaU7lOzYmsbDQc8djB+9wNDlIm27a0gOccQ=;
        fh=JeAT8ejwosw/5rLwDOQS22IYjPklitNT4GZSgrEn/Nc=;
        b=lwCwHRP1mWWiI8xuHX9nK5yhEMpbWcvL7S8KhdjE5a1Je2ZfOUmukXsXUnLJ0XGjVp
         arE+Z+fG/zkKYVVfLWsXAJfCHHJOjfeZYq3Nr/C6w2qrKKsBvyb7lJmlGMVib+9GezEc
         DzVxSpbAGhkd/648os1CSKtkPt+1FpR/r404azZbGqj2SrJ2dGkWjF4TauxnLeeTlQSN
         MgYuSRPDl2y3a3cPvKpyrJV1iIWkFee6NLWn1X5x3gFAVFAadG8sT85YL/1mz/ouk+s8
         Z8WXm6PdeMZyLw8f/ZJHKQmhifQ8kgiaj9q3SyX8IZCsFZw9NmLxsNUQIEXMzos9T6Nc
         ODMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784508853; x=1785113653; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ADSPjehMEaU7lOzYmsbDQc8djB+9wNDlIm27a0gOccQ=;
        b=Tz8FiQx3ZjDPNv1q7Njyi8/01Bkalj1XGTVM38VeHheqCmYMJmPWz/A2S7DwUB2ZPe
         fTv+wOVF4sa3axB54T8JXunpZP1+xVJ74RXZSvDy6iLumAaHHUEkYCyHmYezWfZVGMsV
         HNdH2r/palgsrw7jinOmOQA6ufp78nEjfCKnzyIL4wNRT2vm1AcoyX6KRNUgiTUYnjUG
         Qp064Dhihzef7wqKVv1f9QQKZwTEUYepiF5jRJmlK6JTPxmxl6wr/D6lONBX1OZoBUjA
         6SqxoH7c03fx6VSToBJTGcIB7mxA48xfVZ7TxFl0OWswv3LRi0IQ27k/fwn6CSuqAuoa
         HjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784508853; x=1785113653;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ADSPjehMEaU7lOzYmsbDQc8djB+9wNDlIm27a0gOccQ=;
        b=MUZ5iPVWYYPbSnjIu/lELUY/RETsZwQ0eCuEtMR3fFir9p+Vg0dQ5Q2egQrNmv1P1t
         xNU4EXyaXKpddbI36m8kscCF3LWGAmY9jOCbMxEMQKf3BKpwPnpO9W4lbGw2G2qDwl7o
         RpkwdM+zqKK4ExacUmeSmLSOv2FDvvwVRInwmMkYOXHPGs2PgXINECqLyib/f0Fgp8PR
         wvjEUyeiMfTLQecbU1Qd2u4B02+FIJdpm2+Knlfh6LBPbBAEkVAVna43NhIOjmPoQGUk
         WpFUntNBk/LS5HNy/eKMUUK183CQC74XKC8y9mGmWnN6COGIMfCQ98q3BqO4oKiLCYIw
         LDOQ==
X-Gm-Message-State: AOJu0YxX3aFna8p/eO4ibv6bW5FKByuKzBXW/q9/jxbROmussaEmowAl
	5lX+Efa9bjglvSVtf9l64wXkVHMQsCtPk6mMNMMzdw5JKmtJG06kmACWjCHnMfe801CEK/b/9lj
	KeVgytRQBQcZHd6sLGut2qNyK8l3Dj/JxbH9oQiCz7g==
X-Gm-Gg: AR+sD13ZbVhFnRWPTpIcTqUSKy9cN+d29YS29uCGFhvYhbIMz+ilUwu5GuC8Mm18M0n
	gH+x+LMo4ZngBQyhPb7ROPeyYgPssmu1auE+YF0TO4kGt15Jp8ibEPQGitT7xomIUNJw7s7vhXr
	72TaZK4mrTRoftV3d25STsXBOIM3WKxOQxRgVFcG7QdlYB/cmMt/L/TAt+efmbALexwOe253UbS
	6wF5rsFLA2lF4NjoJ68zKYwPSqtpWcEIu9egWm4HIuaKkPWMaJhH1WRvyl1VQ==
X-Received: by 2002:a05:690c:60c5:b0:81e:6a10:f904 with SMTP id
 00721157ae682-81ef25d5b74mr37021397b3.45.1784508853065; Sun, 19 Jul 2026
 17:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amir Abudubai <amirabudubai@gmail.com>
Date: Sun, 19 Jul 2026 19:54:00 -0500
X-Gm-Features: AUfX_mzugso9jnhSVszNwH7aBQtf84tgRdOhs_gsLwfu9f55ZxPzapPmH-F2TC0
Message-ID: <CAEzAHR-rM3V0hwyrc0H3xzS_gu965Kh2oyCra9aLjxNEsrCdoQ@mail.gmail.com>
Subject: [BUG] Bluetooth: btusb: poll_sync can fail to preserve HCI event/data ordering
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I encountered a bug that shows up as a GATT table discovery problem.
Client sees a GATT table resolved but empty. Eventually I tracked the
problem down to discovery failing when the peripheral drops the MTU
request for invalid handle because it arrives before the connection
complete event.

Digging deeper, the problem appears to be a bad assumption in btusb.c.
Its poll_sync assumes polling jitter is the only thing skewing the
arrival time between bulk and interrupt interfaces, which may be true
for some devices, but isn't typically true. I tested 3 different
devices and all 3 have different behaviors. An Intel adapter that is
async and guarantees interrupts arrive within 2 intervals, a
MediaTek([VID] [0e8d:0616]) that cannot recreate this bug because it
internally delays bulk until after interrupts have been delivered, and
a Realtek[7392] that synchronizes them, but always delivers interrupts
3.109 ms late. This is only a problem with the kernel configured to
1000Hz because of the minimum 1 jiffy delay in poll sync.

I made a test bench that recreates the bug while capturing logs. It
parses them and reports the time delta between MTU and Connection
Complete on both the USB and HCI.
https://github.com/Yes-it-was/btusb_interupt_bulk_sync_bench#

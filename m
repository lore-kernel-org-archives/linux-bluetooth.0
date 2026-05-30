Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820EC15C
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780151620; cv=none; b=ruoUrdvK9/Y8pUAmvaCkMyIRE+JoRqgB+v7Xyu1JWfTV+bCSEz+4TIKK/hk0mRfeQBM7X+gYMKRd7Kj3U+owquaKAfXfW4vks9MFuNUsoAlfIpTnpL2XKNDbO9/926ulPubJhNDqgie6Wj8C595aE3DXKJPHgXaRaWV/HANNVgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780151620; c=relaxed/simple;
	bh=ZxWZtuhDLd+CzDToaIAbqZivsvEBxHUODz7E1s0QHYk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SpQcTZjrHKfJ1wnJVn2FiaX5yeA0pfup/xgOrwjoHkQWOxDUwIvfnnoiuO5ouIpNAkPKbUy3zFdL5CFWAQ5GqeienswnfZS4jk2c4W+SrW2BmUTOl8LnZypy5fd1ABzxsDsuafzng18iYCD78dWArVfKow0B7xlDxxkojGDGlrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1kL6K2Y; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1kL6K2Y"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-914db83362aso694999885a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 May 2026 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780151619; x=1780756419; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=68EsWRycPEn3L2l7DpOfrV1wx8zAjivUiKtHbPwH9as=;
        b=B1kL6K2Y/w/QIkwjx5GLGCGvdRZpa7mmQ++2dvaehXDtSYg+dInEkUsaXQQ4LHti1z
         qJhSutGnv/+JSKtUlJlSbyKhejgQ3D93w3WukafiCfIY479f1H4M/xM7wDp/GkAIVUEj
         YMFjRxkgZgYRHeQrKB/ViXsPRoLQIefff+zV58rWA6Cv1vUfqJFPnGaIKC293qBFaegS
         BOLS5prAkU4Zw/i1Up+SpD3M/lD/5D/ldBDdRX1Nb11kjrtCgtnpAMnU7u+5H7zqbMbm
         uiq6LHh5IqphYzscxQ2AUO73Kd6r7v5TXZf4V0OwqJUyssO8xWLWQAUt0lx2NM5uWe/q
         8r9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780151619; x=1780756419;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68EsWRycPEn3L2l7DpOfrV1wx8zAjivUiKtHbPwH9as=;
        b=euIcHyYaiJTjVsIzaz6YqRtzZiP6rTBhQS/GTtHcxtk2lH5q0oUbV5pvjkLNv/wGMM
         iL24hyskHtbCRTqEZ/cJoz7vOKTUIyESJfwWe/8yWqRaT/yfwG8dRDCcJIN0sDGuQerG
         kSznyW68CQiee99e6OuQpXYt9RXnbKRa3pKEsyxz9kQQ8C4E/f9grfoNXBoN4JEFR6i5
         lv06fP7hZqO9UAE9ShuS/uCjFOj++SYXwNIEsXKVIdI1LMcYOcqWh6gcXsgf1jHL4ul1
         2ChZWTn54RHdzNpBI2KFJyD5IAcS86z0zOkNtoEyTM5+YYT6fcSiIKDLkqUT0usHF/Yq
         gZlw==
X-Gm-Message-State: AOJu0Yy/X00fkiM5UOg21/hn8A6p93LRskrxdxgBC9WLT65nX7Q5hR6E
	oVyWESoAYe7ZaenhFV9LYe7wbUYliipJVpZfqjUgdBiL/cubCJnD3cu5wndiYQ==
X-Gm-Gg: Acq92OFWlB1bmpqLu6DbMEcKxRNFkE3Lr1gdA+hnqZUdJGO8wWR7T8FDPY+YsSbcV3Y
	Bhupxm8qTeZamJmhxhwImUOpc32aV+5NFUo4Nf2d8aGeJ/u8gI0mCiUWOKQiE9rc261JQKh+K5G
	VbHTVyiaqf88N5gLHeeoGFo9ysTg/mHOfdKs3G+/N9246+ok0HoHbifTX//W88FSoqAjDPjpbH8
	7gWNJKwn+MdZishmrFoAxl1sbHOf0goXth4T6Wj6Z2RnbR9QKhRxjseVtlDUX9NbW+dUJXhkGzs
	sodTNAx4EhFqGwvXTdcTjCo/En2QWvgqjNKY7TFit9KFeWbjVkfCg4KIxPrbyD9tL4iKcg9QeBi
	03wfOJTdUe0ljCF06LrMxsjOIcxzJrmy2PWFTEVASZ0VONUzlSbFAahm1BJBS3UtBjXMCDq4jMg
	dp3NcxGsYWXPUlKzpKO92ymilHluTfJzSttmybR7BL7u4=
X-Received: by 2002:a05:620a:28d2:b0:912:5d2a:4bd1 with SMTP id af79cd13be357-9152fa2f46bmr897338985a.40.1780151618729;
        Sat, 30 May 2026 07:33:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.171.254.149])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915326503d2sm509206885a.44.2026.05.30.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 07:33:37 -0700 (PDT)
Message-ID: <6a1af541.98ff5233.6ec58.68b3@mx.google.com>
Date: Sat, 30 May 2026 07:33:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6335581415737277288=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nils.helmig@web.de
Subject: RE: [v3] Bluetooth: btusb: Add TP-Link UB600 for Realtek 8761BUV
In-Reply-To: <20260530123934.4583-1-nils.helmig@web.de>
References: <20260530123934.4583-1-nils.helmig@web.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6335581415737277288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103276

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.92 seconds
CheckAllWarning               PASS      28.54 seconds
CheckSparse                   PASS      27.08 seconds
BuildKernel32                 PASS      25.31 seconds
TestRunnerSetup               PASS      535.81 seconds
IncrementalBuild              PASS      25.39 seconds



https://github.com/bluez/bluetooth-next/pull/259

---
Regards,
Linux Bluetooth


--===============6335581415737277288==--

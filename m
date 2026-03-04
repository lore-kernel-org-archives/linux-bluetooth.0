Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B89350A1B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772659927; cv=none; b=WHQ5PjFQH7Q4mS3FsmPZJ//2gkRRW7uBLEf5t3gs/NFrxcm2O2r9cOk1Ev0W+k89MyzLSa9neFRnShGRwrZwzgwwZq3rr/K79w3NELnZtkbqIQFvBNmiwBkswVzL8kZ21gBK0TCJCMSLqDgH4q8SIn4xE4AQ0LOSbiTO0ibYqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772659927; c=relaxed/simple;
	bh=kNfwas2omAKyl7rV8ZJ4ildIQgYjLGz0nZOX99eRv8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KB++lcl646zZeEkm6c+9sNHPdXl0WpzLUQ7W2x3MAw5hXSEBa04tn/u3OBmKOzscDsqq5k7w70Dr/0TrKt8pZlNuXM+quq7BLiHnFKYI+lK9VfYLf0C4Vq3VpQUgK16czu2t4/wAFfp/ySyVGa2d8NbtG+6ly8OA8vDupePKFJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYqY8GZm; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYqY8GZm"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-679aebf4e56so4970127eaf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2026 13:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772659922; x=1773264722; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kNfwas2omAKyl7rV8ZJ4ildIQgYjLGz0nZOX99eRv8M=;
        b=iYqY8GZmjMat7/20Nj0hmtU/+8YQtgW8TLnff6oRTdBsrWYNR9KRKiFHKjhkOyOEK1
         I13aEc4iMgBxhxyDZhR4y2Xiv1Bfap7XKkMTAxbWdVRiGZoiuq7+r6yhcHPpvTnU91tU
         t3UYrq4vXp3kx9b3mx/tCklS0CufQpGePJYwq5iuK7IkeOnUcxHwi77wwtgWJvImFT0w
         7ekl7TNOSN0oYh4nL3I9SBxHgA/YuGnYIe3W07PkdVEgQie0CdX9hfUDQ3zxaWaX13K/
         G4hZrgE50vAdbNxAE2S2eT5aOIeVCSB2Wx6OsRW4HPCGK+Eln5rdeo6gxPQO0BrJO/oX
         mljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772659922; x=1773264722;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNfwas2omAKyl7rV8ZJ4ildIQgYjLGz0nZOX99eRv8M=;
        b=tmRtBVVXZzbAHGVw7obCVn90bI6YfzGXDvamrg8IrJ9QI4dJHWGmdxndlxMPqSXk1U
         oA1zTuuVheSDDnFomDpfwtaguRXveFzjRLakNLfzjY2+J+csnJvhQXXt7CzW4SGislJ9
         ve+h4KHfykwYnDMcb0cb6mFlJHLYjeRsPyzo4Fcqd54YSLYP2R2g78tVpW83jsKf9Tm9
         exROoOWHVIi3p1Cl2MJ3OguN2j8KC+odgtwGvrJBEX6ST6NvzSdOD0pV45lodWVvwwMi
         IkZo5ju/GQxJS6tw0bE0BZ39pBMfqMVs2NqW3MAanDqMmpSz2HrhE+j49JbQ5xBQORva
         3R0w==
X-Gm-Message-State: AOJu0YzhKyIQPrE709BXTELBulGhqpg047wush3cJohtLrHOEseA2GV/
	FyQd3ITb3Q5r1Z/2tQThXQkUCnVWq2cZozoy51u9OECsumWlkrbeLV+fQs+xGQ==
X-Gm-Gg: ATEYQzwgWZHm9brSUwA0xdjyvEquSbLMmswHsVHt1gc1G5WcHZdMNp8IkBHhBJzuKz2
	ytYfLAc8PFbI58l1UmjUsHg7ysXAMkIRT4VO6ri6GgAcLtnTiHDxVCKulQX8NuohnXZhJCB2XxH
	Ksbtc7TbzvwDJ+UL+NjbNITG54PfeiD9r6lJHrlESlqU730ZOMUAEXy/xf3AzWciREE3SSHJVGO
	dTczpYqh6ZcPB2981sxhE1H6jNTc6XlIWOgbfxAFptTZChGUjDD8IqAJ7uJIQujoYk+RH93vuvD
	hTZBgmF/T0p6Zmfa5Xa81039X4xV12BLwq2eDcQbH0dHfxEFG75EpAuhHmRWEb74tEa01Bpuexs
	q/ZTHq8NQSPyOoHDm/eMDLzyof/ys1AEU3VOedhtloupVV+R41Klg8jGE9/hWj/SmSfYfWLPGF1
	afa+FJ4JYufBs8TX4YTzEnBiZQ+nSAfA==
X-Received: by 2002:a05:6820:16ab:b0:67a:1bc9:bb3d with SMTP id 006d021491bc7-67b17705627mr2231773eaf.24.1772659921757;
        Wed, 04 Mar 2026 13:32:01 -0800 (PST)
Received: from [172.17.0.2] ([52.176.124.231])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2a17bfbsm13764265eaf.0.2026.03.04.13.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:32:00 -0800 (PST)
Message-ID: <69a8a4d0.050a0220.358f41.eee2@mx.google.com>
Date: Wed, 04 Mar 2026 13:32:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2512840042890436678=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kai.aizen.dev@gmail.com
Subject: RE: Bluetooth: hci_conn: Fix UAF in create_big_sync and create_big_complete
In-Reply-To: <CALynFi7uvORERZA+9WUaLvbmc6ooPse4ETCn=ix3WLN62wON-w@mail.gmail.com>
References: <CALynFi7uvORERZA+9WUaLvbmc6ooPse4ETCn=ix3WLN62wON-w@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2512840042890436678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 56: @@ -2198,6 +2203,9 @@ static void create_big_complete(struct hci_dev *hdev,
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2512840042890436678==--

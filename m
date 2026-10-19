Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13A4FC8EA
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419222; cv=none; b=u4MyoINirkwJxyVMYu2dpgkbqERriEfD/wbd6o8NO+N8xYm+UygY3QjyOsOkvv1ZyTI0auX74R6dXVvZ0UP/7wfl64POMp645uWqOq00PH67iJBJa+RgKT3GCAFlbogZqNOUIA7lZvM+aQ8sl6jZjvIYN8l5JVoigEG4akVAdlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419222; c=relaxed/simple;
	bh=WWH5Xr69BUJfqNmf0GKtW1qQmqI0H9uq4dexZy6kiBA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CO92jjNJ+VWmdK8HTCX+2c8q8nhTj1pLs4ocGG8SmHTrmV8qYeT3CTfrmxgc1SEBWy1awY82BNExSgKQvM0Vmj5PCIfCpM2OFFfWfRn4Wttt7U0MIX42tUh7mDInyeO9owllyFzBBeKkimDVxAX0eeKq2jQZZD+m6tAhsJwXRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqWdXuMY; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqWdXuMY"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so3455002eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2026 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792419220; x=1793024020; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WWH5Xr69BUJfqNmf0GKtW1qQmqI0H9uq4dexZy6kiBA=;
        b=RqWdXuMYfu/d66DjS+HDhovjmfBIzuJkG5yZYjV3DGu5t3LuU5fYvPHr+4NPAnVrMy
         zM9c61PJ0kEHFXEqJVtW101xqoI8Qwm+CApgGiHWIeeP3EYR4+4CIbDtiMhg/YWUHDUo
         UNzpKIyNYi+Mm+AcHMwWettXzt/Wu23LtakGj4jE682UglkTn2a20RlORY6NZhtqNFmk
         Z6RHegzeclM1jVVzU2duiJNpqOuR7AZDLQhkBltA7HmcsxZ3A2V5+g7yazHOWMQg0Sjd
         xTbZeebmm7kuVovO4dYsLPXS7F6vF4N56GR3OdZ2mXPe8nr1kvcUygfOxyYjnUDWSRAK
         jcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419220; x=1793024020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WWH5Xr69BUJfqNmf0GKtW1qQmqI0H9uq4dexZy6kiBA=;
        b=cF4yMhORwCJ8oD5h1kbLN3ibyEmYeAZy15HzuxvH2ZWVgiOaHSeyeG/Y8+hidzXR+y
         MNzzRuTg3J0EWpF+ZTZirfZa/yZw4Ye4dA6pRvQ1hIi2vo4Yuf+pifDdZfS4wOiqFLbx
         YwmIXzmIDd9iEeC+AmksyMlDtOqrkQSKXwsj5rcQI+FcAx/yl+e49FioIiEMrPAZfN3U
         DwfjUHu1UKy4+yRYL/UW+khgr/oYzuy50Q1El8u64a3OSn8cKEL0saD756X5gnH3me1G
         eNFUPA84EfRs7cx92FQWH9zu3rSLHKnunn0CBru6mJj1ot4rZDFTjuQciL5T225sREyn
         ZKdg==
X-Gm-Message-State: AFq9FYJjfkndafkD6WKbUOwSfawusJ1JXWpdCzDmDZV7WQz9SubXLLxq
	cUQbm6VmzHeSWULh4HrFjjY4fmXn6DHIsWGAERrNUJzedr9IsHZnV1juKLsk2w==
X-Gm-Gg: AYBFou0SgBZbF4JplX6ciJa1a5J0ZoaZifJ/G1eDj4BCAw3YThYCU4ln+7EDbRRY+5W
	JQ3J9yn9F+J6aW91VBK5kbT6dbZ+VVp26F83Au9HbnBg3YkF9ukkokuHNwyW6skvvR6T6aVFQ6I
	XUUcVftHUY+QFHwRCupMhuF5FZ08z2RVZiPYST32qFU1Xvf3yTw87sIIFXAtEE5M3tADpCb9TU8
	/8JPQeMWHYV5Eq2LTn6+OGk8U5og/dJBv9wfEFr2FyPXZlYgZBVoCcRCK6BWgJaj+LpiPCYpDPY
	GO2ePwby54lwjBZ0NhHb42SJ1u+Qkz7RF0/2x+tLSSazaDS9LcQ26AcP3EwpPG0DT4CUkKaqlK1
	WR6tDLfNKFCK6UlcAyT0Wf16bFwhAOAoxDtSkHsowXa7JmZKX9VyX+gRZaYiy5hrKFn+ViGPzhv
	8pSBcJNdGGN/prVz//GgQDhMWdWTLfxnyNplcgUSuPdwvOM3/byTKypJp32EAsfAo/JDxFDn43N
	Lfqmw==
X-Received: by 2002:a05:701b:2319:b0:151:2e62:fe8d with SMTP id a92af1059eb24-1851238b627mr10686114c88.9.1792418810318;
        Mon, 19 Oct 2026 07:06:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.253.40])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6e33sm34339632eec.7.2026.10.19.07.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:06:49 -0700 (PDT)
Message-ID: <6ad623f9.a4cc3b0c.1ced00.b93a@mx.google.com>
Date: Mon, 19 Oct 2026 07:06:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1910232753727685518=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaojiale02@163.com
Subject: RE: Bluetooth: MGMT: Free cancelled adv monitor command
In-Reply-To: <20261019091243.1847048-1-yaojiale02@163.com>
References: <20261019091243.1847048-1-yaojiale02@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1910232753727685518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:5682
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1910232753727685518==--

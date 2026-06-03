Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7679746AEEF
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488320; cv=none; b=KoVshlb3HLb3IX0HWR8E09Lp99iKSIdTxBEXbdkJI/n4XawImphDds9Ki5tOU4GvsjJvydBhWktWsmfsg9EWhx1LpaTA9udQ+iXvVyMxUoBDj8SaKIDMWqF9+eMcj9ED0TsPEhiN8MEzdN5Gh5rs2B2At8pM0TyJGkg5F1+vlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488320; c=relaxed/simple;
	bh=8149TyIWEuXZdFK8uQkZ2iPlgWo1v7zQRfHa9fitZb8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XrwCrkQnX4K/R18wskOOKr1g3wb2/rC8n42vUGmwjGIeCcZmlRN6c/zoIFTPF8ltmThqJxmxP/wRlGktLued6nfmSCUVfdGrfdUEHKm9AlSczWuOvCmih3Ika72XeIffTxcAoUboX+1+B0HS0SRBWbr+XwM+SXYou65epGhtIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIdrpGOE; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIdrpGOE"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137dd3af345so3357094c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 05:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780488319; x=1781093119; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8149TyIWEuXZdFK8uQkZ2iPlgWo1v7zQRfHa9fitZb8=;
        b=AIdrpGOE3bCmVefZe4G+jzd0z4Xyri8mYVDCEXVwL/HF8zbPTKXH3T4UZHagP4d0jq
         sUbTgyc6zHaHl3FMwfW8H8KvXpcoSMGRounfXdNsk2UIypa3rh0xOCqeCNsg4qfi9TsL
         KB2hlVS4gRhQ0icLHpl0DqpYSSkQuC3swH8TJDXjZwBGHaYg8lvFCEcwhEgBLro/nxgU
         Kna1uQtA/dmQ9f/7Q5UQKqWANMvCdDqfFHq9JJ5MNlUqpRQ6YbRpZkLU3WDgdRiD8GI0
         i574M/jeViNQXLK9DrmiAzqYQNJIKvlGc7oRxMsWkq+sUXIq7jZ0gQsYiz35ehqkddJc
         bvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780488319; x=1781093119;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8149TyIWEuXZdFK8uQkZ2iPlgWo1v7zQRfHa9fitZb8=;
        b=kxNO0yZrtdluhWSEcRAUJBr5FiPvI57yDTTyXUu69BdrfB/0qQWgfbBCOo1y5ZR9DL
         wJvbyFGpTz3mBLko/VziIKNjbxqkpOteKUe7YvvoUHWy5ZSxkbP2KSdriuwq1zKshj1y
         den0U2sGgzLg4AYDrHGbpKNoDxSQssFz03X/Av9ln3APxCILOQVJWqmBsju1/gLVzND4
         I5laxmxEYv9rXGdUqXCA2hHrJSsM5ku9vuRNCV0fc17cEY3GAzEyu/KbRGvKiLqQ74Gn
         KvIZBe0k2USA/NDQsnT4zKDEVXWEFbxpQESVt9ZRZgzBgrwEZ0zAVE64G8fVCnFGGZLM
         ENPw==
X-Gm-Message-State: AOJu0YzT9RXEdQ5IxQpx9MQhAgvzXW4zuc1KJB9ZDq9DBuuaNEov9bsC
	8O+tQ7eQlOLz/O7LZmIfa2fS9ZBUOEPBUzdYX51sRg/O9RtQdTqUPYpCEhb6Sw==
X-Gm-Gg: Acq92OF4SQ/+tR/3BzqMcnHOKhRlgQ7A+t+WE7kGXoc0018cH57ewlx3WktXTozQ+Ml
	cMGICTfqAhvtyZ9I9WJKUO1hCvbRPVTzH78NLvmqipqPd+8K18bJlrm06k4SeA5Jkb5M+DxEYHP
	ThxKQ/fM8+Z9NBH5hUD+bLe005KHsPJEXOaO7Nw6AJghXQUoNRUHf+DDKQnAncAbgTOtk8LcTjk
	a/DCkEAwyRHIOl93VEZlCnvGHMFBcSmZW6l+Z5DBfmAIplnUQiwuKqfLX/b5D1a8PLcEoe+cHia
	Pug09IYMPb0sy4LXE7l8LE2eThIAhcvEIfjqXYBsM31yD/iT9wckgJwVoE7EYDRFdQR+75ZLN74
	wLK5SgRwI7JEeDiXkMbUKRcm2l40FPMRa1OvFGYh6wqmkp4qVixSMBOfqpRBmSY1LO3HxO+xZJC
	cprOyH5vF7Nlog6UvmRMPo4ntKEuBzmeZLJFhNATE1snaHplMzMA==
X-Received: by 2002:a05:7022:6082:b0:137:edfa:6f34 with SMTP id a92af1059eb24-137f6b80c7cmr1050073c88.1.1780488318519;
        Wed, 03 Jun 2026 05:05:18 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.58.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5539035sm1796015c88.11.2026.06.03.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 05:05:18 -0700 (PDT)
Message-ID: <6a20187e.e877838e.3452c1.f9e0@mx.google.com>
Date: Wed, 03 Jun 2026 05:05:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6613777297831210479=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jaggyaur@gmail.com
Subject: RE: [v3] Bluetooth: Fix Use-After-Free in hci_unregister_dev
In-Reply-To: <20260603075134.246832-1-jaggyaur@gmail.com>
References: <20260603075134.246832-1-jaggyaur@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6613777297831210479==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 23
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6613777297831210479==--

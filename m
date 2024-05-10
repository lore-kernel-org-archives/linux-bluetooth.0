Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4612C53F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354023; cv=none; b=GD9OXwzQuOP6zRVxkVbnVwH6XFd34R9bLunwZlodo5vmUCjiN0JM/eIrxzCSjRQAChKtEO9THlLTrmiz/fed5/TFRAbDuS0Xne3Yz645DbBkRBVx4V+Ir/9+rCpiecuSgYoTG01z17YLe6lqcnkwhZXgzwgIGxBbbx0rBk7qMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354023; c=relaxed/simple;
	bh=cOM/Oso0Ew4cg0z1qVZSsLsPJw+YkcxYVRAjogCEodw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VYT7z4UfwOMfjanDQUQ8J67Rh+7dZRU+/3TCbjHo7c+DzB5ity46mGr2bMXUoeCc2AG80IFKtC7rnXrA3507t7AH2jRgsvhkXBwJ/4vZKEaGMTpKKJ0srhE8e65iBKjVsjWMWw/xeq+IPjXgvPQcvC6xfyUcL24Y800pHp5V0OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erieX/Em; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erieX/Em"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f4603237e0so1481943b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715354021; x=1715958821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cOM/Oso0Ew4cg0z1qVZSsLsPJw+YkcxYVRAjogCEodw=;
        b=erieX/Emcqo79nXQJ680aqqOESdvUc5NI0M6VdOSmv5PjrhBOFWzHXe6iilePdqS5F
         baAlCX/+QP1TPBBlWKBcSddO9JVA5qHR/Z9+CpXc3V80A9QjOriZAEQ6luAC9ybpWzcn
         rQiwR4BZvfvrJ1g8MSnrVjIzYPvoWw7KqBrcxEzEl9yVGQMm0hObL8hLcQtlRMr5XgEx
         q/QTg1jm+T6vc+Ih4DUfBOCRnOo2IxpsnMyqOc938KkDasyWLSzzfb2tbj5yb+NjSYRq
         xLjITn4XBT6dOa+e6h2jzKqLkO3UYbYEZqkjFQgpfN0kKgBLc7Wk+dAuRHmKRc5emAvL
         HrAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715354021; x=1715958821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOM/Oso0Ew4cg0z1qVZSsLsPJw+YkcxYVRAjogCEodw=;
        b=Se2SFNqgRI1fA9zg75rbNEts3NbNJBCsrgsh9vSliP84pysCMJ8wYi5Td5LG77/yIF
         960CJx8fGzPxwhYFiR1HvYDd2ZSgg+3rpN+KaRAesLTb/fyfgVprf2/QwZUaAO+NspNJ
         fJ+ft5VZE1Y/eg+345PgtR74mxDKw6ndcHkflJ1g8dsM9oWfXpE0z6op85D91sFsPF5t
         eAvppo7YLlaCBwdUD5ULmcvHlcCV0SqAdjAIJ4E2j4BDz1TjYYFbcOW49GYj1wQ2Zc9f
         m3uhbHyxftZ8A/B7idlQo1RU55RdAwJbgxhxkwioF/hwylkOCnj8uld116KWJh4C1JqF
         8ytQ==
X-Gm-Message-State: AOJu0YyKXeuj+VtwKGFcXxaFS9GMz26wUn2wmQna5gGQERIL+35OVcnC
	MoVRK7JbfnR1OdbxTMNB8/MJfZSe89NwfGkMCR9ZjXRgdWNvRDMOYclRFw==
X-Google-Smtp-Source: AGHT+IF2nOYt4Up83KoJ1g/ALzZY6wY9WD2A13r39mAIZzVD5VaTT+y4RWdmvcqmNss3leH4CpORpA==
X-Received: by 2002:a05:6a00:3d49:b0:6f3:e9bc:cc3d with SMTP id d2e1a72fcca58-6f4c90905a1mr9281859b3a.3.1715354020969;
        Fri, 10 May 2024 08:13:40 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ade27fsm3047031b3a.108.2024.05.10.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:13:40 -0700 (PDT)
Message-ID: <663e39a4.a70a0220.28934.8345@mx.google.com>
Date: Fri, 10 May 2024 08:13:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2317455349642639251=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/util: Fix build error on malloc0
In-Reply-To: <20240510150919.1492039-1-luiz.dentz@gmail.com>
References: <20240510150919.1492039-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2317455349642639251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: src/shared/util.h:85
error: src/shared/util.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2317455349642639251==--

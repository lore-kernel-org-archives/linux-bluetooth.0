Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D009B1898FB
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Feb 2025 11:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739099526; cv=none; b=Bl6bYgK3de0UQS1PZEzv6HgOA07Sefjja7RTsPlB60DpeeIqwW65XNuOogZGUSCz1IRXMgEtvfNF3DO0Q82OD+qMTPjMMvX+HTc5t1DDhF6IkPN9VE+Hdb3P4cbvMrxjwasq95JxlWBqSn3oSStjTs5SzlpScdLqN4sAAonBnF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739099526; c=relaxed/simple;
	bh=yLNddFOewHda8Agkttz+/M853J4PWadV84sLjxOVl/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sPOyKgFuag4GP6yn9H9xvx12rhkhOAqFlaZ+llhsJFtQWRC1PC7uC3EdkH2NRfulew0sQjDwBOq0u1YGQhoNT1zL5KKvznmI59wbTka73H5zm8/QOooHoUHVvUsShBzVKi96oDOwNRO4X/zupdk3GZxlV70gT7vaMBvGfcyogms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEocxQRC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEocxQRC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f50895565so29893715ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2025 03:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739099524; x=1739704324; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yLNddFOewHda8Agkttz+/M853J4PWadV84sLjxOVl/4=;
        b=KEocxQRCvEElBnyVp7BfULKEuvZkkXG50qURGfG20ChBZkaYdiFSLjDvRC8ObyU43+
         2nqxgjAA5GtyVIzBemZ/mCYdNCxq/x4cGWpGfnmYw3VXv2XQXnJy/OVl9/dwzFG5xjxM
         fadFY1HoCO45rEaggyfBsVJVqSh6axrL6jBsg8l3mZJroSH0dB5/cZGXKfCGNzu6OQgF
         pM/7NTfr19aSE6SWNfn7rUPsw0W3fh+ZcQFfEoSjoLE13xkars82BnW0ICC0+X8Qm8/p
         qqt7Y/vB7+0Lu3xNd7fRR0uUmtF3SAHEIDtqwIpDegbgMVyWYK/uoG8sqD4+qBZHPDnP
         5FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739099524; x=1739704324;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLNddFOewHda8Agkttz+/M853J4PWadV84sLjxOVl/4=;
        b=W9li6JmCkHRm+O4p7IS0J7hbSkYIBqnNna4bi543ATeWBoxw6J5VrrW66QygUys4S9
         2ruZnpRUNCkQRMP4RV+F51L07PSSZ2NCJspLveOfcn1vNxTojp9qaXANXtRtVYgnttop
         T3kMkeqzAan4WALOxIP8yMzcXb/Euzw/JlCetizgcIrv378lDJZw/Z4dQ0dJYD0UxPs/
         j5GWaOMHBbk6dQR6V6FHbMcUs9kstBa/4gbUGitjBMtWS9mKuPFo0Hq3ORd2glahXLb5
         8Z31bTfTYeMEkQDwR8/eSbbCRwjF1dQIm3EqVLcMdLuyUf6VW6n6HebZkmQ64riOoHVo
         6pIw==
X-Gm-Message-State: AOJu0Yxxj8VEkvxVibjxRgP6TYSMbexRz76zt0OIkzH14ITWXHimkE3v
	TK/xitqi37G2FFWt5z+fZ8jU9xG/4YnU0ov1utN8AMIsSJjv4rgpIXYKKA==
X-Gm-Gg: ASbGncthE13+zcX2KxsHpnt5edjabUBvgkSht7WFMyHkd+ego1hi5kBQJK6R8JQCXzT
	4vBpQqVX9s+Vt7H6v0QnLk/2KtRtTk4GwIqGjannMfb1qq3xpK0b7D9fJkOyg7QMsS5JB/cubzA
	I1vsBy3SfVz38jRnOV60k20PY0FXZfDT4dDNJnYTJYkh6d+Zr6I0O50GB8T2PPbqFhpuyj3cDO7
	/94z/Bl6i3sOwh1ez3bKkantDW9e4foceplnk3nM34T2sD6vgyZdlPtR0emEK0Z2byHPFukrrcf
	SC1xh+lU5sbKTMvE632cVA==
X-Google-Smtp-Source: AGHT+IHcJveXsscW9I5tVHN7ZQD1J/r6Iar4iplrRsL2tV0opF9XTZIG4YWr3jooDXdnbaUHAZ826A==
X-Received: by 2002:a05:6a00:181e:b0:729:a31:892d with SMTP id d2e1a72fcca58-7305d44a7b1mr17488429b3a.8.1739099523726;
        Sun, 09 Feb 2025 03:12:03 -0800 (PST)
Received: from [172.17.0.2] ([52.234.47.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048a9d584sm5774047b3a.1.2025.02.09.03.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 03:12:03 -0800 (PST)
Message-ID: <67a88d83.050a0220.111ded.4246@mx.google.com>
Date: Sun, 09 Feb 2025 03:12:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8666692933846948762=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Add io watcher to be used with TX timestamping
In-Reply-To: <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
References: <3938636ceaafc589f6d12fa6fe50e1c6a1c76bef.1739097949.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8666692933846948762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: acinclude.m4:63
error: acinclude.m4: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8666692933846948762==--

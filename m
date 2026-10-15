Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729B51C066
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066197; cv=none; b=JtozoMpn2AoME9alInrW8D2DIS0eAF1vg3K0Ko+wO59nhWX8/M+k2Reo0JUTDjwzzRH+5oJlHgiiF3C/poMn08sHaiDGeyevGKORX6Mt13ulp9qaixYI6vpWwdepAT42BwwtBeapeFpn4qmGEVgJ+6YGSJv2qfcQ2K+Jn5DIg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066197; c=relaxed/simple;
	bh=cOmMZw1FptDTv7dBpB1jEGcjHY/aJ3ja5IWhYi0RU0U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M9oljTFxXgHMD3WASQd+H0U7r31bRRoA/F/2brJALPjfyfmfJVJkjzPpYIkSYaiuaMPqHdzy57lIpJPSO/RtQbKfFYmoKUAZSz3fiwfhE0Y6qwxdUGpy/mMjLwKOQFenG99dxrZYxCE5kE17qHKvQ3fLrTn9t7hJ36HRutmnTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBxzx3qQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBxzx3qQ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5339381b46eso51673481cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792066195; x=1792670995; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cOmMZw1FptDTv7dBpB1jEGcjHY/aJ3ja5IWhYi0RU0U=;
        b=mBxzx3qQfUrIaO9yMsM6y+6RMAiC4+tEt6HcIf+O6JTG7f2S5+Lw88kGHJ3/cnx6PR
         jJ8nABVKawBr01CNx8XYWILf+XEkdrmPLrCIuedo7bPvVj8D0bMlwyVDpne9bDPckpjr
         ydQTb28ptEXPB7FnOhvFvtdfzeR6AGCUJaWe7s8IcxRJ4TTuRiKJIL1QzVxvknLOOZJS
         J3y6Ylw4iHqIGp7j833Vf/DVKZZrywI8bTzSiAi6XCAigVN9mtpgvOo7DjtRaj1Ko8ML
         zD62+8R7ZaRVxs1XGh3m98dtJgZRV1flta6ZUvfUKYl++MymQkjG/BhqUhGjmhQR//mf
         DTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792066195; x=1792670995;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cOmMZw1FptDTv7dBpB1jEGcjHY/aJ3ja5IWhYi0RU0U=;
        b=O0qPQGF5eLa/nwhoFZh3NDBDr0ka+jjT49Hld1J1IorDz0z32mGV94F9Ngc5maS9Tr
         9vpCjZ1UCBhmWYUwmzJ7XGT/LGAE2kG+nHX66o4zH1yPBX2AVYJhH3oweP2aW+gC8oe8
         eSg2TFJ1ZxADXTTTOQESihW9YtI2DDQ1fAAyAz2U9A/cIXQcR5u6GxlrRgLeEsQZF6dE
         2yBEegSIwkvO7r2bQXSGNwlqpVppoZuRke2ZyudsZekacHIIANdM2YHhP6LLRLrpRd/7
         uM5yrPoqEQ6crNhC8THNQLvDvZ4R75f4WY+HtrtlLyQOHyAcydWGt7D7K8t9Wihrsuct
         /v7w==
X-Gm-Message-State: AFq9FYKcYjbAWTULehQZBSSqP67Fal9owCbPZoY635aP3ErnJYh8bQiH
	kj0vlQuzfll5P02AV/OZho9KzUsOT6tvfaAZUZ1A/uE7zGmMDMxxAt3gDn4mYw==
X-Gm-Gg: AYBFou3Wx0xURoJvDOYn7AHGTWzN5eWfrRCytAVNgpuJAJunNWfgRKnuWgkhwEOM0Y9
	iwy/qGSAbHmQ0vk+uzscidYiYKBA6J56TQ70d/w9p131iTcXBqT0RxAttBen10ClRQ0dDhx6uBa
	ulBVtGXQjyhJOETdn4OCXKy+bs2IoUFq7EsJJ3GuTZjJVkpIqWykHipQO3eRO4qlFPen4gI79K+
	FwOQvGevL7HI/HHXtVerjIWsVUddGmUZGH+/5yYrmQwT4heYqZxMXmRIKoW49arGI5Lt8p2kDdE
	MZBNioOAh/kbzXO5nHy6QSJYApvhoD4olR4omXhoMFeuWQjsdIAxEwjubqrZol2k6b8mvo6AiYd
	ni/yRZ0jpW8lyxROrNs3Asqix5rmn/C1mKkyWBBjJuqKx9RePsblC+UjQOgnWOK5tUZrK1uCn7x
	dXKcX8Mswjh2eA0ivF1fs1YQsBcrfVlZLWP36w9TrKJ/Y5LSti1yhuARtK/u+CgXzcU8l5Lv/vQ
	6I1Rg==
X-Received: by 2002:a05:622a:447:b0:535:8559:f0f5 with SMTP id d75a77b69052e-5359facb683mr294828011cf.12.1792066194810;
        Thu, 15 Oct 2026 05:09:54 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.70.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536128240a6sm23912371cf.26.2026.10.15.05.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:09:53 -0700 (PDT)
Message-ID: <6ad0c291.e0fcf82b.378745.3c36@mx.google.com>
Date: Thu, 15 Oct 2026 05:09:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4570337416607527727=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: fix ISO data reception
In-Reply-To: <20261015081450.1241194-2-chris.lu@mediatek.com>
References: <20261015081450.1241194-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4570337416607527727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtk.c:24
error: drivers/bluetooth/btmtk.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4570337416607527727==--

Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A637306498
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529392; cv=none; b=qL6KrHPYdVlyVHoKD1sPkOjMrjU6SsyUCXaNrw6CM2mHkZmv7HlP3tAgtRPHpN4Qjo23DUYnhZaz4k43rvzq64/YrK812GKZAq3e/3RI8U2cl6MYK6E1yLl4yQjDhoZjryPub1/1aJNhMyOs3Ys2S+If10y6fqckA9RcMKHnf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529392; c=relaxed/simple;
	bh=3ieBlftHzrAmEQE0UIaRFemFrvx/oX8TACsV8ScLpTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9SOD3WC72FVwEI+cjKw3OB4+fyXjPumyBWQ9c4dOmUldIxss4YEuRgomYf8dIrYniB4DgJDHUERE/DNLy5annJv6nXEfcH2+RmZkQMpXqmZ1LQPM31ALDrPV27QY2Fkrzwibj9N9Su098bszhDEwhbK8RAAPN/4e5MkAZzzgCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKULjE3g; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKULjE3g"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124afd03fd1so1846171c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 11:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771529390; x=1772134190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jNeuVdlDJzTVy0ArtyM66yG3UX1VA/OEWqHiks8coo=;
        b=QKULjE3gD8M7CUDqGURtaKcvnd/+/bw5s//Yx3tO+RK0Y5Asumn8bmiMEtTN4YAUIh
         JKe5HNI0mYAM2/hEmwmZ8Gi0V24zE9dsLEmvvI5ICX34QwO2hKQ6PF07sKYn8RKI2PJ9
         1ZvPbOFfcAT+VP7nhFCfMYkwx8YJyld1uajRSOMH3d2FklyGrD+/f7j7K9GwXCGV8hsJ
         930gpyovp8Pvoxx9c7qcPG+40S5G7pCyIOlOeMSbetTK8afq3PaLGfuXcnFJ3TfhzNlC
         yGx7P3j9b0lQmytNHvMGa9mBuoPDKFICBYQl0ON/Gcnfn+ezAic1N3PXQa91UwFltg8O
         TYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771529390; x=1772134190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jNeuVdlDJzTVy0ArtyM66yG3UX1VA/OEWqHiks8coo=;
        b=DeF6tzXYGjTyLR69bu0MnVnVq0c1D0FwRvEhs12/GL9j1UYIEFLO4iCmBevdKbzx1R
         9SE6O1NzMnGuuz9/bMYuRbVmisx3fm1KNFy1FlvpyRI55eHhAfOAMuOCoYpbbClcNwxQ
         U+AuIKImYEkSUc+4DFcjSJdYbZj4z4H84h9LPB12zt6oGyD7k123rG0badpw08Lsv1HX
         9tQqIfNS+lD9F36NbDsdNnKvPdISf7mlw6/tSKfjroOYJdXYPDzkH+sIECBduiHExOC6
         NcjzDvVsR7BbiQebUO28okuvRzExsShuoEL1hHHJE7B4dk9IS1Oho+7hx97lebgsv68s
         aRxQ==
X-Gm-Message-State: AOJu0YzYnJdVFAL75kDFcbatR+p3+eXbdEIHR8BkiSfzfQLduVWjmtYQ
	KEpGghpLy6m1Rhi0PQ1hFBtsQ8T0oF3Z9hzpgiCWRWlIcWMLZWtR1z5A
X-Gm-Gg: AZuq6aKCtJI1MbcQSBsttHyStkjk5krk8ZOaBEdjQattEHR+n2X8Tl7HhtwXpHVy0SM
	/fJfDz2I4JeJfU8HoRRHh8nuxKCscmIx1sT2C27e08bp2OzDlCbn+s/ii3r202LhLdECww3kq7R
	QiNccsuFDqjzwXXq+vFOlMTswo62dOGE5XOh1NK9ts0AE6KyHkxsCBeQWWwXRzGYBkGqTdxwBkS
	U9HVZ50qquvBpszPL41TIriLvvsfflWR2g4BhiTusqStFpeluKgbCREog3/Q7oZdBNYp8aW4i3k
	C/ur3xyQtRG2fNmkYKTgLHDR5XKsqy9tXnKrU/egbG7Y7OCWaoRIuiOJC0RDJL3lBd0Rpy3ppFH
	TIaf8ao1PzLb+3bQVsNp8WnXfNZvy257T9nbdxecWkGFZHQP1l9gQzmTrJcHiviNwNUkg2EX9yl
	GiL8UKTdzDmOqe/7qln/LuE+mkXpeYuE75gxUCisaIjoQJ+LV9HagfjqF65XNdtrscechiZyUJe
	4hrpUPExu3NKWUo
X-Received: by 2002:a05:7300:fd11:b0:2ba:871f:796d with SMTP id 5a478bee46e88-2bac97cad2fmr7938895eec.30.1771529390130;
        Thu, 19 Feb 2026 11:29:50 -0800 (PST)
Received: from kernel.. ([2804:4ae8:bde0:7200:a049:56ec:8543:a3cb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb67bc16sm22163368eec.32.2026.02.19.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:29:49 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: insidetf2@gmail.com,
	luiz.dentz@gmail.com,
	me@celes.in
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
Date: Thu, 19 Feb 2026 16:29:33 -0300
Message-ID: <20260219192933.805883-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADbaWgF53sPZbR3uahemgZVYv8rENT7-hYBCh5X5prvd3kPo3w@mail.gmail.com>
References: <CADbaWgF53sPZbR3uahemgZVYv8rENT7-hYBCh5X5prvd3kPo3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Daniel and Luiz,

Daniel, thank you for the detailed analysis of the lock.
Once again, I made the mistake of analyzing the function in isolation.

In fact, I used `hdev->lock` in v4 of this series,
but I changed it to `mgmt_pending_lock` (and `guard(mutex)`)
specifically because it was suggested during a v4 review
to align with other list protections in that file.

But your analysis makes it clear that the primary device lock
already serializes this path.

Luiz, I fully agree with removing/reverting `003ca042a386` as well.
The list operations are already secure, thank you both for noticing this.

I consider this whole discussion a great learning experience on how to
track complete call paths and lock routes before introducing new locks!

Thanks, 
Maiquel Paiva

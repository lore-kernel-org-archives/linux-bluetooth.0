Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859833FE36
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896264; cv=none; b=qJsl1PJN8VRVerIhj6YuVCVMyjfk0rw6AQ+C592jziPltCRIxAUw6AUW5mwn/Nz6N5mRU11MSOnSqptYENiPyO7J6WCslNPD1HxJnAPylIIDfvSWrGFFGU/ibMfsz9BhlzKbu0SGiBYUoF18JGQvKLk4b1EOn9yCMAoaKSfD+ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896264; c=relaxed/simple;
	bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=k8VgNHlDEQeZEJ2RvJpV7AieKgwK5QOQ2Q/l+q55Krx6RDGxINaRL0DTM7+i7fTEYR5Zje2DMuV8lDVYB9L3T7yeiM7RVM4T1NwWlbZLEmQIhS4u2H0+8kRkjdNaDX6tISrhY+DxRZ1jjmY/b8yXh5J06r0uHUMNO3YYEDive04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TjZEwn9f; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjZEwn9f"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f97c626aaso6425866b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776896262; x=1777501062; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=TjZEwn9fnqak5iDTgYcGWk2nMcxqUzjiiCOC++GMD08NRZizLLPYQ9ZxwKGNQwFSPj
         MiCKVWlYnrXmu8qrr9SQg5eh1VYUkiivYldOItUFny2XNW/oLvg+Qgj+SYATU2oeP6Nr
         qZWwV5G5nG3Gx38VlpKEc41RsrPI7ik/L0o+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896262; x=1777501062;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nCNK53rTjLnVysfgXoglxvrQ8+xq11LiIZcoNznmu8=;
        b=X6qC1tzZ3aFFDMnZiyfJBsEs4r7pfFJ5L2klgnH5p6iY275PqJQ0nRTt2bCdbH5YvR
         Tn5BxTk0SalWcjZXYv+jig5FQBPoZbZ/uNrcU4M3yZzk112tK+2Gqt0f7FxxOxVhqfcb
         /c3LocLvHQkkYE6ffnhMsPICTIIEGNWQd9gzy23keIqIjadj0x9y/SX7j8r3umdSVIJy
         DtJEpofZ6SShSQC7ARCwZIbjwfamFWPsIE138h7W/2G9rksFl2+Sox5h2QVtdewfBhLJ
         Ci8ICLHhyrt/tgmgh5yn8adouy3KNjcRhSJjwPOCqXZrcTd1ZSgPOdKM+Y9mNEzk8yks
         9ImA==
X-Forwarded-Encrypted: i=1; AFNElJ893rTwq20CXjkDxgSj4PwVtRRUUR3Ki9wANa3DvrfSDOYxBqVBTvrSSc7tJIkuYHmLh+ghpMHwj4ntpLB3uPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Auc2mC+k6q4eMk4EsNjGMrf605YHpMseexTvpPUJyUMZYkjf
	uMKboniFyYtuyWv2HB8uXBzMv5W8EJgzv2IvExECXHakGLtJUbz7gNtjMbNMjdYQccsvsFDoKK7
	X/4E=
X-Gm-Gg: AeBDiet8dQne9o//PxxW8Lp0V61GRHdnet4Tv/7iDUE72olObhde3jz4gNRZ/Hb+yvG
	sX+Q20D1AaJU2uiIhD/nnNx9+NNKG9x0+FS10BcqYBUY+95d388Tq+GLi+XQ20tszy9pJav+4/R
	B3us5gEOwywb9u9D5zgIqa9r5LYvO9q9mfCRy/vREX03AGy/O8WhuG1SVWn4aH3yRDi7+3iIxUs
	E3SXOGCZ/Sra0agzpXIlfBmI8JJz3nLICTNb6wjZDGR2KxMzOGK1HL4vD+XsBB5QZxRsxiYIefr
	x9vb7uiakPcJgXlDbuKy/5qvyuE4Hbbs86IauyKgZppEyupW3C51s1gsiSAqCXCdRZpjhUY1VQf
	N9ITqSZvbLcgzshRJxtpIshRBV1yfMFURaEf12hiA47ycmpn8vf0Da+zcsKJ0T5pTOdX9ug9QbK
	do4RCvLho4E+Q+PLIXr4XqM1isQ7cr2bJv5C8/s3C9xVPsXchPXY1E0SeShb+Emx1pdf7l
X-Received: by 2002:a17:907:6c0e:b0:ba5:216c:56e6 with SMTP id a640c23a62f3a-ba5216c6068mr1144596666b.0.1776896261925;
        Wed, 22 Apr 2026 15:17:41 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bd24sm582778266b.32.2026.04.22.15.17.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 15:17:40 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso34175675e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 15:17:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/h8iyDW+tBCXgaeHHg4hobdxs6e/hWAY3XYHlrNDWzhppUFZdQGbVv6wAt/gUV00D3pZ1lv5Qdm4/7hO9LVmc=@vger.kernel.org
X-Received: by 2002:a05:600c:a303:b0:48a:5576:a28a with SMTP id
 5b1f17b1804b1-48a5576a618mr103376955e9.0.1776896258365; Wed, 22 Apr 2026
 15:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Ruth <druth@chromium.org>
Date: Wed, 22 Apr 2026 18:17:00 -0400
X-Gmail-Original-Message-ID: <CAKHmtrSaDR4fBxN0mvEzYPHoOwr2rrtnOJW6fsrxzsBAeHTjQg@mail.gmail.com>
X-Gm-Features: AQROBzBzddXPT1XEE_H0hC-sWHZhTnR-Xrt8CI9iRdJBAaqlan9vsGglE4T7Hzw
Message-ID: <CAKHmtrSaDR4fBxN0mvEzYPHoOwr2rrtnOJW6fsrxzsBAeHTjQg@mail.gmail.com>
Subject: Re: [PATCH v1] mediatek MT7925: update bluetooth firmware to 20260414153243
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <chris.lu@mediatek.com>
Cc: ben@decadent.org.uk, dwmw2@infradead.org, johan.hedberg@gmail.com, 
	jwboyer@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-firmware@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, marcel@holtmann.org, 
	ss.wu@mediatek.com, steve.lee@mediatek.com, will-cy.Lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"

Tested-by: David Ruth <druth@chromium.org>

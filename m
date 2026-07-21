Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B092749C1
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 03:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784605762; cv=none; b=Q8sPpvC+PJWS90m8qn9TE1Hn7Q02jlRxM03QAUIz+rGM6g23W3vvYm0/cZuAaeZfu5/0M3VteYSk6jfxKKJE4z56CxhcxVL6Bap7jEQUeeogq+GdTV2FHiLv2OwqkRbx2LphYRdR4sd/Rd8go5FszRynTCT1GTjPds9Ma1nlR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784605762; c=relaxed/simple;
	bh=UU9DyipXEi0GI1vE2KXwoyZpIyDFREFIfcEYMWqEoPo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WeM0pOHkm/97i+sloA2XFoJ9hClapsq9F9CaWDO56y54lQ2t14DTH6yEOOldJDTdBqJnQ95wAbNFQFaw8oY/J5echylVrzwsCh1EEUVKOD5WaJTfr0dXY47Uz7bwyqSPZFb3kZEP/s8fDCnoDVZd5q8b1gKdrGiZS38VZZ56Ov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVdT2GfV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVdT2GfV"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c167c58f2so91206081cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 20:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784605760; x=1785210560; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UU9DyipXEi0GI1vE2KXwoyZpIyDFREFIfcEYMWqEoPo=;
        b=MVdT2GfVxeIghNXzysHI9eNwmx1ZDNJujJXCLArqZkomX7ZH0X2ojs0j85hjiYuDrj
         NH5B3IHNX3B4uWJ+bhnNXK/EMekqPxIfM9GGHYhPsTaIfB2fcTRjzjxc2OROjJh8QsOq
         5Ts/4YhE95c3x66Zx1WebRVo3vzOOdSaY/1SDSXL3viEGLgVpZ5aWp4e7/5/jz8pGn1w
         /9+yM5Ns8+NTONLwH3ulo3lJ/HF0kIMg3xMNsGaDJ48SmkLiZO9YJLvwBgAWoTQ+mo76
         tKkdcB0XdNOQGVDO89D+BgWcirOEKGh6pH+cs3bzTH0t+K9fk2MXQj/iE2yNOvXlVWHx
         5J1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784605760; x=1785210560;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UU9DyipXEi0GI1vE2KXwoyZpIyDFREFIfcEYMWqEoPo=;
        b=Lsxyhlp8+Ngjor0DzUTtsVtzO6rXZP7h1jiczyVvr878XRGCW75IWlheyF+JEXHIp1
         9F7NYthlcMEd6hp+IT8AI4zlBy0U8qELjTJnlXhPyNP3X2DU0JQvmTAkbNHra9wcMZ27
         YsIz3gDhduvruQW/wtopL38pqnMGLL9igcYWa9US9Sv72CZTsNBrgW/lxDfl8Uw+Y9ed
         hB6NbbRR0tk0bugpuzNU560SqU+ykx9FtAqioZxgbz43I6EfYxwfZfE5IMrD12mka5tF
         4pFsVQJTkW1JFfTEUuCZnH88k16RDOC4TvnwzE9Ti5EKPauU83jdmTA36VpXORvL0KrR
         zDaA==
X-Gm-Message-State: AOJu0YyJQzZXmJlns0mfIt8WKz6Y037ajTaLpO6tFeDnA7q6VL/ge8zv
	qTgXjlioT/R9GkuAhkRLxdn+6M6Mj/WK72vaEMo+h+wyMc3B5JJRF+Jq71wA4w==
X-Gm-Gg: AfdE7cnSOpzcKA/0i7pk7EpsFEGEFWIPcUhJlgVhb0LQZWPotu1Jo+YxfL4dIGOYHgr
	ZLK0TjVvGwjbSmFJh9qQRdJIi1Z4vk5V2/pqFLCcJvXC9dUBGa9rpLQclX0RgRM6aOlVzBRjsPT
	002wYqPtydnXF7hisbOxUMtXJeOhGJZm2bMNvcgavoatgrQpqEu0bHRp6xEASkeLjvHVV5In41e
	+I2Kaq+fhGKVFJgFI4vRSlgGsYI4q8oK+LIVDzdsgF401+OJbsZ796XUE5pXnC3xseEa6bGDn5V
	XnAPB19Ze2hg7dszsPV5QFmHWXh0mk1L64MOt5bB417f6KQeZdPeB70DJ+knStMb7IQgTccIrcB
	UkBcteHRI22OLBQHzU/CCGUo7ih8INU2i+j+oIMkT5xjaXm4cQjTLgpnqOChUi2saQ6LtkspMg9
	CAuyJ8z6qPeQ==
X-Received: by 2002:a05:622a:1346:b0:51c:1eb5:333d with SMTP id d75a77b69052e-5213eb757d0mr158975021cf.66.1784605760274;
        Mon, 20 Jul 2026 20:49:20 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9077853fa67sm106402476d6.6.2026.07.20.20.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 20:49:19 -0700 (PDT)
Message-ID: <6a5eec3f.ff298dd7.3b8403.cc11@mx.google.com>
Date: Mon, 20 Jul 2026 20:49:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8692212609529015098=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, edgardlv@gmail.com
Subject: RE: Bluetooth: btusb: Add ID 0b05:1825 for ASUS QCA ROME adapter
In-Reply-To: <CACUvvBVT=iVA4GjCHOwxdD9R6ukVmdM-mfr0u9NBfua1cBsUNA@mail.gmail.com>
References: <CACUvvBVT=iVA4GjCHOwxdD9R6ukVmdM-mfr0u9NBfua1cBsUNA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8692212609529015098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:259
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8692212609529015098==--

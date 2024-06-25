Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73527132126
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 10:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719311989; cv=none; b=sgm3HbXF9kfwbSxNuGCxXl4URMSyu8M3ICOGs147GMXzyLbERKM03tP8tJJNnn2g6PsTAbSU2cHG5j8TRc5QK5rsLOSnwbLP4U8BzdIf5W978Drdmf034oUMSW9RUGJx7NHM1L95p9rlYccrVFxkuyxjr8Wwy7CWz6soGuIHuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719311989; c=relaxed/simple;
	bh=Gx0Su5mq6l7ZIzXbPEPwyg/swjzUIEdl0CEPOOqsGa8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GIJUcVpibUzouIzkImLOTOslnz84q8UcW5zKvX7uzd7GS1ENxD/d9iDP1wYJIUC8uLFKPVQCzEjIJtRm32zGSUC0mt8G1TRTW+QaB9qLXO3rUFoT0gK/GPFvVzXvsCXWlkUtzHJnjZ7R+AOwai3IkzUFZMJnm5Q0Z5Jyt0QXABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxiWP/5C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxiWP/5C"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70665289275so1641809b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 03:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719311988; x=1719916788; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gx0Su5mq6l7ZIzXbPEPwyg/swjzUIEdl0CEPOOqsGa8=;
        b=FxiWP/5CLfSGFCbOW03zwIzSbVRxyAZSfU+wpan+fULtueRrcpd6xhvHbKgFNHCuE1
         4Nj3cEHsKLC/Kor/2TGGvx+MhkmrikXjwESACIXFW0WeYs8Ra1HQwR6RnUAqtxOoSSme
         Ov9QMqhvX1Z1Qs1VD9iTBlgSivQnt1VxwQWJIXpIjBuOMCHfLkBPt4PA9B15rNC5pKeX
         5IhDgDze/xL+B/rjF/3nDABm9GiIxEY7xXmKWV2Kd7JCzW6/jhldzLxl5e3Ije1niWlF
         rocStinKC2uRUwXvLWXZEaTckUN8N1U2ht2Ped5PkpcSw/fQDKKwNA+4clqtBn3NZuU5
         5e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719311988; x=1719916788;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gx0Su5mq6l7ZIzXbPEPwyg/swjzUIEdl0CEPOOqsGa8=;
        b=wr82H3gJ+B7qR3L1XkynqFg+Lgycy4ybcNnDXtzWDDgxhLtrCLSGBBibKg4HPuF6Tu
         CU6guMpbj0eRbRWk6DtNA4oLdjST1y7zUzWqAEjCm961k3S+l/NOYHzmOiC0owuzNy1V
         4xdglwMIXR6/gUanALHI+goceJzcNHkAUd8adGvcoDUjV4ask3mcBgExg4SrH/aotO2b
         p2W+BUO/4+NrIXZzR0Dd3fGqWA2E7zkil6RruZ61LWTB5Bwe9aQCLuFcE+7n+StkJcTf
         s1ESuDG/OEcA0x05+WwIi0O6zQzbnjULkJwbyEgD+fRdU4U3tqAf1vQLkTaFjX2Z6+oZ
         vk6g==
X-Gm-Message-State: AOJu0YzFMfP1Yi4U0qOxBPh//1BrX713ogFt24gXWJYDUX6vc5fACKPJ
	F+Wd7iL9b0Vy2eMqDizOg3/i4LRkpuHtycXC3KhKTUPqpeTHDOaxIYtJyg==
X-Google-Smtp-Source: AGHT+IE3V7noe/CeloTGh7asWlx4ptc223uenTudOHLrDX6wSHBZemFLsE8a+KbNfd0Tbtxh2Q0WzQ==
X-Received: by 2002:a05:6a20:3107:b0:1bc:b1fd:7c55 with SMTP id adf61e73a8af0-1bd13b899famr4207886637.6.1719311987481;
        Tue, 25 Jun 2024 03:39:47 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.137.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70674e10154sm4611408b3a.61.2024.06.25.03.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 03:39:47 -0700 (PDT)
Message-ID: <667a9e73.050a0220.9d37e.b6cc@mx.google.com>
Date: Tue, 25 Jun 2024 03:39:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1525329420154971618=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, eadavis@qq.com
Subject: RE: [V3] Bluetooth/l2cap: sync sock recv cb and release
In-Reply-To: <tencent_CFD37DA36B4965E3A7C45E7770776C86DB05@qq.com>
References: <tencent_CFD37DA36B4965E3A7C45E7770776C86DB05@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1525329420154971618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_sock.c:1239
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1525329420154971618==--

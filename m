Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8387E1CAA8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 19:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325249; cv=none; b=Q3wqBRN/s6xk64W0TITT4ZCZNvllOeaborbHvuK7sXR2M+090A5mpuysoOeZpfDmUhL0Mz1f5fe8VEd6izrrx1r7PTNX/G6KEOIK6CXKGCMO0kMkVNxPBwTkgdIkGh2Drdsyu/Ar+blB7ti9TZaZIS1BywUflxTGVdHpHmWqdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325249; c=relaxed/simple;
	bh=rxebzVv/aZFQ6K+DeMGhrvuH4kh26yqFItlWRzd6Wno=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YPh0hchWcPGkJwTq4hd4jye2lrFLkAx4WSxwI1PK0MSbMcSuXuGpOFcchbdjCHv9rqm0iYzHu3Cgs9+M/Lfvc4qRZ58lGv+QGb4fbszJlgOLTwhVHb67NLhRWNWyH0HIHRIO3duZbeB5T9hpn+suUyeY5XMg/KWasz1wruSMhOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3h2oPgN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3h2oPgN"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225fbdfc17dso55086065ad.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 12:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742325247; x=1742930047; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rxebzVv/aZFQ6K+DeMGhrvuH4kh26yqFItlWRzd6Wno=;
        b=B3h2oPgNHdwCQGkvTYrNwIVL6uKxOAtLg3Ig5QxaFZolj+pIzJR/LdJPtOT+zcXj8m
         DpnRJTHmWtAvRJ8zsNOpIk7UlJful3ywjWXt9YBeF1Ko/7WdVOKCKtCFkON9JQxfsFhz
         AqtjBbFVlVh9XtBJpPlcDNPG7if24k60MUFR3tyyHmZC6mX5zzPCho+mNDaL4KxXvQPb
         qJC5ER81AZMCsOk/msigVuq0jpbN+iJjKEnabShCjW4M6idkBQRjLEQ8g8xTBJHOKcIA
         vwW8ocy2frge7fK+G4XagjDYuEUi6ht9shDhamXWktzVBV2GTa1+eTa2kgwZtr5jbStz
         n8Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742325247; x=1742930047;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxebzVv/aZFQ6K+DeMGhrvuH4kh26yqFItlWRzd6Wno=;
        b=nrBuRzm7hFEkVfHpzf90T0Tzah9zzIL3cu+7cBrQffu0jvmZx13Nlrs6V47sHPMXte
         HcXws99Py5n2GtWGRUhTr5Qxkq0xPKoWzcLWFu3T6wkuwUzInVeUotgueIZHXTFyZHhi
         54EfLyeN7VRkUuEKco87y+VJPDSLWfTOADzHGLu6VFtKzaGYD+00eYx6zrYii9ifNKsn
         zKJifTLJyzvmKKDVymW/9FJZTrUSZbVowagi6gojH3hWPu7RqRJPr9JVXgJaQj4RVVTj
         iUQXKrvNHgfgcpMF/xmkHcd+STXPe/4XxbJiK+2Y8lRPyRmlrKie/Xe1FB6tXTy7u6oh
         RqNQ==
X-Gm-Message-State: AOJu0Yy6jW0GpVAn3a7+AwQvzoGxxpCUSB24QUvsKe8gFCBXzrlgNtq9
	N/iLdg1rfJAZRvBBYUp72Ubb1LfmSXSYbVLuUUxwyvvZ9gkQrLU9Sg9pWw==
X-Gm-Gg: ASbGnctcntRDhiY/9lgcPAS7y5gF6A67mrdBg0xE6CiwKRigjsw5vfho1865FKAdj5D
	bZ2wqrRUgcA5e55ewzLMOQkAyuS1zdXNEHi2BfPab6wTiTsodxdF1imHhRYcr0TOIZo9u31qrmG
	0tgDQgCnhNLNy8DoZ1bmDzY4ZEnlXwIHDPMGtq2aU5VdXlTLj1pxd8snmCtERLylHeNEAurcuB5
	VaJrV723MBcIyWjKxGpYX9U59aZzuLGYEpGJzXAOLbR9XQNzOl+qbWzSmlae4L0UH7W0nBNgNxX
	f60OZTd85+XU/0x56UQs3ZUlB54otO4j2TOpIOgiPH80GVLLxA==
X-Google-Smtp-Source: AGHT+IFfHviu0d5MxwEGnhBgGATdlZMRI8ekXoL09hloBCVdxr58YBfRZosKVY90gh9pXJFtOPvcDA==
X-Received: by 2002:a17:903:2f89:b0:223:7006:4db2 with SMTP id d9443c01a7336-225e0a93e74mr214184135ad.31.1742325247483;
        Tue, 18 Mar 2025 12:14:07 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.42.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7d9sm98518165ad.195.2025.03.18.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 12:14:06 -0700 (PDT)
Message-ID: <67d9c5fe.170a0220.21d2a4.7507@mx.google.com>
Date: Tue, 18 Mar 2025 12:14:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5580641511702557549=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
In-Reply-To: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
References: <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5580641511702557549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/linux/skbuff.h:478
error: include/linux/skbuff.h: patch does not apply
error: patch failed: net/core/skbuff.c:5523
error: net/core/skbuff.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5580641511702557549==--

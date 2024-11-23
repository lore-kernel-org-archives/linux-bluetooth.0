Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C262AD21
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382036; cv=none; b=daWFuiuEY/vUcAPszMQviaBEU6g2BzqF4X1fBH6tnXUjh9SRI/3G+5/ujgBfmdNok88D09ecUjiIvtcNZuZB0oy1t2behRauj6YjaNStMMUJ8Z0h8pY87aR616rqv/DesRAejbaaF2IXsnW/h68MWijtEFhWmXeJ0qm5bST9rpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382036; c=relaxed/simple;
	bh=7GXuYvHTkqOFQxpF4zVEnHbTI2mq710zgXHFmmVDewI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LJtFH6M4xOhvnLpbuDGODxkqh7e7ICRqXlHB3diSO2Z2JP3LrvtCQPuO3JbJnISFnAnyZVmMl20XCy1X3nbEWwnw+yV8V4nBMcScSSJprWGfSxGD6vKdGVeFwo2RaGUyghIFcb6Otzi8FLvPJpm4wsanAyo/pRn5wzjJcWtN87A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acggpmJ9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acggpmJ9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2128383b86eso30259795ad.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732382033; x=1732986833; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7GXuYvHTkqOFQxpF4zVEnHbTI2mq710zgXHFmmVDewI=;
        b=acggpmJ9PItEPLw9WIC/LCZ5vXrm4wkeZD2F2LTBGOoaMQvdEPyx4ZNKN9yEzd0t5p
         3Bzi6Y0ovPrftGcxCMTZit3vCj94ew+BAgYc7FzZXt65fG8uXERnLBD95Akhvt/+guO5
         JpqB13pBKm0Kdq75VuNKq+s+1jCv346NOHNpPSeSDKFrGyR8L5dHU8mxMWEeh+s4oTzE
         r887ob9dGOASzNByGzICDQtysssNXzgAPDGjX3Qi/tGnERhVZgF7PE2Ht2nWb3G11FCs
         n6+lyvd4s3YrhZmGo1UOfxTn3XLiznuMqKq0OavLEUTkafJkNQqOI7ER1ZVczVCQovbL
         +okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732382033; x=1732986833;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GXuYvHTkqOFQxpF4zVEnHbTI2mq710zgXHFmmVDewI=;
        b=j46QHM+SPdswopkJYzf07AuSQ8sZQJSjIXsY9KgywV+fhIqpfZ6QFWtRDFfYIru7YV
         V7AjAJlWsMCimTB3tWVeZ9y2psu3usmsCKnnPauVfDqYjjl74XmEXlrHrF/LQk4W/iOz
         txJPvujvwgV837jR/+b+y6osZanWY0DFeGCPVZayShG3ayDR3iqASsI0F8gntfSA6OTq
         DzptXvjjmOTtfi+q3oPXowW2CbbnzcsKVcrKx6NK6zUKlp6ex0tHQkrYDa/LOCysdNyg
         rmvPCLDoftUD/hcdkAN8WEOeeAVIVGfAN9hAjGKNDdJHsbE+tJWw1qTmsxPOZLsPlSw6
         /uVg==
X-Gm-Message-State: AOJu0Yy0KJn659OCUMgdubzunTMFuiC12S5pqdG3SgysXsgETyi6MUQu
	+CDwLo4wUR046/t6urntqis41m9dNdJ3kk9VfDJkPYYJLcKsSqZiryCWIg==
X-Gm-Gg: ASbGnctlZ/uDwLb2MAK/Ww/RXP7NBZoUFQlsiBTYXfjyUpexE2SRXq9TFNfeG+/XUDW
	UFZzq55e1X5bPTTErE1LZ6v7I4b+MODYruokPcalA+qW+yUbwolOrwiM9wKhXX3npqaSPrbiklw
	rpZaZesbN6KW23/stUlH4v9mkaMzpu27vleMDMYIQGDkzDueRcwfYwWFS6d1Bjy0Z9t/jJfTNeV
	IppIdQk+sa6k20aRGrVvdsnj22RtfocY2yMQCDZs1KfPe4UagVWftbV
X-Google-Smtp-Source: AGHT+IHZps2y4N+7ZjnEx6jaehWG/WyrnlgJG70Gllecy8iGCkV6QmaAvfsejEydT0LZUEgfyEA3lg==
X-Received: by 2002:a17:902:ccc8:b0:212:5d53:d02c with SMTP id d9443c01a7336-2129fd74093mr93912465ad.50.1732382033489;
        Sat, 23 Nov 2024 09:13:53 -0800 (PST)
Received: from [172.17.0.2] ([52.234.33.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2517esm34820885ad.269.2024.11.23.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 09:13:52 -0800 (PST)
Message-ID: <67420d50.170a0220.343c71.1dd1@mx.google.com>
Date: Sat, 23 Nov 2024 09:13:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4379411960399645264=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, j.alan.jones@pm.me
Subject: RE: Bluetooth: btusb: Ignore Nintendo Wii module
In-Reply-To: <mAaTd8WUa8rEKmRjJCFc5PohACS9Xdx5NSBRdEIFQIkVisnPvpByHXSOGV9hiIpz4BfIknYY6rWr-5LroHjeAIsova4ytmci3cvfqk6FiZE=@pm.me>
References: <mAaTd8WUa8rEKmRjJCFc5PohACS9Xdx5NSBRdEIFQIkVisnPvpByHXSOGV9hiIpz4BfIknYY6rWr-5LroHjeAIsova4ytmci3cvfqk6FiZE=@pm.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4379411960399645264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:182
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4379411960399645264==--

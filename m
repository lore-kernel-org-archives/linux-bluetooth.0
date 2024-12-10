Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94283211481
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733845548; cv=none; b=b9Vq68tVV39GQYvgnbVNNgWW/tpx24mlMb+6uP+xXyUZPbUHdRpo5sISEwon/gmEBJ69N5tjEJYvSnXOlaEnrepcNFIqJrcwAuZOyq4DrQYjniIFwzF9vmQhuYYL7ai4YAz6d37gXRZMIOBnlBEmQ+Rn8Qql8UwLmhsAwWVmAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733845548; c=relaxed/simple;
	bh=SBXCfWmbXhOQuU8tCgdDw5kwL4pxlchTj+XinCXkmkc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jIZQ7WfikLBp7rqjdsGpwKSdBABCamrUETXAYqY70xqYxoC2J0dmVczTJH+fT28GMeJ+kq/UJ+xgpNPe2zPvE2A9uPTKCbd5fOo+nLnp4SP5y8Gxfjrf8llxH5gfXdXwIi+GNgNGNMWYU8Ss7oTZ2VhY4TVE+iNCVIxaV+/aVm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnHUEpGm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnHUEpGm"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46753228bfbso22133661cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Dec 2024 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733845545; x=1734450345; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SBXCfWmbXhOQuU8tCgdDw5kwL4pxlchTj+XinCXkmkc=;
        b=XnHUEpGmtUsAPK0X1AQ1reUMcHh8J8daRVxSI+hIyDo4qvECRLzeEwA4EyL/+1iPpQ
         5Z1Y+I8Nc1FftTSaKvas2OG1egVcUtg0zAXFQQGPax4xFYBikT/sWWfOqQIWCQDjU4WC
         uPOpSEkSWqpbTMQ9nBEzxWTmN4sYMp8HL0VBO5Eawccc8MCSQY2SCaWJnddSF7Ck7omG
         ArarciSH38bvDzQN2B42W0RjNqJczruugNkwkNxcG5RUwK1QZS+GVX14EHwsZLB9jVV2
         b0TrzR5JbX1bwgyp+u/7nj/pVh1wZHVl2oAaSDKBWJy4Kskn3Emt+M5/67hS2fZc26NI
         5cNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733845545; x=1734450345;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBXCfWmbXhOQuU8tCgdDw5kwL4pxlchTj+XinCXkmkc=;
        b=kJwGfb3jxOyLeJ8/n0YGbUsWGBXE2C4vE7sBbBTlrl67h1VtsT5TXyaESQjp8wY1vm
         mUv8/dsplbCcgvasT2N1Vs6sPgVHlo8+/HN+of1+UGMKxoH1B1xRR1pnKUzqnWRA+3IE
         /sO/YOa9Vlcnt6zPm6+0w5oSycrAeAIdfeDZt4UGqjtCFP6EFIP4rA78URMhmCJAqbY5
         g2bKispxI4cHHSK6LclU0DfHtVykjo2/ovea8S+QZPKrIpwZbzaGZKBc+Bs8aXXiUJIk
         XlXoymcF9EBBjxoBh2v0NGXkA0lpga3FQ2xdnsD8HiAPdsRZIyMd2LvD1IhnFfydqnzy
         2vHg==
X-Gm-Message-State: AOJu0Yyj+FP43WLJ72tctdHzoXLd6bMAGVDtBoRq8j0o948+JEwVA6yJ
	+o8JbRZJh48nI+xC7Q9yVzCXY53pd86qbHAmg1bEpBrpfaLHDrxOODoxRQ==
X-Gm-Gg: ASbGncsryZuPhqx4ChmbLh23IGdNwXJevLGhmBlIgQgvmkbk9kDfNOavnGy/A/FAPAQ
	WALxe24m/W2KnNlHqxNL9UTfh1oyGvlsadx4kvJUiNPmVZPDgfGX8u38DPk7V2lWq1lBvAx+Y9s
	jdd8CoJnpg33SR/5rznxcKSCYNPWDG0AVcfvm9jvsaL6UHmbvUqqYCyHGjcKc537gFlV9DBbCGH
	HYxJVJnBowBVCKBJwFTTmv42no2LQVnipuiTMz8JvLBsOiNiUtsS3kymA==
X-Google-Smtp-Source: AGHT+IEl1wztcW7NuExhuQX+5DpyMha2UZtbLHugq535T8s8gGo7pvwaIP4lnZT4MuQ3D5M0iED4kQ==
X-Received: by 2002:a05:622a:4a8d:b0:467:6dd9:c964 with SMTP id d75a77b69052e-467720978e0mr73689271cf.53.1733845545180;
        Tue, 10 Dec 2024 07:45:45 -0800 (PST)
Received: from [172.17.0.2] ([20.49.54.17])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675fc8fea3sm25985131cf.85.2024.12.10.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:45:44 -0800 (PST)
Message-ID: <67586228.c80a0220.16e65.a493@mx.google.com>
Date: Tue, 10 Dec 2024 07:45:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2735268291247062058=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: Expand firmware-name property to load specific
In-Reply-To: <20241210151636.2474809-2-quic_chejiang@quicinc.com>
References: <20241210151636.2474809-2-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2735268291247062058==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi:857
error: arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2735268291247062058==--

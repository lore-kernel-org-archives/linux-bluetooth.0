Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CDA3E3DAB
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916482; cv=none; b=A0xAsm6CN1h/jlMqnS7mDQk3ZbRHkAZvgbA5G5Op5IrIrA/2zXfWtmkGif+kfgo7HH3+yqfDPpYxDp541biQy4a8IYdYFcV0cE4ft2CWICi45O4adtslAMH7b6KahTqKZh+fy6dOZGyVHhuP4xFNS0JYvJvIf3s74tn4liErf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916482; c=relaxed/simple;
	bh=yx6fDkaGrfKSFM7+4oDPCmIFdFhkRN90kcZqr2GKj7I=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DBSLYWSNMrIgii6Hy+ysWP7Htj3IEdX9JJVNhZ1yLzXZC42QWmB1bkI+jcX9s7z2zbGam3TNa04S3JktUE3DYO2ul47mOsF1wkDf2muqVxwo6Px1Sc+LJdUjcMkpSNP8cQfzSQDhzr+cnq4u9fSNCjgQ17QVGm6vbCcElONWWc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfBLjNDl; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfBLjNDl"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4637814eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916480; x=1778521280; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aQeMRA0Uq5KweRQv8Hp/I0CPbRxqDLngo4mkRKrUj8Y=;
        b=hfBLjNDlpG+Fab7h0Iiavnmb/mgWBEFwM7rdgs+ls/YXDW1VFS02ZpoMQCkcPytL6M
         rFCkZQWUnzv2rzqYF8frwc017s9M9fK+a4QH7Kv1TS7zvP8XWrDpRi9JDC0yb0U0UCE6
         EyFSbJzEuJJkrwlOx6uUdTWPo4jJ3/y4g1btt+a+mqCu3f208bLucy2x8S23GrM1Lp1t
         0Wzdk3vorX4ENMnE80tDA+i/uiKalTNsKaZiKcD/tucox9jwmvdhupcTY3oO8hiNX6xr
         uFGdtlDvlY+z4/6UZHsY2z+0BrOk3OrwbG8B82S1pYBZZx9ZKLNc0Jfkui8rqVICUSWb
         Nvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916480; x=1778521280;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQeMRA0Uq5KweRQv8Hp/I0CPbRxqDLngo4mkRKrUj8Y=;
        b=QRXMIx2Fp20/7GTQ5iLF5jbcDMI+dnTeCfcP3VjQp6CZBulRg78r4Qzhbx630LW2lM
         mvkpSFfNibCiD4KeqIkNh3LHixpS/3ueFZq0F0hslWZUPKqLiUXebjWcQKb/B2LjfC59
         +QUzv7gaRmwuNuMXDZYhOPFjE+wOkdViMzWZ/H024UGZ7a3yG5bTaTjS54Abjj8hvxar
         858b/xfFzF60kku+m4FOgD3NoLXXlp1FpQs8mgIt0E3Nrbjl4qOAbYM9Edg4aT6+8oYi
         6b2n99YKNNyoLc+UxmDcliaHJYLQIwRK3KDiQqeGpdZIMmAWRtCMznNVah4Di2t7Xi+J
         NOIg==
X-Gm-Message-State: AOJu0YzpxLYC1trOSbEIcRn0jzV4JFK4y+SidLDfBaPc18q0wDC4kPax
	oQqvqdSVw12vEcECWa6fm6DPTgP12foxA8WeEg23aeDp8yEpG8OQGaPP0sCiJw==
X-Gm-Gg: AeBDieuq/XNl7nnsTLj6j6F8jpbIb8vmhamFAHJhwMQHwxW22isdi55wGyTj5bl/StK
	+qZBCeyM4TrZPaIpc1afJ7iu9ITit7JZtmoJ4mZSR5ClXP0FE5g4v03YXrMO4Tsp97DSS831K7r
	OYF6mx00Y56WzVJB89dwMQWCb5Tuf9Cp1oZsJrYR79/ZvKWJIE7ErEWqDbNyzEdEvJlOA0gs0AK
	ui8F90k2ZDEVFsvKQvnEOPPyUwUDdyoWoRSXCxlOQdsCn37i4eqKiTtojb3F9pIFH6uxSKBXBnf
	/BSTWPyOzAe+McCtU9HVBQLrMkRI/SO/L3msqto8GRvL2d86AcGAmphYD7B3gSEL0usbIrz+mrc
	IHW3qsfXtneY0QMNdHZNm0MR716S3EiM8KDE8MI/Wsh0fSOY+z90zJxlTMwLgD+GtdSf8H5yxTi
	GIlR9cQPU11j2gg/ySEVv2djoA3LNldAd1+qia0j8=
X-Received: by 2002:a05:7300:cd8e:b0:2ca:7eb4:3e0f with SMTP id 5a478bee46e88-2efb7bdc8c2mr4726124eec.5.1777916479933;
        Mon, 04 May 2026 10:41:19 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.56.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bb60811sm16584144eec.24.2026.05.04.10.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:41:19 -0700 (PDT)
Message-ID: <69f8da3f.050a0220.2467b.b98a@mx.google.com>
Date: Mon, 04 May 2026 10:41:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6141129431244289972=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, lucasp.linux@gmail.com
Subject: RE: Bluetooth: ath3k: add missing blank line after declarations
In-Reply-To: <20260504165956.35199-1-lucasp.linux@gmail.com>
References: <20260504165956.35199-1-lucasp.linux@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6141129431244289972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1089418

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      20.75 seconds
CheckAllWarning               PASS      23.21 seconds
CheckSparse                   PASS      22.35 seconds
BuildKernel32                 PASS      20.58 seconds
TestRunnerSetup               PASS      420.64 seconds
IncrementalBuild              PASS      20.52 seconds



https://github.com/bluez/bluetooth-next/pull/145

---
Regards,
Linux Bluetooth


--===============6141129431244289972==--

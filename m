Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C67377EB2
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 08:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721756; cv=none; b=Jr7p6/j2WiYgfg508xaFmJx0aAvLja13XpB5rp5K992E0O9BraR6STAFuL7pa86FoQ11Ya+51uP82jLT6Y1mUNj9RUoVs7x2gYd21sAY8Y+5//N4nsc8zJMYME/D5atKS6dUU8nYdnB41v1gx1xJnZVPEnTh+ZPdi/9EhHyInO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721756; c=relaxed/simple;
	bh=/qW1/eKb03DNDlTAK6llcONT8EHvtPQbCM2FB2ECGk0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ea295H2iHlaoCIWdVvv6yL56y65cPNVQjVe2uc/gX2gl/qVuTyCRJRyrZwdm+heKjeJ4QW0Yy+luEtPpKltHPIAhu4S6/aiMn7+TkGZRk7bPweGi5grKvlROoeJynvxWlQe/bxgFP/5y7rQ1dTTmrSQhnZyTplYlXz0ijClka+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKUCAhh+; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKUCAhh+"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d87c138e1so6913181cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775721754; x=1776326554; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/qW1/eKb03DNDlTAK6llcONT8EHvtPQbCM2FB2ECGk0=;
        b=FKUCAhh+7Q03U+s7f6I7w3T3N85vBqel3McuA3bgYNm4H1k0hFGUETKTROd3AgZS8o
         pxsUBLDkudw+8UznQe8GtQGavaL+qabFnhi+23KfOSOKdytMoOhrwuxhQ529o3COfGP/
         cEJhJ6SxwYWzHn6xfzx+eNdPvt4d7oY/BqUXZIFIuatMEgC11unuDdIb2HpsTS1fs77j
         youdGy4SJ3xV9BtMJZ6sc1JmXaS8MkwTaWFWi1dihrNvdedjK7Tkvrso7yDzi6A3WNrO
         pLvkU8h1PpH+Wlk6T3MOZygMohGRu1IEFiaZdV83HKN5IHEf9K0eJ5lD6vP4ekf9wRPC
         MrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775721754; x=1776326554;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qW1/eKb03DNDlTAK6llcONT8EHvtPQbCM2FB2ECGk0=;
        b=TzMgHRsADM+iIvi7JkOtMw4dAey3nAAmpxs8J3Fa7AYFhMBPO36HpjQSjtjmaWLu89
         J/Ogd2uwVo+lmCU1mtXmmQVonGGlr7KXH5XaYp70E8rK4Y0HPy6gTRzye4t+mDtInd8D
         BUIxlcV66zyCVRaPBbNBI3v54F8A3KvI3cwyPdYAa+kacHdxif5zgIx52IdoFFsQa/bL
         UAnnduAI8dWJDQ6k8b2OMFtWeVTAfRuV6bcA+rP5WQCVXLbTZq5FryWfMLcbK/hgHPHZ
         lmCQ3grdhO9r2yeydj1ywy4Qn4wmiGvlXHcvhcZD0LWUSIbzwsMwDx95nZnZoiK520xX
         nVuA==
X-Gm-Message-State: AOJu0Yy8JMm9ovnyZlrvB3CTboyc9jyF8B123fzC9ak5vxRUMSHHaDQ+
	ImL54rJHx5twyj+p/q7YmJHc4y2m52F26+/pltARq/9q6K6AIaaid2h5/V/6a/a2
X-Gm-Gg: AeBDiesSEmXdtIZnT3Uy8B4IpgBbWNTfuSyUANbnOtOM3e8tQBqvCSB8wNw+MMmweAr
	el5HhlJttzGNnROjG9+cKaXJmcTuwN2HijzVSey3Evb3TQpYSCUE/qnCRW2rAJ8UAs19jioapg4
	9iJSHV3Sf4Hu2fdBzqPyTb+piSdLBAbOXwLF7dn1J8mvqE9aImTQ9bDf1tXvtztdRJehNR7WapK
	BsCNyxGWuegIJFC92+liSZtWbjO8P7UGkczmdFtjzrfnHVUS0Mdh4P0kXjEGjhaT2ek4PcBuB3t
	JNS3G4m4XIoDomzteBuhHC5tI1VeNJbvMqgpxbbvCydWHgeYrEcmkzrvWfJ7jT0dLA8VPbTJfJB
	YOlRHKqlr9jL9POtSOLbD3JJXrEhgepweih1Qv4NprBSpSrJvD0iT+bm5+bofMhd4UElXIIMVYO
	UGrszl6N3HA4HIIl99wUDvoLTxENBn54We/8ztwFNddA==
X-Received: by 2002:ac8:5844:0:b0:50d:8b60:ff13 with SMTP id d75a77b69052e-50dc2174a6bmr36834721cf.14.1775721753754;
        Thu, 09 Apr 2026 01:02:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.30.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8aa1c6d5856sm104097656d6.46.2026.04.09.01.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 01:02:33 -0700 (PDT)
Message-ID: <69d75d19.050a0220.e2061.ca01@mx.google.com>
Date: Thu, 09 Apr 2026 01:02:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1378322715800358470=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jianqkang@sina.cn
Subject: RE: [5.10.y] Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold
In-Reply-To: <20260409074429.740279-1-jianqkang@sina.cn>
References: <20260409074429.740279-1-jianqkang@sina.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1378322715800358470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/sco.c:305
error: net/bluetooth/sco.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1378322715800358470==--

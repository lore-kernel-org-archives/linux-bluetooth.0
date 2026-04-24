Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28965392C56
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029369; cv=none; b=WcVqvd2JwrwzUaqn19G2lXVqRPVZKB6WqomwR6KbCfYIGhHAaoMP+hg6Qf6EkyVeeTXyg1QFlwoi4XBIvAdMxv9qSl/uTR7LHoEsxSVpHr3A/TxNBQywGJEBqMO9dbxV/ToJRmgAGtRFE7hbLN16UbX24ZTRPQBh6bju/ZHlUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029369; c=relaxed/simple;
	bh=PXF/QcBQj1PkX5+zdzUdrqwAhRms9fuL1YBpAjTq7Kc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PD3Bb4lxwnQPjn5hArNjuHyKbfop9nfwUnuqxy/IBjS0uDlPsxWzVMtHyh22CEgKmn/i/UHBUKwOqLPl65+wPRldyZJ4BkPrG6dvNalLd0uTddE0nQamxv4bFpKOHFswQ5VK9aSqE/s3ovGl+y6tOLRpQtP5iE1CAwvNcXWs6vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvFSN6x+; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvFSN6x+"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6948ed7139eso2460583eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 04:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777029364; x=1777634164; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XmDXbG9zZO4sBEnLCC4x73whzSkDNR2rajpBKxkXVZM=;
        b=EvFSN6x+IQXSj07fc/wItUMR0S2Rp/8+2cbByBLw1+6vK70qKIh2XHHK6ICqUgn6rI
         7O5rkDsruWf1EMUFDhtkfyRN88g2gHlqtSoh92F/BlRZu2t4Ywy5d5N9h63n3zf0fhpK
         TYgaKWAmq+pUtFN1m3IZC40gLmV4WtfHWDTD/OSJc+Eq79kKJy37Cc85FJZsgLC4GTMN
         lQ+T1B9y7tCfT8LEz+DDWxZNPwutj212AiFswhR86KJhb04k9j5yai04S6/Acqp+9GCh
         OiHKIJWlF7Vm5jtEVc7Pw3Co0xyhb2+6NA+CUXHaXRs2EptBvFgBslhvShw+qFmGUrxK
         OQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777029364; x=1777634164;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmDXbG9zZO4sBEnLCC4x73whzSkDNR2rajpBKxkXVZM=;
        b=I420vkVBNvwvmVu9wjaXnUFf0ajhMIL6U1SDHW9wkNQ22K57a9cGd1gl9DcPz7Fkyq
         ZvlEGWmiL9g+6V5X4Hihe0jYleSCa3u1fcse58H7pLRuQ2AJaAXVNmwgxD7y6qaxOAec
         wh4Alp3y/RmkbDCbKVJl3uTRMdYrk58Ad4CGBGmfI9AZnqOWAX1NjrydSQkrNZJnk4wu
         XDglW1qkGkUXRJtDie7VmSp1XdWddnctq0RLHvTGp7e/lJWqPDLJ1QguoRh6KOfH5eCl
         tTAaRh1lAumIzJ/MRNXWZzNoE2+J/Je26q7ppM570okwFMIOddIEKeJ85dg1b6esLYSi
         lYxA==
X-Gm-Message-State: AOJu0YzzQB/ujlDX7KH44EixzDX/dvG9OcVOyGx7dpaa/IWhlYCrw2Zt
	Zuy+1mvQH0xF5ideLYraTcxYBeJuP6mix6xQU7FB/2+reL9m4Ln6XPOw+eU+pw==
X-Gm-Gg: AeBDieuqUaqpkQ4206+3mq11txCV//hn2/mJ5ll0HuTuC8njJQCK1APwumpDl3YKEmz
	R62VQo06vkqIgQ8+UGYcRQG19ZAwVoeaVsG/teHxRHzmkfT2+gtB4QPgldO6jwRg/yawYqoojJe
	MVKB1rwvYrDOHoqn0cjcI6hAN/XkNurZvOEQ+tBy3f1HAfM3DtxeFw3mW7rCddcKt5kig0NGGC8
	HQTAafwq9HIZSA6RYmgIyh7DBuB0dEeVzorvMCWfYpw6wnErc33cQiDa51ZZMDCtXYmOO9sIfdb
	zBeLAZeMV3V9QxXJWuQBWFRSiHYDU34GYrvfIfNKckOIApdjh6vxw2eMZ7RfNTqv2z0ykMZQGGH
	2kIrTiYVL8ltlt09oaGCepc6vWDbvfyb1cQKZZgi/UqVK5EGnzhu6M9rncgXwKPlzbSI1Yk32Rr
	jy02Xh1AJQVH4LamHGPv5t+j0quWs19dVl7kAJKrzyC+acGoayyknZ+w==
X-Received: by 2002:a05:6820:180a:b0:694:9392:9b0b with SMTP id 006d021491bc7-69493929f03mr10678226eaf.26.1777029363832;
        Fri, 24 Apr 2026 04:16:03 -0700 (PDT)
Received: from [172.17.0.2] ([130.131.237.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42feebc3556sm4580804fac.17.2026.04.24.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:16:03 -0700 (PDT)
Message-ID: <69eb50f3.050a0220.16b98d.b17d@mx.google.com>
Date: Fri, 24 Apr 2026 04:16:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2056455230381889443=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: Bluetooth: btusb: Add Realtek RTL8922AE support ID 0x0bda:0xd922
In-Reply-To: <20260424100003.357700-1-zhangchen200426@163.com>
References: <20260424100003.357700-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2056455230381889443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1085130

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      26.56 seconds
CheckAllWarning               PASS      29.04 seconds
CheckSparse                   PASS      27.77 seconds
BuildKernel32                 PASS      25.55 seconds
TestRunnerSetup               PASS      576.20 seconds
IncrementalBuild              PASS      25.23 seconds



https://github.com/bluez/bluetooth-next/pull/119

---
Regards,
Linux Bluetooth


--===============2056455230381889443==--

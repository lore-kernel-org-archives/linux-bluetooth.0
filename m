Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C346017C64
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875959; cv=none; b=XV4SOOfO2GLkmYWk/pDtGn6BviDmvGqgDN66qcc1Bafab6c4tZVXcng73ArkERpsQ9i+/8lMsot/aEfgsZlrUMmxVGLlv5H828isRrgAQ8UIgMaSvMEtdfOcOrsF3KH7WYviicnR7ZmzI5kPJgZ9ArD/G9/Q9SjG9HHJH5qlFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875959; c=relaxed/simple;
	bh=pqHRwMRiG7AbbZx0Ikavn4KVrmthECJYHySxh1UJgwA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EKZguQUDySwYMMxkzQ+eeHK0SdQCzlaKrVShgytMMw76Z44TWqt4LyKVb34OeYYw7id8mh2v9DQ/LMHh/NvPn/jOc1gLL5LMlKRLT8GuPUpm27Dy3ETdN0waLhlx5RUEPMyVFqLDNIbtfoz6EnuSypna3CzPz/BMz71dcd+W0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/8ngYHe; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/8ngYHe"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5d5c324267aso5722926eaf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722875957; x=1723480757; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HBt9R6eO/u+7hu9ZeiPa7c7vbF0b7EWO2ZRjNYd+CiY=;
        b=a/8ngYHettTBbDl1ASSxhYB4LX2Q8t+zyvsCFX01Vwrfv+wT02pmtX8PtHUk37WAoc
         IFyAiTlFCMWTLH9XM8jdzoiNRXCJ5Bf0GmXTfrq+H+2AgLCEPOgNrD8xXeQLuuqS++Of
         9T+yS6YIgdSZPqTGqqdwnY2OYaKdXIsbODY7HPxg124AxT0R46Z8qI0AMjEuHqbb+DiX
         BAVVebLnbwyjiXwHxgezfPvdPmpHCfUDfIys2OSf4QqtU3CztgL/DlLN7FCXVaBegnie
         LgEy3cjwxPjisPLs2fa7uFaQJMUIvp5oGQzOxLdiqnCbuxpacatpFVizh4W8weO7FRqS
         UPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722875957; x=1723480757;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBt9R6eO/u+7hu9ZeiPa7c7vbF0b7EWO2ZRjNYd+CiY=;
        b=q0Mgd97GUHMd38dxFTCbtlG2gzsySF637A4YQPE9m9vncvzk4uJECiRofk7CvE2LAs
         YxUpcGWzpyap9gnFV1JGw80Ted6W1rqV63f66BvcC3ZCZplpNv8P0QqKk1ekZgzZUSon
         U2+WmV2r2yS3e+Z2nmzNV8FZvn4NNqOhqONj4PtmcZUAZTGjWrMf0svxSTWLZNgJIj76
         JSwHyeUbpmh/ezlWQiHKVO7/qfzNoMqvMMVBuQzpquqQcEtv3J+U5Dv/CGKFn0hY8HeO
         Ml9dGFlAcpNGPLN1GQX9SQYLn7rSnBY3JDZmjpY0FAvp8OYA6o7JaTELVC8gQbiO+2L7
         j0rQ==
X-Gm-Message-State: AOJu0YyWlP0H/5lfiz95lyPd1ab0+0V2vz6DhZ9k0VUl8ty8eRGqzeb8
	ba8w5Jc0fKAU+DbsyXfqcqhaiVSZp8cvK4Op8CsxFZiGa2ZNKWXqYKsfww==
X-Google-Smtp-Source: AGHT+IH3qzFUCEkwm1XPVanWyzVqOlAjroJyK4cB6cJCeWbpcf1qjZf4nZVYR3oXWgK2XS6eDISDMw==
X-Received: by 2002:a05:6358:3419:b0:1ac:fed2:c3eb with SMTP id e5c5f4694b2df-1af3ba3b1femr1396864055d.2.1722875956568;
        Mon, 05 Aug 2024 09:39:16 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c83c6eesm36837586d6.94.2024.08.05.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:39:16 -0700 (PDT)
Message-ID: <66b10034.050a0220.c122a.adce@mx.google.com>
Date: Mon, 05 Aug 2024 09:39:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1361737942374917558=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Implement the MediaAssistant "Push" command
In-Reply-To: <20240805120429.67606-2-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1361737942374917558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876697

---Test result---

Test Summary:
CheckPatch                    PASS      4.44 seconds
GitLint                       PASS      3.63 seconds
BuildEll                      PASS      24.73 seconds
BluezMake                     PASS      1713.09 seconds
MakeCheck                     PASS      13.55 seconds
MakeDistcheck                 PASS      181.30 seconds
CheckValgrind                 PASS      253.21 seconds
CheckSmatch                   PASS      357.08 seconds
bluezmakeextell               PASS      120.23 seconds
IncrementalBuild              PASS      11308.49 seconds
ScanBuild                     PASS      1006.70 seconds



---
Regards,
Linux Bluetooth


--===============1361737942374917558==--

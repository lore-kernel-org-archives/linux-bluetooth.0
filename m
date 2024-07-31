Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958DF1AAE06
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419917; cv=none; b=YnF8NPqN0YNx+lzZP9zWuCfZWiRIGbkU08y7DcaLxOVK/abGO7v/vcmm4RtLmjrLlEbxOKmd9p+MeXRhfIIkBD3A1BjD11kvEB4kHp1O2+QZgQVy7QjcneMbvGz+sTw1mk3/yeObsRv4++cd1w36/BjDMFve5+73Njrv+f2PaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419917; c=relaxed/simple;
	bh=XEfyVAfxNkC3bQi93scEHZnGa1fXlCCAL5THOfS05eI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d43jt5v+3xGgIVjYuh21QRZjTSNdWfek8esskpeOHFDa1AmPuZC1CEVt38hu+uCagDVQ6TvnGpXW9jmICgLM8rvBsmV3tuYzJqoQLBgFXuwEJ1zFT0GLL8YkFn2/QWS+lH2EvceksgjyvmTNGpw2cklFwAdUfh/bYGemU3CT00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdYol6US; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdYol6US"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6b6199ef089so31864206d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 02:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722419914; x=1723024714; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Thkp8udPPpZENaTKkDvB2jEhw9GyqIIFmCIOcEb5p2o=;
        b=cdYol6USZwqQkbhXuKfVUbgNyYus6VHlVtb0m1/DLZndBhywAVYPLDLJL3GVDib7IN
         o+svfIuKxZBxo1Fgb7E2x/X/aswDmfxKtJraBPvauy8S97YexAWFh4Saj6xkWcIDVQvV
         9lJmnJ1y+EUeGaP+QPFpPF7oaNqr6ahj955LmsSm3Mk8uxc0SunQo+xyYKFGwU42YSZV
         sBlCTe4utD7H9Q7NeW6QA3T0BmXDSVF/fWMQycRFoIqJenf0iDQRykkQa/2DjE/fPdKH
         wmSakFFPzg9f3YR5fE4Dwh+GrMyFERhpvWWWRay3NyKAop0T/xyYxovtX2Z+K2m0eV6B
         chBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722419914; x=1723024714;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Thkp8udPPpZENaTKkDvB2jEhw9GyqIIFmCIOcEb5p2o=;
        b=XxZFGPXDr6Abi5FHBu85R4MJD2gMg3Vj+8sBphk/Y/aaf2Uwv/VjXaKp+eSTWsLYPz
         60xfXo7OPSdBqYsXvjd3aeRT/pp5Zf4kjv6fkLMFUJr5+5/YwKjtxp8QyhKWLDIgGju3
         4JLJtWBMRWyF4EhgoPLW9UpxMv4Ais+HShTUTl4QTkR+kDdQ7nxZrZEwrAU3YK6YftZ6
         NGC1sPHW7RrapUCqNNyzhHjKwyRU+5dI0PQx1oDPDrYWIBrNQ4odWXp8i63r4qE7ONjl
         J7n72ktmjvY7EY24xuiw772htcVapZCyxJmc+mqWD8FOSMi8gp/7j4PfXBGqyo1OcT/W
         vl0Q==
X-Gm-Message-State: AOJu0YyIQxdDBxn8c4r8hpnQI8wlGEmqge5lqk8HG44C+GR4ZeBrut0b
	G6ojJVRvfr055gCaqEJb2oHoBlzKetqr//UtzRURZzd74BLmVkq4CCRsSw==
X-Google-Smtp-Source: AGHT+IEN1FILm/Mkb7gsgJf5UgbbG872fCw1qXTrV3oW2BKDxreC0OpOGGaMxGu7O86juRqA6PQoaA==
X-Received: by 2002:a05:6214:29ce:b0:6b7:aeb2:e796 with SMTP id 6a1803df08f44-6bb55a1367amr183046296d6.33.1722419914394;
        Wed, 31 Jul 2024 02:58:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.111])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fae79d9sm71956316d6.125.2024.07.31.02.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 02:58:34 -0700 (PDT)
Message-ID: <66aa0aca.050a0220.20314.6644@mx.google.com>
Date: Wed, 31 Jul 2024 02:58:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4235453539536392789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()
In-Reply-To: <20240731091936.476484-1-dmantipov@yandex.ru>
References: <20240731091936.476484-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4235453539536392789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=875380

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.42 seconds
CheckAllWarning               PASS      32.76 seconds
CheckSparse                   PASS      38.48 seconds
CheckSmatch                   PASS      103.46 seconds
BuildKernel32                 PASS      29.82 seconds
TestRunnerSetup               PASS      538.73 seconds
TestRunner_l2cap-tester       PASS      22.30 seconds
TestRunner_iso-tester         PASS      37.69 seconds
TestRunner_bnep-tester        PASS      4.94 seconds
TestRunner_mgmt-tester        PASS      117.50 seconds
TestRunner_rfcomm-tester      PASS      7.59 seconds
TestRunner_sco-tester         PASS      13.03 seconds
TestRunner_ioctl-tester       PASS      8.13 seconds
TestRunner_mesh-tester        PASS      6.10 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.14 seconds
IncrementalBuild              PASS      28.55 seconds



---
Regards,
Linux Bluetooth


--===============4235453539536392789==--

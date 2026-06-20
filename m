Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288D233954
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 21:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781989745; cv=none; b=tmtWk/J1FB4UghKfcOwOzuaadSyh5NwhcpVmcVgPYdEyBjU0B1ZWvodpml5pX6HMKNSwfF+TdNNMGMu2CvVG4V6ywTEG9eFRAJ53NTQHtJB7dS51QXGmuovmfVd0W/HWl3bNYYI1Fw/YFl3iNl1I/E4js0u4ORxZ8wCUJ6ytrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781989745; c=relaxed/simple;
	bh=JGkz5PdQED95eY+3/h3VKpzfln4/vlU1ICmuc24GoSg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o1znM1nxBo8cLHTPWdcfQVbcENMrrMjfGRePqNGvXitWpjCZUm6yavhUd8ZZdf3bv4U/vSNpAgIYUcmIw7bYTpAcR3Z0QeQ4FqOBpMIGdHp/NpxrV0sac9wLeW2/mDFW/uK9hTKkkzDu2joxIQ34JPQv91PODXvhErwv9oQU5W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkL68DRV; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkL68DRV"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30b9e755555so7022154eec.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 14:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781989744; x=1782594544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vd+0217Cg1NzBWC2HRNGP1QoBhzOxd1ImLq2qj4hxuw=;
        b=fkL68DRVA/GP4Ae2jL8ueJGLY1RYSSvjTXO5fsD291+djPJMxJ5oydGcSaPPJSdy1f
         QvcFU5e20a6l/IFRSEvQNdYO6gXIYn152BXOaGHZfXICmurl1U5HjeJVlMSszcbcNCQu
         bzQzQqxQ3QLPo6N7yLULD/Yxw7U6WcOIzPG37B5ZkhhdnSnLL1GEErmCp0TCx0jxt60z
         Zml5qUPTXpeepEv0n3HxldYVQMYvZyRykO5llHXvde5LBpIrMgzpZNj4zcamahoqAXcV
         liEWF0j4Q4rjeqIKholvgaxccnifP/dSl99P9ZlGF+JX3rpgrbcEGM8+uNOZRdr3nce/
         USdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781989744; x=1782594544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd+0217Cg1NzBWC2HRNGP1QoBhzOxd1ImLq2qj4hxuw=;
        b=AQmPAoeXY/VKsbMpno8uZthzdPR/368GV3ZRBLUlv0RG6whz+NgtVkeDbm1915rvOT
         HHzOIX7ladARRVdkP+w7up4mGrlkTT8+cQcl14JKQFrGfVONDvj3T5Yi2I8SO3XjJ0fC
         9B+aA/jLQZs5Y+7fqfxvjMvRkNbP4l8z02MRp0PlpI0dhdpPBa+xtId7TeB4iAH/JT+G
         5CWdQvejMDUfCE0ETG1R4aiWpE0cIIuDVG28eZ8rHZ19ouSaXYsc9vm8CEKgWydrav8M
         UBvC7Pv5BPcu/S3gqIO8CMIPG5aBP5s5W7XLF5PUTQH7b4WfVk/gDJH1+3I1FfYC0UTt
         Vu/A==
X-Gm-Message-State: AOJu0YwIUPpvgJXqttsFpjmJzAXbFOvsopa0rhtnhqhRMRQPDWEvxEKb
	SlNfjk8v2m7cRN9ANUgjGH9DQCVE/FvvsvDz1SNxbfJHGYTa1qWFBttlTvAm4w==
X-Gm-Gg: AfdE7cmjlYKMj5Sdnx7/fHa09aUNQP6xAx8DMTcl0uCISvWGiQbydctKuEyIZmU+yls
	JAe9CP0wR0P5OFghDI/LgCiPCF1joVaAJGBSu2OswuzjPutYF5KNawzp1OM523Ot5dILCOCVDpG
	SKqi3H2sqFr4rHnqpPz9jne0UdMocZdLAyIcZJGb4cTzCoe5uyaxs2SAtCovidqIm7gGPhd59Y7
	mh0Al6hgVkR7sHLcUlWyUqEYAeXDJUJk4qAiF7BZRWqN/eSsBnQikOEG4WNwCpP7kofHWWT7g5N
	oHxZE9a76dmYtJ3955oTmZ+wkkmQVFdaiHa30IR/6zYLML5IEmJ5ypuhFKp95f3dIc3m9dy4bxb
	e37nJQJ4q4Th/3QvyM2XwouYV1++ea+o+wfxsOLxAN0m95jD6Eb+2Pz9kb8puSsoBkhhgfXMsVw
	+Mvv1G14zNpQpQrCZOh/7o7XFtBHx7HQ==
X-Received: by 2002:a05:7300:3c20:b0:2ed:e15:c923 with SMTP id 5a478bee46e88-30c071e9f90mr5876231eec.31.1781989743789;
        Sat, 20 Jun 2026 14:09:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f0a9sm4829863eec.2.2026.06.20.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 14:09:03 -0700 (PDT)
Message-ID: <6a37016f.de8afdfd.185b72.7713@mx.google.com>
Date: Sat, 20 Jun 2026 14:09:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5824140837150709098=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, geraldonetto@gmail.com
Subject: RE: [BlueZ,1/2] shared: harden btsnoop trace parsing
In-Reply-To: <20260620192228.2692610-1-geraldonetto@gmail.com>
References: <20260620192228.2692610-1-geraldonetto@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5824140837150709098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114243

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      667.04 seconds
MakeCheck                     PASS      18.36 seconds
MakeDistcheck                 PASS      251.81 seconds
CheckValgrind                 PASS      303.17 seconds
CheckSmatch                   PASS      354.29 seconds
bluezmakeextell               PASS      184.13 seconds
IncrementalBuild              PASS      699.32 seconds
ScanBuild                     PASS      1041.22 seconds



https://github.com/bluez/bluez/pull/2245

---
Regards,
Linux Bluetooth


--===============5824140837150709098==--

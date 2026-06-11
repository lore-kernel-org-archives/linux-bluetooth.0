Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043940960C
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191265; cv=none; b=MfffT6uLDl7coQxlMeE/R4Od5XPUzMx5m9Bk6Tk6C8i0HZu6/XWP7QMi8K7SYID+gBDmZTeSmvhpe3tu4b198bkG1x15DTaD1ZYmjxnJnfwE9C6UXeireoRpCCZ8nLd4xqh38LpfSKL6wKEjCVhEz3erqP28N09WDTFZLSXS54w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191265; c=relaxed/simple;
	bh=OGG+e3ZnB1WlDm6Pn4oaOoBnO4JWbYFXPMIOPdnNc0o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sOFFkcpKtHb54BKAIXAzwXFx3aCnfkGj891CHzc2bRzMNnjugR7F5uhQB/G9VA17g/yq90g+7wM81iGlvfrQUeukZIlo4aOlEHDjEaXEwwAWSV5aQJ5VyxAOYTkAmirIvdp1zFH1CR/02YFPRXdSGYqj/5FX8ldqBTBUBp6Brsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDuAmkUr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDuAmkUr"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-91563abd6a9so393443685a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781191263; x=1781796063; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FI9CpF+vsLkoVT7GjfqVVlDBvpIE0PCRTTr7wCKeCH0=;
        b=MDuAmkUr92ciplhswgylkFunkFqkIh0pCr8bTBYopsWRw1RvlYX3AsUJIKgEIsEXvg
         O35S3dMaMxO4lfzuWmA6dwpRMDCPKl+ye2JNbCjXiaH0UZyr+u5KqqxsRw8aG+/JXmJy
         COpKJcZoq7Hq8mbXBR2VH7cFbBMIeviXXXvdZr1WigrLwtRe2cmmrapA9k6ksxyi296+
         Rf33BvD9Oe0V/TTJFjrh6OuiczwRx9+Ju4ptNPFQCbGjbHxLpXMdb6S33AGRWnNrWaiu
         3F+e6B5+VFzyd/MhEgngVl6amQefRwcm4WIe3RqMcD6C1nve2rY4ww0qG/ZMucM6vVhL
         XtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191263; x=1781796063;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI9CpF+vsLkoVT7GjfqVVlDBvpIE0PCRTTr7wCKeCH0=;
        b=P9iDAbqccflKa5wBXW+CwSn0kvzscAXa0fWfXFQUYzUQUG/M2D2oJ5rtKPBvKMXfG7
         wqzsqRLbdF0hVLj+EkICFPGHzHR9t73dukU3Kdfn3VdZRmmNIMb4eH59YH0mu7cm/meC
         9cdQeqTEKss4l2tigCoQsgb5LOQDa6Ij9L6bqRYdgte5WarcMa11LsWPJWmlCf4OhEKG
         1zT6Tt0mN6kb2aBMf0P1CTt+GHps9wIsBPV1aRs44IVqci1YHZklfGmp+covL2fDvgiE
         cWv0YVJ1MjM56FnGiLtKkHFurrPDINpG0qJzZDbkxtgyRujBP/7tBVxqu59tY3LlGctL
         td1Q==
X-Gm-Message-State: AOJu0YxCodysZ7L8Fq4vWxaNM8I2aPH7MqTjhnxVQ7WZHQ8nGNky+/UW
	xrrCDPT8XbeQQQ4CgO/PAzjzQSKQ+9t4T33WiSPTi05jQZ2dj1SAKaDC72voDQ==
X-Gm-Gg: Acq92OHPsA/0b43b2lPMLytyLCupU9CYL5WtV024ndZqwVMpy7oli7S2SxZdbEGYesa
	oWVEcaeGe+HykhLCN11WLRMjXXWqjMxNxX3X9z6twHlwKYuIuXShcPl6whIlxn2jyR73crGyH1g
	n3RoPmMqLa3fT96vgCxEHbSC/DKiKWlP898rfyY++5r37GD0VoyRNfVfpLxq7B/Vym1l/i6rvrz
	2VyYDD8Kjxor9U8CPhW9pWZ33XSnyvoryt2aVmqpiPO+wYprmGZbTrqbh2q8KgecJe+Lk/VDekx
	42YSzTCWdFv3GBAKu6txxAu0wSe3rGrBKbbD59tobGAdaWxzIHTAxDiFByUKu4/CL35K7JDu5N2
	8cpppzeWnF0Sa0t/XXLL99r506sqojkCnnukRWvZYnivLwPix2Ig1bderCunxzs7K63J1uZEHnS
	eMKz03XH2ptoVMwhhoIg2XjGXbNcibY1tYmmd7NsHo
X-Received: by 2002:a05:620a:4412:b0:914:c032:5870 with SMTP id af79cd13be357-9160ad0dcefmr434805385a.38.1781191262997;
        Thu, 11 Jun 2026 08:21:02 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.145.74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9160ae26238sm209359285a.33.2026.06.11.08.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:21:02 -0700 (PDT)
Message-ID: <6a2ad25e.19aa4c8d.3683b8.9b14@mx.google.com>
Date: Thu, 11 Jun 2026 08:21:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2677920481744007439=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Initial Channel Sounding Support for
In-Reply-To: <20260611120044.1641009-2-naga.akella@oss.qualcomm.com>
References: <20260611120044.1641009-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2677920481744007439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1109997

---Test result---

Test Summary:
CheckPatch                    PASS      1.88 seconds
GitLint                       PASS      0.95 seconds
BuildEll                      PASS      22.94 seconds
BluezMake                     PASS      611.29 seconds
CheckSmatch                   PASS      327.26 seconds
bluezmakeextell               PASS      164.50 seconds
IncrementalBuild              PASS      656.58 seconds
ScanBuild                     PASS      942.40 seconds



https://github.com/bluez/bluez/pull/2217

---
Regards,
Linux Bluetooth


--===============2677920481744007439==--

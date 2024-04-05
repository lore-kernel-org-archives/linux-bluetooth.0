Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593A91DFEB
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361146; cv=none; b=ppH8Tv/6EF7KSv0lKb1giB/H006Ghi/Kr03csPobKs3DWo95k6cqYJp5hU7dq7VHpwogOKD5WRBtQOGotzT3dDkW1TVZKTFFkloZMcXgVr81wKD/fLIlcsKvDQ7NY8zqq09YN7+aKywwJkwpu2viECIZWE+dBZWtcN1U29AAuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361146; c=relaxed/simple;
	bh=V4NewiY4d5hFbegEPhHiBVZmOw2QMUPEcrdHbyDu10A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g+YnQiA/4v+SwuQHymoKSTWQ7XkCoc3DGjkp5zPlQ26DlbWZydjd7B/ixsNdhjGNCKKUbkLnGPFfLyRo7Ty2tdmOTYBiAGYUTpefHmJjtTIy6ENjOVSc+tTXhFUHgVakhz6sdScw+rmNrN8PnYdxRoP3jU2aktK2q4lWIiO0bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+fGfvbr; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+fGfvbr"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so2022662b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Apr 2024 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712361143; x=1712965943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8Otr4lvjSYBDjJPZ0fEPP23idi7zA0VcRCJ7smh5ZLY=;
        b=O+fGfvbr+1n03YTLYqPKc5UJ71p2fDZ7v7JS+lHg+gTSd3DwCl4xRbJ4LS4Wa9c5vO
         KQRsBkKClKOq3TtjRJKiLUTlPkIS67k2QY60b9zAK/NO1EiwwIrsTigQCzg+TFYwpq8E
         Bs7lF0bK2rw58b5mGVHyAg2tG1i/ZUeC0A/XC5jeJ0djB0oQxN7EmTBMVGtlqIxmMxPB
         x+pxP+nFlt/NyNHP04WvdiGMDbA5yNRREua89WFhjtlnFD6V+btZIjnnKhsJrHjnZZEo
         M6HRNSy3s76zi1bPcnI3EnQe3+wyu7Lvxpy9SZMQkf4rA6+PDU+sbWJpNhpeVIqBHBVS
         TolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712361143; x=1712965943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Otr4lvjSYBDjJPZ0fEPP23idi7zA0VcRCJ7smh5ZLY=;
        b=eKa2F3iMnabcorkdj6PUUjOR69UPEnfw9Ph8yh2JDws0NhnAG7G6R5TW6kNt8gl15D
         a70ByPSzkSejIksEq4z4ScNUVki4BXVEm+i3YpXpM+iW4mAkNNXb4RNvvMv6dejPPhsp
         1WP647f1RA1CXxBqbbmkOFv0FJGuiQmxTjgZnwIpNQf6ottc+wkWr5X+2Cu3srNZ9R62
         +7NVpg+O7IdX7PbLo5H9qNhzdgnH5Y5Yw4semBYE9IphmxlFF0+a2wFxS846/ZPz2geb
         lTeOgK7JvZMPjMIr6LHsPVoTqxJiMRz/ys+ZYINYVs8rnhu4IvpXVZWjr1iorc1YP7hM
         eBaA==
X-Gm-Message-State: AOJu0Yxbf+bVH7zg9DGopANiuw2AxPSZhOcefqCAFTZ/ShNwm2culGDv
	93/KagOZX97rTyZ4nMZkx/WVRpS3kyLjKMnfM3Bfg2yyfnR15GNZ+RZCAZJD
X-Google-Smtp-Source: AGHT+IEbigP+9ndisqQsjr3giNnKZ91XoE9s/LZQhcPYk+HAUnF3669w82/nmdspNEzzgonDXwvIaQ==
X-Received: by 2002:a05:6a20:baaf:b0:1a6:f9a6:d51 with SMTP id fb47-20020a056a20baaf00b001a6f9a60d51mr2817824pzb.49.1712361143197;
        Fri, 05 Apr 2024 16:52:23 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.25.5])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001e245d90d6fsm2203038plh.59.2024.04.05.16.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 16:52:22 -0700 (PDT)
Message-ID: <66108eb6.170a0220.69a8e.76de@mx.google.com>
Date: Fri, 05 Apr 2024 16:52:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4756440162542446263=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v6,1/3] input/device: Fix not handling IdleTimeout when uhid is in use
In-Reply-To: <20240405211145.3463154-1-luiz.dentz@gmail.com>
References: <20240405211145.3463154-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4756440162542446263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841948

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       PASS      0.58 seconds
BuildEll                      PASS      24.19 seconds
BluezMake                     PASS      1637.10 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      174.11 seconds
CheckValgrind                 PASS      244.85 seconds
CheckSmatch                   PASS      349.91 seconds
bluezmakeextell               PASS      119.93 seconds
IncrementalBuild              PASS      4565.34 seconds
ScanBuild                     PASS      967.50 seconds



---
Regards,
Linux Bluetooth


--===============4756440162542446263==--

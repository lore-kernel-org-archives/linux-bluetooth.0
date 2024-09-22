Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6A1EB46
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Sep 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726980221; cv=none; b=KemNm3braMSlJKD28Buk9E7Ko8mbLDjAmKiU6vDGgbhFoR8L5Auzsij76YCsRHJmPt4sZC5EW1G503yAeyENgTSDlaeHlLc0m0ClMaZ9XH85dvxSPEA2Q1zRig5bb0ETMibC0+3dJpr/vhmjViVgmY98PHJKtH6wA36Cejr3rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726980221; c=relaxed/simple;
	bh=4jUv2KA/gfiAuzN7sdUoHueMtRLPrcbAp1VWv9PZy6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OTV+cqKCuXv/y0unukumyf2MafPWdO/v3e4XkWscySLKd5WsBQtKXm2eLfDr7r9kAqKk+TzAjZePyuLbn7rT8SIcZpA+rr8Bz5Y5WOZl34ZUib0sSjW9noYx1X50/WGMu5sXoZ5H5UAb5bcinIY2IgemWBHf00WHE7iu582udjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkeyHajp; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkeyHajp"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-208cf673b8dso33256875ad.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Sep 2024 21:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726980219; x=1727585019; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wMaNSYR7nIkqlm9WU8RmjrlU97uJsbXRAUEOSbnTP2U=;
        b=SkeyHajpBL0705XTHTNt6ETvWWx1P7C9WSeB5/5tdxCrNUn0uRJVYzn2wR4XB6aoVy
         CW0+wLx1ZJjfRsuevID7ZYF1d23OUZT/Xm1att5maMmCJn6vzneLf4Z7XMD0mNjrH4M3
         FCq+R4fnXwElAFlP7GxkgT3rQbm6bFNvF4Rr+rKj6zOndcW6A2aiCB/HpqBDWMkmKRX3
         9aVX1h9hfyDlPmsQ4BCVVsn0L926950Qxhquam+bKqw38PX4ztSF5QwUrcExnc0I29m4
         8plRcqOjnyKIRYsmU0sV4Y3WFV5nF1ynwefml6h0vempVnRjRKQR/3nvnFxo7Z0QOZcY
         L9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726980219; x=1727585019;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMaNSYR7nIkqlm9WU8RmjrlU97uJsbXRAUEOSbnTP2U=;
        b=JT2SRX2Zf5ccgxzrm2mly8Olo5MbIK5AXkkcS7X7lZ3MxCUYz9t6UWWYXfRhljH02S
         E7XSpLXKlS8Ehj656x+zoRraKtGwAXryt2XA189WOR9RwtYONxmuyJG5FkbJhSyTkijO
         7f/xr7AV9d37D75aeFiIGOiUsJAP5hYHnQYbVrPahBLnJQ49c76KA/pvtkGhC/1A8cqz
         FDaxKSErg/Sc/WyalEpd0Q6+bC4bbsath24B4dLJZxxqBEV2oyQwOucwkCL0iEo06jvg
         acXPcGIlfaKsssooQZEnlPkRi/lyNKndXcVnhs+pKVHu7V1iguD/3GFYgYYtoR/Oryt7
         vrqQ==
X-Gm-Message-State: AOJu0YygYV9IKQ4Q5L3bbJ8Bu9ZGolcfJAcgGdXNZxxl9Rc1qJYZ6efh
	OHphTBpJqGiM9DT9+VSe17LnX2sPukLs9xyMj57czEa591Mb6S7z7ICVcg==
X-Google-Smtp-Source: AGHT+IGRj5zts5Q7Ul35nKa1CCm6z4dSL55XVss4TxOl7IryGf2eo6JVRzMd225nOMsfwC0U/BjHNg==
X-Received: by 2002:a17:902:fc85:b0:207:4c7f:37fd with SMTP id d9443c01a7336-208d981d025mr96915225ad.31.1726980218792;
        Sat, 21 Sep 2024 21:43:38 -0700 (PDT)
Received: from [172.17.0.2] ([13.87.243.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731afasm115164335ad.272.2024.09.21.21.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 21:43:38 -0700 (PDT)
Message-ID: <66efa07a.170a0220.38600b.e8c4@mx.google.com>
Date: Sat, 21 Sep 2024 21:43:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1228629796016835242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v3] adapter: Cancel the service authorization when remote is disconnected
In-Reply-To: <20240922030417.140005-1-quic_chejiang@quicinc.com>
References: <20240922030417.140005-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1228629796016835242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=891875

---Test result---

Test Summary:
CheckPatch                    PASS      0.33 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.17 seconds
BluezMake                     PASS      1509.41 seconds
MakeCheck                     PASS      13.26 seconds
MakeDistcheck                 PASS      176.21 seconds
CheckValgrind                 PASS      248.79 seconds
CheckSmatch                   PASS      349.19 seconds
bluezmakeextell               PASS      117.72 seconds
IncrementalBuild              PASS      1390.41 seconds
ScanBuild                     PASS      1014.84 seconds



---
Regards,
Linux Bluetooth


--===============1228629796016835242==--

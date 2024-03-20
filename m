Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CA11720
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925376; cv=none; b=lbyBrcuvScD8X2YCYAZYrJJnodBcAl4Z5mx/S4decO0VpMZYrInYJCo+IjVD/5tvuFlBL+/yX1GtIMrwkHwUNYSyr/jLzgF7V3Fn2xDHcRq5D0/5z8ga23wVHiKbxudj8gYnDY5FGV50Xn6YocbBdUkCU38DwSkHWZ6vqOs9vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925376; c=relaxed/simple;
	bh=Uh79HIIBDbTT+m9P3pgvo3Lklwxr30Gq6ia6CYdlDyI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HqK3QPfGVsfYlDAvfupadbXhzm3Axx6VPP+XP1Ibx/QmqlQ2CfFJxWPkd4HzNp3EASki7L51XfGDUI36Qv03HtbkkWUOCiwJ9xwypFw7bZ1l5NlwaWwKnc2YHEd9+7ECoUpmtLlONjgeQf3bnUsAcK5pCz43EcKL2sbG6fKiEJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNj+mUs5; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNj+mUs5"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-789e83637e0so286990885a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710925374; x=1711530174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk4DFM4zNu7R8LSNWsQmfa6nldZ51hFlwRdj3jhjYsI=;
        b=LNj+mUs58fnZmBMMXXxvyjilcFi+5rU1AtxdDnssVk2yc14dDGEBRe14GE46rZ9O/N
         gxwEvlrKmHg6XGYsE1CTE2aEw8PCkvSt6sxNdJM4/gKUbneryS15C0ao2G/S4msBs/wX
         Q9VbF+O+N1OjGFQwbjVdp7NiTkUQ6IEHfzlS8IQoBTEYfQLbaNsxq3lRLSS8ZYNbFd0z
         3sYjC1wUn3cTVFnIZPKm2m/4ICQBgZFc0z6Gtjee9CTaLeWYDyP/l8nH4JxuCwlE1sRb
         E5KJLuqsAurT+pH7OJnCZnGxhMhr2rjDh9n69YezQ5sExX9LZlpT44cMufR+2JojkIAb
         C8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710925374; x=1711530174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk4DFM4zNu7R8LSNWsQmfa6nldZ51hFlwRdj3jhjYsI=;
        b=EwchrbUW9TrPEZOqKmvgHyhNqN/iGbcpyuZ6djCsex5mxxAWchaxaPYmNfRFPXxquG
         DUMHNcO3S/zET1JTpvOlzueCOf5pkp1UDAKGZ8D0pqFnYkyrf37AruPRG8tJPo6WFtvP
         q9A+ZBaUgJzEbysSx/PnUOZdTWD4a2FjQJjc9tiMX6W3YBDmYf57xtna2RqQuJxNfTNr
         TNKFc86BIaxuJ0HCOBAxNFdWl4FkvjyZNE2w8WtYIUEpeWO3f9cJlqA8MDvdnYFasQLk
         J3Os+xx1vsyB2EW4dWYANRHDMc/5WwtvDTqEsyZsb7Pvsm1BaJKPxRVXySm4ERo/V51v
         7Hqg==
X-Gm-Message-State: AOJu0YzkmVYziRLFcr3oigX2md6xk6L8xjz/LPDpUv1qecZxAJ37UmXI
	vhhqXNV27trfU5Sdhyn7ueVT5VtMSWgTNSaMsRCwNNR7zTopMxe461XhqZNx
X-Google-Smtp-Source: AGHT+IFkQDDk2T6CNG8XmK1eBBoNWMP5ujLCtBD6ZcU/00ZK/6pdb9SsGOQEJt2C/Uri0FfLQWOUjQ==
X-Received: by 2002:ae9:c207:0:b0:788:32c4:7d05 with SMTP id j7-20020ae9c207000000b0078832c47d05mr1468588qkg.17.1710925374026;
        Wed, 20 Mar 2024 02:02:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.77.193])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a148c00b00789f64ec397sm3387430qkj.97.2024.03.20.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 02:02:53 -0700 (PDT)
Message-ID: <65faa63d.050a0220.a3fe.0e49@mx.google.com>
Date: Wed, 20 Mar 2024 02:02:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4338951992188532608=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] tools/btattach: Add support for all QCA soc_types
In-Reply-To: <1710919161-19190-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1710919161-19190-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4338951992188532608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836647

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.20 seconds
BluezMake                     PASS      1678.26 seconds
MakeCheck                     PASS      13.19 seconds
MakeDistcheck                 PASS      174.98 seconds
CheckValgrind                 PASS      243.07 seconds
CheckSmatch                   PASS      348.13 seconds
bluezmakeextell               PASS      119.57 seconds
IncrementalBuild              PASS      1431.75 seconds
ScanBuild                     PASS      982.21 seconds



---
Regards,
Linux Bluetooth


--===============4338951992188532608==--

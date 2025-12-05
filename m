Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4AF33ADA2
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764950675; cv=none; b=UvzBmwxcaJw98alxWsM8jN9SpulqU1fjgGQ+dF2acjQbC8LTFa18xVKICaM84ruPW5PkQfQ8sxESKosG6CGIZRsnYyUvqhw+y5nq53uMKRmVjlUtRULUnXlDu4d4y1A/fMG6Jzc834esP4ZEX8ZGgkNCezyUoJE+5d6hFNNvi48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764950675; c=relaxed/simple;
	bh=6vz68bDdPB6LoZvHxwipKYx6Cj18+S4eWckb7I/VE3M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=tGMnpPsNMvgCKH66iaY1mI39W8DT9leQgt2ckQ2JeD6jKMdWxX7Iz0UjQeviYIH1868AGaq4H7pL9TfYKihYAlu8q96X49txienwh1IQzmNa1g4bB+cpNkuOGJFECOi8cxkR2jKZ984MCIJz8wFNT0pJOF7Oorqk79gjwOjxiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6QUBxzF; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6QUBxzF"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-657a6028fbbso1096247eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Dec 2025 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764950660; x=1765555460; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7LP31PJH8CbvYwtl5fNVcb1jhz45anlBmVzx03mHxdM=;
        b=R6QUBxzF39ZAetNL2GZobbKHdwmawANiVSiQttP7mQn73SxMN6JiiO8uUjMOiZmUo0
         bnX2DO5mx4hJ3n3vGvMG59Yb5khL4nfsAyCbBz04gCnBkXRYPruSj0J/k1/lLbXYv6g7
         Jsu84KJfTMAKaJojdrirw4074ssTj6OtG1y1yyoBWxDJNXekKTmnxY1ftBtbhB6VMUqy
         PjcYI9EQ0OZEEok/B/16lkqBx06NZ6rNdavyA/N+vUFXBNh8mbcZmmqErOp1Du88xaRk
         eh5RIjJsder7R/O8JvQv5M4Bq+FSwZdfIinS0tLgDZtU/hna3QTU+rnIDX8LnLfAw8Wz
         EkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764950660; x=1765555460;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LP31PJH8CbvYwtl5fNVcb1jhz45anlBmVzx03mHxdM=;
        b=LyQOI0aBGYTzfjMXnwG6RIj3M6IXk6Bc3NCv/7nDW+LBa55IzbI+jHO8Id6Z7FHBny
         BQxK/ib64vaFJuQVM/QzOFkouLVNHK+P4ZCE1LcXjL3zoUbHIBIqxRfP/F7YaoFgwTCP
         5zd/u8YPDSWvHNCuLRxA35Nzb5eL2KtCcfPVo9TFhVSaaJMzMQY5BvAGPfGhWM+KYsI2
         M1A6opF9b5J0K4s0LuVVSABs1jr5NThNiqIkAr34Vmatn8X7s8OQhKwDmQm8NYU9ZCVI
         zNknzTRtTsHBIgkt8gw7elcM8US7x+bosMpMv7C7BYpRWq3dUMxcNCw8cy7zkkRJou/D
         zOyQ==
X-Gm-Message-State: AOJu0YyLE3hiTAtHbeiJlDLIVYR9tYFD9XdeuDrBA+7pZg1mu0NBnJnZ
	ymO09pydJ8TVvlT4/av33pXjauuNNABD8OrT59Sv2OBgObp8n03w57EV1Bd9ww==
X-Gm-Gg: ASbGncsCZ42PU3AEdjDmsvOpJry6UdEIMnp4fFgijVGyMVB6Xf80T+ys/9YLhhx76Rf
	/R5c44o79KCsHtcpV5k19blYeanwAO7/P2kVC7R67uFvaDpUdya1jz+opOYoBi1/IiQA9sM4eNZ
	urUm3/Gs0A/fKzYIO5DPLb1Kzl4lPesvVy2HyuoFeDDYH2DAFY7HPqp37Gunh70SgaQFZhyMd6G
	c6VCixWOKkcxtXax0Niay6QqZls62p+iX/AXlJ2UT1h7HqzNAkM6ul4IncbSw6ibxkKz90znxP1
	MZNBfcwM4jORBu14IlJzBS9hBzR1eSt5rnBqSec6ozB3mdraqyVsS83bkc7HXmVpxVKoffVkKAh
	kJ97bOpn+oi7CnLxjnbThkAwVc4f2rwppYDREhLn1z1h+4bgde5Id+jOhiNirz5Mtw70LfjEqQu
	qKxf0DO87HoWzj8qeZfa4VIfJ2
X-Google-Smtp-Source: AGHT+IHXX2wEG49V/T94zrZNjfnI8EBm+87Mg3v1Uhpcn8ZyIRWUQlqHU5f9QlSwxj2K1Rxa0shjew==
X-Received: by 2002:a05:6820:4c01:b0:657:5e6f:b9d7 with SMTP id 006d021491bc7-65998a34b2fmr307370eaf.6.1764950660230;
        Fri, 05 Dec 2025 08:04:20 -0800 (PST)
Received: from [172.17.0.2] ([52.165.59.6])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6597ef0ca05sm2342018eaf.11.2025.12.05.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 08:04:19 -0800 (PST)
Message-ID: <69330283.050a0220.352f8e.6eb0@mx.google.com>
Date: Fri, 05 Dec 2025 08:04:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0013544337720868363=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] bass: Fix attempting to create multiple assistant for the same stream
In-Reply-To: <20251205144952.8373-1-luiz.dentz@gmail.com>
References: <20251205144952.8373-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0013544337720868363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1030870

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      19.91 seconds
BluezMake                     PASS      638.04 seconds
MakeCheck                     PASS      21.49 seconds
MakeDistcheck                 PASS      240.46 seconds
CheckValgrind                 PASS      300.94 seconds
CheckSmatch                   PASS      351.75 seconds
bluezmakeextell               PASS      182.01 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      1012.04 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0013544337720868363==--

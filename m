Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BC12E52
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710974287; cv=none; b=LnYQXDb2xG2fYidtcKhhtUrc4EV/MvBbhaII3lDc1CP+jOOVweo6nEZorCG6rGSV/yiVllO1xuUC1fA004+2fPvoqdd/BL0NqrDq4zywLx71OMlLXMuBG7VcYCr/RHl7ULuU/1GXNUtgNUZGkI3I8wH5D770kMi+VzhVLwnEWtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710974287; c=relaxed/simple;
	bh=IhQRZA7GV+Ww14GFYMj8Ep+Bbf+luf+94MvvLvvvNCE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jsG1/PuJmDIuFSaFStX+/0ZQglKBnpAMViqZNicrlgojcsSZGe/WZnQuXFxmof1h0UoXnkFTekvO2mnJCB+kGW2Qg+wmHhMAF8X3RN8SZACif6eyxNEsu3hJ/Agww8vOnXVVkww8HotlBpLPtWD7/5uOexZfQBaM0Q4l5tg9ACI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcGHlLPs; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcGHlLPs"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-789e4a4d3a5so24940585a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 15:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710974285; x=1711579085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v6PNudADWIvc2DxyRxiPAhg/PGWCYdT8Nhp4hoj3n4M=;
        b=DcGHlLPstgTgXYeVomTGRzPtlHR6Y7ar1VqnxRFQfXYEnSQcmcu3JCs3ey1XexRweo
         tyma/Mj2McBLIWRZBVc7TYdZdriROGqDIP3wAEQYVPlxl+j/lCZhcqzyJi7QHHrm4Lx1
         2ct3yy2x0rS/GrMglzwe1QD4Oinm3unNR7UOq3fLxFQhfVbfTFaZnfUIzN1hSLDB85FS
         ff+ov6vOBAog5ydD5hemBmphzg5sYi3bl/9zWliTtTT0ooOW9mOwXKSn/H8cYYZFEBLf
         a6RQ+ofSAevedhcR/ty62m9iJIbQLIp1AIw/ThxDd3uu/pBMbCn7TZ/5fzMaqLhBfO91
         yrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710974285; x=1711579085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6PNudADWIvc2DxyRxiPAhg/PGWCYdT8Nhp4hoj3n4M=;
        b=oBxJJRGZBOZflLNjIcDXKAT+qduSpsGq7N4GRNYDEaM96dIhui9bwfgFXAaI1sIMYK
         65t5PAQvrUoc7bAw3QMrooTNfUDHgfxL3GNKPkIvaVMzP/Evbu7lr7+gZ+IB8FlkSCof
         kQj7M+5jAr8oHZPHWi7qdREsA9jEDz60BpgSwovIGNW5PubiseP31lNkLeDbAoLtT57m
         Xpk1VZ9neBvfWmfObSsvKX7/SZ7mzArvcgjvje/dpRp4YlzrwOMnLO9VzYOnTd9NhmCR
         32K1Q/QSJmYl9b3nEY4QLLOuirtOBSdyffvVEhVhZOnrx4UfJ1OZCvsC6x23FcvCOmVm
         RwZg==
X-Gm-Message-State: AOJu0YxNObds3s9rm9V9k7KNKE+PkpX4lw83/MRgjU/QuGvc5NiVNZXi
	QA9/T80p9034unvdP/kImxO77kC0w/0Ooha/I/YOuejoktKs/+nx8XDQAX+C
X-Google-Smtp-Source: AGHT+IFYASrHf19dLUBzhH5AZtDJNxo8yKgi32jJm6zpsbwsOovBJCDQdGRZTrMq/1Ghcg689un2qA==
X-Received: by 2002:a05:620a:479e:b0:78a:78c:8920 with SMTP id dt30-20020a05620a479e00b0078a078c8920mr3181934qkb.61.1710974284964;
        Wed, 20 Mar 2024 15:38:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.174])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0c8500b00789e6f7f6dasm5417676qki.124.2024.03.20.15.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:38:04 -0700 (PDT)
Message-ID: <65fb654c.050a0220.d7c85.c5df@mx.google.com>
Date: Wed, 20 Mar 2024 15:38:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3322404561447226921=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Fix crash in iov_append_ltv function
In-Reply-To: <20240320210350.101941-2-silviu.barbulescu@nxp.com>
References: <20240320210350.101941-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3322404561447226921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836840

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.40 seconds
BuildEll                      PASS      24.46 seconds
BluezMake                     PASS      1649.90 seconds
MakeCheck                     PASS      13.13 seconds
MakeDistcheck                 PASS      176.79 seconds
CheckValgrind                 PASS      246.92 seconds
CheckSmatch                   PASS      349.41 seconds
bluezmakeextell               PASS      119.45 seconds
IncrementalBuild              PASS      1431.16 seconds
ScanBuild                     PASS      1008.29 seconds



---
Regards,
Linux Bluetooth


--===============3322404561447226921==--

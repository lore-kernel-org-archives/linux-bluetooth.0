Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A362F26
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715428800; cv=none; b=iK4qTtg/gTCFUBIgPSpqLkatDZ8AMrbYXoljhRX/IYVrDgE90nQ9L1x/PkxjDJEu+ubXL8nKWRuKYlUHYzEddVkA9xV5pXtgMPFTH7dz7ucfqMQrLAZhmv0EwbmRPCfQvUQmQ2RgIsQhkCX3HWf6hwLVyLUlrwA5OTIyBjO63TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715428800; c=relaxed/simple;
	bh=ICoiXIhDtBytOcmbbDtrYAmPak4/uqafZ2OaXHfuBj4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gEmplerxzI7slJxGbW61XTa4SBa4AZDv5YfvUd7wZz0EtBs+LmTLR0Tc7vLbL59A1OIXuVPdwHRk03lBk4LxJ6oqvrKmJ3sW1M0UPbMVv6SlGo8QRKTZRBcwEorlRNASjozcHegjUAkj2/EQK86W8mDfBwnO4WXXdJ6FDsvsdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DURLBNPP; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DURLBNPP"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792c7704e09so154775985a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 May 2024 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715428798; x=1716033598; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WN6zLKz2bRAuucXR/cUoKR6vuTEgmQQLJ5c3EKOqmQY=;
        b=DURLBNPPFb6a2k5ZQtVyr5PpWfIknv8Yv7kxEWBl7inhnW8otsjdgyGE1fpTpuAv3i
         OrDYLbXbepebLr6Oi/h9ZBfakBH3kWaWZ7CN7yjaJ3f0YxcizcL9pkJjyloWrtiLRSli
         OFMN/VMA6b03moD4WFUFi7e5R4yLPu2nUONzzxXyqxc8aWeKhBpFz6k+5h6BfLCBOGZA
         GYw3hP0ZksW7s6sKLPFvEyLfC7yhoUDUwqNeLDbi8SZF8Kr1G+Mu5wW1TIRE+bICxS3W
         8C8ZrRn78XP2jQ7kBn4fzndxNoIgnkDp3gbhIUV8KPqwUKGUQ3Qd4fC3+EgLzjdg+wG7
         3c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715428798; x=1716033598;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN6zLKz2bRAuucXR/cUoKR6vuTEgmQQLJ5c3EKOqmQY=;
        b=Pi+y7uIaydj6KnxCi3gVDz3LE/miT/twCxmbcxI8LLOXeweTTf9WlrK4ncfp6pWDam
         3QUj3HFaDDTw9xtVu+k1iaj8MWuPIq+3ksUYawDWx7FWtXrSrd/zpzlHl3fq23GwUek5
         orJhxTZ3hB9L1SgrdoaJOHiBhRjUMWuHJfsmhpPRVVqRAicfOkjHiGWs5/PCggent6P2
         JsGT0Vdxa1dkk22W8GYkqitTcyvOoqx0u0e46fopBum50otOyaLpFaX6BwK/BxCMMPHH
         6hwY6e+BlvCUyUfUnO+NXeCfs+R0T+SQ8X4m2B9HOjM6BuK2ZzRlQZyBU+thnTdLsmmn
         qwlA==
X-Gm-Message-State: AOJu0Yz+uH9PZPTTClta9WsRGXOrNXzyH38zsEd0ZTS2CYE8V9sOafeY
	JrWfdRvq43/ebPUfxXVpgKDPqpJdNfRzERz+w/AmDSMKTuRQZJz5+JylbQ==
X-Google-Smtp-Source: AGHT+IHmPZaSM8pwk3oebANd4Mv/1ctI4ozR3c389/gb8TBRCyB0XIFNGAQFaWi/KbRAo8OyU4KNLg==
X-Received: by 2002:a05:620a:4085:b0:792:ba14:28cc with SMTP id af79cd13be357-792c6c3ac1cmr1076596485a.1.1715428797736;
        Sat, 11 May 2024 04:59:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.196.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc55csm271107785a.85.2024.05.11.04.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 04:59:57 -0700 (PDT)
Message-ID: <663f5dbd.050a0220.3df19.8539@mx.google.com>
Date: Sat, 11 May 2024 04:59:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2395667517483357315=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tools: fix using too small buffers in test-runner
In-Reply-To: <9b7b8130a4296de7e02435d7be3c6d00c4976427.1715423446.git.pav@iki.fi>
References: <9b7b8130a4296de7e02435d7be3c6d00c4976427.1715423446.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2395667517483357315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=852514

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.29 seconds
BluezMake                     PASS      1620.69 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      176.44 seconds
CheckValgrind                 PASS      249.65 seconds
CheckSmatch                   PASS      349.86 seconds
bluezmakeextell               PASS      118.87 seconds
IncrementalBuild              PASS      1419.35 seconds
ScanBuild                     PASS      982.15 seconds



---
Regards,
Linux Bluetooth


--===============2395667517483357315==--

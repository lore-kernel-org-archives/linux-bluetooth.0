Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7962280CD5
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762370796; cv=none; b=ZiSJI0vw7LVa8SDiDpZit3ssgPCQf2wrTwU+Ew6MDkap47F1C6L8jSLFaZnRcOwmz0Uhya+tuH3/aSB9WjFw/71A3XAUW12wwYNzL9pNkzCIr995tqPvxQBqervu6yR8o61B0ZqvhGhsyTgQ1f7/oyBtujESQv21xsaX0jzmIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762370796; c=relaxed/simple;
	bh=UNZcMpuO6y4OJjn0NtIVuErY1p4zM2D4jXthLsi6Mpc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=etA/7o2BSs0lPYWlqSq7wuXb9+4ERkTJtVNlgMZGqvV8tFKueY4Lg0n7qFvVvCaWF26CCUX6UUlynK/yaqblVkHrfga+aXhWgfqjY0H+EALYCY7MAt0Jo1LJMNuX51gJUFumCWpiw7hNm6OyFO0dTD90S3G6NZ2gi0VGpIRi6wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/oKO4TE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/oKO4TE"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295548467c7so2225995ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Nov 2025 11:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762370793; x=1762975593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBGVBhk9WiBBQIyOs7VH474iefDJjtxM86Nb1wbwzEQ=;
        b=M/oKO4TEOceSmtEHilWCfNEnHYUL72a35otsYwZ0y+JNmn5ojJjz1Ftx9/sCOHVW20
         PQunOCa81Gjb7i6mB3j5Z8WQkJJbYFGKjItZJz3lJvFhOQq3vNc6Ew8sesA6xnTkyTTc
         x8tFDKnYBCh/7Px7FwvBXZ8Qpc/mu36XMGD8WcqUPdpmyaOXAgV+Cs5hkXkTK0MQt+2d
         zFQL5Fi7abKWq5dxvfEkZLoT8+NjUB35DuNjFzV7C0LE3JJk9ySZ5Xw3RFSmuCTknqNy
         lfcbK9yZnYPO1Nhg/IAt869aPF3TCB4j85OQpb3sXmtdFowoAgU9DK4DMQw2jLFdh0I+
         B1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762370793; x=1762975593;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBGVBhk9WiBBQIyOs7VH474iefDJjtxM86Nb1wbwzEQ=;
        b=uW8HsnmDDFFRd1Yvx2H/GBO9zUCrCuGZT3AXCEFfQHZiZNWctaH1GmZXYIpKadVAVJ
         4bCbfy6LAdFzgQHC2hAOdNaXXjBKcFo7ZYYpam390n9YBZqmK1KmpFr/kAb9lv/WWQjl
         5G5+q5yj+MNOFMdB+P/tLzZpF97B6CtuhOLEygfB6U45Q7OFD90tx8gd2mwQcInQ3JQi
         Q6VAZe+0LYIYWrXWyBXH+xeU7b+HiGVxA7iqGIBsY7bLPaxsYK8QUk4KfXL/dv6fL0BG
         kDIjLssLVUOAEO8f2geBMCo5o0ynoRfImfbUhNQXOXwuEqkZ4I0eHMxXEMowcL/OL9JF
         7e3Q==
X-Gm-Message-State: AOJu0YxJzX7Sju/1CDYlsAZhW0snC92eGrNQZ89O13Kl3CZFmwIiJ8rA
	+g9PCVPZyZdcinSIWfG+Ua9JyXXosCUlG8/k53o3M1iEQFdsXhy3QIsL
X-Gm-Gg: ASbGnctrStRQJlChjOE3H5v9i3fy+84KoRpcYw2agIJFpUgmns484EvcTntCIkALCuw
	rZQiEpoNg0ERSjzkqRPjmqgJo1ifs1Ivbv8fj9vcNq21t2FivqT7bI4ja6Kes4tC9G7SX0p6R5b
	nfZrJRkYJMvg+sQKdKqDDcazqAVENwZxV/ygZoL2TwaFB5Gvz0eKkUyDk3Fbpvzjso3VD2I5EEK
	4LNSj1IOdmfIxP4aCFYg1I8p1AcuL+E84hpDsPKrq1LKMO05dmS9ByUhrs9SJC6xe3vf9ujx/11
	TxCrnSK+ATlq9icE5BNUXlCMdKrLiokmj1MoGe4PENnAJXKsyk4pY6IcpGUrW+eXqNd8LYiGmHH
	IASvHO+RM6kY24wJ2KQhtaLJtRE5gM7ccQ5yWOEVnvvwkS50wOLaLosHuZsPgL+9gb262rBq677
	094eedPw==
X-Google-Smtp-Source: AGHT+IHdphld0nTUW0FL4kZnPuqWZOJ2nTOf3UbOG8vdAxizKHLsONTbcVoz1FMjfjVAQMg5mnXZhQ==
X-Received: by 2002:a17:902:f68f:b0:294:7048:643 with SMTP id d9443c01a7336-2962ad1efa5mr64435405ad.15.1762370792924;
        Wed, 05 Nov 2025 11:26:32 -0800 (PST)
Received: from [192.168.1.13] ([110.226.177.99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm102870a12.21.2025.11.05.11.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 11:26:32 -0800 (PST)
Message-ID: <8a4ec353-fe9d-4c7e-a56e-796280dc7f47@gmail.com>
Date: Thu, 6 Nov 2025 00:56:28 +0530
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+14b6d57fb728e27ce23c@syzkaller.appspotmail.com
References: <5ff5d1d0-192d-4aaa-8ef4-e1bfe2fdf6bb@ee.vjti.ac.in>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_unregister_user
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <5ff5d1d0-192d-4aaa-8ef4-e1bfe2fdf6bb@ee.vjti.ac.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
https://lore.kernel.org/all/20251105142251.101852-1-ssranevjti@gmail.com/T/


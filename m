Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F116080055
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715290972; cv=none; b=Ujz6c8AaJt4BxBJPqQqom8zz/rkizJOCVWSoXGVni6/2IMTinZ+9jd/wY2EFxlXrr8s0BiNPGk0T7QJkCMjMHAl7sD0zPsDrzx6wlkt4o1JnGkzWRlQLUWfKwHc435QHdh7f1Ge+boDiri02rmOJnzBKjN2WoaCurw4sesRw7TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715290972; c=relaxed/simple;
	bh=6kVWUk+HGpaaHtjW9AQ3EuVwX1170XWb0r32/8ROtyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YHmxg4iPH8S/KRhvT4htRVs+2C0YaDg9fI0QKbdli6KBjfv12lXjIqFm45R28V+Gf+qAmSTuYEZGPZKULYVd1pAnChVa0QohXMeCurgMxt4THdL4D2KVwpJYJxqzVVL55IvfbNF+oyKdAuaoGcVdyOPLGCPjf9a/QnfelS5uf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com; spf=pass smtp.mailfrom=prestonhunt.com; dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b=k3+CX1TW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prestonhunt.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prestonhunt-com.20230601.gappssmtp.com header.i=@prestonhunt-com.20230601.gappssmtp.com header.b="k3+CX1TW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b5388087f9so1072498a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 14:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prestonhunt-com.20230601.gappssmtp.com; s=20230601; t=1715290970; x=1715895770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvIRmHHv6fqXGgRF63+lC5ZMgldqunqAkjQ+2c5CHzA=;
        b=k3+CX1TW5krkpmzqnQWuhUcInolQJJ7Kwr69ZqGpBW04C/nXSUoJ9qnMIOA1En+nkV
         FaRqD+tqerOuuHXjZgKfkxB4KYaTrUv1mtI6cA4GATl3sT4ORWZxADttjx5ynHVCFHqo
         62I5D9g6c6yGsTzJaQRXxMvDgh6rhc9CoSh9ixQkOfQn+PEF3OZtkn6MGoHz09aMKwc4
         g7Ubn4jOs6nRQQ9JOhWod+ysU/HMG6/S6XQWQAndeYIUZwQ7/ZnA3HVjgICoqkqqEFdV
         I7bvEjhDRPGiWhHQlaPehAysIXVMXFNsEeiT/by3J/IIWLFNGnXAHn2iDHGYaGlSnQCZ
         ZynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715290970; x=1715895770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvIRmHHv6fqXGgRF63+lC5ZMgldqunqAkjQ+2c5CHzA=;
        b=TnHlwE6VjatJkPTaJ8tNSR9hpC2B6HGIf4eBc/1r3lrzuekLzXWJzC5JotmN0XBiHK
         IISiu+l/xlDmf6MIVr46r+XuQBaQDBiGWazyZKP06kw1PkugNPsbRj9vHHxjY8Nn1/eO
         Uf1sOlByaUSwIaVJt/JbUW+mdtqtyaHP5OKQtWMQLDE2Dmh30Q8udAr3Rg5qxCXO2WE9
         g7F7kta2YynzstmmFsOXLQsRpk40bTiKr3JahCUhRAmYnQn4jWz1uNFHe9UxogcfFoDa
         HWUGQvR5V+npU0gPWK5iCqPRlEqt0GW5wGUEO261hu4aSC+/5u7nrciu2yj7MlVX1dgG
         s10Q==
X-Gm-Message-State: AOJu0YwTj4fpwRAM4TSm6la2rdIsF9e0IuC+O0QH78qyjfWiZeyPp3aQ
	Boj7fgbcWMthYTSMcMBoULwVpykbvNNJ4/yc1ytjf1mW2x21flqeAtuCBexM4cUt2YjzzfARlGJ
	r
X-Google-Smtp-Source: AGHT+IHpBc4g2w42CXhGP8ApbDTdfLEtm180McvIHQcbL2/prMEOSvk0gZLXfE8vfZ+ufiLUBlbfEg==
X-Received: by 2002:a17:90a:d157:b0:2b2:d375:3b7c with SMTP id 98e67ed59e1d1-2b6ccc73104mr720135a91.31.1715290969584;
        Thu, 09 May 2024 14:42:49 -0700 (PDT)
Received: from localhost.localdomain (97-115-125-150.ptld.qwest.net. [97.115.125.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628ea59absm3817455a91.47.2024.05.09.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 14:42:49 -0700 (PDT)
From: Preston Hunt <me@prestonhunt.com>
To: linux-bluetooth@vger.kernel.org
Cc: Preston Hunt <me@prestonhunt.com>
Subject: [PATCH BlueZ 0/1] Update python2 examples to run properly with python3
Date: Thu,  9 May 2024 14:42:30 -0700
Message-ID: <20240509214231.2783781-1-me@prestonhunt.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several of the examples in the test/ directory are python2 scripts. In
commit d31f04aa928ae8fb7a4fc5b0876dd17ea65d4513, added a python3
shebang, causing these scripts to be run by python3. Because they are
python2 scripts, they won't run properly.

Fixed by running Python's 2to3 utility.

Preston Hunt (1):
  test examples: fix python3 errors

 test/exchange-business-cards |  4 +--
 test/get-obex-capabilities   |  6 ++--
 test/list-folders            |  6 ++--
 test/sap_client.py           | 68 ++++++++++++++++++------------------
 test/simple-player           |  4 +--
 5 files changed, 44 insertions(+), 44 deletions(-)

-- 
2.42.0


Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDB74ACC74
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 16:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217287; cv=none; b=LuhW8H4PwfadfYIF5kBd5sYqnfh7aYFAO9bDMEVFcAVC3STZPYlC+jiDy5Ve3zL+Yqn3bgjpphyHBcHVN4F0j0Bg+K2cGnUnCKk6JUGzu/xmiGCNjdaNrYhIl42cWEaRHFL2o6SLUSv1e72eMN1gq15RwpSWQ/jjUcG1lETNpQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217287; c=relaxed/simple;
	bh=ZFPKFNeL12NudLCaMBejCceswps20lhBnQG13v0OQqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRkdC3cbOP0oi9QsJLDLc2vWiKG+MmK5l+7zPBf/2UBqHA1EinytA8BZXlnVEJklcioQfuP380IygZCllUNXd/LpjUuODMu+eE5mIH7FPf8Ik78eg/bYurnCVjJ/D6luz/pAuYI9nQM+fSiTgvz/zT6bNoEzE9rAWH1pyNhx+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=IBbYPawX; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="IBbYPawX"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-35120d43ecaso2630523eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 09:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791217285; x=1791822085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9SXbvXbPFGbrJkUVkEigTxyJ/vmOwf3FQAQp2tgLsho=;
        b=IBbYPawXt5v0ek40f09p2ZbxCFs47y47beG32Mau6b52/SCtMDO5IMEOJ717AAfWaq
         or5VHUp54bZO9R2wxUQnaToy6vLLyXyFsiU4ar2IkiAwhr5m/tqtrfmkEW6vF2yfdJIq
         bu7jnlfliYhD0QsRWBsvFb/LmeVVkTptbHYabqDeft9cagZlpw/MK+/hkIdzsbfo8s36
         9xig10pv5ElpE+DcAkIRKh8hql94Ipl9nLzq5xlgdoyBQTLTZBUSqnfQIQ+ZGW2WHBzG
         AcOaG2ZEmZtx5qU/F6l3W78Ip3J0pXYYrqwnotn295iJC3gBXj6TgOpet6HuNiMnuKGk
         M6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791217285; x=1791822085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9SXbvXbPFGbrJkUVkEigTxyJ/vmOwf3FQAQp2tgLsho=;
        b=bV/An75amT+Ze3uAaVDZP6VhFJHrL7al5U7DvuVBtGT+AHSXIgG7W2giymkERMjRYa
         ekIPXBISO7uh3UazM9Xwfje0ZGTYJyADVbm6uEXyxVFQMtsh7DisOyOdWogPtYJVzZBr
         3mR3DJbh690nWS4PeJsC4rPjKOubWqpTRB/2MMo+wyZg97TUgOloyFb0/MjAxtb3xKQ+
         HYS5vaK7eTGVCusBLEoGDK9UIF9Gmx01vX33p8cRwoFHvvwytKR5yNLVhpryrGasb1Z0
         XOwsThbuPJmlVHZ+11GUBOtyY77Ly1C/xNpPQVuxDbnyEczkOQ9hihcxlYko7h9imWCV
         fikQ==
X-Gm-Message-State: AFq9FYLcK08ZDjSjiCb+dDpm8Ltl9o3ajWRn3XuV4Mzj79zLTFRPfR+9
	u26KKg5q7t5Gr+APq8nhj9Sib4ebx74XoGyQu6NDfBm+FiJSsZqqf8b5PbGuZ8zekuubJmYr+Yr
	Kwf8jyDc=
X-Gm-Gg: AYBFou2vJVylM1f5kTGH8Uczn0RAqLlpNc4uGkTT71zulVnpD3aHdMN2IFp6G5QPAwc
	rlg7ZwN8EwsoN21/3CLZFu/huMXkvHEz+5/uhparYnPrzTtwe+eXmm5D0IgSUxjOIpag3h7wt6r
	Rtj6nz5RKOJROjP9C24IRWyYIeeAnFhb3rvHnHL3N4xOFjhHMtjwFSoGyZPSt3Y8jmu7UUkIOvB
	TXs4qLEFrlyM8kV/+qgZZs+iFhn8UH7aioykEv8iDCuULiOJgbZg3Zs2X8IFEbHq9pSB43HranM
	DS4Q5uqZs0zDEh8Qc8FZXRieBh0wD2J00agTYIUuiInLelcy/oS1X0VpsIqJvUTVXy97+/mgGr1
	HG3RiDEjTVquwTlkI8/zFkx6Lnt07BRBhQ2QbSPnEBEotjzQ6sG+JlR/XReHsRYdRnbiAxrdyZy
	lIf7bqJx8n5lrz8ZaVy47NxWZWToK1EWXKNTvHdPunNgOfqwGjlSdKpFWhvkW+J9iaEivqu4pLu
	upxY3CZiiqdIj0Nt7OjjV/PxcaWrKbhSp+KW7OQti2STbQX5Fn4BaSnj+oZWbUfv6Z0UDJDQsNp
	EKurLQ9Y2zINnfAMgf8NeWsKFH48Q/Wi71tQaCZB
X-Received: by 2002:a05:693c:88dc:10b0:33b:e264:362a with SMTP id 5a478bee46e88-351113c0c4emr10315189eec.13.1791217284421;
        Mon, 05 Oct 2026 09:21:24 -0700 (PDT)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512713809csm15646567eec.7.2026.10.05.09.21.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 09:21:23 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/3] emulator: Fix extended advertising report types
Date: Mon,  5 Oct 2026 09:21:14 -0700
Message-ID: <20261005162117.4606-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btdev sends the wrong Event_Type in two of the LE Extended Advertising
Reports it generates for an advertising set:

- the scan response to non-legacy scannable advertising is reported
  with Event_Type 0x0000 instead of 0x000a
- with more than one active scanner, every scanner after the first gets
  the advertisement reported as a scan response

The first patch removes le_ext_adv_type, which sits next to this code
and has been unused since advertising sets got their own struct.

I reproduced both with a small test driving an advertiser and two
scanners in-process. On master it shows:

  scannable set: scan response 0x0000, expected 0x000a
  two scanners:  scanner 1 adv 0x001b, expected 0x0013

I can send it as a unit test if that would be useful.

mgmt-tester, iso-tester and smp-tester give the same results with and
without the series, apart from LL Privacy tests that fail
intermittently on both.

Kevin Dewald (3):
  emulator: Remove unused le_ext_adv_type
  emulator: Fix extended scan response Event_Type
  emulator: Fix report type after a scan response

 emulator/btdev.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

-- 
2.54.0 (Apple Git-157)


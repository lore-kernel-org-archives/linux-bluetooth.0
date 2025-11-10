Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196771DDC28
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765341; cv=none; b=X8B9vqrnyHVs8VrIwbbBj6GtddEA9Bt67gY5xSMNEXPnfMlWLwlXc+IAZZyLMNKoBgqtus8cWrdwbw+P+2GT3cweMnLBZ/8k0tn6bVPMlVBwmaX/98MwCbsZH966bzAS4PzIkv4NPw58CnEutfce4Y71EpE1t/bhSRbU+nJ5MVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765341; c=relaxed/simple;
	bh=et6MF5YD/fe2TpiOCbixUs1QFYSFR+IMz/Z1V4PLPGw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WRY9nw1Zqo8cDb4UCX+WC8rfdx25YoO41uXIA6VYvDvkao4OnykDhnUMEp5pqj/wGh3Lmo4bWPAafRb0UIRtg4ykF8vX0UTkZU/p4y3g8svmg8DrPue0DB5Ytx/xBBPITFy2d2NS2/cTx6hojdttantp42NEsC4NfdrdhSFWopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePTUtIf1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePTUtIf1"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8909f01bd00so283695685a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 01:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762765339; x=1763370139; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w9VepaQAHKMaBtflYWJnZmBW5Q1lMQvnugPmhHP9meY=;
        b=ePTUtIf17jmfcWIMgr9qBm3dbpMv3a2t6/Kum5SzPtdE+HxRN67LUHM3nT9D/rLRJt
         fWnsYIx7AASrspnHdwMPoMHOir6EQRCvh98K9TaxYla0FjXnuMfuC8YdNSNmmRuzr7/s
         LBy4b0n+iyWrN9zAhxTxJHRJW7Kf7aAlHP4pabv42Xoxw2/bc7uVJfLMyJIzFV35owfM
         dYrAhmPJzkfTllBYcFxXihuyi10kRBLnefyNzlewrXkRqtAil5jwSoC7wwRkmJ+8TWI1
         PIutNmDMnmkoh+zNV0zD/2WbtDpu2nHunTo1zZpeLZJx4fLHpAfwuFwReqA1+J3tND6A
         9yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765339; x=1763370139;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9VepaQAHKMaBtflYWJnZmBW5Q1lMQvnugPmhHP9meY=;
        b=tu46CZBmnQZolv/KGSgTgCd4Ek/zJ1Hum/5P/G56iZjHAF3CGOR8X0/qBuzlhROpLA
         jRckLJ629aZ6pTT9a7KIeenxMyuJNTNFslswo2FVl6gkmvNkx5RhlBfxOalDqJRVeVPc
         sOrr4Glco4X/Hxz0JlJR+QvrlNN4os+LZXQ3b9bNlRFkG57W5pPZQg9d+gAAu3KDsVKI
         KDeGAEE1dpRGmcy+TqDVAhlPt18vYzQEVATtrkRzX7u9OztUw0UC/rU2oj9Df3Mg/uzb
         eNeMRg8X81arda6ZYAUckmkLv5rB3Ji3TQqI+HyZ3DK9cC0/kgzFDXRhJkeXOV1dXPY/
         MnZw==
X-Gm-Message-State: AOJu0Yyyrk0afBGAo+HDoeicmXNcrh31oT0EKujKbxjs5ePXEX1EVomm
	A3rrmVX63W7D2CnfeuhMyw/Q30gLby+ufBZ98M6kktbNUxMEWLX7SvDCqfeoNQ==
X-Gm-Gg: ASbGncu68/rsgxt7XlbtB+8uP36Am3EPlJvv4c46nc3Cgj0bdrNx/Z+84PkCpGSjQMq
	bAg0Gw4CXGoexYLdoJC1pvOiKBg6PM8UHsM1pAQTXiMsa2yUYmpszjFo4gHnv1Ng41LM16uuY3+
	LX71a+hGwAVripCQ8TQ7JZyVfj1F50TONISSf5hzBONbncURFSVPNxmQGJ2GZqzLd04XHP0VSLn
	xJFYek+r/TfB/IOcTeBtw58y4ZVAMGapx07t0GVBfiwniYNXRQKSsy6f3/zjb1tyIkbX9Pt/pZi
	XTowGniMB4qN2/N1oK1v4WOjEvaCETpxGd6InmsFGtWjFP40WCTpLvROcf+hR1rDUdcMyKsg0sn
	RwZnICkPVq9OTCVeu8/MM468bVro/j+Kg4b3Gt8GtmRp6/1JKZ+GUu8yoGEEvuhHrXv2XXmLTu0
	EI+9mYrecpkDqxXjvm
X-Google-Smtp-Source: AGHT+IFZvQtWOCUczrJtsgYK2n9YwGeKSjhIgTgvLApQJAV++/tgfhTSy9g46WKy0xhAyEivang3fg==
X-Received: by 2002:a05:620a:a81a:b0:8b2:598d:6e66 with SMTP id af79cd13be357-8b2598d6ff5mr668143785a.22.1762765338599;
        Mon, 10 Nov 2025 01:02:18 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23582b0c9sm975606985a.55.2025.11.10.01.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:02:18 -0800 (PST)
Message-ID: <6911aa1a.050a0220.27a1a5.62b9@mx.google.com>
Date: Mon, 10 Nov 2025 01:02:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4214521583651537478=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] shared/hfp: Add Enhanced Call Status support
In-Reply-To: <20251110073804.49651-1-frederic.danis@collabora.com>
References: <20251110073804.49651-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4214521583651537478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021420

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.19 seconds
BluezMake                     PASS      2691.38 seconds
MakeCheck                     PASS      20.25 seconds
MakeDistcheck                 PASS      187.06 seconds
CheckValgrind                 PASS      238.82 seconds
CheckSmatch                   PASS      312.11 seconds
bluezmakeextell               PASS      130.20 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      932.78 seconds

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


--===============4214521583651537478==--

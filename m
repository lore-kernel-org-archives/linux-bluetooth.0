Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9781B0F03
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383065; cv=none; b=l0PW3/X2QR5/Q8OjtbjWtxvu1CWALV9WUvd47szMm5XTDlcZv5BjPpmjDaasoTCyhtGxFIssQIpw06xQH1CcgnFsVDjk3sRZ418h7Kc1MIWBARvkGcXTqnRjsL+7Nfa9Edvu9OnKubdG/64undN2uBHOFo+XkurB7oiYaPvsF5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383065; c=relaxed/simple;
	bh=9huMapLYdP4ATt33V2+e5WuMOrvdBacuNolBNR08zgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOInsL53A/cPoTqd2vySxV2D+xnHJDAv7BDh3XU9hhwrXrPebX/RGzOFHZiSSHmV53bbHD0ucHGjpVQDo3yvIINgk+42+GpDVM1owQYS7v9r+ORIA5/DuqGlsKzUzZASHcHNVt7s9Jozplvxb3Y7Akd4nN5qokGdj4V1Uj3IPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YGbYOF56; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YGbYOF56"
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DDF0A3F185
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733383054;
	bh=/RIS0nHnkl4g4MTcoFHMie3N4MZuSB1tDmETrtj2Fj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=YGbYOF56k13LZLAe52Awd6a2qxTc3MP18K8Ie13sjaLnbfLopA5JkZlXyzCJMbRvP
	 5XvsgfR0xc+e4wYxw21+RRgLBH59Bbo4uWDJAL0EPQum6XnNbu4ysOwuRAbx5DA1aq
	 wRGy4CTzlE0DdNfwSfJGF5EUxTqmmhr7kff1+JxOlDR1Ww657FweTji8uxvhSN2XYG
	 jpeWVtK6Dwnc557FestOsF//fGtvh8vFHXbg65uJpOTYVf5wF3k2l6/bb0yVLxxi/m
	 Ca6tmkSqddeET3uoVuWufoYdY61Ekm7HVrKXucFitDq9mpDMJeXI9vpdeEMIFhB+3U
	 hesndba5ntNsA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7ea8c2b257bso464871a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 23:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383053; x=1733987853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RIS0nHnkl4g4MTcoFHMie3N4MZuSB1tDmETrtj2Fj8=;
        b=u6QIKtE4P5xYkz0Sb4ErDC9yBS/zjfTKtqyhqJTX5sXLtUEg3/YyeplVooi0xnem+W
         1dXDS87okZZF2eUzEVqNdTR0E7wIh4CoprmQadeUO0IMHPjnzTRwXa4w6tDn94vvlSIM
         DkAqVa0ACOaSxi8v9FZiafuzRYI6+pSMdqNy9JA4IeRQ8+0pKKy3Ohl6q8G0MANnLptT
         Bmgl5BtH627UoZZ7qpre7Okcq2nufkued5yz9YYLUMCiWD9iSabiSg5/UGTSzFkLr4i/
         euUYRo+EKATFlKjnVnZc7nI1X1F2Ch4dJkgwwW5S3HGYPTJF+L4UENfDdREV2KReal7X
         4AMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZLWbIOWlXtPK9zpSCvxvMVl2kVrhfVvdUtOgxDnYAYSV7X6apqyYSTK2Jm3dA0rml6pFEXfg72sZBqCHerJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1peBMRoxA5N2RvxuvTaRWgvWSIZvVZn41elnFwFU8xm6zsf2y
	itVsQg8RP85lWBAcvXWHI4ZZQ/5b0Uyo+gQW+YxUWrqvvQnCnnm4bzwAlsCoNON6iM5C/u1ykgM
	F+b/dR2M3YBIIw1lljjIk6qY1NQY7ypkq88CtWg9vlYnA0LA0JA43ksrb+EsEHWw5Kq8kK3m8WO
	4QU5bGEQ==
X-Gm-Gg: ASbGnctsYcvmM30q9rFfjvp9SA7YjpKOBYiAiBFQfxXiaz+Q+duD2/kvtYniB/cRJna
	toLzComIwmMoNERTjhnKDF7kE446sKoTNbccbMhUALeJIbhJxE+KdcXEdFqgiToCNwDnpgDZlD3
	8+oboMV8eH0CwFnzOA0npnobsjS8P2MYgPfIhalmxsd+YhYPu2agtSuvlqJghizqUVCkt49wqeF
	nD4Vq/n5TmXxJUg5ataiWoKPwmzMZVf/h2kgEknjn4e7PiHnS1Npu3RrlpYC9yw56aGgD8QXwVV
	NDlMJuOXByX2Ek5rxKVxrjHLhllNyyFH62uNKv5ptTVyysh0UCqK
X-Received: by 2002:a05:6a21:118e:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e16533435fmr15688805637.0.1733383053251;
        Wed, 04 Dec 2024 23:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGjhvekHo3vTsU0CH7fUBu54sWUP62KnHSZbe471psELyNS6NOWZGRPH6aKI4mwGvu/37iTQ==
X-Received: by 2002:a05:6a21:118e:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e16533435fmr15688780637.0.1733383052937;
        Wed, 04 Dec 2024 23:17:32 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156fb8fcsm573909a12.40.2024.12.04.23.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:17:32 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	kuan-ying.lee@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v3 0/2] Bluetooth: btusb: Fix QCA dump packet handling and improve SKB safety
Date: Thu,  5 Dec 2024 15:17:25 +0800
Message-ID: <20241205071727.36710-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a NULL pointer dereference in the QCA firmware dump
handling and improves the safety of SKB buffer handling. The problem occurs
when processing firmware crash dumps from WCN7851/WCN6855 Bluetooth
controllers, where incorrect return value handling leads to premature SKB
freeing and subsequent NULL pointer dereference.

The series is split into two parts:
- Patch 1 fixes the NULL pointer dereference by correcting return value
  handling and splits dump packet detection into separate ACL and event
  functions
- Patch 2 improves SKB safety by using proper buffer access methods and
  adding state restoration on error paths

Changes in v3:
- Use skb_pull_data() for safe packet header access
- Split dump packet detection into separate ACL and event helpers

Changes in v2:
- Fixed typo in the title
- Re-flowed commit message line to fit 72 characters
- Added blank line before btusb_recv_acl_qca()

En-Wei Wu (2):
  Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
  Bluetooth: btusb: Improve SKB safety in QCA dump packet handling

 drivers/bluetooth/btusb.c | 120 +++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 46 deletions(-)

-- 
2.43.0


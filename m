Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011306;
	b=3wjbgwwEObXnxr50cUwJT5fWfDIZxVKEf+Kw1rXTy3p4ldrXJbmQXswEnfw1Wib1npUz
	 ceJq8l2WFCFmGv7RtwwPdRlhUEb3jhn3ZOw0G1uhXh6MXxc5oLv9V41KDpcMZQhcF6z7a
	 ZD1yyXXmBeZ5jHBNq+9YtP/Ac+XNt0leclaspS+pSpUZfvoXKJMfwfc1zKqv1loDOlLZw
	 vtaZqzsESlkwNe3HGDo4nT/uc70frfZzIRlwJUKAHsY1VFoT9NA5rQQccEw9zr0DYaAQf
	 aGsDz+Xh3dFvKEqyG3e/cpfIQ90Y/VKgI/SayJ/wV6Pdnq1L+jxmVqIZFonKTKHjuUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=2sl2UYato9PST07e2NHUUDKpmyZiHhJhxergzADRXcE=;
	b=saSOpMp7IvBkF4naQvAJlgFldHotjEOdtwK1n1Z2ZYNmx1biz6+5OWf9Gkt3WgBcqKAV
	 7aWBBUbvr1fdChefUHrpFVNEkn16yoXXSpFoj0MHjOi5Gh+QO4dKW55zhCSi4VkPdxxMM
	 MlKdmyzMyYbbhw9ibEiZApAcb57ib/kIvimSaD0/OCMgbhKBheEHOI0QqcfA+zh8kFsyQ
	 x1r7JdSGyM7fDVG7WMru3pTvuoiSrIJVGZeDWMFgqfEMntOAq71lAtlGA/TyODPEOeWuL
	 jYcZLSuTADh3WvM4cuzhR8m/Wh1MJ0dXQ8t8gc91ootN92kC8SVEooCPtrCr8/mctXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lo3b99Kg;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91A1606A331
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E91A1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lo3b99Kg
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so14267095e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795011300; x=1795616100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2sl2UYato9PST07e2NHUUDKpmyZiHhJhxergzADRXcE=;
        b=Lo3b99Kgcxzt4xKOm6wJvpQMoqmyuCMvRsWY8ijt+XOVboJb5WKy6qNg/fJ7OHa8cx
         aWCX+m2/AklAVFtjxk04SBhmZPFSvy7LlI/6occjqrJ4s3gYLH0WKvVG2sGc3IrMbBuI
         O6NtBFe+MmfCnXZ7k2oHFMROIEqWkxzBiiVE0zj8nqCRMpvEZMTkX4apzebk5+HswicL
         aPFN9PGwl3JjSgEBK4mqgVbwcYLGSU0kNCfustM0yLMPnYZnkEC5+EUhDDDm586fuo6G
         zFXi6MDEAsPULQ16Xi6VQS8qLhKUCHgStAHC5MQ6M0foCXlHs2LQmR73ir4FcPEkyTFT
         fwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011300; x=1795616100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sl2UYato9PST07e2NHUUDKpmyZiHhJhxergzADRXcE=;
        b=C5YVDEDlFXhqsUUWS1ppiww4FIOEoDVmNgnlRn5mFGa5WuU/KitDGaacoeYpgq5JEk
         VIPQqXxdTSBoq/Z02CrHT5gYPPVU6tzuVWIpf/r2tKNCOlK4RHplORPUyeu/S3o9F6fV
         0VlG9CVNMI8xWJXUQLdVFl+p0Fz0zxL8lsCxCV9Q81zQMmo47W068mLuAFf+tbIH6xKq
         WtmVpGxpmRPvVs/TVK0qikbxgy5wBqDqq5YE1VHcNzFv2S+vSK9fnAbud/g3/QddUQl9
         GufDip986KQs8JSoSPhZiCfk5QjwYpBz75TsVhLB+GAhshZrNimmdYON2H2mezF0SS8F
         4SMg==
X-Gm-Message-State: APuU4Z9+ivcwnCbdYU15N0u1K2XzHmlMy3xzmNB9eL11VqalhLHgvr7j
	l+DYBrKHPvAGt+zE3bV6PYXmN6GXiFpZKeNY8mXdcOaPuWE5BQbdtANnxAP8BEpbU7I=
X-Gm-Gg: AYBFou1vGmgdG1zXWpxbBMWv+3FJyosAU5x5y1xxZ+t3nTdtT+iMAIT1tBQmWtAeZJn
	bUAWNAgxWvQlVpFv9b2YrnlPCox27am2786rA8+SCBeWcxK8c2XLIL5/V9tE12u1njUxRvPOxbn
	EI518OJy1Y8tQstiNOG8yGAnL0++Y1xDecHn8QlYKKuuTWjDFD0/5Eiw8xJjcfvZVflNmXbsa8s
	eSnc9EEq0yWvdqMUCN4Tgdi+sWvAkFRPh5ZyXJhmED8lMdrjeEnC1piAyBwTlWCjZPSTToTNt32
	+EBCQSSMUP86RQqbPzzQWgI8OgBKFn24cYumvFtzFwezedcnG+i6B6QZZaqkY8JixGqXqGu2tcP
	MDRuDRoz1T7JE6ZGiMN85nG0OfNw/SflZfilMF4Oyb5+44hkLnqWN1okpTyCVUdQkCQcBqMG8T3
	JW9Ftg7YLcSQrvMqvYcrA2mKc0yFtD38j+lGPufD8Y9eOOg1+GDa61183auKAFvnsyOpkk2pBc6
	/mjz8OfINtqgAdekByCVdhRrJ1+lw77Zmsr8Bqm9v5WLgfLaFtXugMW86iSpAlNn3NmIKMg1y3q
	eONCISNKmrySp9nP8Lt4BG9lOkjZigpV9ctkwFf8RlU8UODSXOYZ
X-Received: by 2002:a05:600c:470a:b0:4bb:6fd3:5ac0 with SMTP id 5b1f17b1804b1-4bb7da2b98fmr53502785e9.28.1795011300146;
        Wed, 18 Nov 2026 06:15:00 -0800 (PST)
Received: from localhost.localdomain ([197.119.251.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7e588884sm20894275e9.2.2026.11.18.06.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:14:59 -0800 (PST)
From: AuthenticSm1les <khidarlaminehamdi@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: AuthenticSm1les <khidarlaminehamdi@gmail.com>
Subject: [PATCH BlueZ 0/2] Don't probe LE Audio profiles on unpaired devices
Date: Wed, 18 Nov 2026 17:14:36 +0300
Message-ID: <20261118141438.308232-1-khidarlaminehamdi@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When an unpaired phone connects to us over LE, for example Android's
Quick Share checking a GATT advertisement, bluetoothd probes the LE
Audio client profiles. Their reads fail with Insufficient
Authentication, bt_att raises security and the phone shows a pairing
dialog. That's the issue reported in #1789.

In the "Don't auto-bond on reactive GATT security elevation" thread
Luiz suggested fixing the plugins rather than the elevation, so this
adds a paired_only flag to btd_profile and sets it on the LE Audio
client profiles whose services need encryption.

Tested on an Intel 8265 (BT 4.2) with a Samsung phone. Quick Share
from the unpaired phone no longer gets a pairing dialog, and tmap still
reads the phone fine. Pairing over BR/EDR from bluetoothctl still works
and an A2DP/HFP headset reconnects as before. Unit tests pass.

I couldn't test with real LE Audio hardware, pairing while an LE link
is already up, or a dual-mode device paired over BR/EDR and then
connecting over LE. Testing on any of those would be appreciated.

Link: https://github.com/bluez/bluez/issues/1789

AuthenticSm1les (2):
  profile: Add paired_only flag
  audio: Mark LE Audio client profiles paired_only

 profiles/audio/bap.c  |  1 +
 profiles/audio/bass.c |  1 +
 profiles/audio/ccp.c  |  1 +
 profiles/audio/csip.c |  1 +
 profiles/audio/mcp.c  |  2 ++
 profiles/audio/micp.c |  1 +
 profiles/audio/vcp.c  |  1 +
 src/device.c          | 29 +++++++++++++++++++++++++++++
 src/profile.h         |  7 +++++++
 src/service.c         | 13 +++++++++++++
 10 files changed, 57 insertions(+)

-- 
2.56.1


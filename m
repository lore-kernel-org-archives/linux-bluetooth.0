Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674381BC2A
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 Mar 2024 23:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766292; cv=none; b=D7poDF0EPLDXKIk63TBvoIzywwI43/cmFWg12um4I7hH1KYHQzx3X2HAB354ynMBrJLd2zq3ePChCW/5Zt5mCklw+yA6kFXKiwB36bTkM+UMQCPemU5cI71GfEDQeZkq+kIGyNgst2GhV2LVqYRfxkDYOhO09ILpAc4J96e0DcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766292; c=relaxed/simple;
	bh=VwzUCcWJoKaHPQffcCXApnFOxTK6gwBTwQEnB1ELGoc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nWdkHKQR+63ieam4bZxWnqKMmG+OH97xVq0SeBhBd8H/4UQsYhtrMgTN7BfO20oFQE9ZT2r1OzkkPPw1CjlaO3jq4ybQvExob4cP3yHPtwVwXgZwqYsxjTDF5heAdxJQSG2s9IMJPZZwgH2bXA2St22vt/yec2tjMlFlnrZ4zd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eenj02O/; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eenj02O/"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7d5c40f874aso141398241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 15:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709766286; x=1710371086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJsOfwBmsHhIwWf6x3Qh0bPw4A5Hg2C29xcahT/w+nU=;
        b=Eenj02O//Th2OBfnhlXa8mtNtGviwAc5tNxBNtV6ge80IFxpD+Q0V/9QgndoFjpxbF
         LCM5kE5kamthyYMXAoWJB87s7o0nIbZvQMioxn6vP4+shl5qMlRT/9pa76DVC6gk8b59
         reNAvmCCs/JF4nB/GM6q5pWmhVs0I6bOTWW/wi3UNIbT89WvV7X1nRr9tiT7alCzqn8H
         h7F8MAGhlIZN5OwHskbdEDl5lTt8+8YzC+9LKlfSMVEk6GUIKNjozjmPTTtzY9uRp2hL
         nZSZ73+zuZgWDzQnwsoek0I0lOdzTdGCMcQMzjiVQthI0zCSDuWU5qL0hkPSZ4MWYglW
         xJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709766286; x=1710371086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vJsOfwBmsHhIwWf6x3Qh0bPw4A5Hg2C29xcahT/w+nU=;
        b=X26GufZVVtpHwSgN7dZ7hyUS++fLOV941KWUrOlOQooMYjZQQl9zBH1j9Pwjht94Sv
         AWqjHDDNA62/+QXQCcpY++ehBWNAbHb6vMJXexa9vdEi33E3nNM3IK97d8mjC0JehkRN
         abt3nTN9tCplEdlhxHN3jJW/x+G59ZD88r6S7cQM7tl8Arzb7vkAriu4quP1smbTSFow
         x8Bs8ksKb/mPtdT4f6qlKxOrMgqPzlRNA/wpDjYTozoB4HRqsrRWUQIiySmQ1E98MDpR
         ctOT5DF1jnJaAoqk1ksVwRp9ugLL/Kt6JT1VnjSfLmQL5FGFqrfjzWDr8MI+qPbNFto/
         IB1A==
X-Gm-Message-State: AOJu0YzGQrikOWozi1quo5mXz2PnAxUhAQks946JXXyX+0+ZIoj/1B+R
	Cum/TYFxccSjzhe2p846dAqRXcxmnaH4HVBNWePs9JXj64DA1dKBrZrrvZo+
X-Google-Smtp-Source: AGHT+IEuGYrp4H+I2ADHAY5lfTb1uxQMl/N1kn/1DQiS4/22Wif8VzlGzbMBGaWtuz3XgWSwts91iA==
X-Received: by 2002:a05:6122:1d94:b0:4d3:37d1:5a70 with SMTP id gg20-20020a0561221d9400b004d337d15a70mr7308951vkb.7.1709766284710;
        Wed, 06 Mar 2024 15:04:44 -0800 (PST)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id d9-20020ac5c549000000b004cd7e68c973sm1659592vkl.19.2024.03.06.15.04.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 15:04:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/2] test-bap: Add STR sink tests
Date: Wed,  6 Mar 2024 18:04:40 -0500
Message-ID: <20240306230440.3983598-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306230440.3983598-1-luiz.dentz@gmail.com>
References: <20240306230440.3983598-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

4.10.1 Unicast Client Streaming – 1 Unicast Server, 1 Stream, 1 CIS –
LC3 (Page 80)

 Test Purpose:
 Verify that a Unicast Client IUT can stream audio data over one unicast
 Audio Stream to or from a Unicast Server.

 Pass verdict:
 If the IUT is in the Audio Sink role, the IUT receives SDUs with a zero or
 more length that contains LC3-encoded data formatted using the LC3 Media
 Packet format (defined in [3] Section 4.2).

Test Summary
------------
BAP/UCL/STR/BV-001-C [UCL, AC 2, LC3 8_1_1]          Passed
BAP/UCL/STR/BV-002-C [UCL, AC 10, LC3 8_1_1]         Passed
BAP/UCL/STR/BV-003-C [UCL, AC 2, LC3 8_2_1]          Passed
BAP/UCL/STR/BV-004-C [UCL, AC 10, LC3 8_2_1]         Passed
BAP/UCL/STR/BV-005-C [UCL, AC 2, LC3 16_1_1]         Passed
BAP/UCL/STR/BV-006-C [UCL, AC 10, LC3 16_1_1]        Passed
BAP/UCL/STR/BV-007-C [UCL, AC 2, LC3 16_2_1]         Passed
BAP/UCL/STR/BV-008-C [UCL, AC 10, LC3 16_2_1]        Passed
BAP/UCL/STR/BV-009-C [UCL, AC 2, LC3 24_1_1]         Passed
BAP/UCL/STR/BV-010-C [UCL, AC 10, LC3 24_1_1]        Passed
BAP/UCL/STR/BV-011-C [UCL, AC 2, LC3 24_2_1]         Passed
BAP/UCL/STR/BV-012-C [UCL, AC 10, LC3 24_2_1]        Passed
BAP/UCL/STR/BV-013-C [UCL, AC 2, LC3 32_1_1]         Passed
BAP/UCL/STR/BV-014-C [UCL, AC 10, LC3 32_1_1]        Passed
BAP/UCL/STR/BV-015-C [UCL, AC 2, LC3 32_2_1]         Passed
BAP/UCL/STR/BV-016-C [UCL, AC 10, LC3 32_2_1]        Passed
BAP/UCL/STR/BV-017-C [UCL, AC 2, LC3 441_1_1]        Passed
BAP/UCL/STR/BV-018-C [UCL, AC 10, LC3 441_1_1]       Passed
BAP/UCL/STR/BV-019-C [UCL, AC 2, LC3 44_2_1]         Passed
BAP/UCL/STR/BV-020-C [UCL, AC 10, LC3 44_2_1]        Passed
BAP/UCL/STR/BV-021-C [UCL, AC 2, LC3 48_1_1]         Passed
BAP/UCL/STR/BV-022-C [UCL, AC 10, LC3 48_1_1]        Passed
BAP/UCL/STR/BV-023-C [UCL, AC 2, LC3 48_2_1]         Passed
BAP/UCL/STR/BV-024-C [UCL, AC 10, LC3 48_2_1]        Passed
BAP/UCL/STR/BV-025-C [UCL, AC 2, LC3 48_3_1]         Passed
BAP/UCL/STR/BV-026-C [UCL, AC 10, LC3 48_3_1]        Passed
BAP/UCL/STR/BV-027-C [UCL, AC 2, LC3 48_4_1]         Passed
BAP/UCL/STR/BV-028-C [UCL, AC 10, LC3 48_4_1]        Passed
BAP/UCL/STR/BV-029-C [UCL, AC 2, LC3 48_5_1]         Passed
BAP/UCL/STR/BV-030-C [UCL, AC 10, LC3 48_5_1]        Passed
BAP/UCL/STR/BV-031-C [UCL, AC 2, LC3 48_6_1]         Passed
BAP/UCL/STR/BV-032-C [UCL, AC 10, LC3 48_6_1]        Passed
BAP/UCL/STR/BV-033-C [UCL, SRC, AC 1, LC3 8_1_1]     Passed
BAP/UCL/STR/BV-034-C [UCL, SRC, AC 4, LC3 8_1_1]     Passed
BAP/UCL/STR/BV-035-C [UCL, SRC, AC 1, LC3 8_2_1]     Passed
BAP/UCL/STR/BV-036-C [UCL, SRC, AC 4, LC3 8_2_1]     Passed
BAP/UCL/STR/BV-037-C [UCL, SRC, AC 1, LC3 16_1_1]    Passed
BAP/UCL/STR/BV-038-C [UCL, SRC, AC 4, LC3 16_1_1]    Passed
BAP/UCL/STR/BV-039-C [UCL, SRC, AC 1, LC3 16_2_1]    Passed
BAP/UCL/STR/BV-040-C [UCL, SRC, AC 4, LC3 16_2_1]    Passed
BAP/UCL/STR/BV-041-C [UCL, SRC, AC 1, LC3 24_1_1]    Passed
BAP/UCL/STR/BV-042-C [UCL, SRC, AC 4, LC3 24_1_1]    Passed
BAP/UCL/STR/BV-043-C [UCL, SRC, AC 1, LC3 24_2_1]    Passed
BAP/UCL/STR/BV-044-C [UCL, SRC, AC 4, LC3 24_2_1]    Passed
BAP/UCL/STR/BV-045-C [UCL, SRC, AC 1, LC3 32_1_1]    Passed
BAP/UCL/STR/BV-046-C [UCL, SRC, AC 4, LC3 32_1_1]    Passed
BAP/UCL/STR/BV-047-C [UCL, SRC, AC 1, LC3 32_2_1]    Passed
BAP/UCL/STR/BV-048-C [UCL, SRC, AC 4, LC3 32_2_1]    Passed
BAP/UCL/STR/BV-049-C [UCL, SRC, AC 1, LC3 44_1_1]    Passed
BAP/UCL/STR/BV-050-C [UCL, SRC, AC 4, LC3 44_1_1]    Passed
BAP/UCL/STR/BV-051-C [UCL, SRC, AC 1, LC3 44_2_1]    Passed
BAP/UCL/STR/BV-052-C [UCL, SRC, AC 4, LC3 44_2_1]    Passed
BAP/UCL/STR/BV-053-C [UCL, SRC, AC 1, LC3 48_1_1]    Passed
BAP/UCL/STR/BV-054-C [UCL, SRC, AC 4, LC3 48_1_1]    Passed
BAP/UCL/STR/BV-055-C [UCL, SRC, AC 1, LC3 48_2_1]    Passed
BAP/UCL/STR/BV-056-C [UCL, SRC, AC 4, LC3 48_2_1]    Passed
BAP/UCL/STR/BV-057-C [UCL, SRC, AC 1, LC3 48_3_1]    Passed
BAP/UCL/STR/BV-058-C [UCL, SRC, AC 4, LC3 48_3_1]    Passed
BAP/UCL/STR/BV-059-C [UCL, SRC, AC 1, LC3 48_4_1]    Passed
BAP/UCL/STR/BV-060-C [UCL, SRC, AC 4, LC3 48_4_1]    Passed
BAP/UCL/STR/BV-061-C [UCL, SRC, AC 1, LC3 48_5_1]    Passed
BAP/UCL/STR/BV-062-C [UCL, SRC, AC 4, LC3 48_5_1]    Passed
BAP/UCL/STR/BV-063-C [UCL, SRC, AC 1, LC3 48_6_1]    Passed
BAP/UCL/STR/BV-064-C [UCL, SRC, AC 4, LC3 48_6_1]    Passed
BAP/UCL/STR/BV-065-C [UCL, AC 2, LC3 8_1_2]          Passed
BAP/UCL/STR/BV-066-C [UCL, AC 10, LC3 8_1_2]         Passed
BAP/UCL/STR/BV-067-C [UCL, AC 2, LC3 8_2_2]          Passed
BAP/UCL/STR/BV-068-C [UCL, AC 10, LC3 8_2_2]         Passed
BAP/UCL/STR/BV-069-C [UCL, AC 2, LC3 16_1_2]         Passed
BAP/UCL/STR/BV-070-C [UCL, AC 10, LC3 16_1_2]        Passed
BAP/UCL/STR/BV-071-C [UCL, AC 2, LC3 16_2_2]         Passed
BAP/UCL/STR/BV-072-C [UCL, AC 10, LC3 16_2_2]        Passed
BAP/UCL/STR/BV-073-C [UCL, AC 2, LC3 24_1_2]         Passed
BAP/UCL/STR/BV-074-C [UCL, AC 10, LC3 24_1_2]        Passed
BAP/UCL/STR/BV-075-C [UCL, AC 2, LC3 24_2_2]         Passed
BAP/UCL/STR/BV-076-C [UCL, AC 10, LC3 24_2_2]        Passed
BAP/UCL/STR/BV-077-C [UCL, AC 2, LC3 32_1_2]         Passed
BAP/UCL/STR/BV-078-C [UCL, AC 10, LC3 32_1_2]        Passed
BAP/UCL/STR/BV-079-C [UCL, AC 2, LC3 32_2_2]         Passed
BAP/UCL/STR/BV-080-C [UCL, AC 10, LC3 32_2_2]        Passed
BAP/UCL/STR/BV-081-C [UCL, AC 2, LC3 44_1_2]         Passed
BAP/UCL/STR/BV-082-C [UCL, AC 10, LC3 44_1_2]        Passed
BAP/UCL/STR/BV-083-C [UCL, AC 2, LC3 44_2_2]         Passed
BAP/UCL/STR/BV-084-C [UCL, AC 10, LC3 44_2_2]        Passed
BAP/UCL/STR/BV-085-C [UCL, AC 2, LC3 48_1_2]         Passed
BAP/UCL/STR/BV-086-C [UCL, AC 10, LC3 48_1_2]        Passed
BAP/UCL/STR/BV-087-C [UCL, AC 2, LC3 48_2_2]         Passed
BAP/UCL/STR/BV-088-C [UCL, AC 10, LC3 48_2_2]        Passed
BAP/UCL/STR/BV-089-C [UCL, AC 2, LC3 48_3_2]         Passed
BAP/UCL/STR/BV-090-C [UCL, AC 10, LC3 48_3_2]        Passed
BAP/UCL/STR/BV-091-C [UCL, AC 2, LC3 48_4_2]         Passed
BAP/UCL/STR/BV-092-C [UCL, AC 10, LC3 48_4_2]        Passed
BAP/UCL/STR/BV-093-C [UCL, AC 2, LC3 48_5_2]         Passed
BAP/UCL/STR/BV-094-C [UCL, AC 10, LC3 48_5_2]        Passed
BAP/UCL/STR/BV-095-C [UCL, AC 2, LC3 48_6_2]         Passed
BAP/UCL/STR/BV-096-C [UCL, AC 10, LC3 48_6_2]        Passed
BAP/UCL/STR/BV-097-C [UCL, SRC, AC 1, LC3 8_1_2]     Passed
BAP/UCL/STR/BV-098-C [UCL, SRC, AC 4, LC3 8_1_2]     Passed
BAP/UCL/STR/BV-099-C [UCL, SRC, AC 1, LC3 8_2_2]     Passed
BAP/UCL/STR/BV-100-C [UCL, SRC, AC 4, LC3 8_2_2]     Passed
BAP/UCL/STR/BV-101-C [UCL, SRC, AC 1, LC3 16_1_2]    Passed
BAP/UCL/STR/BV-102-C [UCL, SRC, AC 4, LC3 16_1_2]    Passed
BAP/UCL/STR/BV-103-C [UCL, SRC, AC 1, LC3 16_2_2]    Passed
BAP/UCL/STR/BV-104-C [UCL, SRC, AC 4, LC3 16_2_2]    Passed
BAP/UCL/STR/BV-105-C [UCL, SRC, AC 1, LC3 24_1_2]    Passed
BAP/UCL/STR/BV-106-C [UCL, SRC, AC 4, LC3 24_1_2]    Passed
BAP/UCL/STR/BV-107-C [UCL, SRC, AC 1, LC3 24_2_2]    Passed
BAP/UCL/STR/BV-108-C [UCL, SRC, AC 4, LC3 24_2_2]    Passed
BAP/UCL/STR/BV-109-C [UCL, SRC, AC 1, LC3 32_1_2]    Passed
BAP/UCL/STR/BV-110-C [UCL, SRC, AC 4, LC3 32_1_2]    Passed
BAP/UCL/STR/BV-111-C [UCL, SRC, AC 1, LC3 32_2_2]    Passed
BAP/UCL/STR/BV-112-C [UCL, SRC, AC 4, LC3 32_2_2]    Passed
BAP/UCL/STR/BV-113-C [UCL, SRC, AC 1, LC3 44_1_2]    Passed
BAP/UCL/STR/BV-114-C [UCL, SRC, AC 4, LC3 44_1_2]    Passed
BAP/UCL/STR/BV-115-C [UCL, SRC, AC 1, LC3 44_2_2]    Passed
BAP/UCL/STR/BV-116-C [UCL, SRC, AC 4, LC3 44_2_2]    Passed
BAP/UCL/STR/BV-117-C [UCL, SRC, AC 1, LC3 48_1_2]    Passed
BAP/UCL/STR/BV-118-C [UCL, SRC, AC 4, LC3 48_1_2]    Passed
BAP/UCL/STR/BV-119-C [UCL, SRC, AC 1, LC3 48_2_2]    Passed
BAP/UCL/STR/BV-120-C [UCL, SRC, AC 4, LC3 48_2_2]    Passed
BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_3_2]    Passed
BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_3_2]    Passed
BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_4_2]    Passed
BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_4_2]    Passed
BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_5_2]    Passed
BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_5_2]    Passed
BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_6_2]    Passed
BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_6_2]    Passed
Total: 128, Passed: 128 (100.0%), Failed: 0, Not Run: 0
---
 unit/test-bap.c | 2472 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 2466 insertions(+), 6 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index ecd5e2897093..29b027096f55 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -372,6 +372,8 @@ static void bap_enable(struct bt_bap_stream *stream,
 						data);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
+		if (data->cfg->snk)
+			return;
 		id = bt_bap_stream_start(data->stream, bap_start, data);
 		break;
 	}
@@ -2291,8 +2293,7 @@ static struct test_config cfg_src_enable = {
  *   Handle: 0x001c
  *     Data: 030300000403020100
  */
-#define SCC_SRC_ENABLE \
-	SCC_SRC_16_2_1, \
+#define SRC_ENABLE \
 	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x03, 0x04, 0x03, 0x02, 0x01, \
 			00), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x01, 0x00, 0x00), \
@@ -2300,6 +2301,10 @@ static struct test_config cfg_src_enable = {
 	IOV_DATA(0x1b, 0x1c, 0x00, 0x03, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
 			0x01, 0x00)
 
+#define SCC_SRC_ENABLE \
+	SCC_SRC_16_2_1, \
+	SRC_ENABLE
+
 /* Test Purpose:
  * Verify that a Unicast Client IUT can initiate an Enable operation for an ASE
  * with a Unicast Server that is either in the Audio Sink role or the Audio
@@ -2408,7 +2413,7 @@ static struct test_config cfg_src_disable_streaming = {
  *   Handle: 0x0016
  *     Data: 0101010400403020100
  */
-#define ASE_SRC_START \
+#define SRC_START \
 	IOV_DATA(0x52, 0x22, 0x00, 0x04, 0x01, 0x03), \
 	IOV_DATA(0x1b, 0x22, 0x00, 0x04, 0x01, 0x03, 0x00, 0x00), \
 	IOV_NULL, \
@@ -2417,7 +2422,7 @@ static struct test_config cfg_src_disable_streaming = {
 
 #define SCC_SRC_DISABLE_STREAMING \
 	SCC_SRC_ENABLE, \
-	ASE_SRC_START, \
+	SRC_START, \
 	ASE_SRC_DISABLE
 
 /* Test Purpose:
@@ -2620,7 +2625,7 @@ static struct test_config cfg_src_start_release = {
 
 #define SCC_SRC_START_RELEASE \
 	SCC_SRC_ENABLE, \
-	ASE_SRC_START, \
+	SRC_START, \
 	ASE_SRC_RELEASE
 
 static void state_disable_release(struct bt_bap_stream *stream,
@@ -2798,7 +2803,7 @@ static struct test_config cfg_src_metadata_streaming = {
 
 #define SCC_SRC_METADATA_STREAMING \
 	SCC_SRC_ENABLE, \
-	ASE_SRC_START, \
+	SRC_START, \
 	ASE_SRC_METADATA
 
 /* Unicast Client Initiates Update Metadata Operation
@@ -2825,6 +2830,2460 @@ static void test_scc_metadata(void)
 			SCC_SRC_METADATA_STREAMING);
 }
 
+#define SNK_ENABLE \
+	IOV_DATA(0x52, 0x22, 0x00, 0x03, 0x01, 0x01, 0x04, 0x03, 0x02, 0x01, \
+			00), \
+	IOV_DATA(0x1b, 0x22, 0x00, 0x03, 0x01, 0x01, 0x00, 0x00), \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x03, 0x00, 0x00, 0x04, 0x03, 0x02, \
+			0x01, 0x00)
+
+#define SNK_START \
+	IOV_NULL, \
+	IOV_DATA(0x1b, 0x16, 0x00, 0x01, 0x04, 0x00, 0x00, 0x04, 0x03, 0x02, \
+			0x01, 0x00)
+
+static struct test_config str_snk_ac2_8_1_1 = {
+	.cc = LC3_CONFIG_8_1_AC(1),
+	.qos = LC3_QOS_8_1_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK(_freq, _ac, _dur, _len) \
+	SCC_SNK_LC3(0x10, 0x02, 0x01, _freq, 0x02, 0x02, _dur, 0x03, 0x04, \
+			_len, _len >> 8, 0x05, 0x03, _ac, 0x00, 0x00, 0x00)
+
+#define STR_SNK_8(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_8KHZ, _ac, _dur, _len)
+
+#define STR_SNK_8_1(_ac) \
+	STR_SNK_8(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_8_1)
+
+#define STR_SNK_QOS(_interval, _sdu, _rtn, _latency) \
+	QOS_SNK(_interval & 0xff, _interval >> 8 & 0xff, \
+		_interval >> 16 & 0xff, 0x00, 0x02, _sdu & 0xff, \
+		_sdu >> 8 & 0xff, _rtn, \
+		_latency, _latency >> 8, 0x40, 0x9c, 0x00)
+
+#define STR_SNK_QOS_1(_sdu, _rtn, _latency) \
+	STR_SNK_QOS(7500u, _sdu, _rtn, _latency)
+
+#define STR_SNK_8_1_1(_chans) \
+	STR_SNK_8_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_8_1, LC3_QOS_8_1_1_RTN, \
+			LC3_QOS_8_1_1_LATENCY)
+
+#define STR_SNK_AC2_8_1_1 \
+	STR_SNK_8_1_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_8_1_1 = {
+	.cc = LC3_CONFIG_8_1_AC(2),
+	.qos = LC3_QOS_8_1_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_8_1_1 \
+	STR_SNK_8_1_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_8_2_1 = {
+	.cc = LC3_CONFIG_8_2_AC(1),
+	.qos = LC3_QOS_8_2_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_8_2(_ac) \
+	STR_SNK_8(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_8_2)
+
+#define STR_SNK_QOS_2(_sdu, _rtn, _latency) \
+	STR_SNK_QOS(10000u, _sdu, _rtn, _latency)
+
+#define STR_SNK_8_2_1(_chans) \
+	STR_SNK_8_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_8_2, LC3_QOS_8_2_1_RTN, \
+			LC3_QOS_8_2_1_LATENCY)
+
+#define STR_SNK_AC2_8_2_1 \
+	STR_SNK_8_2_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_8_2_1 = {
+	.cc = LC3_CONFIG_8_2_AC(2),
+	.qos = LC3_QOS_8_2_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_8_2_1 \
+	STR_SNK_8_2_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_8_1_2 = {
+	.cc = LC3_CONFIG_8_1_AC(1),
+	.qos = LC3_QOS_8_1_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_8_1_2(_chans) \
+	STR_SNK_8_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_8_1, LC3_QOS_8_1_2_RTN, \
+			LC3_QOS_8_1_2_LATENCY)
+
+#define STR_SNK_AC2_8_1_2 \
+	STR_SNK_8_1_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_8_1_2 = {
+	.cc = LC3_CONFIG_8_1_AC(2),
+	.qos = LC3_QOS_8_1_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_8_1_2 \
+	STR_SNK_8_1_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_8_2_2 = {
+	.cc = LC3_CONFIG_8_2_AC(1),
+	.qos = LC3_QOS_8_2_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_8_2_2(_chans) \
+	STR_SNK_8_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_8_2, LC3_QOS_8_2_2_RTN, \
+			LC3_QOS_8_2_2_LATENCY)
+
+#define STR_SNK_AC2_8_2_2 \
+	STR_SNK_8_2_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_8_2_2 = {
+	.cc = LC3_CONFIG_8_2_AC(2),
+	.qos = LC3_QOS_8_2_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_8_2_2 \
+	STR_SNK_8_2_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_16_1_1 = {
+	.cc = LC3_CONFIG_16_1_AC(1),
+	.qos = LC3_QOS_16_1_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_16(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_16KHZ, _ac, _dur, _len)
+
+#define STR_SNK_16_1(_ac) \
+	STR_SNK_16(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_16_1)
+
+#define STR_SNK_16_1_1(_chans) \
+	STR_SNK_16_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_16_1, LC3_QOS_16_1_1_RTN, \
+			LC3_QOS_16_1_1_LATENCY)
+
+#define STR_SNK_AC2_16_1_1 \
+	STR_SNK_16_1_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_16_1_1 = {
+	.cc = LC3_CONFIG_16_1_AC(2),
+	.qos = LC3_QOS_16_1_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_16_1_1 \
+	STR_SNK_16_1_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_16_2_1 = {
+	.cc = LC3_CONFIG_16_2_AC(1),
+	.qos = LC3_QOS_16_2_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_16_2(_ac) \
+	STR_SNK_16(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_16_2)
+
+#define STR_SNK_16_2_1(_chans) \
+	STR_SNK_16_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_16_2, LC3_QOS_16_2_1_RTN, \
+			LC3_QOS_16_2_1_LATENCY)
+
+#define STR_SNK_AC2_16_2_1 \
+	STR_SNK_16_2_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_16_2_1 = {
+	.cc = LC3_CONFIG_16_2_AC(2),
+	.qos = LC3_QOS_16_2_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_16_2_1 \
+	STR_SNK_16_2_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_16_1_2 = {
+	.cc = LC3_CONFIG_16_1_AC(1),
+	.qos = LC3_QOS_16_1_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_16(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_16KHZ, _ac, _dur, _len)
+
+#define STR_SNK_16_1_2(_chans) \
+	STR_SNK_16_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_16_1, LC3_QOS_16_1_2_RTN, \
+			LC3_QOS_16_1_2_LATENCY)
+
+#define STR_SNK_AC2_16_1_2 \
+	STR_SNK_16_1_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_16_1_2 = {
+	.cc = LC3_CONFIG_16_1_AC(2),
+	.qos = LC3_QOS_16_1_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_16_1_2 \
+	STR_SNK_16_1_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_16_2_2 = {
+	.cc = LC3_CONFIG_16_2_AC(1),
+	.qos = LC3_QOS_16_2_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_16_2(_ac) \
+	STR_SNK_16(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_16_2)
+
+#define STR_SNK_16_2_2(_chans) \
+	STR_SNK_16_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_16_2, LC3_QOS_16_2_2_RTN, \
+			LC3_QOS_16_2_2_LATENCY)
+
+#define STR_SNK_AC2_16_2_2 \
+	STR_SNK_16_2_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_16_2_2 = {
+	.cc = LC3_CONFIG_16_2_AC(2),
+	.qos = LC3_QOS_16_2_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_16_2_2 \
+	STR_SNK_16_2_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_24_1_1 = {
+	.cc = LC3_CONFIG_24_1_AC(1),
+	.qos = LC3_QOS_24_1_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_24(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_24KHZ, _ac, _dur, _len)
+
+#define STR_SNK_24_1(_ac) \
+	STR_SNK_24(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_24_1)
+
+#define STR_SNK_24_1_1(_chans) \
+	STR_SNK_24_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_24_1, LC3_QOS_24_1_1_RTN, \
+			LC3_QOS_24_1_1_LATENCY)
+
+#define STR_SNK_AC2_24_1_1 \
+	STR_SNK_24_1_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_24_1_1 = {
+	.cc = LC3_CONFIG_24_1_AC(2),
+	.qos = LC3_QOS_24_1_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_24_1_1 \
+	STR_SNK_24_1_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_24_2_1 = {
+	.cc = LC3_CONFIG_24_2_AC(1),
+	.qos = LC3_QOS_24_2_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_24_2(_ac) \
+	STR_SNK_24(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_24_2)
+
+#define STR_SNK_24_2_1(_chans) \
+	STR_SNK_24_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_24_2, LC3_QOS_24_2_1_RTN, \
+			LC3_QOS_24_2_1_LATENCY)
+
+#define STR_SNK_AC2_24_2_1 \
+	STR_SNK_24_2_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_24_2_1 = {
+	.cc = LC3_CONFIG_24_2_AC(2),
+	.qos = LC3_QOS_24_2_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_24_2_1 \
+	STR_SNK_24_2_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_24_1_2 = {
+	.cc = LC3_CONFIG_24_1_AC(1),
+	.qos = LC3_QOS_24_1_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_24_1_2(_chans) \
+	STR_SNK_24_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_24_1, LC3_QOS_24_1_2_RTN, \
+			LC3_QOS_24_1_2_LATENCY)
+
+#define STR_SNK_AC2_24_1_2 \
+	STR_SNK_24_1_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_24_1_2 = {
+	.cc = LC3_CONFIG_24_1_AC(2),
+	.qos = LC3_QOS_24_1_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_24_1_2 \
+	STR_SNK_24_1_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_24_2_2 = {
+	.cc = LC3_CONFIG_24_2_AC(1),
+	.qos = LC3_QOS_24_2_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_24_2_2(_chans) \
+	STR_SNK_24_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_24_2, LC3_QOS_24_2_2_RTN, \
+			LC3_QOS_24_2_2_LATENCY)
+
+#define STR_SNK_AC2_24_2_2 \
+	STR_SNK_24_2_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_24_2_2 = {
+	.cc = LC3_CONFIG_24_2_AC(2),
+	.qos = LC3_QOS_24_2_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_24_2_2 \
+	STR_SNK_24_2_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_32_1_1 = {
+	.cc = LC3_CONFIG_32_1_AC(1),
+	.qos = LC3_QOS_32_1_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_32(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_32KHZ, _ac, _dur, _len)
+
+#define STR_SNK_32_1(_ac) \
+	STR_SNK_32(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_32_1)
+
+#define STR_SNK_32_1_1(_chans) \
+	STR_SNK_32_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_32_1, LC3_QOS_32_1_1_RTN, \
+			LC3_QOS_32_1_1_LATENCY)
+
+#define STR_SNK_AC2_32_1_1 \
+	STR_SNK_32_1_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_32_1_1 = {
+	.cc = LC3_CONFIG_32_1_AC(2),
+	.qos = LC3_QOS_32_1_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_32_1_1 \
+	STR_SNK_32_1_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_32_2_1 = {
+	.cc = LC3_CONFIG_32_2_AC(1),
+	.qos = LC3_QOS_32_2_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_32_2(_ac) \
+	STR_SNK_32(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_32_2)
+
+#define STR_SNK_32_2_1(_chans) \
+	STR_SNK_32_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_32_2, LC3_QOS_32_2_1_RTN, \
+			LC3_QOS_32_2_1_LATENCY)
+
+#define STR_SNK_AC2_32_2_1 \
+	STR_SNK_32_2_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_32_2_1 = {
+	.cc = LC3_CONFIG_32_2_AC(2),
+	.qos = LC3_QOS_32_2_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_32_2_1 \
+	STR_SNK_32_2_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_32_1_2 = {
+	.cc = LC3_CONFIG_32_1_AC(1),
+	.qos = LC3_QOS_32_1_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_32_1_2(_chans) \
+	STR_SNK_32_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_32_1, LC3_QOS_32_1_2_RTN, \
+			LC3_QOS_32_1_2_LATENCY)
+
+#define STR_SNK_AC2_32_1_2 \
+	STR_SNK_32_1_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_32_1_2 = {
+	.cc = LC3_CONFIG_32_1_AC(2),
+	.qos = LC3_QOS_32_1_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_32_1_2 \
+	STR_SNK_32_1_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_32_2_2 = {
+	.cc = LC3_CONFIG_32_2_AC(1),
+	.qos = LC3_QOS_32_2_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_32_2_2(_chans) \
+	STR_SNK_32_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_32_2, LC3_QOS_32_2_2_RTN, \
+			LC3_QOS_32_2_2_LATENCY)
+
+#define STR_SNK_AC2_32_2_2 \
+	STR_SNK_32_2_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_32_2_2 = {
+	.cc = LC3_CONFIG_32_2_AC(2),
+	.qos = LC3_QOS_32_2_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_32_2_2 \
+	STR_SNK_32_2_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_44_1_1 = {
+	.cc = LC3_CONFIG_44_1_AC(1),
+	.qos = LC3_QOS_44_1_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_44(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_44KHZ, _ac, _dur, _len)
+
+#define STR_SNK_44_1(_ac) \
+	STR_SNK_44(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_44_1)
+
+#define STR_SNK_QOS_44_1(_sdu, _rtn, _latency) \
+	STR_SNK_QOS(LC3_QOS_44_1_INTERVAL, _sdu, _rtn, _latency)
+
+#define STR_SNK_44_1_1(_chans) \
+	STR_SNK_44_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_44_1(_chans * LC3_CONFIG_FRAME_LEN_44_1, \
+			LC3_QOS_44_1_1_RTN, LC3_QOS_44_1_1_LATENCY)
+
+#define STR_SNK_AC2_44_1_1 \
+	STR_SNK_44_1_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_44_1_1 = {
+	.cc = LC3_CONFIG_44_1_AC(2),
+	.qos = LC3_QOS_44_1_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_44_1_1 \
+	STR_SNK_44_1_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_44_2_1 = {
+	.cc = LC3_CONFIG_44_2_AC(1),
+	.qos = LC3_QOS_44_2_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_44_2(_ac) \
+	STR_SNK_44(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_44_2)
+
+#define STR_SNK_QOS_44_2(_sdu, _rtn, _latency) \
+	STR_SNK_QOS(LC3_QOS_44_2_INTERVAL, _sdu, _rtn, _latency)
+
+#define STR_SNK_44_2_1(_chans) \
+	STR_SNK_44_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_44_2(_chans * LC3_CONFIG_FRAME_LEN_44_2, \
+			LC3_QOS_44_2_1_RTN, LC3_QOS_44_2_1_LATENCY)
+
+#define STR_SNK_AC2_44_2_1 \
+	STR_SNK_44_2_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_44_2_1 = {
+	.cc = LC3_CONFIG_44_2_AC(2),
+	.qos = LC3_QOS_44_2_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_44_2_1 \
+	STR_SNK_44_2_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_44_1_2 = {
+	.cc = LC3_CONFIG_44_1_AC(1),
+	.qos = LC3_QOS_44_1_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_44_1_2(_chans) \
+	STR_SNK_44_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_44_1(_chans * LC3_CONFIG_FRAME_LEN_44_1, \
+			LC3_QOS_44_1_2_RTN, LC3_QOS_44_1_2_LATENCY)
+
+#define STR_SNK_AC2_44_1_2 \
+	STR_SNK_44_1_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_44_1_2 = {
+	.cc = LC3_CONFIG_44_1_AC(2),
+	.qos = LC3_QOS_44_1_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_44_1_2 \
+	STR_SNK_44_1_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_44_2_2 = {
+	.cc = LC3_CONFIG_44_2_AC(1),
+	.qos = LC3_QOS_44_2_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_44_2_2(_chans) \
+	STR_SNK_44_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_44_2(_chans * LC3_CONFIG_FRAME_LEN_44_2, \
+			LC3_QOS_44_2_2_RTN, LC3_QOS_44_2_2_LATENCY)
+
+#define STR_SNK_AC2_44_2_2 \
+	STR_SNK_44_2_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_44_2_2 = {
+	.cc = LC3_CONFIG_44_2_AC(2),
+	.qos = LC3_QOS_44_2_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_44_2_2 \
+	STR_SNK_44_2_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_1_1 = {
+	.cc = LC3_CONFIG_48_1_AC(1),
+	.qos = LC3_QOS_48_1_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48(_ac, _dur, _len) \
+	STR_SNK(LC3_CONFIG_FREQ_48KHZ, _ac, _dur, _len)
+
+#define STR_SNK_48_1(_ac) \
+	STR_SNK_48(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_1)
+
+#define STR_SNK_48_1_1(_chans) \
+	STR_SNK_48_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_1, LC3_QOS_48_1_1_RTN, \
+			LC3_QOS_48_1_1_LATENCY)
+
+#define STR_SNK_AC2_48_1_1 \
+	STR_SNK_48_1_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_1_1 = {
+	.cc = LC3_CONFIG_48_1_AC(2),
+	.qos = LC3_QOS_48_1_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_1_1 \
+	STR_SNK_48_1_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_2_1 = {
+	.cc = LC3_CONFIG_48_2_AC(1),
+	.qos = LC3_QOS_48_2_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_2(_ac) \
+	STR_SNK_48(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_2)
+
+#define STR_SNK_48_2_1(_chans) \
+	STR_SNK_48_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_2, LC3_QOS_48_2_1_RTN, \
+			LC3_QOS_48_2_1_LATENCY)
+
+#define STR_SNK_AC2_48_2_1 \
+	STR_SNK_48_2_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_2_1 = {
+	.cc = LC3_CONFIG_48_2_AC(2),
+	.qos = LC3_QOS_48_2_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_2_1 \
+	STR_SNK_48_2_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_3_1 = {
+	.cc = LC3_CONFIG_48_3_AC(1),
+	.qos = LC3_QOS_48_3_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_3(_ac) \
+	STR_SNK_48(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_3)
+
+#define STR_SNK_48_3_1(_chans) \
+	STR_SNK_48_3((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_3, LC3_QOS_48_3_1_RTN, \
+			LC3_QOS_48_3_1_LATENCY)
+
+#define STR_SNK_AC2_48_3_1 \
+	STR_SNK_48_3_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_3_1 = {
+	.cc = LC3_CONFIG_48_3_AC(2),
+	.qos = LC3_QOS_48_3_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_3_1 \
+	STR_SNK_48_3_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_4_1 = {
+	.cc = LC3_CONFIG_48_4_AC(1),
+	.qos = LC3_QOS_48_4_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_4(_ac) \
+	STR_SNK_48(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_4)
+
+#define STR_SNK_48_4_1(_chans) \
+	STR_SNK_48_4((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_4, LC3_QOS_48_4_1_RTN, \
+			LC3_QOS_48_4_1_LATENCY)
+
+#define STR_SNK_AC2_48_4_1 \
+	STR_SNK_48_4_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_4_1 = {
+	.cc = LC3_CONFIG_48_4_AC(2),
+	.qos = LC3_QOS_48_4_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_4_1 \
+	STR_SNK_48_4_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_5_1 = {
+	.cc = LC3_CONFIG_48_5_AC(1),
+	.qos = LC3_QOS_48_5_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_5(_ac) \
+	STR_SNK_48(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_5)
+
+#define STR_SNK_48_5_1(_chans) \
+	STR_SNK_48_5((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_5, LC3_QOS_48_5_1_RTN, \
+			LC3_QOS_48_5_1_LATENCY)
+
+#define STR_SNK_AC2_48_5_1 \
+	STR_SNK_48_5_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_5_1 = {
+	.cc = LC3_CONFIG_48_5_AC(2),
+	.qos = LC3_QOS_48_5_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_5_1 \
+	STR_SNK_48_5_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_6_1 = {
+	.cc = LC3_CONFIG_48_6_AC(1),
+	.qos = LC3_QOS_48_6_1_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_6(_ac) \
+	STR_SNK_48(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_6)
+
+#define STR_SNK_48_6_1(_chans) \
+	STR_SNK_48_6((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_6, LC3_QOS_48_6_1_RTN, \
+			LC3_QOS_48_6_1_LATENCY)
+
+#define STR_SNK_AC2_48_6_1 \
+	STR_SNK_48_6_1(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_6_1 = {
+	.cc = LC3_CONFIG_48_6_AC(2),
+	.qos = LC3_QOS_48_6_1_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_6_1 \
+	STR_SNK_48_6_1(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_1_2 = {
+	.cc = LC3_CONFIG_48_1_AC(1),
+	.qos = LC3_QOS_48_1_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_1_2(_chans) \
+	STR_SNK_48_1((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_1, LC3_QOS_48_1_2_RTN, \
+			LC3_QOS_48_1_2_LATENCY)
+
+#define STR_SNK_AC2_48_1_2 \
+	STR_SNK_48_1_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_1_2 = {
+	.cc = LC3_CONFIG_48_1_AC(2),
+	.qos = LC3_QOS_48_1_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_1_2 \
+	STR_SNK_48_1_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_2_2 = {
+	.cc = LC3_CONFIG_48_2_AC(1),
+	.qos = LC3_QOS_48_2_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_2_2(_chans) \
+	STR_SNK_48_2((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_2, LC3_QOS_48_2_2_RTN, \
+			LC3_QOS_48_2_2_LATENCY)
+
+#define STR_SNK_AC2_48_2_2 \
+	STR_SNK_48_2_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_2_2 = {
+	.cc = LC3_CONFIG_48_2_AC(2),
+	.qos = LC3_QOS_48_2_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_2_2 \
+	STR_SNK_48_2_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_3_2 = {
+	.cc = LC3_CONFIG_48_3_AC(1),
+	.qos = LC3_QOS_48_3_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_3_2(_chans) \
+	STR_SNK_48_3((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_3, LC3_QOS_48_3_2_RTN, \
+			LC3_QOS_48_3_2_LATENCY)
+
+#define STR_SNK_AC2_48_3_2 \
+	STR_SNK_48_3_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_3_2 = {
+	.cc = LC3_CONFIG_48_3_AC(2),
+	.qos = LC3_QOS_48_3_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_3_2 \
+	STR_SNK_48_3_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_4_2 = {
+	.cc = LC3_CONFIG_48_4_AC(1),
+	.qos = LC3_QOS_48_4_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_4_2(_chans) \
+	STR_SNK_48_4((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_4, LC3_QOS_48_4_2_RTN, \
+			LC3_QOS_48_4_2_LATENCY)
+
+#define STR_SNK_AC2_48_4_2 \
+	STR_SNK_48_4_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_4_2 = {
+	.cc = LC3_CONFIG_48_4_AC(2),
+	.qos = LC3_QOS_48_4_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_4_2 \
+	STR_SNK_48_4_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_5_2 = {
+	.cc = LC3_CONFIG_48_5_AC(1),
+	.qos = LC3_QOS_48_5_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_5_2(_chans) \
+	STR_SNK_48_5((BIT(_chans) - 1)), \
+	STR_SNK_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_5, LC3_QOS_48_5_2_RTN, \
+			LC3_QOS_48_5_2_LATENCY)
+
+#define STR_SNK_AC2_48_5_2 \
+	STR_SNK_48_5_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_5_2 = {
+	.cc = LC3_CONFIG_48_5_AC(2),
+	.qos = LC3_QOS_48_5_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_5_2 \
+	STR_SNK_48_5_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac2_48_6_2 = {
+	.cc = LC3_CONFIG_48_6_AC(1),
+	.qos = LC3_QOS_48_6_2_AC(1),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_48_6_2(_chans) \
+	STR_SNK_48_6((BIT(_chans) - 1)), \
+	STR_SNK_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_6, LC3_QOS_48_6_2_RTN, \
+			LC3_QOS_48_6_2_LATENCY)
+
+#define STR_SNK_AC2_48_6_2 \
+	STR_SNK_48_6_2(1), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_snk_ac10_48_6_2 = {
+	.cc = LC3_CONFIG_48_6_AC(2),
+	.qos = LC3_QOS_48_6_2_AC(2),
+	.snk = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SNK_AC10_48_6_2 \
+	STR_SNK_48_6_2(2), \
+	SNK_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac1_8_1_1 = {
+	.cc = LC3_CONFIG_8_1_AC(1),
+	.qos = LC3_QOS_8_1_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC(_freq, _ac, _dur, _len) \
+	SCC_SRC_LC3(0x10, 0x02, 0x01, _freq, 0x02, 0x02, _dur, 0x03, 0x04, \
+			_len, _len >> 8, 0x05, 0x03, _ac, 0x00, 0x00, 0x00)
+
+#define STR_SRC_8(_ac, _dur, _len) \
+	STR_SRC(LC3_CONFIG_FREQ_8KHZ, _ac, _dur, _len)
+
+#define STR_SRC_8_1(_ac) \
+	STR_SRC_8(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_8_1)
+
+#define STR_SRC_QOS(_interval, _sdu, _rtn, _latency) \
+	QOS_SRC(_interval & 0xff, _interval >> 8 & 0xff, \
+		_interval >> 16 & 0xff, 0x00, 0x02, _sdu & 0xff, \
+		_sdu >> 8 & 0xff, _rtn, \
+		_latency, _latency >> 8, 0x40, 0x9c, 0x00)
+
+#define STR_SRC_QOS_1(_sdu, _rtn, _latency) \
+	STR_SRC_QOS(7500u, _sdu, _rtn, _latency)
+
+#define STR_SRC_8_1_1(_chans) \
+	STR_SRC_8_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_8_1, LC3_QOS_8_1_1_RTN, \
+			LC3_QOS_8_1_1_LATENCY)
+
+#define STR_SRC_AC1_8_1_1 \
+	STR_SRC_8_1_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_8_1_1 = {
+	.cc = LC3_CONFIG_8_1_AC(2),
+	.qos = LC3_QOS_8_1_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_8_1_1 \
+	STR_SRC_8_1_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_8_2_1 = {
+	.cc = LC3_CONFIG_8_2_AC(1),
+	.qos = LC3_QOS_8_2_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_8_2(_ac) \
+	STR_SRC_8(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_8_2)
+
+#define STR_SRC_QOS_2(_sdu, _rtn, _latency) \
+	STR_SRC_QOS(10000u, _sdu, _rtn, _latency)
+
+#define STR_SRC_8_2_1(_chans) \
+	STR_SRC_8_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_8_2, LC3_QOS_8_2_1_RTN, \
+			LC3_QOS_8_2_1_LATENCY)
+
+#define STR_SRC_AC1_8_2_1 \
+	STR_SRC_8_2_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_8_2_1 = {
+	.cc = LC3_CONFIG_8_2_AC(2),
+	.qos = LC3_QOS_8_2_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_8_2_1 \
+	STR_SRC_8_2_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_16_1_1 = {
+	.cc = LC3_CONFIG_16_1_AC(1),
+	.qos = LC3_QOS_16_1_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_16(_ac, _dur, _len) \
+	STR_SRC(LC3_CONFIG_FREQ_16KHZ, _ac, _dur, _len)
+
+#define STR_SRC_16_1(_ac) \
+	STR_SRC_16(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_16_1)
+
+#define STR_SRC_16_1_1(_chans) \
+	STR_SRC_16_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_16_1, LC3_QOS_16_1_1_RTN, \
+			LC3_QOS_16_1_1_LATENCY)
+
+#define STR_SRC_AC1_16_1_1 \
+	STR_SRC_16_1_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_16_1_1 = {
+	.cc = LC3_CONFIG_16_1_AC(2),
+	.qos = LC3_QOS_16_1_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_16_1_1 \
+	STR_SRC_16_1_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_16_2_1 = {
+	.cc = LC3_CONFIG_16_2_AC(1),
+	.qos = LC3_QOS_16_2_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_16_2(_ac) \
+	STR_SRC_16(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_16_2)
+
+#define STR_SRC_16_2_1(_chans) \
+	STR_SRC_16_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_16_2, LC3_QOS_16_2_1_RTN, \
+			LC3_QOS_16_2_1_LATENCY)
+
+#define STR_SRC_AC1_16_2_1 \
+	STR_SRC_16_2_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_16_2_1 = {
+	.cc = LC3_CONFIG_16_2_AC(2),
+	.qos = LC3_QOS_16_2_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_16_2_1 \
+	STR_SRC_16_2_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_24_1_1 = {
+	.cc = LC3_CONFIG_24_1_AC(1),
+	.qos = LC3_QOS_24_1_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_24(_ac, _dur, _len) \
+	STR_SRC(LC3_CONFIG_FREQ_24KHZ, _ac, _dur, _len)
+
+#define STR_SRC_24_1(_ac) \
+	STR_SRC_24(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_24_1)
+
+#define STR_SRC_24_1_1(_chans) \
+	STR_SRC_24_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_24_1, LC3_QOS_24_1_1_RTN, \
+			LC3_QOS_24_1_1_LATENCY)
+
+#define STR_SRC_AC1_24_1_1 \
+	STR_SRC_24_1_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_24_1_1 = {
+	.cc = LC3_CONFIG_24_1_AC(2),
+	.qos = LC3_QOS_24_1_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_24_1_1 \
+	STR_SRC_24_1_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_24_2_1 = {
+	.cc = LC3_CONFIG_24_2_AC(1),
+	.qos = LC3_QOS_24_2_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_24_2(_ac) \
+	STR_SRC_24(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_24_2)
+
+#define STR_SRC_24_2_1(_chans) \
+	STR_SRC_24_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_24_2, LC3_QOS_24_2_1_RTN, \
+			LC3_QOS_24_2_1_LATENCY)
+
+#define STR_SRC_AC1_24_2_1 \
+	STR_SRC_24_2_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_24_2_1 = {
+	.cc = LC3_CONFIG_24_2_AC(2),
+	.qos = LC3_QOS_24_2_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_24_2_1 \
+	STR_SRC_24_2_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_32_1_1 = {
+	.cc = LC3_CONFIG_32_1_AC(1),
+	.qos = LC3_QOS_32_1_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_32(_ac, _dur, _len) \
+	STR_SRC(LC3_CONFIG_FREQ_32KHZ, _ac, _dur, _len)
+
+#define STR_SRC_32_1(_ac) \
+	STR_SRC_32(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_32_1)
+
+#define STR_SRC_32_1_1(_chans) \
+	STR_SRC_32_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_32_1, LC3_QOS_32_1_1_RTN, \
+			LC3_QOS_32_1_1_LATENCY)
+
+#define STR_SRC_AC1_32_1_1 \
+	STR_SRC_32_1_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_32_1_1 = {
+	.cc = LC3_CONFIG_32_1_AC(2),
+	.qos = LC3_QOS_32_1_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_32_1_1 \
+	STR_SRC_32_1_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_32_2_1 = {
+	.cc = LC3_CONFIG_32_2_AC(1),
+	.qos = LC3_QOS_32_2_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_32_2(_ac) \
+	STR_SRC_32(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_32_2)
+
+#define STR_SRC_32_2_1(_chans) \
+	STR_SRC_32_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_32_2, LC3_QOS_32_2_1_RTN, \
+			LC3_QOS_32_2_1_LATENCY)
+
+#define STR_SRC_AC1_32_2_1 \
+	STR_SRC_32_2_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_32_2_1 = {
+	.cc = LC3_CONFIG_32_2_AC(2),
+	.qos = LC3_QOS_32_2_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_32_2_1 \
+	STR_SRC_32_2_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_44_1_1 = {
+	.cc = LC3_CONFIG_44_1_AC(1),
+	.qos = LC3_QOS_44_1_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_44(_ac, _dur, _len) \
+	STR_SRC(LC3_CONFIG_FREQ_44KHZ, _ac, _dur, _len)
+
+#define STR_SRC_44_1(_ac) \
+	STR_SRC_44(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_44_1)
+
+#define STR_SRC_QOS_44_1(_sdu, _rtn, _latency) \
+	STR_SRC_QOS(LC3_QOS_44_1_INTERVAL, _sdu, _rtn, _latency)
+
+#define STR_SRC_44_1_1(_chans) \
+	STR_SRC_44_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_44_1(_chans * LC3_CONFIG_FRAME_LEN_44_1, \
+			LC3_QOS_44_1_1_RTN, LC3_QOS_44_1_1_LATENCY)
+
+#define STR_SRC_AC1_44_1_1 \
+	STR_SRC_44_1_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_44_1_1 = {
+	.cc = LC3_CONFIG_44_1_AC(2),
+	.qos = LC3_QOS_44_1_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_44_1_1 \
+	STR_SRC_44_1_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_44_2_1 = {
+	.cc = LC3_CONFIG_44_2_AC(1),
+	.qos = LC3_QOS_44_2_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_44_2(_ac) \
+	STR_SRC_44(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_44_2)
+
+#define STR_SRC_QOS_44_2(_sdu, _rtn, _latency) \
+	STR_SRC_QOS(LC3_QOS_44_2_INTERVAL, _sdu, _rtn, _latency)
+
+#define STR_SRC_44_2_1(_chans) \
+	STR_SRC_44_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_44_2(_chans * LC3_CONFIG_FRAME_LEN_44_2, \
+			LC3_QOS_44_2_1_RTN, LC3_QOS_44_2_1_LATENCY)
+
+#define STR_SRC_AC1_44_2_1 \
+	STR_SRC_44_2_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_44_2_1 = {
+	.cc = LC3_CONFIG_44_2_AC(2),
+	.qos = LC3_QOS_44_2_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_44_2_1 \
+	STR_SRC_44_2_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_1_1 = {
+	.cc = LC3_CONFIG_48_1_AC(1),
+	.qos = LC3_QOS_48_1_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48(_ac, _dur, _len) \
+	STR_SRC(LC3_CONFIG_FREQ_48KHZ, _ac, _dur, _len)
+
+#define STR_SRC_48_1(_ac) \
+	STR_SRC_48(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_1)
+
+#define STR_SRC_48_1_1(_chans) \
+	STR_SRC_48_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_1, LC3_QOS_48_1_1_RTN, \
+			LC3_QOS_48_1_1_LATENCY)
+
+#define STR_SRC_AC1_48_1_1 \
+	STR_SRC_48_1_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_1_1 = {
+	.cc = LC3_CONFIG_48_1_AC(2),
+	.qos = LC3_QOS_48_1_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_1_1 \
+	STR_SRC_48_1_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_2_1 = {
+	.cc = LC3_CONFIG_48_2_AC(1),
+	.qos = LC3_QOS_48_2_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_2(_ac) \
+	STR_SRC_48(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_2)
+
+#define STR_SRC_48_2_1(_chans) \
+	STR_SRC_48_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_2, LC3_QOS_48_2_1_RTN, \
+			LC3_QOS_48_2_1_LATENCY)
+
+#define STR_SRC_AC1_48_2_1 \
+	STR_SRC_48_2_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_2_1 = {
+	.cc = LC3_CONFIG_48_2_AC(2),
+	.qos = LC3_QOS_48_2_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_2_1 \
+	STR_SRC_48_2_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_3_1 = {
+	.cc = LC3_CONFIG_48_3_AC(1),
+	.qos = LC3_QOS_48_3_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_3(_ac) \
+	STR_SRC_48(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_3)
+
+#define STR_SRC_48_3_1(_chans) \
+	STR_SRC_48_3((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_3, LC3_QOS_48_3_1_RTN, \
+			LC3_QOS_48_3_1_LATENCY)
+
+#define STR_SRC_AC1_48_3_1 \
+	STR_SRC_48_3_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_3_1 = {
+	.cc = LC3_CONFIG_48_3_AC(2),
+	.qos = LC3_QOS_48_3_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_3_1 \
+	STR_SRC_48_3_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_4_1 = {
+	.cc = LC3_CONFIG_48_4_AC(1),
+	.qos = LC3_QOS_48_4_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_4(_ac) \
+	STR_SRC_48(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_4)
+
+#define STR_SRC_48_4_1(_chans) \
+	STR_SRC_48_4((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_4, LC3_QOS_48_4_1_RTN, \
+			LC3_QOS_48_4_1_LATENCY)
+
+#define STR_SRC_AC1_48_4_1 \
+	STR_SRC_48_4_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_4_1 = {
+	.cc = LC3_CONFIG_48_4_AC(2),
+	.qos = LC3_QOS_48_4_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_4_1 \
+	STR_SRC_48_4_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_5_1 = {
+	.cc = LC3_CONFIG_48_5_AC(1),
+	.qos = LC3_QOS_48_5_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_5(_ac) \
+	STR_SRC_48(_ac, LC3_CONFIG_DURATION_7_5, LC3_CONFIG_FRAME_LEN_48_5)
+
+#define STR_SRC_48_5_1(_chans) \
+	STR_SRC_48_5((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_5, LC3_QOS_48_5_1_RTN, \
+			LC3_QOS_48_5_1_LATENCY)
+
+#define STR_SRC_AC1_48_5_1 \
+	STR_SRC_48_5_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_5_1 = {
+	.cc = LC3_CONFIG_48_5_AC(2),
+	.qos = LC3_QOS_48_5_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_5_1 \
+	STR_SRC_48_5_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_6_1 = {
+	.cc = LC3_CONFIG_48_6_AC(1),
+	.qos = LC3_QOS_48_6_1_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_6(_ac) \
+	STR_SRC_48(_ac, LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_48_6)
+
+#define STR_SRC_48_6_1(_chans) \
+	STR_SRC_48_6((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_6, LC3_QOS_48_6_1_RTN, \
+			LC3_QOS_48_6_1_LATENCY)
+
+#define STR_SRC_AC1_48_6_1 \
+	STR_SRC_48_6_1(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_6_1 = {
+	.cc = LC3_CONFIG_48_6_AC(2),
+	.qos = LC3_QOS_48_6_1_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_6_1 \
+	STR_SRC_48_6_1(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_8_1_2 = {
+	.cc = LC3_CONFIG_8_1_AC(1),
+	.qos = LC3_QOS_8_1_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_8_1_2(_chans) \
+	STR_SRC_8_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_8_1, LC3_QOS_8_1_2_RTN, \
+			LC3_QOS_8_1_2_LATENCY)
+
+#define STR_SRC_AC1_8_1_2 \
+	STR_SRC_8_1_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_8_1_2 = {
+	.cc = LC3_CONFIG_8_1_AC(2),
+	.qos = LC3_QOS_8_1_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_8_1_2 \
+	STR_SRC_8_1_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_8_2_2 = {
+	.cc = LC3_CONFIG_8_2_AC(1),
+	.qos = LC3_QOS_8_2_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_8_2_2(_chans) \
+	STR_SRC_8_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_8_2, LC3_QOS_8_2_2_RTN, \
+			LC3_QOS_8_2_2_LATENCY)
+
+#define STR_SRC_AC1_8_2_2 \
+	STR_SRC_8_2_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_8_2_2 = {
+	.cc = LC3_CONFIG_8_2_AC(2),
+	.qos = LC3_QOS_8_2_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_8_2_2 \
+	STR_SRC_8_2_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_16_1_2 = {
+	.cc = LC3_CONFIG_16_1_AC(1),
+	.qos = LC3_QOS_16_1_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_16_1_2(_chans) \
+	STR_SRC_16_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_16_1, LC3_QOS_16_1_2_RTN, \
+			LC3_QOS_16_1_2_LATENCY)
+
+#define STR_SRC_AC1_16_1_2 \
+	STR_SRC_16_1_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_16_1_2 = {
+	.cc = LC3_CONFIG_16_1_AC(2),
+	.qos = LC3_QOS_16_1_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_16_1_2 \
+	STR_SRC_16_1_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_16_2_2 = {
+	.cc = LC3_CONFIG_16_2_AC(1),
+	.qos = LC3_QOS_16_2_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_16_2_2(_chans) \
+	STR_SRC_16_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_16_2, LC3_QOS_16_2_2_RTN, \
+			LC3_QOS_16_2_2_LATENCY)
+
+#define STR_SRC_AC1_16_2_2 \
+	STR_SRC_16_2_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_16_2_2 = {
+	.cc = LC3_CONFIG_16_2_AC(2),
+	.qos = LC3_QOS_16_2_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_16_2_2 \
+	STR_SRC_16_2_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_24_1_2 = {
+	.cc = LC3_CONFIG_24_1_AC(1),
+	.qos = LC3_QOS_24_1_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_24_1_2(_chans) \
+	STR_SRC_24_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_24_1, LC3_QOS_24_1_2_RTN, \
+			LC3_QOS_24_1_2_LATENCY)
+
+#define STR_SRC_AC1_24_1_2 \
+	STR_SRC_24_1_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_24_1_2 = {
+	.cc = LC3_CONFIG_24_1_AC(2),
+	.qos = LC3_QOS_24_1_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_24_1_2 \
+	STR_SRC_24_1_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_24_2_2 = {
+	.cc = LC3_CONFIG_24_2_AC(1),
+	.qos = LC3_QOS_24_2_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_24_2_2(_chans) \
+	STR_SRC_24_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_24_2, LC3_QOS_24_2_2_RTN, \
+			LC3_QOS_24_2_2_LATENCY)
+
+#define STR_SRC_AC1_24_2_2 \
+	STR_SRC_24_2_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_24_2_2 = {
+	.cc = LC3_CONFIG_24_2_AC(2),
+	.qos = LC3_QOS_24_2_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_24_2_2 \
+	STR_SRC_24_2_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_32_1_2 = {
+	.cc = LC3_CONFIG_32_1_AC(1),
+	.qos = LC3_QOS_32_1_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_32_1_2(_chans) \
+	STR_SRC_32_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_32_1, LC3_QOS_32_1_2_RTN, \
+			LC3_QOS_32_1_2_LATENCY)
+
+#define STR_SRC_AC1_32_1_2 \
+	STR_SRC_32_1_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_32_1_2 = {
+	.cc = LC3_CONFIG_32_1_AC(2),
+	.qos = LC3_QOS_32_1_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_32_1_2 \
+	STR_SRC_32_1_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_32_2_2 = {
+	.cc = LC3_CONFIG_32_2_AC(1),
+	.qos = LC3_QOS_32_2_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_32_2_2(_chans) \
+	STR_SRC_32_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_32_2, LC3_QOS_32_2_2_RTN, \
+			LC3_QOS_32_2_2_LATENCY)
+
+#define STR_SRC_AC1_32_2_2 \
+	STR_SRC_32_2_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_32_2_2 = {
+	.cc = LC3_CONFIG_32_2_AC(2),
+	.qos = LC3_QOS_32_2_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_32_2_2 \
+	STR_SRC_32_2_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_44_1_2 = {
+	.cc = LC3_CONFIG_44_1_AC(1),
+	.qos = LC3_QOS_44_1_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+
+#define STR_SRC_44_1_2(_chans) \
+	STR_SRC_44_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_44_1(_chans * LC3_CONFIG_FRAME_LEN_44_1, \
+			 LC3_QOS_44_1_2_RTN, LC3_QOS_44_1_2_LATENCY)
+
+#define STR_SRC_AC1_44_1_2 \
+	STR_SRC_44_1_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_44_1_2 = {
+	.cc = LC3_CONFIG_44_1_AC(2),
+	.qos = LC3_QOS_44_1_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_44_1_2 \
+	STR_SRC_44_1_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_44_2_2 = {
+	.cc = LC3_CONFIG_44_2_AC(1),
+	.qos = LC3_QOS_44_2_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_44_2_2(_chans) \
+	STR_SRC_44_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_44_2(_chans * LC3_CONFIG_FRAME_LEN_44_2, \
+			LC3_QOS_44_2_2_RTN, LC3_QOS_44_2_2_LATENCY)
+
+#define STR_SRC_AC1_44_2_2 \
+	STR_SRC_44_2_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_44_2_2 = {
+	.cc = LC3_CONFIG_44_2_AC(2),
+	.qos = LC3_QOS_44_2_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_44_2_2 \
+	STR_SRC_44_2_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_1_2 = {
+	.cc = LC3_CONFIG_48_1_AC(1),
+	.qos = LC3_QOS_48_1_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+
+#define STR_SRC_48_1_2(_chans) \
+	STR_SRC_48_1((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_1, LC3_QOS_48_1_2_RTN, \
+			LC3_QOS_48_1_2_LATENCY)
+
+#define STR_SRC_AC1_48_1_2 \
+	STR_SRC_48_1_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_1_2 = {
+	.cc = LC3_CONFIG_48_1_AC(2),
+	.qos = LC3_QOS_48_1_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_1_2 \
+	STR_SRC_48_1_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_2_2 = {
+	.cc = LC3_CONFIG_48_2_AC(1),
+	.qos = LC3_QOS_48_2_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_2_2(_chans) \
+	STR_SRC_48_2((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_2, LC3_QOS_48_2_2_RTN, \
+			LC3_QOS_48_2_2_LATENCY)
+
+#define STR_SRC_AC1_48_2_2 \
+	STR_SRC_48_2_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_48_2_2 = {
+	.cc = LC3_CONFIG_48_2_AC(2),
+	.qos = LC3_QOS_48_2_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_2_2 \
+	STR_SRC_48_2_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_3_2 = {
+	.cc = LC3_CONFIG_48_3_AC(1),
+	.qos = LC3_QOS_48_3_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+
+#define STR_SRC_48_3_2(_chans) \
+	STR_SRC_48_3((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_3, LC3_QOS_48_3_2_RTN, \
+			LC3_QOS_48_3_2_LATENCY)
+
+#define STR_SRC_AC1_48_3_2 \
+	STR_SRC_48_3_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_3_2 = {
+	.cc = LC3_CONFIG_48_3_AC(2),
+	.qos = LC3_QOS_48_3_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_3_2 \
+	STR_SRC_48_3_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_4_2 = {
+	.cc = LC3_CONFIG_48_4_AC(1),
+	.qos = LC3_QOS_48_4_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_4_2(_chans) \
+	STR_SRC_48_4((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_4, LC3_QOS_48_4_2_RTN, \
+			LC3_QOS_48_4_2_LATENCY)
+
+#define STR_SRC_AC1_48_4_2 \
+	STR_SRC_48_4_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_48_4_2 = {
+	.cc = LC3_CONFIG_48_4_AC(2),
+	.qos = LC3_QOS_48_4_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_4_2 \
+	STR_SRC_48_4_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_5_2 = {
+	.cc = LC3_CONFIG_48_5_AC(1),
+	.qos = LC3_QOS_48_5_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+
+#define STR_SRC_48_5_2(_chans) \
+	STR_SRC_48_5((BIT(_chans) - 1)), \
+	STR_SRC_QOS_1(_chans * LC3_CONFIG_FRAME_LEN_48_5, LC3_QOS_48_5_2_RTN, \
+			LC3_QOS_48_5_2_LATENCY)
+
+#define STR_SRC_AC1_48_5_2 \
+	STR_SRC_48_5_2(1), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac4_48_5_2 = {
+	.cc = LC3_CONFIG_48_5_AC(2),
+	.qos = LC3_QOS_48_5_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_5_2 \
+	STR_SRC_48_5_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+static struct test_config str_src_ac1_48_6_2 = {
+	.cc = LC3_CONFIG_48_6_AC(1),
+	.qos = LC3_QOS_48_6_2_AC(1),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_48_6_2(_chans) \
+	STR_SRC_48_6((BIT(_chans) - 1)), \
+	STR_SRC_QOS_2(_chans * LC3_CONFIG_FRAME_LEN_48_6, LC3_QOS_48_6_2_RTN, \
+			LC3_QOS_48_6_2_LATENCY)
+
+#define STR_SRC_AC1_48_6_2 \
+	STR_SRC_48_6_2(1), \
+	SRC_ENABLE, \
+	SNK_START
+
+static struct test_config str_src_ac4_48_6_2 = {
+	.cc = LC3_CONFIG_48_6_AC(2),
+	.qos = LC3_QOS_48_6_2_AC(2),
+	.src = true,
+	.state = BT_BAP_STREAM_STATE_STREAMING,
+};
+
+#define STR_SRC_AC4_48_6_2 \
+	STR_SRC_48_6_2(2), \
+	SRC_ENABLE, \
+	SRC_START
+
+/* Unicast Client Streaming – 1 Unicast Server, 1 Stream, 1 CIS – LC3
+ *
+ * Test Purpose:
+ * Verify that a Unicast Client IUT can stream audio data over one unicast
+ * Audio Stream to or from a Unicast Server.
+ *
+ * Pass verdict:
+ * If the IUT is in the Audio Sink role, the IUT receives SDUs with a zero or
+ * more length that contains LC3-encoded data formatted using the LC3 Media
+ * Packet format (defined in [3] Section 4.2).
+ */
+static void test_str_1_1_1_lc3(void)
+{
+	define_test("BAP/UCL/STR/BV-001-C [UCL, AC 2, LC3 8_1_1]",
+			test_client, &str_snk_ac2_8_1_1,
+			STR_SNK_AC2_8_1_1);
+	define_test("BAP/UCL/STR/BV-002-C [UCL, AC 10, LC3 8_1_1]",
+			test_client, &str_snk_ac10_8_1_1,
+			STR_SNK_AC10_8_1_1);
+	define_test("BAP/UCL/STR/BV-003-C [UCL, AC 2, LC3 8_2_1]",
+			test_client, &str_snk_ac2_8_2_1,
+			STR_SNK_AC2_8_2_1);
+	define_test("BAP/UCL/STR/BV-004-C [UCL, AC 10, LC3 8_2_1]",
+			test_client, &str_snk_ac10_8_2_1,
+			STR_SNK_AC10_8_2_1);
+	define_test("BAP/UCL/STR/BV-005-C [UCL, AC 2, LC3 16_1_1]",
+			test_client, &str_snk_ac2_16_1_1,
+			STR_SNK_AC2_16_1_1);
+	define_test("BAP/UCL/STR/BV-006-C [UCL, AC 10, LC3 16_1_1]",
+			test_client, &str_snk_ac10_16_1_1,
+			STR_SNK_AC10_16_1_1);
+	define_test("BAP/UCL/STR/BV-007-C [UCL, AC 2, LC3 16_2_1]",
+			test_client, &str_snk_ac2_16_2_1,
+			STR_SNK_AC2_16_2_1);
+	define_test("BAP/UCL/STR/BV-008-C [UCL, AC 10, LC3 16_2_1]",
+			test_client, &str_snk_ac10_16_2_1,
+			STR_SNK_AC10_16_2_1);
+	define_test("BAP/UCL/STR/BV-009-C [UCL, AC 2, LC3 24_1_1]",
+			test_client, &str_snk_ac2_24_1_1,
+			STR_SNK_AC2_24_1_1);
+	define_test("BAP/UCL/STR/BV-010-C [UCL, AC 10, LC3 24_1_1]",
+			test_client, &str_snk_ac10_24_1_1,
+			STR_SNK_AC10_24_1_1);
+	define_test("BAP/UCL/STR/BV-011-C [UCL, AC 2, LC3 24_2_1]",
+			test_client, &str_snk_ac2_24_2_1,
+			STR_SNK_AC2_24_2_1);
+	define_test("BAP/UCL/STR/BV-012-C [UCL, AC 10, LC3 24_2_1]",
+			test_client, &str_snk_ac10_24_2_1,
+			STR_SNK_AC10_24_2_1);
+	define_test("BAP/UCL/STR/BV-013-C [UCL, AC 2, LC3 32_1_1]",
+			test_client, &str_snk_ac2_32_1_1,
+			STR_SNK_AC2_32_1_1);
+	define_test("BAP/UCL/STR/BV-014-C [UCL, AC 10, LC3 32_1_1]",
+			test_client, &str_snk_ac10_32_1_1,
+			STR_SNK_AC10_32_1_1);
+	define_test("BAP/UCL/STR/BV-015-C [UCL, AC 2, LC3 32_2_1]",
+			test_client, &str_snk_ac2_32_2_1,
+			STR_SNK_AC2_32_2_1);
+	define_test("BAP/UCL/STR/BV-016-C [UCL, AC 10, LC3 32_2_1]",
+			test_client, &str_snk_ac10_32_2_1,
+			STR_SNK_AC10_32_2_1);
+	define_test("BAP/UCL/STR/BV-017-C [UCL, AC 2, LC3 441_1_1]",
+			test_client, &str_snk_ac2_44_1_1,
+			STR_SNK_AC2_44_1_1);
+	define_test("BAP/UCL/STR/BV-018-C [UCL, AC 10, LC3 441_1_1]",
+			test_client, &str_snk_ac10_44_1_1,
+			STR_SNK_AC10_44_1_1);
+	define_test("BAP/UCL/STR/BV-019-C [UCL, AC 2, LC3 44_2_1]",
+			test_client, &str_snk_ac2_44_2_1,
+			STR_SNK_AC2_44_2_1);
+	define_test("BAP/UCL/STR/BV-020-C [UCL, AC 10, LC3 44_2_1]",
+			test_client, &str_snk_ac10_44_2_1,
+			STR_SNK_AC10_44_2_1);
+	define_test("BAP/UCL/STR/BV-021-C [UCL, AC 2, LC3 48_1_1]",
+			test_client, &str_snk_ac2_48_1_1,
+			STR_SNK_AC2_48_1_1);
+	define_test("BAP/UCL/STR/BV-022-C [UCL, AC 10, LC3 48_1_1]",
+			test_client, &str_snk_ac10_48_1_1,
+			STR_SNK_AC10_48_1_1);
+	define_test("BAP/UCL/STR/BV-023-C [UCL, AC 2, LC3 48_2_1]",
+			test_client, &str_snk_ac2_48_2_1,
+			STR_SNK_AC2_48_2_1);
+	define_test("BAP/UCL/STR/BV-024-C [UCL, AC 10, LC3 48_2_1]",
+			test_client, &str_snk_ac10_48_2_1,
+			STR_SNK_AC10_48_2_1);
+	define_test("BAP/UCL/STR/BV-025-C [UCL, AC 2, LC3 48_3_1]",
+			test_client, &str_snk_ac2_48_3_1,
+			STR_SNK_AC2_48_3_1);
+	define_test("BAP/UCL/STR/BV-026-C [UCL, AC 10, LC3 48_3_1]",
+			test_client, &str_snk_ac10_48_3_1,
+			STR_SNK_AC10_48_3_1);
+	define_test("BAP/UCL/STR/BV-027-C [UCL, AC 2, LC3 48_4_1]",
+			test_client, &str_snk_ac2_48_4_1,
+			STR_SNK_AC2_48_4_1);
+	define_test("BAP/UCL/STR/BV-028-C [UCL, AC 10, LC3 48_4_1]",
+			test_client, &str_snk_ac10_48_4_1,
+			STR_SNK_AC10_48_4_1);
+	define_test("BAP/UCL/STR/BV-029-C [UCL, AC 2, LC3 48_5_1]",
+			test_client, &str_snk_ac2_48_5_1,
+			STR_SNK_AC2_48_5_1);
+	define_test("BAP/UCL/STR/BV-030-C [UCL, AC 10, LC3 48_5_1]",
+			test_client, &str_snk_ac10_48_5_1,
+			STR_SNK_AC10_48_5_1);
+	define_test("BAP/UCL/STR/BV-031-C [UCL, AC 2, LC3 48_6_1]",
+			test_client, &str_snk_ac2_48_6_1,
+			STR_SNK_AC2_48_6_1);
+	define_test("BAP/UCL/STR/BV-032-C [UCL, AC 10, LC3 48_6_1]",
+			test_client, &str_snk_ac10_48_6_1,
+			STR_SNK_AC10_48_6_1);
+	define_test("BAP/UCL/STR/BV-033-C [UCL, SRC, AC 1, LC3 8_1_1]",
+			test_client, &str_src_ac1_8_1_1,
+			STR_SRC_AC1_8_1_1);
+	define_test("BAP/UCL/STR/BV-034-C [UCL, SRC, AC 4, LC3 8_1_1]",
+			test_client, &str_src_ac4_8_1_1,
+			STR_SRC_AC4_8_1_1);
+	define_test("BAP/UCL/STR/BV-035-C [UCL, SRC, AC 1, LC3 8_2_1]",
+			test_client, &str_src_ac1_8_2_1,
+			STR_SRC_AC1_8_2_1);
+	define_test("BAP/UCL/STR/BV-036-C [UCL, SRC, AC 4, LC3 8_2_1]",
+			test_client, &str_src_ac4_8_2_1,
+			STR_SRC_AC4_8_2_1);
+	define_test("BAP/UCL/STR/BV-037-C [UCL, SRC, AC 1, LC3 16_1_1]",
+			test_client, &str_src_ac1_16_1_1,
+			STR_SRC_AC1_16_1_1);
+	define_test("BAP/UCL/STR/BV-038-C [UCL, SRC, AC 4, LC3 16_1_1]",
+			test_client, &str_src_ac4_16_1_1,
+			STR_SRC_AC4_16_1_1);
+	define_test("BAP/UCL/STR/BV-039-C [UCL, SRC, AC 1, LC3 16_2_1]",
+			test_client, &str_src_ac1_16_2_1,
+			STR_SRC_AC1_16_2_1);
+	define_test("BAP/UCL/STR/BV-040-C [UCL, SRC, AC 4, LC3 16_2_1]",
+			test_client, &str_src_ac4_16_2_1,
+			STR_SRC_AC4_16_2_1);
+	define_test("BAP/UCL/STR/BV-041-C [UCL, SRC, AC 1, LC3 24_1_1]",
+			test_client, &str_src_ac1_24_1_1,
+			STR_SRC_AC1_24_1_1);
+	define_test("BAP/UCL/STR/BV-042-C [UCL, SRC, AC 4, LC3 24_1_1]",
+			test_client, &str_src_ac4_24_1_1,
+			STR_SRC_AC4_24_1_1);
+	define_test("BAP/UCL/STR/BV-043-C [UCL, SRC, AC 1, LC3 24_2_1]",
+			test_client, &str_src_ac1_24_2_1,
+			STR_SRC_AC1_24_2_1);
+	define_test("BAP/UCL/STR/BV-044-C [UCL, SRC, AC 4, LC3 24_2_1]",
+			test_client, &str_src_ac4_24_2_1,
+			STR_SRC_AC4_24_2_1);
+	define_test("BAP/UCL/STR/BV-045-C [UCL, SRC, AC 1, LC3 32_1_1]",
+			test_client, &str_src_ac1_32_1_1,
+			STR_SRC_AC1_32_1_1);
+	define_test("BAP/UCL/STR/BV-046-C [UCL, SRC, AC 4, LC3 32_1_1]",
+			test_client, &str_src_ac4_32_1_1,
+			STR_SRC_AC4_32_1_1);
+	define_test("BAP/UCL/STR/BV-047-C [UCL, SRC, AC 1, LC3 32_2_1]",
+			test_client, &str_src_ac1_32_2_1,
+			STR_SRC_AC1_32_2_1);
+	define_test("BAP/UCL/STR/BV-048-C [UCL, SRC, AC 4, LC3 32_2_1]",
+			test_client, &str_src_ac4_32_2_1,
+			STR_SRC_AC4_32_2_1);
+	define_test("BAP/UCL/STR/BV-049-C [UCL, SRC, AC 1, LC3 44_1_1]",
+			test_client, &str_src_ac1_44_1_1,
+			STR_SRC_AC1_44_1_1);
+	define_test("BAP/UCL/STR/BV-050-C [UCL, SRC, AC 4, LC3 44_1_1]",
+			test_client, &str_src_ac4_44_1_1,
+			STR_SRC_AC4_44_1_1);
+	define_test("BAP/UCL/STR/BV-051-C [UCL, SRC, AC 1, LC3 44_2_1]",
+			test_client, &str_src_ac1_44_2_1,
+			STR_SRC_AC1_44_2_1);
+	define_test("BAP/UCL/STR/BV-052-C [UCL, SRC, AC 4, LC3 44_2_1]",
+			test_client, &str_src_ac4_44_2_1,
+			STR_SRC_AC4_44_2_1);
+	define_test("BAP/UCL/STR/BV-053-C [UCL, SRC, AC 1, LC3 48_1_1]",
+			test_client, &str_src_ac1_48_1_1,
+			STR_SRC_AC1_48_1_1);
+	define_test("BAP/UCL/STR/BV-054-C [UCL, SRC, AC 4, LC3 48_1_1]",
+			test_client, &str_src_ac4_48_1_1,
+			STR_SRC_AC4_48_1_1);
+	define_test("BAP/UCL/STR/BV-055-C [UCL, SRC, AC 1, LC3 48_2_1]",
+			test_client, &str_src_ac1_48_2_1,
+			STR_SRC_AC1_48_2_1);
+	define_test("BAP/UCL/STR/BV-056-C [UCL, SRC, AC 4, LC3 48_2_1]",
+			test_client, &str_src_ac4_48_2_1,
+			STR_SRC_AC4_48_2_1);
+	define_test("BAP/UCL/STR/BV-057-C [UCL, SRC, AC 1, LC3 48_3_1]",
+			test_client, &str_src_ac1_48_3_1,
+			STR_SRC_AC1_48_3_1);
+	define_test("BAP/UCL/STR/BV-058-C [UCL, SRC, AC 4, LC3 48_3_1]",
+			test_client, &str_src_ac4_48_3_1,
+			STR_SRC_AC4_48_3_1);
+	define_test("BAP/UCL/STR/BV-059-C [UCL, SRC, AC 1, LC3 48_4_1]",
+			test_client, &str_src_ac1_48_4_1,
+			STR_SRC_AC1_48_4_1);
+	define_test("BAP/UCL/STR/BV-060-C [UCL, SRC, AC 4, LC3 48_4_1]",
+			test_client, &str_src_ac4_48_4_1,
+			STR_SRC_AC4_48_4_1);
+	define_test("BAP/UCL/STR/BV-061-C [UCL, SRC, AC 1, LC3 48_5_1]",
+			test_client, &str_src_ac1_48_5_1,
+			STR_SRC_AC1_48_5_1);
+	define_test("BAP/UCL/STR/BV-062-C [UCL, SRC, AC 4, LC3 48_5_1]",
+			test_client, &str_src_ac4_48_5_1,
+			STR_SRC_AC4_48_5_1);
+	define_test("BAP/UCL/STR/BV-063-C [UCL, SRC, AC 1, LC3 48_6_1]",
+			test_client, &str_src_ac1_48_6_1,
+			STR_SRC_AC1_48_6_1);
+	define_test("BAP/UCL/STR/BV-064-C [UCL, SRC, AC 4, LC3 48_6_1]",
+			test_client, &str_src_ac4_48_6_1,
+			STR_SRC_AC4_48_6_1);
+	define_test("BAP/UCL/STR/BV-065-C [UCL, AC 2, LC3 8_1_2]",
+			test_client, &str_snk_ac2_8_1_2,
+			STR_SNK_AC2_8_1_2);
+	define_test("BAP/UCL/STR/BV-066-C [UCL, AC 10, LC3 8_1_2]",
+			test_client, &str_snk_ac10_8_1_2,
+			STR_SNK_AC10_8_1_2);
+	define_test("BAP/UCL/STR/BV-067-C [UCL, AC 2, LC3 8_2_2]",
+			test_client, &str_snk_ac2_8_2_2,
+			STR_SNK_AC2_8_2_2);
+	define_test("BAP/UCL/STR/BV-068-C [UCL, AC 10, LC3 8_2_2]",
+			test_client, &str_snk_ac10_8_2_2,
+			STR_SNK_AC10_8_2_2);
+	define_test("BAP/UCL/STR/BV-069-C [UCL, AC 2, LC3 16_1_2]",
+			test_client, &str_snk_ac2_16_1_2,
+			STR_SNK_AC2_16_1_2);
+	define_test("BAP/UCL/STR/BV-070-C [UCL, AC 10, LC3 16_1_2]",
+			test_client, &str_snk_ac10_16_1_2,
+			STR_SNK_AC10_16_1_2);
+	define_test("BAP/UCL/STR/BV-071-C [UCL, AC 2, LC3 16_2_2]",
+			test_client, &str_snk_ac2_16_2_2,
+			STR_SNK_AC2_16_2_2);
+	define_test("BAP/UCL/STR/BV-072-C [UCL, AC 10, LC3 16_2_2]",
+			test_client, &str_snk_ac10_16_2_2,
+			STR_SNK_AC10_16_2_2);
+	define_test("BAP/UCL/STR/BV-073-C [UCL, AC 2, LC3 24_1_2]",
+			test_client, &str_snk_ac2_24_1_2,
+			STR_SNK_AC2_24_1_2);
+	define_test("BAP/UCL/STR/BV-074-C [UCL, AC 10, LC3 24_1_2]",
+			test_client, &str_snk_ac10_24_1_2,
+			STR_SNK_AC10_24_1_2);
+	define_test("BAP/UCL/STR/BV-075-C [UCL, AC 2, LC3 24_2_2]",
+			test_client, &str_snk_ac2_24_2_2,
+			STR_SNK_AC2_24_2_2);
+	define_test("BAP/UCL/STR/BV-076-C [UCL, AC 10, LC3 24_2_2]",
+			test_client, &str_snk_ac10_24_2_2,
+			STR_SNK_AC10_24_2_2);
+	define_test("BAP/UCL/STR/BV-077-C [UCL, AC 2, LC3 32_1_2]",
+			test_client, &str_snk_ac2_32_1_2,
+			STR_SNK_AC2_32_1_2);
+	define_test("BAP/UCL/STR/BV-078-C [UCL, AC 10, LC3 32_1_2]",
+			test_client, &str_snk_ac10_32_1_2,
+			STR_SNK_AC10_32_1_2);
+	define_test("BAP/UCL/STR/BV-079-C [UCL, AC 2, LC3 32_2_2]",
+			test_client, &str_snk_ac2_32_2_2,
+			STR_SNK_AC2_32_2_2);
+	define_test("BAP/UCL/STR/BV-080-C [UCL, AC 10, LC3 32_2_2]",
+			test_client, &str_snk_ac10_32_2_2,
+			STR_SNK_AC10_32_2_2);
+	define_test("BAP/UCL/STR/BV-081-C [UCL, AC 2, LC3 44_1_2]",
+			test_client, &str_snk_ac2_44_1_2,
+			STR_SNK_AC2_44_1_2);
+	define_test("BAP/UCL/STR/BV-082-C [UCL, AC 10, LC3 44_1_2]",
+			test_client, &str_snk_ac10_44_1_2,
+			STR_SNK_AC10_44_1_2);
+	define_test("BAP/UCL/STR/BV-083-C [UCL, AC 2, LC3 44_2_2]",
+			test_client, &str_snk_ac2_44_2_2,
+			STR_SNK_AC2_44_2_2);
+	define_test("BAP/UCL/STR/BV-084-C [UCL, AC 10, LC3 44_2_2]",
+			test_client, &str_snk_ac10_44_2_2,
+			STR_SNK_AC10_44_2_2);
+	define_test("BAP/UCL/STR/BV-085-C [UCL, AC 2, LC3 48_1_2]",
+			test_client, &str_snk_ac2_48_1_2,
+			STR_SNK_AC2_48_1_2);
+	define_test("BAP/UCL/STR/BV-086-C [UCL, AC 10, LC3 48_1_2]",
+			test_client, &str_snk_ac10_48_1_2,
+			STR_SNK_AC10_48_1_2);
+	define_test("BAP/UCL/STR/BV-087-C [UCL, AC 2, LC3 48_2_2]",
+			test_client, &str_snk_ac2_48_2_2,
+			STR_SNK_AC2_48_2_2);
+	define_test("BAP/UCL/STR/BV-088-C [UCL, AC 10, LC3 48_2_2]",
+			test_client, &str_snk_ac10_48_2_2,
+			STR_SNK_AC10_48_2_2);
+	define_test("BAP/UCL/STR/BV-089-C [UCL, AC 2, LC3 48_3_2]",
+			test_client, &str_snk_ac2_48_3_2,
+			STR_SNK_AC2_48_3_2);
+	define_test("BAP/UCL/STR/BV-090-C [UCL, AC 10, LC3 48_3_2]",
+			test_client, &str_snk_ac10_48_3_2,
+			STR_SNK_AC10_48_3_2);
+	define_test("BAP/UCL/STR/BV-091-C [UCL, AC 2, LC3 48_4_2]",
+			test_client, &str_snk_ac2_48_4_2,
+			STR_SNK_AC2_48_4_2);
+	define_test("BAP/UCL/STR/BV-092-C [UCL, AC 10, LC3 48_4_2]",
+			test_client, &str_snk_ac10_48_4_2,
+			STR_SNK_AC10_48_4_2);
+	define_test("BAP/UCL/STR/BV-093-C [UCL, AC 2, LC3 48_5_2]",
+			test_client, &str_snk_ac2_48_5_2,
+			STR_SNK_AC2_48_5_2);
+	define_test("BAP/UCL/STR/BV-094-C [UCL, AC 10, LC3 48_5_2]",
+			test_client, &str_snk_ac10_48_5_2,
+			STR_SNK_AC10_48_5_2);
+	define_test("BAP/UCL/STR/BV-095-C [UCL, AC 2, LC3 48_6_2]",
+			test_client, &str_snk_ac2_48_6_2,
+			STR_SNK_AC2_48_6_2);
+	define_test("BAP/UCL/STR/BV-096-C [UCL, AC 10, LC3 48_6_2]",
+			test_client, &str_snk_ac10_48_6_2,
+			STR_SNK_AC10_48_6_2);
+	define_test("BAP/UCL/STR/BV-097-C [UCL, SRC, AC 1, LC3 8_1_2]",
+			test_client, &str_src_ac1_8_1_2,
+			STR_SRC_AC1_8_1_2);
+	define_test("BAP/UCL/STR/BV-098-C [UCL, SRC, AC 4, LC3 8_1_2]",
+			test_client, &str_src_ac4_8_1_2,
+			STR_SRC_AC4_8_1_2);
+	define_test("BAP/UCL/STR/BV-099-C [UCL, SRC, AC 1, LC3 8_2_2]",
+			test_client, &str_src_ac1_8_2_2,
+			STR_SRC_AC1_8_2_2);
+	define_test("BAP/UCL/STR/BV-100-C [UCL, SRC, AC 4, LC3 8_2_2]",
+			test_client, &str_src_ac4_8_2_2,
+			STR_SRC_AC4_8_2_2);
+	define_test("BAP/UCL/STR/BV-101-C [UCL, SRC, AC 1, LC3 16_1_2]",
+			test_client, &str_src_ac1_16_1_2,
+			STR_SRC_AC1_16_1_2);
+	define_test("BAP/UCL/STR/BV-102-C [UCL, SRC, AC 4, LC3 16_1_2]",
+			test_client, &str_src_ac4_16_1_2,
+			STR_SRC_AC4_16_1_2);
+	define_test("BAP/UCL/STR/BV-103-C [UCL, SRC, AC 1, LC3 16_2_2]",
+			test_client, &str_src_ac1_16_2_2,
+			STR_SRC_AC1_16_2_2);
+	define_test("BAP/UCL/STR/BV-104-C [UCL, SRC, AC 4, LC3 16_2_2]",
+			test_client, &str_src_ac4_16_2_2,
+			STR_SRC_AC4_16_2_2);
+	define_test("BAP/UCL/STR/BV-105-C [UCL, SRC, AC 1, LC3 24_1_2]",
+			test_client, &str_src_ac1_24_1_2,
+			STR_SRC_AC1_24_1_2);
+	define_test("BAP/UCL/STR/BV-106-C [UCL, SRC, AC 4, LC3 24_1_2]",
+			test_client, &str_src_ac4_24_1_2,
+			STR_SRC_AC4_24_1_2);
+	define_test("BAP/UCL/STR/BV-107-C [UCL, SRC, AC 1, LC3 24_2_2]",
+			test_client, &str_src_ac1_24_2_2,
+			STR_SRC_AC1_24_2_2);
+	define_test("BAP/UCL/STR/BV-108-C [UCL, SRC, AC 4, LC3 24_2_2]",
+			test_client, &str_src_ac4_24_2_2,
+			STR_SRC_AC4_24_2_2);
+	define_test("BAP/UCL/STR/BV-109-C [UCL, SRC, AC 1, LC3 32_1_2]",
+			test_client, &str_src_ac1_32_1_2,
+			STR_SRC_AC1_32_1_2);
+	define_test("BAP/UCL/STR/BV-110-C [UCL, SRC, AC 4, LC3 32_1_2]",
+			test_client, &str_src_ac4_32_1_2,
+			STR_SRC_AC4_32_1_2);
+	define_test("BAP/UCL/STR/BV-111-C [UCL, SRC, AC 1, LC3 32_2_2]",
+			test_client, &str_src_ac1_32_2_2,
+			STR_SRC_AC1_32_2_2);
+	define_test("BAP/UCL/STR/BV-112-C [UCL, SRC, AC 4, LC3 32_2_2]",
+			test_client, &str_src_ac4_32_2_2,
+			STR_SRC_AC4_32_2_2);
+	define_test("BAP/UCL/STR/BV-113-C [UCL, SRC, AC 1, LC3 44_1_2]",
+			test_client, &str_src_ac1_44_1_2,
+			STR_SRC_AC1_44_1_2);
+	define_test("BAP/UCL/STR/BV-114-C [UCL, SRC, AC 4, LC3 44_1_2]",
+			test_client, &str_src_ac4_44_1_2,
+			STR_SRC_AC4_44_1_2);
+	define_test("BAP/UCL/STR/BV-115-C [UCL, SRC, AC 1, LC3 44_2_2]",
+			test_client, &str_src_ac1_44_2_2,
+			STR_SRC_AC1_44_2_2);
+	define_test("BAP/UCL/STR/BV-116-C [UCL, SRC, AC 4, LC3 44_2_2]",
+			test_client, &str_src_ac4_44_2_2,
+			STR_SRC_AC4_44_2_2);
+	define_test("BAP/UCL/STR/BV-117-C [UCL, SRC, AC 1, LC3 48_1_2]",
+			test_client, &str_src_ac1_48_1_2,
+			STR_SRC_AC1_48_1_2);
+	define_test("BAP/UCL/STR/BV-118-C [UCL, SRC, AC 4, LC3 48_1_2]",
+			test_client, &str_src_ac4_48_1_2,
+			STR_SRC_AC4_48_1_2);
+	define_test("BAP/UCL/STR/BV-119-C [UCL, SRC, AC 1, LC3 48_2_2]",
+			test_client, &str_src_ac1_48_2_2,
+			STR_SRC_AC1_48_2_2);
+	define_test("BAP/UCL/STR/BV-120-C [UCL, SRC, AC 4, LC3 48_2_2]",
+			test_client, &str_src_ac4_48_2_2,
+			STR_SRC_AC4_48_2_2);
+	define_test("BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_3_2]",
+			test_client, &str_src_ac1_48_3_2,
+			STR_SRC_AC1_48_3_2);
+	define_test("BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_3_2]",
+			test_client, &str_src_ac4_48_3_2,
+			STR_SRC_AC4_48_3_2);
+	define_test("BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_4_2]",
+			test_client, &str_src_ac1_48_4_2,
+			STR_SRC_AC1_48_4_2);
+	define_test("BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_4_2]",
+			test_client, &str_src_ac4_48_4_2,
+			STR_SRC_AC4_48_4_2);
+	define_test("BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_5_2]",
+			test_client, &str_src_ac1_48_5_2,
+			STR_SRC_AC1_48_5_2);
+	define_test("BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_5_2]",
+			test_client, &str_src_ac4_48_5_2,
+			STR_SRC_AC4_48_5_2);
+	define_test("BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_6_2]",
+			test_client, &str_src_ac1_48_6_2,
+			STR_SRC_AC1_48_6_2);
+	define_test("BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_6_2]",
+			test_client, &str_src_ac4_48_6_2,
+			STR_SRC_AC4_48_6_2);
+}
+
 static void test_scc(void)
 {
 	test_scc_cc_lc3();
@@ -2835,6 +5294,7 @@ static void test_scc(void)
 	test_scc_disable();
 	test_scc_release();
 	test_scc_metadata();
+	test_str_1_1_1_lc3();
 }
 
 int main(int argc, char *argv[])
-- 
2.43.0


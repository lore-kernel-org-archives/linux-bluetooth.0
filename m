Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3351F4CB1
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765057; cv=none; b=cHRv3k9/fyIs2NEiEtH68iClvU/hWj+riKnKcwpTbouCJgVicRG1LDnf2HLSjmiXSXZFjF0rpC/gRFjAUsKEGYAxa4qCI8tZqbMbDBUuWCd7vpdO66/Zr5nOoo8PpCcmiIrEefgfkL24+0pYQslhJsb/HYcGdv/egolA+9jtzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765057; c=relaxed/simple;
	bh=3gkkujp8ODcNkYH+WnVHjoEkwXjH/x9vmNTmZl98Pek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kgHHhK6n2VT5/yb0GqclYIdwW+TIXNxo+AdHgrbmcVxiZ7A/eK5nBX6uLv0Keo65bQd2OEZEWvOyo/PcPr2QX6J2mEVV8/y4zWmZym+4l+7f59zi5P1MwDL/+29K2cexrmtfZLMLtdbegRymh743yO1mjxtQC1tmhJIxxba55fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQ0ATF7X; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ0ATF7X"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-866e8ca2e07so1029440241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 09:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740765054; x=1741369854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hOrxGUyxWuWuXbwQ4JCgbTGmzL/BAJaz0QW7245U9E=;
        b=EQ0ATF7X0GT5tk+lmCHA/YhLAH/zL90FHghMIQOQCrkxwp3D3gsIOkZWbwCCekDEW4
         fHE7I/2vKjJHybG9ckxdEAHmUB9ARBygzgCQa6Nb50V0J4HtUhKhTIhzyga0Ywfx2haj
         FSlCNIsmmNgt95mIKl9GHk80Axl+JnYbEy2VAqTOMChRhiZ3AtI/e/Qld2s6gElJfCxr
         gFFKN+hi5w1m9V73HW0tmuxK4Rcwr7qPP/V2obGwESUkdlUPwot5wmUzsEWx8IBAUtCg
         a7tBa6J/r8iemq3rbAyybhaMlCRv0EcJo0B+07zPqiZQB/Xba9DMGddoQoYUPPdXQAR1
         tUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740765054; x=1741369854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hOrxGUyxWuWuXbwQ4JCgbTGmzL/BAJaz0QW7245U9E=;
        b=VSSnD+T1+APGJdKjIx7RDkohl2H5YYZAPE/GYp2bIdmKDtCNoD3s7SoYCgo6wO3wKU
         fwN3WWo4GC0SBirqZZdMTtXTd9D4QoGCjTPuydEpVZkglgOqm25Adzky3fw8gfEfSe8c
         aG1nWghlOMJS1JwXMYs6hNTONjHBX1Qfo5b/7WUQhi3cLVc/TYznt+nY8RN+UF4XgOLK
         EypUx7r6gxwy2pq/dNj569UesgUF5fXV0f6Y5Hd81YS0vjsn2KSoOw9tTp296zKujE6e
         JrptwA4Hz9Cojr5Xfgiyh+iOK+rPCX+SASS1Qqb1I9AR3rcMOxnTAh8xy+gButEJnhcb
         CNqw==
X-Gm-Message-State: AOJu0Yx2XIF5Y+9MO3AxAL+oZfDpFBnM8LqA+stHVWZfLmP+aRtubiJd
	l7Vi2YsC7VM4JihrPM1gLmH+6secbu30jmAht+R8D9ZlX4ZwdAVVbIBH+SlM
X-Gm-Gg: ASbGncs0LqDtwIgJPNbtNbpPzYclOh70OVPpEwRllS1XyFNHJM6zgSJ8d7xeEZAb7MB
	c9p3tgm/Yl1Iud5P8A3+FPH6FMTZOoZktj0FOi5Exo+ISEbYFDLGWleL9iq05mRpVJmURAJ+zEZ
	oU1j2po0yyqE1QWmo9lxB1R5/8WiIxEtlFhKFeBLC91VKXe2RmCnteygr18xAT2BeXJCx3pP16s
	8StzWW+JjJwUlg+oZva8hqoQxi1hkZSBGJ9rs0OFn5WeWMGYKkqiXEQvJC+WYVCvaJsy2g5wHrT
	GkqbiSptsD66LFQ0VK9BK7V5gUX0oP2jy+wptTAISqLK5kGtc1gbPp8PL6QqSWY/v/nYABw=
X-Google-Smtp-Source: AGHT+IEWCWeAFLcKOknZaLBfYKAB0USRdMVV7ox91S/eeQQpjkcGKt+5skEPfV2LR1TMD23uE76Yiw==
X-Received: by 2002:a05:6102:6c4:b0:4bb:c8e5:aa8b with SMTP id ada2fe7eead31-4c044d31023mr3130117137.22.1740765054179;
        Fri, 28 Feb 2025 09:50:54 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c0346757b7sm794322137.16.2025.02.28.09.50.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:50:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/bap: Fix state transition of sink for disable operation
Date: Fri, 28 Feb 2025 12:50:48 -0500
Message-ID: <20250228175048.3471469-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes a regression introduced by 173045553c15
("bap: Fix not generating releasing state") where the Disable operation
no long caused the transition to QoS configured for Sink, as per ASCS spec
Table 3.2: ASE state machine transitions that state transition is
required.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f7e42fc15a81..208fc1bf2958 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1965,6 +1965,9 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 	/* Sink can autonomously transit to QOS while source needs to go to
 	 * Disabling until BT_ASCS_STOP is received.
 	 */
+	if (stream->ep->dir == BT_BAP_SINK)
+		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
+
 	if (stream->ep->dir == BT_BAP_SOURCE)
 		stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
 
-- 
2.48.1


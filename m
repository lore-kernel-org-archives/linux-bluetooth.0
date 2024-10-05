Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7787158548
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Oct 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728162921; cv=none; b=rv4rpEWW1Pi+BKr6w/vVOiUym9O+cI+vWsKG0Ch+dN2uEk9ogc36qw31rwfeBsyRYrZmhkzzP3lCQSjBTGKe4JzQh2JKerxaulfiGt6e0RYyIR8NxjmcOYk4FQi3S5AWljVGogYengEMS6EwTYZFVFpiN8cim4tgholQmYuNGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728162921; c=relaxed/simple;
	bh=XNHBMRK4qnIef+V4rSnObwzRCI4ehDqW+JO9qGACDYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+uPj6/YhQtZXZ4srh4JEUCarQdyoDmpW3R5r+J6t0vFpkYInoym8TSIInpOoP78td5MOf84E1FsLejpFEt2nr72TNpO6ea7gsVbXjljVyEAUpXEAmfAbRUwKLiplZ1W/Uk9mbTTsFEHNSHYaHbknglIbH1Masg/9dGZrlel6lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5H6E2Sp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5H6E2Sp"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a993302fa02so120687466b.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Oct 2024 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728162918; x=1728767718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MQ/EnI7fEu6TQpU4Sjn+jw6JgPCVFXm11p6mS6vJHzI=;
        b=f5H6E2SpLndLKQzlTmI9M1tPGwrNTB6PYqzhRSwubOafvINvXk/k8wFb3YUrfmUwwl
         C+xGJcD+W3on8Fw1O7Msg8p/oeROCozr/WGZE01VUSOPVwZvMwfC+NIZQC0ZxFv5eH6Z
         g6YABNPNF0II3e/HH4H1cOmB66yFoJwvLfNsS/xAMNV5mdhbWJZAcwc7s0MANDI4pxp4
         SmF9AE1go/y7PHVYOOF054WAbGJdo1C4J0ntmE93z3JIKQNCTTQgINlawedGsYuvZaBR
         xDZIp8BdGkpHBTGlh7j81kYS8cqDTLhtPSY7T+6sSswtYnDO5yU4BEJF/bVSO+IY01ZR
         HpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728162918; x=1728767718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MQ/EnI7fEu6TQpU4Sjn+jw6JgPCVFXm11p6mS6vJHzI=;
        b=Ksg38SxEEjRWlgtcr6K5GHvGzRNHQ4iqzJba1tMPWQQdjXT1Dg4OBrwyuaf69f7KjC
         jUmdBMLX5bcCtA96u2S4zy5crAGN2g+/TfkRyJqRpF78ouT7r03SboeG371LXWRnblrs
         ro5FK7f7FxIt0KUIqjkZqAXLKG+nMNNB/MJok/uTeTVMlrwgi7wU67JxJxy8B+3WmugL
         0bu97CTFD0RIJaHxEZaYMsuFPTl7yIp4ftjW7rb3vzKK4OUEOlz+WRdmcG2eTVK6rLrF
         8nKGhH1V1C3bYYX1UTlSe2IH3tabPjEhU60CccTj+NMwYIWcp0Or9GhLrcY8lo3mWdfY
         BmEA==
X-Gm-Message-State: AOJu0YyUc25AscVUIaTIIf55Zxrkuwqq3ivF2sv9np0Zm/JCZDKrMl1X
	uoddLsPMU3UXEAYsnys21hQAqBWYQQj878/kNbtnSP70PmpigE2AlJ+DuA==
X-Google-Smtp-Source: AGHT+IEWUFmvQ97OxVOohAV3jDBMPrZRpKL5XmyqQIdabWpjFiHWHw8UOBFhfSon3K/TTsNPMEq3nQ==
X-Received: by 2002:a17:906:dc92:b0:a90:344a:7db6 with SMTP id a640c23a62f3a-a991c01175bmr695305966b.62.1728162917715;
        Sat, 05 Oct 2024 14:15:17 -0700 (PDT)
Received: from raspberrypi.home (46.205.194.156.nat.ftth.dynamic.t-mobile.pl. [46.205.194.156])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7d4d9csm175728366b.182.2024.10.05.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 14:15:17 -0700 (PDT)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] avdtp: Fix state check before sending delay report
Date: Sat,  5 Oct 2024 23:15:10 +0200
Message-Id: <20241005211510.409471-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function which handles the incoming delay report command was fixed
in 2fd62cd. However, the function which send such command was not
updated. This commit fixes that.

Also, indicate that the stream does not support delay reporting with an
appropriate error code.
---
 profiles/audio/avdtp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 0a923ac6c..448ee2730 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3769,11 +3769,12 @@ int avdtp_delay_report(struct avdtp *session, struct avdtp_stream *stream,
 		return -EINVAL;
 
 	if (stream->lsep->state != AVDTP_STATE_CONFIGURED &&
+				stream->lsep->state != AVDTP_STATE_OPEN &&
 				stream->lsep->state != AVDTP_STATE_STREAMING)
 		return -EINVAL;
 
 	if (!stream->delay_reporting || session->version < 0x0103)
-		return -EINVAL;
+		return -ENOTSUP;
 
 	stream->delay = delay;
 
-- 
2.39.5


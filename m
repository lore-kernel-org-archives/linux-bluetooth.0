Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB120C319
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887721; cv=none; b=NiFlNojf5Zy7pVAFa1DX9VsGmzWflJdzYkNcCE6FhUX76m3raQ2kBTjIsm8bVmCOX/qv60turzyXKjXgfNr/Uem3gRCTxyFjHxxJI6L/oBKpRbOEsh9djRhLzi5fNzb0KRbt6T5qE6Mggf/OQL9wcirepb+O73LOOZX7EQQIPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887721; c=relaxed/simple;
	bh=ZRPVFOfUzriixQYFog79mvybwZpe4AsZ8x2as2/Pbzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyrvGVtb6BBAOPIPx0u6xeADnpNZYUsl75nJR5s9R4AqQfSHJsHTq4BiEWbVOGU4klsAYdZxJcEyJUmuvxFTvfrFarFwuMsPKS3RJ5wDfrK2YZIL+l3uATG4OzBtLLoG0PASseZfIbw3QwSdt4JHKVlbcFm4ZJGSciQJZtF8WL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com; spf=none smtp.mailfrom=igorinstitute.com; dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b=x7ceep07; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=igorinstitute.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igorinstitute-com.20230601.gappssmtp.com header.i=@igorinstitute-com.20230601.gappssmtp.com header.b="x7ceep07"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6ed072cdaso1733031a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20230601.gappssmtp.com; s=20230601; t=1729887718; x=1730492518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOCgIG1KsXO+edkbkOVvREhzAA0JbOFkL57CJ+U4CRQ=;
        b=x7ceep07iLe5jMZ8qxWNZVlHqfX90rBiIoSJK8kgmCYEFa8fGHJtZEoJoPYChIfSKH
         Psd/btQ0WgxI6mNC8EMas0FsYNqlE+2SEludHkFFtk2fc53bw4gLeJfVXeaPpbGBweIP
         +OEWYunW/7uUv9FhXSPOhAkaBm4MRm4s2db9CpJOEqYSfEv/5VkAci/DI+OUiRZu6NTE
         io9ue2rxHOPSwTylKpWQuRZ3qGhD3xNnYLp+aAZ86h1AHMjh14xK7VpF1L8+/1NSzp7j
         NolRVeVM5gTPaIAkZkCQOzSOUximi/79UQp8USfNfZcFWEsNzx82xaKEySX7pRtolFy5
         feaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887718; x=1730492518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOCgIG1KsXO+edkbkOVvREhzAA0JbOFkL57CJ+U4CRQ=;
        b=BSqn4wQBCG8bNSX6VNxUwR/yWwlrsmgqvwXVzdEL3lTZQiF5P69mDzn/yWSBAIzIqS
         ujF/kHt0VEgX69YPoZjPQX5tbUCTpOgoFsr+8oJXJGON7Wjs2Wstpcfs8o89ZbXuGfWg
         OP7yD6/MhFRMMG/M+ZXU6iWANwMVCb4YbaNezKQKfgwo89S0PNZtnmDMNMlxZr0s/rH+
         aNhKfB/WGKc+kaDTLnZc1tSfmvVzU6O+9J0I7TfqxeRm3BKQ65eMR6W+MDhWHn8K/RMf
         5kVEVSvZ2cwozc+BqMgeg/1PxBiBIa+7CUVlGJ5GqX5SyX+uEgvdW0lIASJjIsAooEs0
         40Qw==
X-Gm-Message-State: AOJu0YyRQeBF17I2taN+ruXcOY19uvN5fNSOi3O0XzHHVtG/NYLxMIyD
	Rt5JXvQZd/PnWJrTkj5SThf2ayVoYx7Hgr04v6YWzgoScyI/2HFOCr8YS615gv/NCqgWbjHUMUi
	VDrg=
X-Google-Smtp-Source: AGHT+IG/hMpsJFp14niifp8r0CefcKm4GsLz8CB1exTy2jy3AgtUKNnLJ8Y5VzoVsLrmsVeTQYrRPA==
X-Received: by 2002:a05:6a20:e347:b0:1d9:1045:3ed5 with SMTP id adf61e73a8af0-1d9a83c974emr558120637.11.1729887717812;
        Fri, 25 Oct 2024 13:21:57 -0700 (PDT)
Received: from localhost (118-92-78-251.dsl.dyn.ihug.co.nz. [118.92.78.251])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48bb69sm3980540a91.1.2024.10.25.13.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:21:57 -0700 (PDT)
From: Daniel Beer <daniel.beer@igorinstitute.com>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Beer <daniel.beer@igorinstitute.com>
Subject: [PATCH BlueZ 1/2] sink: clean up outstanding AVDTP requests if the stream goes away.
Date: Sat, 26 Oct 2024 09:21:40 +1300
Message-ID: <20241025202141.158946-1-daniel.beer@igorinstitute.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the stream goes IDLE while we have an outstanding request, connect_id
stays non-zero and is never cleared via a completion callback. As a
consequence, the profile on this device will never be connected
successfully again until BlueZ restarts.
---
 profiles/audio/sink.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index a547dcb41..77f195436 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -137,6 +137,11 @@ static void stream_state_changed(struct avdtp_stream *stream,
 	case AVDTP_STATE_IDLE:
 		btd_service_disconnecting_complete(sink->service, 0);
 
+		if (sink->connect_id > 0) {
+			a2dp_cancel(sink->connect_id);
+			sink->connect_id = 0;
+		}
+
 		if (sink->disconnect_id > 0) {
 			a2dp_cancel(sink->disconnect_id);
 			sink->disconnect_id = 0;
-- 
2.43.0


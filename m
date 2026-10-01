Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3613A5456
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865295; cv=none; b=ab/auMRSgvm/lPfGMQ3/MpZwXH9Upbg3piIZ5oxrtO1+F5flkg+FLvB48oc8imu9cqA6DpgH+nnQajrvfXYyAz8i4n3h+bj4xoEyt09M3qZhRSIkYbNPQr69uO9ZH97PZ1KnH/1EAKjFylUf/Qa8EeaaXOHVrpy7dUC1g4rB+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865295; c=relaxed/simple;
	bh=gvBZPaZdZ0B7QwZliS8YKMbdlv1d1i0Ek5wCe7MM6DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y36zgPSvtVhRRzJmZS1UR1rvrgwvwAGJjdeNG+gikcAGL7DvMwrqswmRtL7tcAuFO28zFlGsyqDdSHsWvSOiP6oRG+/phM80j558Mhe3NHTFRkXu/bSblu08DDXewR+51zCEWrs7QXp9m7k6BfSviLlwotrWKwB1TcZTP0eurjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYDJDQpW; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYDJDQpW"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34bb8b31660so1831957eec.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790865284; x=1791470084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSFmEfAT3pGWAonxpbRScToX1KOmu0Uq4u1RQWBATcI=;
        b=jYDJDQpWDQslX+PzxGgQqj5X7TH+r6Zv3qbnzqIn8aDzOjKHGil6TBiQXKCQnr975x
         5YtI3NHJmpWz4oN23Oo9v/EUtbrW2Nskt11Ntz00/CDVIE6hJ3gmn5uiVDmjQJHIOb+u
         DqDazzWj+tLBPlmYzJA1oF/6pPRjD8ug8U/WQ64NIsxWNRAbpcttzLsDKj+AckLrWWGd
         J3gfQP7QHlD9CrOe6G2h0wu3MMHtOD2Wb0U4HymPmqtEyRt4WhIjwPz8PwtruU2gWGKE
         u+dOKOfi4V4faPHO+i+7vKB3CSVIo13lRF7tVEQb4gZGTTzpqXsR0SwedJIc2+wPFNAq
         139A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865284; x=1791470084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nSFmEfAT3pGWAonxpbRScToX1KOmu0Uq4u1RQWBATcI=;
        b=GZ5jUiA3fBakxAThtPBBhdSeBNRmoEoVQvQ4NyTJj5GwnqsWvLdWybnYyPF6lFjc/i
         X3c8IjAfrKFI5kHuYj3XidZJoNKD8ZLWcpEi3lkN3svmK4a1tirGr5NRrZ5JrPwjCkr9
         Vn/Lf9UGfzC8yYWUIMDSCv/5aldTEHBSGrhXfK4efzlSdIkzydqStXdE2Y5AmU0+37hF
         pZ0zymBuB4sDpSu58ZlXha65SLZatIYoa/khnAuYNMU66+dMCSPbA0FyXiqWKsRvL/r7
         wZH7DBux3vbdp7jLLIW7+WhPXFHybn+EfZ8NfmtAbI6WdeYPPZqb3IqCvXio3tHAiF+q
         G+HQ==
X-Gm-Message-State: AFq9FYIgAne3ztjOroMtjBzrKTsk4WWvTy8nSBmrkFPQ4WnG/o0FIoPd
	Uc+lLy8NFLvmzqg+cGr7rB48Zh0fbnh+fNYm1UKMzL8cpmBpLLaZdkjOPOXwGQ==
X-Gm-Gg: AYBFou1MdG01yQWqutl+jaqCdC0RQUXYmDfDW9tQRf0ToqLuWhGMSBVuKpMLdXRdH6h
	ItM1Qd5/QPD/HnCea2omb0asUqiG7MobmPHQHkpZ2f0xTASCMMWG272MLFER1O+mEfVbI0FnGeC
	mnzB/itt8iYpKmTDGlK71APuEhbg5ZzlBo+n1pUU6SDyswD0H6Z86mzUp03e3qvz/L/XiEN1Y+v
	oey6MqJZWcpI3h2UB/49U8rlTgXo+KNZyfUnlpuHv8uIbeqLnY5wmOGZqLzHILHcxZFh9HiICWb
	3dog6GSPnxPhoiWSJc1ml6UEk/v2yOqtwLa3rzqU/TqQ5FFRX3jMqahj9RpTl+P4YDbngA9yCMU
	Skx5+/dF6Y+8MqYRrZ+vaqvPi1DEc96fRRBhM63hMRXZ3kw7id8NkmUwIQ87W2j1l5Aqp/sKAR8
	TAdi5/QDLFByS237AxqFjW+f++zJRRwtA+GnYWN6tE1NmL51AeFXtWVD4IkNoWJe7oj9IBtav06
	rkD2JwwrnE=
X-Received: by 2002:a05:7301:18a1:b0:342:e7a0:2829 with SMTP id 5a478bee46e88-34cdd39de3cmr4805594eec.26.1790865283829;
        Thu, 01 Oct 2026 07:34:43 -0700 (PDT)
Received: from archlinux ([2804:952c:2:0:d3a1:f67e:6409:c184])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db315e877sm8627416eec.9.2026.10.01.07.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:34:43 -0700 (PDT)
From: Eduardo Alves <eduardoalves8006@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Eduardo Alves <eduardoalves8006@gmail.com>
Subject: [PATCH BlueZ 1/2] a2dp: Fix UAF after rejected SetConfiguration
Date: Thu,  1 Oct 2026 10:34:35 -0400
Message-ID: <20261001143436.230557-2-eduardoalves8006@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261001143436.230557-1-eduardoalves8006@gmail.com>
References: <20261001143436.230557-1-eduardoalves8006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the MediaEndpoint1 rejects SetConfiguration, auto_config() calls
setconf_cb() with an error and avdtp frees the avdtp_stream, but the
a2dp_stream wrapping it is left on sep->streams with a dangling stream
pointer. The next stream configured on the same session finds it in
a2dp_config() and reads the freed avdtp_stream:

  ERROR: AddressSanitizer: heap-use-after-free
  READ of size 4
    #0 avdtp_stream_get_state profiles/audio/avdtp.c:3952
    #1 a2dp_config profiles/audio/a2dp.c:3282
    #2 select_complete profiles/audio/source.c:200
    #3 finalize_select profiles/audio/a2dp.c:486
  freed by thread T0 here:
    #1 stream_free profiles/audio/avdtp.c:747
    #2 setconf_cb profiles/audio/avdtp.c:1504
    #3 auto_config profiles/audio/a2dp.c:752
    #4 endpoint_setconf_cb profiles/audio/a2dp.c:768

Fix it by destroying the a2dp_stream when the configuration is
rejected, which also drops the session reference it holds.

This can be reproduced with test-functional using two VMs over btvirt,
where the A2DP Sink endpoint replies to SetConfiguration with an error
and the sink then connects to the source on the same session.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/a2dp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index efbe73f1b..e4b6f03fe 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -748,9 +748,17 @@ static gboolean auto_config(gpointer data)
 	}
 
 done:
-	if (setup->setconf_cb)
+	if (setup->setconf_cb) {
+		/* Rejecting the configuration frees the avdtp_stream */
+		if (setup->err)
+			a2dp_stream_destroy(setup->sep, setup->stream);
+
 		setup->setconf_cb(setup->session, setup->stream, setup->err);
 
+		if (setup->err)
+			setup->stream = NULL;
+	}
+
 	finalize_config(setup);
 
 	setup_error_set(setup, NULL);
-- 
2.56.0


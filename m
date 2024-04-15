Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2A52119
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192889; cv=none; b=TE+/F6Bze4kfeqXqMYIxb4edQvRtD5sj5n9TUceG5tQV8iPgf9RqdS3xSm84MUZyOlMTQCb39G53NPz7oTr7Yi8XDILIOEmJslRFcWW9qGaa7DhSiJeX/5ajOlI1nW2mI108Prhhen8HZ6x8FwtMmOJg65JTcbeV13pi2BJDb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192889; c=relaxed/simple;
	bh=K+07fymbgHjhn8XFHVYcOTR0BLyaz8QV7+jbf8uZoYE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RhsgkeE43febz4uxcC/CoUTcFtn9oqOaofO9WdzRFKwVmrx979gZ/6g+IAQjZy/A71YopwDr89D5jAJnAY0Dd9D6JNNuBLtFd3aBK8+7i6V5DY7RP+KgrlAVuj+Dlz0SwreCzgTco762QEcqlgAhJeo19hbSl3mx1dUseQAkKBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVylU34R; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVylU34R"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6098a20ab22so29028057b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713192886; x=1713797686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQnRumMoaF7gSzqotLZBHfrSRlMURAtn7bOgwW5gJHc=;
        b=GVylU34Rc13LIX4FUSzg/1OYIcugMBulCz/egKpRO7OB4NblzivBcPlUvaC1JDuHIr
         NbgOdoIKTpZfvOgSwNSACBQoOu+7o2PcXCiJJRKMbOam1ABciJBeNMfYE12I+iWkDzFB
         uCUuGazJT7B28Z7LuYRqRpwV32tr8quA3L+CH1B9UWQvaXM708M9CxncTGFFToWLty41
         3UKOO66/pRUnr6WnWbVEAonYZUakZ58PDb3YuanEHeJ2Hj5kt4q0LWRB1dqDxui97J0i
         MFBdSLcNxpBjdYqLJAUMhCX3YlrfV9svv2VTI5rEdzaSOp79THr5SUGeRPPpeixoCrSI
         dW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713192886; x=1713797686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQnRumMoaF7gSzqotLZBHfrSRlMURAtn7bOgwW5gJHc=;
        b=I6ONU/2gEif1Vq/MATu6wveAJMpjqmAS8CF8vPhRNw2tnPFa5Th0zPN7Ad2Ee1UwE8
         E1XWMfIwW+nYU4f6fRtISZUFGOrPTP+EuC/bhxgpUwi5cqWkNdjFBGsWvSin7H3ds06a
         0gXamrJJNvvz2GmP+NCuazFkAp2IMKqnxVukDtHjdhtvQRIgaAo91kaPuHErTPRSLyeI
         nfwgAmQ6bPausVlnH4EBSn6A5wTjoFbv8NbBuuEG8BIr14Zi4dolh5rz+N2VUiFRenHj
         YUXN6XCsHFWrIuwXFe1S8dlP358AR4QO/B9IG1Nuew3p4gNs8z+wDP4cBo06dYeDvjOs
         GNoQ==
X-Gm-Message-State: AOJu0YySBLNTa446GCsnNhYaE8lWweEwalTKpvPEBENakAoLKPcihRkG
	FqrguVlOYxTkqKg2QWqdGZjMPJcpzoVcn3ibYxYBXO9OUvvp0d5i8QmgLQ==
X-Google-Smtp-Source: AGHT+IERB+yoHiKZRdzNKydOZy0oLkgPjSKez7E4yvNFDF9n/YHANaUOAIPUJDf2vk+k/BaxhFDviw==
X-Received: by 2002:a05:690c:6102:b0:617:cfb8:4e50 with SMTP id hi2-20020a05690c610200b00617cfb84e50mr12350702ywb.17.1713192886250;
        Mon, 15 Apr 2024 07:54:46 -0700 (PDT)
Received: from lvondent-mobl4.. ([107.146.107.67])
        by smtp.gmail.com with ESMTPSA id d65-20020a814f44000000b0061ab4627d7esm917074ywb.102.2024.04.15.07.54.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:54:45 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/uhid: Fix crash if bt_uhid_destroy free replay structure
Date: Mon, 15 Apr 2024 10:54:44 -0400
Message-ID: <20240415145444.857497-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Id replay structured has been allocated it shall be set back to NULL
after calling uhid_replay_free otherwise it may cause the following
crash:

Invalid read of size 1
   at 0x1D8FC4: bt_uhid_record (uhid.c:116)
   by 0x1D912C: uhid_read_handler (uhid.c:158)
   by 0x201A64: watch_callback (io-glib.c:157)
   by 0x48D4198: g_main_dispatch.lto_priv.0 (gmain.c:3344)
   by 0x49333BE: UnknownInlinedFun (gmain.c:4152)
   by 0x49333BE: g_main_context_iterate_unlocked.isra.0 (gmain.c:4217)
   by 0x48D4DC6: g_main_loop_run (gmain.c:4419)
   by 0x2020F4: mainloop_run (mainloop-glib.c:66)
   by 0x20254B: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x12D6D4: main (main.c:1456)
 Address 0x53ae9c0 is 0 bytes inside a block of size 40 free'd
   at 0x48468CF: free (vg_replace_malloc.c:985)
   by 0x1D8E19: uhid_replay_free (uhid.c:68)
   by 0x1D8E19: uhid_replay_free (uhid.c:59)
   by 0x1D8E19: bt_uhid_destroy (uhid.c:509)
   by 0x1591F5: uhid_disconnect (device.c:183)

Fixes: https://github.com/bluez/bluez/issues/815
---
 src/shared/uhid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index c1092b70781b..1f071b958974 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -507,6 +507,7 @@ int bt_uhid_destroy(struct bt_uhid *uhid)
 
 	uhid->created = false;
 	uhid_replay_free(uhid->replay);
+	uhid->replay = NULL;
 
 	return err;
 }
-- 
2.44.0


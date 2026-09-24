Received: from mail-ua2-f43.google.com (mail-ua2-f43.google.com [74.125.226.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00B3EAC8F
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264806; cv=none; b=UQwBMrmHKWTLUGxqETsRNmdlw5Tjbjbrqi+7921+5h2f3y8pAecXFiDLzReWTA5oG0j6yKMtvGjukx3EDuJXsauc73H+c1GqgOz80rNTwq09gFXTCkO/Hy3WK2KVjNFFYEdfK8T2DKLrw1W+u4H8Xo8Win3AFW90f4udku6ZShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264806; c=relaxed/simple;
	bh=nTDQqii3W3sR4SeC2HXzbnIV9tdGurgAGCYOyoMvDGg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lz/+P3uQ5BpDgg8eKQqpp5YD590wbTGRFLt6xkQYMs40MOY8fxlBau1YhqyIO16JrKpG4SmXPGUXiWQR/Dh3ok1VONsBjBdnul9KnwyGtCp5Oud62VgifbILCDmyJrK8aiMU3WVotvk4FIOTjXJ8z2FoplT2QqMpyQCqZjWcRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ixwxae6a; arc=none smtp.client-ip=74.125.226.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ixwxae6a"
Received: by mail-ua2-f43.google.com with SMTP id a1e0cc1a2514c-97eaa1155b1so1175432241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264803; x=1790869603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1Ag9z3Jo6gTcnaVkgPx+3vFhn/WBjZEYbPSMgmGQppI=;
        b=Ixwxae6a7gVvHajKXf+/f3gpuG3ZzrBAzo7SwwvpInGLDfyrcPnCrUmeICuLoYMBfi
         Nqeotc6hi9SQgh/3b1AXfioBznqBMTX8SZv6lPiCne7pGcHHqshNeiYw5RLof3fUQa+/
         2gNZJX0kQtebw654X0zvHIIcR3zWvRo9CzU4n9qr5jhy+S2OOPpN14TrvVkmOj2o++5o
         viywufE0I3MO5i9L7TcuHVd9O22VF10Gddo019mzbsSxhwZEqnI/LF+b2w+ay6kauHjO
         pE+zjvRCji+krHlUna+0/lldauzOJWjioQF5+Vl0HXhkF+Dg4fs2nhqmSC5kooXrci/w
         Lqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264803; x=1790869603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1Ag9z3Jo6gTcnaVkgPx+3vFhn/WBjZEYbPSMgmGQppI=;
        b=X1qociLWPfdfC1hVCFRHWNR7FfAJ98dUc4jJwx/7wdCvfapmcsmM6tBhCcOHblDQiJ
         bKocsb2KTegl+7QcyhbnBs1ELkOgIOU6Dw0bk6sxu8ckUwUhj6E+oh3qdQpCTXD2ouPN
         KHR5Iz0rzwovytuSWQUL8ObGESXBhBOzmMzWQP89d3DMCIOd3UivJSBc35zyEFTmoAqy
         FIGPa5msKrtAsOM5M6+ULxgVNnq+alpvYDz2hcL8KRgdwywCE9uSR8CDzQP7QfAw/2J3
         0kYeVk3YxtoFOfO213KsR+dNMxlLyTrFnBIBkIZnpXvucbH5C1Y6mN8UQmYou071gueQ
         Fj1Q==
X-Gm-Message-State: AFuF++kOoYWgCVzNu7wwp5LbhHzRcCPAPyp9pZkmCT7pOsAPdAPPWCRH
	vzZ/zp03xKB/qKPlzEGEAddQ03k8qN+zNmmcqS795y0BvYXlTv/JdGcexPPEd+MXPOqQXw==
X-Gm-Gg: AYBFou1uTYZAdnVCos0mfkW/GqeqozsdlJnrv94M+KltWz2XdBcCwM5LK+w/aNBHwAm
	tIOanewDFxkYAnSgJz5szJFcRLJG54DW+rWVqJ0fN5WQWokIG5XXOpNumRQaOFE1mnmrplrzBiW
	9mUGzuA3+N4+NnEqryzL7FH/zI5SN2jftgldk6rY787gvSJOE0URYLvcoWJ46+/KWCJXIWD0ehL
	wwoK5RonKF8/BMmX6eHRe4n8qNY6cCxlvGg7wcNVgZ+Vp81thRvhWjgTxFOUkZh8Q7Rp9cjiBly
	JUFllBYfNRBwFWFwuFJgXP92mWHHKJOJ3QO5YnXJnvz4BPiotvg5d603U15Gl0Ipf/lSGmG8Rpn
	kg0s70R+8uBZ6qSQLpG5d7w9/etpqS+MghU2OU45H8IrVKPVISabO2TehQwAwIHCjrCDxZMODCW
	zR8/zPPy1vKCYPhMGkUAZv3fBr5JcWKuWXZklC3GYiU8iFa193UPAwwKsL7xHKBM6cgNX/yegEj
	syGuO2Sv6edrPVjr63bXxSgaHd9PtL295R4f9qvZIvYh58caLN9xWOU90b6LKdM
X-Received: by 2002:a67:e704:0:b0:7a8:1817:2765 with SMTP id ada2fe7eead31-7af1bf72852mr1490426137.11.1790264802859;
        Thu, 24 Sep 2026 08:46:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/9] shared/gatt-client: Fix calling destroy after unregistering notify
Date: Thu, 24 Sep 2026 11:46:23 -0400
Message-ID: <20260924154631.369299-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_gatt_client_unregister_notify resets the callbacks of the
notification but not its destroy callback, which is called once the
notify_data is freed. If a procedure is still pending at that point,
e.g. the write of the CCC to disable the notifications, it holds a
reference to notify_data so destroy is called later, once the user data
may have been freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:130
 #13 notify_data_unref src/shared/gatt-client.c:256
 #15 destroy_write_op src/shared/gatt-client.c:3189
 #16 request_unref src/shared/gatt-client.c:201
 #17 destroy_att_send_op src/shared/att.c:215
 #18 bt_att_cancel src/shared/att.c:1925
 #19 cancel_request src/shared/gatt-client.c:2783
 ...
 #21 bt_gatt_client_cancel_all src/shared/gatt-client.c:2811
 #22 bt_gatt_client_free src/shared/gatt-client.c:2290

Call destroy when unregistering instead.
---
 src/shared/gatt-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 92ad7c39c115..cd4270291827 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3858,6 +3858,15 @@ bool bt_gatt_client_unregister_notify(struct bt_gatt_client *client,
 	notify_data->callback = NULL;
 	notify_data->notify = NULL;
 
+	/* Call destroy now as the user data may be freed once unregistered,
+	 * while notify_data may still be referenced by a pending procedure,
+	 * e.g. the write of the CCC.
+	 */
+	if (notify_data->destroy) {
+		notify_data->destroy(notify_data->user_data);
+		notify_data->destroy = NULL;
+	}
+
 	complete_unregister_notify(notify_data);
 	return true;
 }
-- 
2.55.0


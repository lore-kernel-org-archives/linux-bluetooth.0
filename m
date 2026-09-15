Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C2420898
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488176; cv=none; b=LjRqF6gvXN51LIFZm8H+LUx0jhA7DJ7hxtDRADoXvgr51+EAldxtL3suyOwOoSPpuym6SA8OObNNOomGG1qwN22sEn8j3ADYOMGBwvf4txscIAjZ8srQZwYtMqF7vwyHlAjkqhCA/kvvezsR4LHs+wSfr4K6kQHjaujymj2UQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488176; c=relaxed/simple;
	bh=9UwYC4oAOD0QyUOBHTahfXva8dPMW5L+Y0G4I2GbhK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVPo6u1xuDV+0Poh1s0pBeJ/sSZTfPvmf4C5mF/1sPsNNINF2KgLm9G8QysB5NqetH3pL/t/s+6/j9Ei7CFjgvJiTDBwPsLYFOad/Q9bAcYj/ZlYx+hFo5/6NjxL0sz5X24NhPdtYlXppnTkfCsVWpuip7Q5se41VXU7G83uWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lunoOwBz; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lunoOwBz"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c8d040aso257651241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789488172; x=1790092972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G2OyX4TBZ7Y1HQ2aZjbOcGyMSBVmU4uZJiE97DYV0Rw=;
        b=lunoOwBzgY2LcIWA3JpVQLZ49XKm3odL0hFDJ454Iqf3vnGbCOgklpIeTl4gJvPjel
         OJzx0Kk6CfE5Z6SplGUXnrDngkDgHjgpeJw+CPTIcdNzZCmYxdPM+HKp+LmRbG02M8C8
         zXJVMtRHed50mwAZjOL4qWbk/CImNvCqZcf4QBVapV8uXdi44JOtS+reZyOXu4BS3i+L
         CdhAOgQ5JNEr7xFc2u5AwVhjC4rfPfUU01sVCUr5qBGrotTX6SvxijmxOiQdKUkRytTw
         qlWXq+z2S2Jb+P7ajktbOCUTnWG2Z3RMuL+q5rkz70o3HZUExw7t6tEpuTVILALjG0UD
         2Aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488172; x=1790092972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2OyX4TBZ7Y1HQ2aZjbOcGyMSBVmU4uZJiE97DYV0Rw=;
        b=A5LuoeNmSXa0XRZ6ERorFAo78BpGCI0172zOKF8JVgcRbxSmeWQORHKjs+/BhA36fo
         OIovL3SlNzTy+NVqQFCmA6wA02HgDtbkY+/T5aneLwAWI16zgL9bXj8s2JVaWRtLSFoZ
         LzDDwGTPENXbg/Xws4ADNp1mpCw5hIoLpSqTMfD1S6DgRSHaDzN8jEiChgJowE3+mDZk
         YHw+tqi8aankVBbP3iM30T04TTyWk9LdePHDVfWUOyyVT35/ug4haikDyr7KQMeqobS3
         /9w28l2+taC0rIJs/m/EOdh0MFMv0QHslTA49IavLOo91OPLJY7AG5eU3/rf/1TAj892
         BKbA==
X-Gm-Message-State: AFuF++lRqzcWeGPnAPvLNtMfNreRjEGLW7PacXr3XarPqiwxL5N0vF1v
	plsrOBZm4P1AAar2DctFOC+aAx+3O8Rv/mQos56qRl/9LTqjjSbXTMas
X-Gm-Gg: AYBFou3EgxWyfogWqitWXnOd9YxaUp6LoyhJT79oLmtwIv2/61uX9L4UzZbt9wI7dC2
	S+YpdT/RIC8M8/szynOks8nLwjUlKtr3ZYk5PGfm6wLaMKjv2jjybnerK9QiwT83YUw6C/sruii
	LiUaoZCOAeejknewBK45tQpQwLgjpXdzVJDe/v2CkdE8G7h1TOIddJkwPzRwZ2Ku4blBi2su/zy
	3QK/UePJU+mfyKptvmzBiSIRSiO0R0K4EJ9PQ3uaUsHHFGnju1v1gpVpqq+1j2d1gVX4joM2smd
	n05wQEQP8Mhaq8c/MzAgiSnJe/MCFy+E14bgyIaKHwyZFQAt+1+lD5b+DdEVa0B0XylBERDtAhW
	RYxhTBYZXqXdGTCDMdVn/iIkhEM+eWrpRSmOnC3XgtlHgk7G2G0eVOIn6DLagijWHxz4XlWwVnb
	LbKztwWka2EE6fbB+ptnk9xcIHhuCprcoYc1ReCTxve+f4NxzCQEy9rZ8Un/b35LrW
X-Received: by 2002:a05:6102:38c6:b0:79e:373e:8216 with SMTP id ada2fe7eead31-79ecdbfe5f3mr3192373137.0.1789488171648;
        Tue, 15 Sep 2026 09:02:51 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-79fb193e849sm78576137.8.2026.09.15.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 09:02:51 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] Bluetooth: L2CAP: validate frame length before control and FCS access
Date: Tue, 15 Sep 2026 13:02:39 -0300
Message-ID: <20260915160239.3106697-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_data_rcv() unpacks either a two-byte or four-byte control field
without first ensuring that it is present. A short ERTM or streaming-mode
frame can therefore cause an out-of-bounds read.

There is a second short-frame case when CRC16 is enabled. After the
control field is pulled, l2cap_check_fcs() subtracts two from skb->len
without checking it. If fewer than two bytes remain, the subtraction
wraps; skb_trim() leaves the buffer unchanged and the subsequent FCS
load reads past the logical end of the frame.

Validate that the frame contains both its control field and, when
enabled, its FCS before either field is accessed.

Fixes: 1c2acffb76d4 ("Bluetooth: Add initial support for ERTM packets transfers")
Fixes: fcc203c30d72 ("Bluetooth: Add support for FCS option to L2CAP")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/bluetooth/l2cap_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1156aba4e..40ebabe34 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6683,9 +6683,17 @@ static int l2cap_stream_rx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_ctrl *control = &bt_cb(skb)->l2cap;
-	u16 len;
+	u16 len, min_len;
 	u8 event;
 
+	min_len = test_bit(FLAG_EXT_CTRL, &chan->flags) ?
+		  L2CAP_EXT_CTRL_SIZE : L2CAP_ENH_CTRL_SIZE;
+	if (chan->fcs == L2CAP_FCS_CRC16)
+		min_len += L2CAP_FCS_SIZE;
+
+	if (skb->len < min_len)
+		goto drop;
+
 	__unpack_control(chan, skb);
 
 	len = skb->len;
-- 
2.43.0


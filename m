Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269A12DD9B
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036674; cv=none; b=R5DIbK43UoRtpJKCLfFqNW9B9/zJnutsC5w1z3ML+9hOV9XkcqGFzz5B4P4615SwMX7qf+IjfNNL3BQnh9oy683rajOgKOFE08uU5RMQgbhAG4HFLGvWv/2jM31X1QnMC/j5ho5cDHeVNaV4jdeTG9eC3901pnpzVhJUi5ak9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036674; c=relaxed/simple;
	bh=TFsKGKW1/xuT0Gi5mEkxzAptNw/rmCnBQK5KYSbpMj0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzkxGe0IWme3LYp7SR21dAmrJXLfG/RFeXJZvS51kXqGHbX+86yt/3xzGraGL80YRcz454KiZUxtRTbXB8zY6rXTGNKM8qO3SlIZjH54wtzhkgBw2310B6XLYfjdLax2/JY9YI7TEWi5NvyzBnjl5LnO0rtMY/BbWvHNBfCmEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8QKPbH4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8QKPbH4"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ff7ec8772dso38959227b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 11:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706036671; x=1706641471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=++Awl1pKHGi7oV2oMVtH+lGaeq0Dae6pbLc7gUzZnLc=;
        b=c8QKPbH44tR3aLyUrJcc+N7ntqWaiODmSjsO6o80Mo1xDEX9AfzpbEC/r+F3IFz0AQ
         7KDhezTfxZp/jS2TR1pvOCUEtPz3eZPcbf9BOkTTlUEBgPD9Kqla99rthNrXLGCDOAFl
         9X9gIThI/GsWHsgzuxgufxGeKutyJnCyRilGCW7JUA8JGnYnEeBhNT2FoptgLcml5a8p
         IUuDYz25docgsl+HKlguBdL9pvWf2qEVXJakXGMZIG5zykuTck3b1H43QoKiHXrwKJz9
         trAfO1MBFXHgI3Fug5y1fnwQtigzjqdS+f8eXarrs98RP7li8hR2PrqEEgiCqwvMBrPy
         c6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036671; x=1706641471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++Awl1pKHGi7oV2oMVtH+lGaeq0Dae6pbLc7gUzZnLc=;
        b=I6hHb72u3cJA5qa7uiEoWACd1ogfWLZ+oqcn6wMxhEJpGqfh2PrA8E8RkXeYHz+Ery
         Ryu4YuTXU4KWDGGCtH7JwtIZezLR1kUCEaqgv7zxiIMO+LJTYaQIjRlLIO8RaAGUpGrG
         FJcwep6Li3ZLWIXcPiV0Va1euIYxzgIzKRCr8uOQXDoPnX9iZBrXQK+DWIinfEy+ivVS
         LPZvPy1UrwFAxPD3KnrMrVLQI5oQW8ZCrvzQa9M4tZkkaQ9oR66oHHbkR1usYZD11sND
         RQGm2uXEjSGZ9WO4GOQaHJknpDHUW80z6DX4RPLXO5DRmqQPdEyD3WhCbyzhkMpE1Bpv
         zofw==
X-Gm-Message-State: AOJu0Yz23oEEjY8yPxKE0XfPjVAb6AwwIv2iIs5y990NYTqYS5vNvLYc
	vahRu9INevJFkWtlWSkjKip3On/LzxGLm4eurcfPbABK0c3OvsOAoXbPXgtP
X-Google-Smtp-Source: AGHT+IGJXeENuTqjkys91sdpLH8+vZqT6TVwYQH7mnIu6aH4y5uPxsQ6Ybm2/lkqZhb+BIWKtdym6w==
X-Received: by 2002:a0d:ea49:0:b0:5ff:cb36:4121 with SMTP id t70-20020a0dea49000000b005ffcb364121mr3866048ywe.91.1706036670924;
        Tue, 23 Jan 2024 11:04:30 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id x70-20020a81a049000000b005ff5fc95e2esm5590109ywg.142.2024.01.23.11.04.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:04:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] bap: Fix not handling out of order responses
Date: Tue, 23 Jan 2024 14:04:27 -0500
Message-ID: <20240123190427.3031698-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123190427.3031698-1-luiz.dentz@gmail.com>
References: <20240123190427.3031698-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When EATT is enabled it is possible that response are generated out of
order, since they may come from different sockets/fds, so this attempts
to detect when that happens by checking if the state has already been
changed.
---
 profiles/audio/bap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6184c9d178a8..a4036bbbdfa8 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -801,8 +801,20 @@ static void config_cb(struct bt_bap_stream *stream,
 
 	setup->id = 0;
 
-	if (!code)
+	if (!code) {
+		/* Check state is already set to config then proceed to qos */
+		if (bt_bap_stream_get_state(stream) ==
+					BT_BAP_STREAM_STATE_CONFIG) {
+			setup->id = bt_bap_stream_qos(stream, &setup->qos,
+							qos_cb, setup);
+			if (!setup->id) {
+				error("Failed to Configure QoS");
+				bt_bap_stream_release(stream, NULL, NULL);
+			}
+		}
+
 		return;
+	}
 
 	if (!setup->msg)
 		return;
-- 
2.43.0


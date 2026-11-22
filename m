Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376035;
	b=xcJAG69f0vomh+zJcMsrHrJZ4R7nz8PuwBjn96pbCyuBGmZ9UMp69D2k47kiYj8YVNx3
	 A9gnCVxhAVG1br1qnoxf8eVVqyupmzi/wQ1UR78TbLQ/AGZ1b3xj0Ha22aYZDVP4Ky+1S
	 mx6wppMHWT1T7O5nYPG5R7RwVmdiEzJFbi5/B7cri07KBd8VraQlgT0AsMIpkVgvaiVvv
	 oQR0h2laTCgsjhEO5xfh/l07Df4lrJ/JYOhyOa3qh5TWs4c3TaRo8XJG+Z6naJ5oB1yMp
	 B74xbGnppaLF/2XH8ocYY4nDuOsnnIXoka/KNdI6XG+ladw5/t4E3qhkH5zy+VfIijA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GcOQVzEiETB4OL7U9Zwh7hQgb4ZfgcSD/YTNMOb8+xg=;
	b=P8hTC+V9d70ZL9decgVsuhDxPWZeVN0xhHf9bBvTVVperV8iTQSDN3kUueyP4C9q2Qyl
	 m2E2DGZYW18te9XgqiT1RPaQrCT1YXz38d5qqrAiw6jxrh6qwDEsKj8LBLManbswKhGOW
	 8EbRNeRUC6hz5Fx8EoGMaSc1aoN/2K47ES5EQaUYC2iV4nzRJ3whDhM/0OoDNbPaBuni/
	 kuFDvnPTufoDltZKxae5/nRfpq3Gt7GtE/Koe56MPIigtD06AM538T/3642SdcErQ0cbW
	 bCoepi2o+x+Kg+rKCP73ra6Oc+2bFCXV0newZPopTuyTo7cPCMCFIc0PJNukbmdnUsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cSx80sPE;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB06606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 19:33:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB06606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=cSx80sPE
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so23242215e9.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795376033; x=1795980833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GcOQVzEiETB4OL7U9Zwh7hQgb4ZfgcSD/YTNMOb8+xg=;
        b=cSx80sPEaWt/Pzdm7BQUV6QitgC1KNXtq41RuMxIcwten1ylU2xtQlWYjFreDdyIfD
         Gk9OyShQtR6yWO36KnUnGm7wIz6Rw73niFUMxDZXXs6/aA/ulEpLIUsePOAhvPhudLnY
         j0HuABPpcJGPTmsqUj9pD3N4jCi36C306tnJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376033; x=1795980833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GcOQVzEiETB4OL7U9Zwh7hQgb4ZfgcSD/YTNMOb8+xg=;
        b=P27evV3QKBEvGMW7AUfnJCK18umKUgZ0Q36FJi2BP/zUTilY640BBIkIPTOM1SjnPG
         tRRZ59tdpF7zqUVpEebzzDuK4basqhPNIPMH5JpKTQLJet7zERdFxi2WJT+9krIR3zmM
         nU4+uKOqiTRpZhx3C9NeXCRU3JAN0JwXX9x2DZnSgRr8jb3VxjezOKgCg5dCK3Zc4qsP
         H1FlM8AejrkTv7BPHJ/DkuwqwtaMbWp5Qs9x8u9mOdGyilFp0A91uZabazUMiW5OsAdc
         VSqy9d6RRoa62Bsg0UaPJWz4b1wZmmExHPZN0KLdxtQt9xlfH8W2HJE4rS1yBeps3i05
         8vLg==
X-Gm-Message-State: APuU4Z+XbvQAisDDWCLCHHqQU4+/63gx3XN637nszu2eoJdiMd1GuJ9Y
	2upIbI3VnyG8gHI8XjnSLXGwes/3cpqSI58CM2NXk1oJub7T96q1Hf4pkW/lPvhzARcR2+uvNvC
	95U3F
X-Gm-Gg: AZFdTZcq2cPczpw23QeZx7aybhFLWbHFO7rE1rM8jJ90KV6hvr4WNPjWVwNhtAIdhcu
	7GmwHl6U19QgW7rrJNS7jn3yiyo/BT3UTKbx11Kh9Ictd1pYncypYK2sqnCZYvT0jeQx4V0t922
	SAPqW8TQ5obZmAiJ5sX6/hlc1tJue4ufPvHAUIZjk6RTkkj+e/HSoQDUwKjSA2Jsr8fVoWltNi5
	QNLSsvduednNICQ8/vkpzXK4d3yaEwMKyLIQK17J4/m+LUxdO6unXuTDJrVSyfhBilxMc/tHy3Q
	+r6sX32PbC4yQOuJirpOKJkb2I2vBjiajSv4xzADvLJiJNR6zCzv9Bs+sp8punTsO9OaMKckTnt
	z/eYf4bZBG+IyhV7gjOiwuCrwvQnJ4nJ8bdxok+aleuudRa9MvSegeVbHeCvCgI2ajk+KyfkPNr
	XGIHu531xJAKKQQ7P10CmtuMYy/dWq0xPYjcHXgcEGT/h0WxgRPKDy/HVR69EtOO3wYaVkRBo3m
	XzG5j8F7Re9O9fe4gigq4y1zoqJC9qz8/2V41WhEwFJjZo2CIl1hcn/YUqdvVog2BSjhXfjRzfH
	slDVKgCQpk2uZR5PKlj96c3Drtxc5igNWZnNDiVUUQFNJVEOSkx2h0nNiI2jfKQRUDoVz7M=
X-Received: by 2002:a05:600c:4e4c:b0:4b6:5dac:b61e with SMTP id 5b1f17b1804b1-4bb88938d2dmr178496145e9.32.1795376033032;
        Sun, 22 Nov 2026 11:33:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:f8cf:a1d9:90ed:c978])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm223759655e9.0.2026.11.22.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:33:52 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
Date: Sun, 22 Nov 2026 20:33:44 +0100
Message-ID: <20261122193347.2366500-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

bt_bap_remove_pac() looked for the PAC in the sink, source and broadcast
source lists only, so a broadcast sink PAC stayed in broadcast_sinks
after its endpoint was freed. When the endpoint owner goes away, like
WirePlumber restarting, the next BIGInfo matches the stale PAC and
bluetoothd crashes:

  pac_bcast_config (endpoint=<freed>) at profiles/audio/media.c
  pac_config () at profiles/audio/media.c
  bap_bcast_config () at src/shared/bap.c
  bt_bap_stream_config () at src/shared/bap.c
  create_stream_for_bis () at profiles/audio/bap.c
  bis_handler () at profiles/audio/bap.c
  bt_bap_parse_base () at src/shared/bap.c
  big_info_report_cb () at profiles/audio/bap.c

Fixes: d49ea14f70da ("shared/bap: Add support for BAP broadcast sink")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc28de52..9404bddba 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4864,6 +4864,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sinks, NULL, pac))
+		goto found;
+
 	return false;
 
 found:

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349168;
	b=wy53wDyfpKeupnceB6t/WBYv/TRD/bgFVGvVFvsptn1Jmp0SVXb6jyKAsNA0ZsWgI1+q
	 2SctvL3AluOcDakEdQubxOTPjBlm+Yey8gI7BMjwLacxfzgQEI2MfmRBcWKeHfMYuG6Vk
	 sNr5Mnov6XacBMScD+x6ipbkYZo2qaZgNT3Hol+12CjJw+qYgBC4gPPX8fka+tVMkWPz0
	 0iVi+1mtU7E7yWj9BubG6iQdWF2FZ5Ea1SK54Nl43RL/ZxB3TXlKRmSs5ZNeSVLRfulhg
	 1QkoAIukCkgbEUZF5tM1CcU94WJoTb/6zvQRIyFtxKjPoXQ57nPVY7S7PmL5FBk/ehQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qIYiuWOFD4U5Qe/QHiZ+PsI4+5+Ue0OA5XRL4OVzy78=;
	b=jrGzpRa02bODSiQd4D0NPzPfyQdM4b0p+jnauXSDh9URcD4aLnezrAiUV1N8CNbOdHoY
	 ULSM+BDu9d5TxX0a0SZL2RMl4hsGmLLW+aiphk6ZMSY8+ry3LfuON0QUqgvKmGuZXEGWM
	 QMxhs43BO1GOjS861m49bqHW6j+nrWUv3BeaHcg/TQAsYsT4xI5l09Hfdn5KVblhCqxsm
	 kbxB8lI3gEASXeVQKNxFLyqDyrtaYtcjK+ys710XXB9M6kb3RY3MlYt9Lft9wWPNfTsMZ
	 LirFLkSWrHVFVjL3TCN01OYXZFUf+lwYzVVrYLSjEhS4nVIcVV/oN4MzN7cR5OF7mFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RONaIPmw;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D9606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 991D9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RONaIPmw
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eac7220e9cso938436e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349167; x=1794953967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qIYiuWOFD4U5Qe/QHiZ+PsI4+5+Ue0OA5XRL4OVzy78=;
        b=RONaIPmwaIgPeA9FYqD5grK5zF+KQxN7InmHna5I4GpOVnTlg916DlOn9puoS4lKAo
         5RZTmQPXmAGGFdLIkYZo6MdBvXFIkxNoLn4S+PBTD2BEWV8OFnRN2h9ObmTDH5tzVv1R
         LjuG8F/GKFt/9bdgjJmq4MUyG/R7K13JmX9gYIIYAxTrdt8kUISlqTkP2MA5G8H/onp/
         NOYDV3+gjMCphcwtoHnxClDQa5tsVXsk839w1Pa4viPRe8i6Ml1LvfPcrUbd9WUYwqYE
         8rVhQtnVuElTY/xCP6Gxt8mIU0G/T95kB1M3vqhyNjEi1zSDGZ2duZfIvfHiLKkyLWIr
         MI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349167; x=1794953967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qIYiuWOFD4U5Qe/QHiZ+PsI4+5+Ue0OA5XRL4OVzy78=;
        b=jD+ISX90WYoKSJdAeo1JTjE8TN5QEetYJ3idkzXMDvJeNLdX86ftE9/Pa0zCldvpic
         YaJ/w5vSYHuIMWcI9QQCdF9y6/pRqClcZlJHmvCErhbWjvC1Efj1ugKKtcvDwYK5ws8e
         RrwG2dhWdIMTBLMty0d3bLBziTWL3G8tq0Zlj+BbXz5z8VsJWUqQN44QwYN85MLFiqM5
         Dt3DAOUWCKO8jD6F20i0v2/YlIMMEQApjNGLF3TkVdL2XkJvmBj14EXD9hEJlQ3dW4K+
         VujPB6toBffJ6Xf3xQy/CflmDlYTw9x41V1aTLsRblf5vOfSgkLTVtKx25SyKvSYFh+j
         HLPw==
X-Gm-Message-State: APuU4Z/UarMcX4SOH03ogVU0jzVHqprim/5KN9057Lti5OMmYXvgpyP/
	opXHtRQEqSIgYC264J8ZbMEHCayMWcpyS5hhefvLQdc9Hj28Ex6NXHcR1SA7nA==
X-Gm-Gg: AYBFou3VFHM8m5ljG6UFpZ2FSht60A4m4sqYEE1I2oHnurNvlq0VMnkCJG4+OH9jhFh
	3JRLjOOyi5ZIc3MZKXlGTqMn/u4a+VXu1Kcd1xWUgCtMUwXT0u281pij29t+UUci1iPVGsvyO+g
	PG35o37CLFNqfL7gIIlYViyFCZXjf/aP8ZqWkamjIDMcniaMq89zwry1Hbd9be4Y1Haf5ChTZFN
	eUG+ekE7X2IIi1JDDxCB7kU/Kn+lGsjGInMz3N23olYfTNEP3i+oPN4NBEm3ya832JfMesnbvc8
	5rw7LVXW1d3XNeQJtxfXvIrC6nRKgofILbn4LE1hcI8Phn9BdU60rNYl7k2J7LpA50FzM0brnS3
	I7VEChJNj26cS+F6jsykLwfjc8ask38CbzPP8NHyuRJpneCrXeur2XRVAPeubP++PHlHdEW+iXw
	A/StqyQ08JwrTZ75C+GbVHSo2qWFlnWNT6Gvgn/HxQLWh51wnSxIwK48y9gZcup4o2Loaq2pc0R
	K0G2mFZIC++iqwR+rhs5RoFOLTl2kbhwicVJw0FuLmhLGeuMpXmK8oNXrm+0b/1oLH0pTuNyWG+
	S9lCJD2xzDkouG0HkqnAhzrvuRAuUW7fr1y60X7urzy6KTpINcCjCJHvl9gZmKZ7n2wowIELdaU
	yHHev6AQFxITd1Kc+gN5z0PQud/1h8b26xmAG7S3lm9asg9Xnxdkg1EfoHj7hrsmoBeVpNDJS3S
	emZoY=
X-Received: by 2002:a05:6122:2909:b0:5e4:f6c8:b0a5 with SMTP id 71dfb90a1353d-5ee1bf422eamr149897e0c.0.1794349167454;
        Tue, 10 Nov 2026 14:19:27 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/5] bap: Release cached ASEs on ClearConfiguration of an endpoint
Date: Tue, 10 Nov 2026 17:19:05 -0500
Message-ID: <febc3a723377599d9cc60b8aba5584b104259583.1794348982.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794348982.git.luiz.von.dentz@intel.com>
References: <cover.1794348982.git.luiz.von.dentz@intel.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once a stream is released, the server may cache the codec configuration
of its ASE, leaving it in Codec Configured state, while the setup of
the stream is freed. ClearConfiguration only closed the streams that
have a setup, so it could not release such an ASE anymore.

When ClearConfiguration is given the path of the endpoint, also release
its streams in Codec Configured state that have no setup, as a client
may release an ASE in that state (ASCS Table 3.2, BAP 5.6.6).

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a0e0ba60d817..34aed93d8414 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1319,6 +1319,27 @@ static void clear_configuration_cb(int count, void *user_data)
 	free(data);
 }
 
+static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
+					struct bt_bap_stream *stream);
+
+static void ep_release_cached(struct bt_bap_stream *stream, void *user_data)
+{
+	struct bap_ep *ep = user_data;
+
+	/* The server may have cached the codec configuration of a released
+	 * ASE, which has no setup anymore, so release it again.
+	 */
+	if (bt_bap_stream_get_rpac(stream) != ep->rpac ||
+			bt_bap_stream_get_state(stream) !=
+					BT_BAP_STREAM_STATE_CONFIG ||
+			bap_find_setup_by_stream(ep->data, stream))
+		return;
+
+	DBG("stream %p", stream);
+
+	bt_bap_stream_release(stream, NULL, NULL);
+}
+
 static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -1338,6 +1359,10 @@ static DBusMessage *clear_configuration(DBusConnection *conn, DBusMessage *msg,
 	cbdata->all = (path == NULL);
 
 	DBG("%p %s %s", cbdata, ep->path, path ? path : "NULL");
+
+	if (!path && ep->rpac)
+		bt_bap_foreach_stream(ep->data->bap, ep_release_cached, ep);
+
 	ep_close(ep, path, clear_configuration_cb, cbdata);
 	return NULL;
 }
-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684036;
	b=vlEBoFtwry785aQJv68IhHB/lgLxp8vpp0FKKzZlQ/Iax9tNjVmIwO11tOYzkaJzpcYg
	 mRTh+lyJhwtYPNazF4cXxmyNUJv9Z82hjlHbwRx2SsNDMSgjbIYl78IQgkI5dzNuNdInv
	 KW/6OmCWWLzrsOv36t90KDzbJJZVHOiIgq1X57+Y5R8jzObzGAqKxTvWHacHjQVx3TIhG
	 afEhRHebL4zF0MNHSG4gt9zCOCi0GPeix/rO45kT46sBLepeTbROWFwibJJ/tph6viC9O
	 Fy+Lg8OMi9LLJhwkYm/NjJEJlFpj/VEANKG9zGZBlyoJsVouXwU6Y3sO9tFixWFXwTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684036;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bhcweexgak3544lB5+7N7WheOmEaTIpXGl6CqgMCKDY=;
	b=4az5pppK5752Pn6tXhdvSXrbsAxjezIgVXMDvWU8Svd0dHHBShuOePjkpBuC3wKmqEDV
	 RYOXy31ZiAySgaJZLsS6EJTBpUNEKVikAdTECZxrmrZI5NNMaSNTgXNmz6tC5QnnjiIEo
	 Uw+ciDpnMy3cfYpr24n5PEmWE1f8/3aKKN3hC5gV6RrPFbnmgW9fPctOglH14IusSdzfz
	 h4PjRR094QHONchk8mBNS75A5qs972mS1gRagdlOIemXJWwK8RzW3Ah8WlyerUOWCp6wc
	 zvPyeRn7NZ7zBbqnfaJ2T7/kvN3nrCi/nIv2blDCqGdqzFRQU0WAzK3Obv1oQXSXp3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eKzZRKS2;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C2606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eKzZRKS2
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so9242e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684035; x=1793288835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bhcweexgak3544lB5+7N7WheOmEaTIpXGl6CqgMCKDY=;
        b=eKzZRKS2sPeFuLlCWlvlkAZMK0Clovv0aXNoN4LxcXFcBeT/RNcPDlwsIMWvg0U763
         CAMCHrvk0x7TPXqgnD25wOYI4mr8hqZ4Wm8Vsrzkgr0ceNqd1tfwTa4g16tGuho+yrZ7
         V4Kz4De+6wjEXYmRjvr6H0J7RWJdDX9PR1u2eQ0qI+01qGloGT9a6e/Q7yVrBnDofBnj
         7yZOBTQLvuPl4xfWbtOUnnStK0x5qsWRyD0UW27tyVACBzMDDG5i+1+h0LMCiZNFPbCk
         Q9ZJG7vUWBEDjFZfmGJlrF5L3vmh8lM30DwP66Ky7W+kvwiOZyK7Dpp3KWxGLjuBwVrX
         iCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684035; x=1793288835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bhcweexgak3544lB5+7N7WheOmEaTIpXGl6CqgMCKDY=;
        b=LxRPnDm3kEKgPEa0e8LBUiF4FTMSng0hGXLkt3IR6YMT6Jz70MHfxJYPA0BVXjzDHF
         r42G+IE6k1C+nfR/f1hZfor+weeXU0yYzj3tOp2bGoASX0ZgrYDc5Zf/4NmHjZJ3xkcY
         ahYV35aZ3Ey7p8LNa9XOr3W/rx4KtOFHQDeQgqmgwGgr0wYe7ja5uCB6IEFK9Im7TBT2
         A9G0fUhT5l1KQp/OWUJ/BT6SIpXf/IPluFbwjkz7SUEAiLyroxXskQ8PuqCkN11DHLkC
         diQtmHpYlTZWvulHsvkRHMQHZvgKLyY0IPaARZ482PwbRQmqRZsJeV95A899LBKDZeAi
         Ngnw==
X-Gm-Message-State: AFq9FYJKN5UK22ExuXnGYmU9O69tQa6bPsLIIBvVEaUes6CFnTFCIV4I
	gRw6TQyHLwQuVw/rsNWW298Dc77xg8kzNLCepvGUwitoDS/9s3SrqcG1+SlUO3kdzn4=
X-Gm-Gg: AYBFou3qVEcJ0tgRdbLMMNewDEenJ51B5CTNK8E0Li/63MoeVej4Q3tN0pqi9T4iUAX
	YQTk+9XoFaXZQpuUazUL4/l4phaWbhwp1yj9K1+NRhxmIu47Xlix8NdTfYNwz6BjUeftebQ5H1v
	PIpRMZ10MD5+DOP793PdEF26dGqVJtWvGzQ7p5k26BnUstArO1j0HMmGkBiJjR1e7Ath3btK92e
	p5YokO1fcQm5XMEz9UlUXOUgB6vDlHSzi1W77hQE1uxN6exNxg6aufwDHJbLmFs5tsu3OOuTg6y
	IU7QUOpfg+qRHyBZm6V1LL1tIVVWIGQ/38CHULFgF+14eb9cIvu3Ea/7OsUXDchB6vGOIVQlpMh
	Zi67O6hqPmPNtHL5MkdA6PaETGitZojN7ghBJDxrep25XU6CQgdziLsP+fClxZnXadjhRmc/4Wj
	hbOLg29G+vJSiaPqR1ZA6abLqMXKniX3C9P2MlQuotgoxIQPJzya9jhWHvI6F/X5snI+LVchRM+
	/RN4scMqTJ+yr6MCk1DFpoDPygVOSHjQwEG30uomnxIA7hc2fD/jsJ7vHcKUFM4Uh080hmeED2r
	kxQ/U2zxR5N2JLOrfK2+tVLkkVcmGseQS4hKWWsERvUTAQ==
X-Received: by 2002:a05:6122:6212:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5eaebdae65fmr2405903e0c.4.1792684035464;
        Thu, 22 Oct 2026 08:47:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:15 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 06/27] iso-tester: Fix busy waiting in PAST tests
Date: Thu, 22 Oct 2026 11:46:39 -0400
Message-ID: <20261022154701.3959500-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
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

iso_pollout() kept its watch while the connection to the PAST receiver
was missing, but the socket is writable all along, so the main loop was
woken up until the connection was established. Under User Mode Linux
time travel, where computing takes no simulated time, the PAST Info
tests took about 400 seconds each.

Drop the watch instead and send from iso_new_conn() once the connection
is there.

Assisted-by: Claude:claude-opus-5-5
---
 tools/iso-tester.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index d610b3c32c51..7149232d17f4 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -471,6 +471,7 @@ struct test_data {
 	uint16_t handle;
 	uint16_t acl_handle;
 	struct queue *io_queue;
+	GIOChannel *past_io;
 	unsigned int io_id[4];
 	uint8_t client_num;
 	int step;
@@ -712,6 +713,11 @@ static void test_post_teardown(const void *test_data)
 	if (data->io_queue)
 		queue_remove_all(data->io_queue, NULL, NULL, io_free);
 
+	if (data->past_io) {
+		g_io_channel_unref(data->past_io);
+		data->past_io = NULL;
+	}
+
 	/* Remove the watches with the test, as the sockets they keep open
 	 * hang up once the controller is removed, which would wake up the
 	 * main loop over and over for the following tests.
@@ -1716,6 +1722,8 @@ static void bthost_iso_disconnected(void *user_data)
 	data->handle = 0x0000;
 }
 
+static void iso_send(struct test_data *data, GIOChannel *io);
+
 static void iso_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
@@ -1727,6 +1735,12 @@ static void iso_new_conn(uint16_t handle, void *user_data)
 
 	data->handle = handle;
 
+	if (data->past_io) {
+		iso_send(data, data->past_io);
+		g_io_channel_unref(data->past_io);
+		data->past_io = NULL;
+	}
+
 	host = hciemu_client_get_host(data->hciemu);
 	bthost_add_iso_hook(host, data->handle, bthost_recv_data, data,
 				bthost_iso_disconnected);
@@ -2703,11 +2717,16 @@ static gboolean iso_pollout(GIOChannel *io, GIOCondition cond,
 	const struct iso_client_data *isodata = data->test_data;
 	unsigned int count;
 
-	if (isodata->past && !data->handle)
-		return TRUE;
-
 	data->io_id[0] = 0;
 
+	/* Send once the connection to the PAST receiver is there, see
+	 * iso_new_conn(), rather than waking up for good until then.
+	 */
+	if (isodata->past && !data->handle) {
+		data->past_io = g_io_channel_ref(io);
+		return FALSE;
+	}
+
 	tester_print("POLLOUT event received");
 
 	for (count = 0; count < isodata->repeat_send_pre_ts; ++count)
-- 
2.56.0


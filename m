Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532968;
	b=rvmC6HRLeFiDmwDr395upf7ZArQzgkSR0JE7q4x3MwGHWwoT5zqpC/7uMi9Lw2X1hv8E
	 52xobhFtrThMcCaNhXpeBIiKRSOTAM7s4OoOdOqz8KrJcFLCtXMVRTbgLs0P0z2ZmnlwQ
	 fNt51yDnGCIhiWQRViwkcYh0W+8gfdma8GNrKuGUmI0e8K4eng0n0kT6+2vk9p6gOMdeh
	 g7n5eP2uCQMXryfChi8URmLQst8KvDbbK8UpjIPx17zSC+fvfoNyaD3wPxJ0EC7NQvZge
	 ONXL3+L3Cde6+ihsLp2CA3ESplbQSZPJ4PbK4h4MSXAPifzDkLjth83zQx0gpYzOiWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lw7EwILrYM4gyPtbdBjKrm298UEcX0uSOl8gJaShjQw=;
	b=Sp6XQwfxuj65By8YTFEm2IMwpQo8UOeBWP89JfDF1Trz+ookadRwFHhG46VKwEPMsquG
	 m2qGmpT6PwlXKnjwVuuX0SIPADfdaBhAJiAHNOEzS8sF9LTdyvm68pR/47k3ZHYVB0pUc
	 sVbrUn9ShoJGgrKAzo/E7SChQiblfQsWDlOCgsM4ozIiGTW1HIPlvfkrahvX1rnC9X4n1
	 tg4rSTULHo4zznEAtpV131ESlLqO/G/YfB164dDX3SnK5ZBTnpHlmt2MB/YyU+N/VJAX1
	 XQe3iu5QXPwQGUWDFMJgVw54J89n9JzyiK1C3jnkBpm3MT5TIXAuR/jZCEyNXjdQ9gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qz3LVCVy;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EF6606A333
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3EF6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=qz3LVCVy
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so42582955e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795532966; x=1796137766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lw7EwILrYM4gyPtbdBjKrm298UEcX0uSOl8gJaShjQw=;
        b=qz3LVCVynxnia2M8k7A/R9nRyiOGtjFy9kuevdsvY9C/1UqlSJ+Xk25hzAhNw80kTi
         xU1+djMWVhLafwyeMsqQ69FWw9bxN1gKptkZlX6gIq5eOSd84kVOp7tUPwizoY93BCpf
         6IvPm+LMV+F+UcAIJDm3+aKS8g2KjwMm4ymdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532966; x=1796137766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lw7EwILrYM4gyPtbdBjKrm298UEcX0uSOl8gJaShjQw=;
        b=Nqj8X+oFYf3QwOESSp/R4dy+l+ywC1ZvMguDHqeyJP1VMBDLB2/bFgZYEgYDOQJLVw
         CY4i1+NxLHwexq5O7LLFDmGVTGAefWAnzr5SZxEbj1jcHlwF3ylLguxydEpMLvgH2IEA
         A1JmaKu8zNR+zFodbcYRxxbABCZvrfOPKSPcH0XvcWHelbGr20fSjwK+M+XrjD4PBcsI
         G6Hte1wVWjZejCPm5uNmuqRtk3UjrsIJNMHVQi0c0/OGZ1GpAsi6TNBlw0Z/1cyAaSrs
         BdXYf6GhgNjgoa7Tfq98yT7Da3qxyrvROvewFvcU2DKXWkqg2tmVWWgokDaSJB66vTcS
         zM0w==
X-Gm-Message-State: APuU4Z/9NGwFk46nFNmNZ1sBG4jpVQ50FF4o1Gg7oh2xtuHEpXDrbEAm
	VEaJuR7oQO8Xs216gJXi2PR5FNhHYaYmXe/cH/M2li6Ztzhd1BELBm9TQ9fCaU2qFyCXU5Rr5Qq
	trIDU
X-Gm-Gg: AZFdTZcx58NYG1XtPy1w90ALlDFk/nqamMS7AnQrh6umfiLY+vP5yQecg2yvgWV5p1A
	XKxhMn8tmY4BCq4EO+Dp1ks7FNvC/7cugEMux2a9BT758uMtHbaDPte05y+XlgmHQF5VqwLnuRp
	P5HJKOtp7kWSqVAWFHFLHOmtbL26ShziT2F9XSNURdzZ8EVMphNosjMZUdmE9Ugw1VWUCwSKkwU
	LaPbJg8Z8lL9xJ46aLE1GDZkZpbyDPSaTBavomQjZoOuFf1xtoh5Bn8Fl44MFt9NbEO9ELCOXxP
	IQd+BpVEmQ1xAbGx9lWzl4p/TVZrHNiaTvjYjMaQ3DDVXrZJVDPowDRc1zDQ9qOeo87kKzCz358
	MtMeIFhR8gktKE31L25X+7lXlaFE7nZWZbJ7jZfToI11hrcGlVaikn8t8QYeCnsdTrF6SxTwt81
	VFupsBnm8l+JO0iz82wNvSh5mCeThNNMODFduDzKKnedRaEHCJfRt3yVnqFG1NLKZcVI1kywBr3
	rFcQfgB16N6qrtfXsTFpH7v5ZHYgM7PmtpJOO61TTT7ZwZGyCKuvfwc97VbmrAt9PwE9NMj5sz2
	Ooww0ZPjClt+rpVnB7yjiaDYM36+RXkBjWmRUl6jwAWxn7rZYA==
X-Received: by 2002:a05:600c:638f:b0:4bb:7581:2bb9 with SMTP id 5b1f17b1804b1-4bb8892692dmr267158845e9.22.1795532966350;
        Tue, 24 Nov 2026 07:09:26 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm402731955e9.8.2026.11.24.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:09:26 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 4/4] bap: Close a pending PA or BIG sync when a sink session ends
Date: Tue, 24 Nov 2026 16:09:22 +0100
Message-ID: <20261124150922.341655-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
References: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
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

bap_bcast_disconnect() frees the broadcast sink setups, but listen_io
stays open with a callback on one of them, and so does the watch of a
PA sync waiting for BIGInfo, which is on the accepted channel rather
than on listen_io. A PA or BIG sync that completes after the session
ended crashes bluetoothd:

    #4  iso_do_big_sync (io=0xaaaad1ab3a30, user_data=0xaaaad1a87110)
        at profiles/audio/bap.c:3689
    #5  server_cb (io=0xaaaad1aabd30, cond=<optimized out>,
        user_data=0xaaaad1ad1310) at btio/btio.c:285

Remove the watch and close listen_io before freeing the setups, and
release a PA sync kept for a stream to be enabled. iso_do_big_sync()
now clears io_id, so later cleanup does not remove an expired source.

Fixes: feb4ee9dcd4b ("bap: Fix use-after-free in broadcast sink cleanup")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/bap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9a456f45b..eff621762 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3957,6 +3957,8 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 	struct bt_iso_qos qos;
 	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
+	data->io_id = 0;
+
 	DBG("BIG info received, do BIG sync");
 
 	if (data->listen_io != io) {
@@ -4294,6 +4296,24 @@ static int bap_bcast_disconnect(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return -EINVAL;
 	}
+
+	/* A pending PA or BIG sync calls back with one of the setups freed
+	 * below, and a PA sync kept for them is of no use any more: close
+	 * both.
+	 */
+	if (data->io_id) {
+		g_source_remove(data->io_id);
+		data->io_id = 0;
+	}
+
+	pa_sync_release(data);
+
+	if (data->listen_io) {
+		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+		g_io_channel_unref(data->listen_io);
+		data->listen_io = NULL;
+	}
+
 	/* Clean up broadcast sinks before detach (like unicast does) */
 	if (data->bcast_snks) {
 		bcast_snks = data->bcast_snks;
-- 
2.43.0


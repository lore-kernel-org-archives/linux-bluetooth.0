Received: from outbound.st.icloud.com (st-2003l-snip4-11.eps.apple.com [57.103.77.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A5A547066
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649793; cv=none; b=jjObCX3YnAKKIsEnImSTC8ej2sjwoU45k3axjpewZnFe1RwtKPTHUWOsTimgfhND5/lLbdw8QP7gn9Y7FCR8LFk/jC2bsImZsidhhmDRnDY8qcxjlTzrkSGGlfTFKgV5CScxW9WLyviEzjwV1/oRDaHFcihXxnOYMXfiWnVmQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649793; c=relaxed/simple;
	bh=RffSBG0mDyYwLpKscZBXWhJAUMyCF3oW2SWtRGkawQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmSIU9Bp25mOCKKn6qicCMVusSxp7Eldhg5Awt0D9sJDjmFWHKbYpDPjMtEGrj9b4zpXGV2aeAB+0xkURRfQi8sPdhFeDIqFLk2sDdc5NCogbQ3lgx3K66ptKdYleCr/Z4vNReLsMRjLtMwXfDEsrc8ijTBffQ/Xsjp24iBWuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=Kkj/S/N1; arc=none smtp.client-ip=57.103.77.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Kkj/S/N1"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id EAA7B180023A;
	Tue, 29 Sep 2026 02:43:08 +0000 (UTC)
X-ICL-RepId: 01a0eb0b-6995-7bd9-94e1-7cb2af8176bd
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhPBkMFWgNeAUgdVQRLVxQEEl4eWgwDMFQdHQ5YBhIWXUVeCBkIXR0ZClBQBUtaFVUXDgJCH1AfTBZXQ0QfHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgZXXloXXk1aAlZNBUoDXwFbC0IASAFZBFsAXgpBBFoFXwRdCFVZAEQGVUF5FVZDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790649791; x=1793241791; bh=aUaYfWcZdNeOwkvhvJKoWQC92dTu8OSHU4r6yCFMrLk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Kkj/S/N14fSBqCkZ2omCq3csTYMDgDruMg8PZkUtXJrly3aJKBN9AMt4OrY+dOCcU7+cL47Xitbnq/S7VKJ5SZ7LY6NHl9hURVvwPDbEbiNHXA4P/N4t7t784zEbEXvptMOzkVLhaa6UacOhwqub72Xt2D0htbrKEryCmpv4QWc9fjFWQlUD88WUrzfkLgHdhIwtNM0UEmPbRGWiluX8ObpbaRyNGLe47fCwehPX2T87cpdGM7zoRVGH3CraIUeKkxOlTIDVqH47/v3XTkVgnhyDwOGqivc9w/3sJjnzu1i1iYl5Q388oYVQhBqUlVkGy/teaR/fsQyJcjFD+TjC+A==
Received: from seonggoc (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 36B7418000BC;
	Tue, 29 Sep 2026 02:43:07 +0000 (UTC)
From: Seonggon Cho <jmsmg1@me.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seonggon Cho <jmsmg1@me.com>
Subject: [PATCH BlueZ] mpris-proxy: Line-buffer stdout
Date: Tue, 29 Sep 2026 02:43:02 +0000
Message-ID: <20260929024302.3977246-1-jmsmg1@me.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: t0gPlMRSXMMC7P-2muZHrzn6E1mJO7vi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMCBTYWx0ZWRfX9w0IsHOYFXVZ
 JwfZG/eWR/jbC2b8/VbDSloyDtbIkTCy4h4psG/XMV+QErboFvPmKoPejA5RGDDxX7cJOt367wU
 M6vpuIF9VDjekAa0NglXrwA9m+OxMQCySl8X3myENeKFnU/WDBvl2gNgMx1U2RTJbwRw6ddLTwH
 Ht4S5vtszi5pflMvP/kWdQWNYof4woRQZj9WZE4gCOKzJTs93ltfBNQm4iliNs2nLDd2nKFM8nn
 Qi8UK/Y8tuVVhe43VG+arrPptgy12mDC3d7NzHID0mWG+j+zZg6jnBy3ijzcLD01ahWq2A3U+1J
 P7gZ4M2JkDnyRf5X09AzTvIlNOthhaEK1edacEO5N0PPtWZ4b3uYjZLTs0IJhk=
X-Authority-Info-Out: v=2.4 cv=P883RyAu c=1 sm=1 tr=0 ts=6abb25bd
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=f7IdgyKtn90A:10
 a=x7bEGLp0ZPQA:10 a=_XrXW31pRgsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HoQ4qfohMmCRy--Nq4UA:9
X-Proofpoint-ORIG-GUID: t0gPlMRSXMMC7P-2muZHrzn6E1mJO7vi
X-JNJ: AAAAAAABmNRTNLlsZI6qtUEQb+IBCNtp5l1RHHThaP+b2w+j/xcfFce89EATIVPOI9ZyIKAuAmXM+1wOXGSinRQhXhjCUaB06Q+SQkmceIISff0Q5L7Tng/cQCG6HMoRmrD4boBDUTvsu8DtUNskKxVzboo0UCL6tUMR7oHFxIu9x9CBSmFWQlFgbdZbUohErs91+01NpdhpS9P4FzRvQlI5Wy/m3Zcww+q7Qdf6i/oHjVKdTVvhduuFkEtdg9NcH4IqyHkrSRzM/fUoZcdd+NUTS6G9mUvkVa+KRV/2DEd4aZtqhb4hf29UVxnlIDH3ydm9Gx9qiislfrZ6ftrZwCNZ74cM63XGZtvib4tR3P6XhEhjMtnMfNiyrg+GgfzADi2QaC79NN2q8CZKxKdMwShIVt9ICstXBWohg+V0pj6yNTZICqNqyB+nQse5h9k94uTQziVCFsFkcmjKpUDh/5JvZW6nu3pV7F/bqN9LwVDYyT2HA2AvRj4b9Hk49LJKY5OvPxOxH4C0Yut/z5+Ms6eQlVo9JRXL3FBErssp0Tp94BaahlH6WQ7LTNW/d588SwFm00Rsj0FmIhtCUp5eDd2RsFDWtfRZaDLbkDEKBnbZ5dptJnW3z2OBTG2E1OPVTRhqqclzpXLxo+RNCSPo/ntNDZN7PZ5iHb34J/vYaa5nyxUBwwxwWzYUyj4FxBfsPUKw9BXRitYY8c/Y/yjmkK/WRm4L0WC1qejMZ/DSur0IS7fcd3DQCz5nnEE2xaY2AMYYGZdh1FS3LneO+9f56oyJIP20Cr1oAyH8AxjtV+Z+F1RBpgiafKsE5eEegoD4fuUI9g84JhqBmL9rXpIoJziwZEWm8Jak+sYpJmxQDY4JxlSmVxSN2trFUS1qYkO85QGzxsl9tA1exwaTJcyM/ZKfUgnSAUjGdXHT1IE/zReDGjWJl2EKSPDETA3VtWTNZ4ErUI2YFbScMI2Z8DM8+Ie/jypwtmh
 EiL6ExSWBYN5uJFaBIHW6Pgj5ac42CnTyOMyqjsjZk2iJzNSYq/Lb4yRkE1/SIQTC5iWRo3DFR7ENi0rr4+Tx7ZnUbwmMUPsqh4LvIst8+Yyx0FTIbFMS/NH2K8lDvzK+rIJ1XA2R03xAsYlypmh6UjT9XVT+DYVKJkhJnKXPr1plKxB91IBN4Q==
X-Apple-Category-Label: MTE0MjA1MDkwNTokY2F0ZWdvcnkkX1BlcnNvbmFsLA==

mpris-proxy reports adapter and player changes with printf() but never
flushes stdout. When it runs as a service (tools/mpris-proxy.service)
stdout is a pipe to the journal, so glibc fully buffers it and nothing
is written until 4 KiB have accumulated or the process exits.

On a system whose Bluetooth adapter went away and came back every two
minutes, the "Bluetooth Adapter /org/bluez/hci0 removed" and "... found"
messages reached the journal in bursts of exactly 100 lines (about
4096 bytes), all carrying the timestamp of the flush rather than of the
event, i.e. up to about 80 minutes late.

Set stdout to line buffered at startup, as bt_shell_init() already does,
so every message reaches the journal with an accurate timestamp.

Assisted-by: Claude:claude-fable-5-1
---
 tools/mpris-proxy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 1d7a421e9..4a8dd71e2 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2954,6 +2954,10 @@ int main(int argc, char *argv[])
 	guint owner_watch, properties_watch, signal_watch;
 	struct sigaction sa;
 
+	/* stdout is a pipe to the journal when running as a service, so make
+	 * it line buffered to get the messages out as they happen. */
+	setlinebuf(stdout);
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
-- 
2.55.0


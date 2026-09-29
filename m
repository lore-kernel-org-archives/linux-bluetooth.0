Received: from outbound.st.icloud.com (st-2001g-snip4-1.eps.apple.com [57.103.76.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA531B80E
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649943; cv=none; b=O/YGtJuDM5Y3e/MBdwxfHaV47OjQIa1XxgeBmVhlUWiPO9EMhVGJZ89Zs8vwbxg2ojiD+oVXuaQv14lX54GFoha5XIlcXBhw1+XAL5DLe8J26ZE1tRwykI+kZ4e/6HUe2F0BJ4jUv31EYKl1ZTtCCHExsDTJv+2vnll0oMXh/Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649943; c=relaxed/simple;
	bh=ZhdaJFWb9Tob1xfnz1dBOIsDXXlQihLw9Hm54WwZeNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjP036SQYVZoHgSBbVHSP+LOLnCxA5vq8jqb91qe0c3TXaJ8WmO/AwdkuT+nbbr9f+wAiqYE095qJzi/dceq5opmjTB528BlHI5jHsn+dw3ZWuk+Gain+l+Ep1eLqA7BjJ7/oxmMcOu5ojQ+3lHsNXH/5fwreV2qcXRZRLj4URI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=JrDAezvH; arc=none smtp.client-ip=57.103.76.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="JrDAezvH"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPS id 57ABA18000B5;
	Tue, 29 Sep 2026 02:45:39 +0000 (UTC)
X-ICL-RepId: 01a0eb0d-b559-70c5-9144-eaebaa6315a0
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhPBkMFWgNeAUgdVQRLVxQEEl4eWgwDMFQdHQ5YBhIWXUVeCBkIXR0ZClBQBUtaFVUXDgJCH1AfTBZXQ0QfHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgZXXloXXk1aAlZNBUoDXwFbC0IASAFZAlgCXgpBBFUHUgddCFVZAEQGVUF5FVZDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790649941; x=1793241941; bh=7adektT3otfk8mKS+KFhV/hvimTTspqmO9gLj+ZxTgY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=JrDAezvHOPnEM7xUAhaDXgLhlSq7AUV0Gj5Lbv6Gwl155GcfQxA4o/KW493WpKZpvAl6dKkAFjvv8drYVpOU9Mp2dUD6aUcSqUzZDTgGmNGK1Ckt+wyFzIgbe5iFSJJNqlHFfQY0HLLQjVGK5GQ9mVunBRupDIaolH76MFYRo3JmRcss751PPL9QSonvUrF4AAXUkkjtvBoyIHP8QMV/pPsFgKImvJwkjcDA48hIGfGr/Ngm6eiNiMo1I3uGmGbY0LmglnWJFUQ+p0QBE2PgZuwGJQ3Y7Aof8WgPvPv/+LbbqzPpV8VYCZzhx59LHAht9Sff111CqgYfseUIN1/QSg==
Received: from seonggoc (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-8 (Postfix) with ESMTPSA id 20BBF18001C9;
	Tue, 29 Sep 2026 02:45:37 +0000 (UTC)
From: Seonggon Cho <jmsmg1@me.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seonggon Cho <jmsmg1@me.com>
Subject: [PATCH BlueZ v2] mpris-proxy: Line-buffer stdout
Date: Tue, 29 Sep 2026 02:45:30 +0000
Message-ID: <20260929024530.3978095-1-jmsmg1@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929003432.3937487-1-jmsmg1@me.com>
References: <20260929003432.3937487-1-jmsmg1@me.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMCBTYWx0ZWRfXx/wSks9AqRz8
 fcztM1qmp9BmFSsNZNqQ0vgEBKfqlyLL2uVbkjMG68lvSJBR0CEIWunQlC++gXAC5+yEkzfS4Nl
 KjkarKAtNhW4gal07F+BarckB/c4SWAaVbi+DDGAtm0d/mmdWfQEjIN2Lt27VhatUd8nISwCDcL
 dila07m+qyvsjE5RshOP1khBOwCMqbPyD3ehNBxcqRZ7I7jeZ2NgLZszmCLZYEGN4yAjZnidq2F
 UQWN3hUZG3Fxt6EJfsQwpVZKx1LHa5T3b+Zp/QJDXEoxZoh9dZGNAvNDn/1RHvdTvRKMLD2QYY9
 g1OXyrA7ETw0SSteT66VS/uEAW8IZNoHzqs44URcxzCWGr+rrIURC+BfZQurJs=
X-Authority-Info-Out: v=2.4 cv=NZXrFmD4 c=1 sm=1 tr=0 ts=6abb2653
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=f7IdgyKtn90A:10
 a=x7bEGLp0ZPQA:10 a=_XrXW31pRgsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HoQ4qfohMmCRy--Nq4UA:9
X-Proofpoint-GUID: LekFrmR2z1zY9pPI3hobXsnWYzVJ1bxx
X-Proofpoint-ORIG-GUID: LekFrmR2z1zY9pPI3hobXsnWYzVJ1bxx
X-JNJ: AAAAAAABxHu0Yjd3WjKosq+bLem8X8ks2urnbgPKfkSENZeenGcFocMcA9SribeJ04mtawFbnmJhcO+tfxJFvkH0WQ4skReW+Za4oSKmqOqyJ26rUDlnmce4gZeNH25RSGKVPEAGYP1irS3tCN8AOw6EYSvbaYOUI4siICwbYHf5MECmUz9tG15GF070Qo3jGpvMtnUuPq/FGA6S+y83geUu1q2V/rJe9BLwNLTxNVucnPDdNZhXo2st4a7bfewP2ZooWBQXl+POEJE5G9K1MJaUCviv5GpOKIWHpqP75db73J3PTGgHANlpMuDHz2MMoJfgCS54X9+Sk/C1Kb5t0kl32r4cosm8eO6mc/zk3UkduCsH9q0bJx4I1shL5iK1UJxTizam4xsb1+rdbU0PkZ21Fsi2BUlYcc+fx2ZfdMDH1HR3G0MtFy4ak8ER90BvHLVXoGOffKenXAEahtmWeyPk46XtnItb7uWGyb0gZft94ke7RZj90+XZ4WNfr/GwmaiSBuaRrzF97s0XcP04GZtl2owz0f7feCoZk84HpjxmX38Mupu64T5crKyBUMznltP6/2XfD6104MYRj2yi9fSlvua/QxrxLis2nLPQYbkI9PPXIQmKbO9YV0NsNP9vNZ9nd5QyBXpeXWg81lQRYy973c259E8CZ9Ubhgu/MaZWmY37+MAQJtT7MK+ay83vNEIvc4vHNBprgjbhCMzECImhF+zqjqD4k7j7eg5vLWfCslw/yYv6e+ukTZu14yjOaFHovmTsMMXX2F+H9IqbW7j2Ilvd6+gphtAD5PoCn80XeS+bYu1e6C1swWcwFUu2E2u2ECn2gqA4PUNkhdmJ3JMIaVZsCjfEJOWFnD6Q14dtW9IVBxWrwIT6tNI4gUXDs/tlK0j7+S+LiS/sWf8nRZCNCOPzPHzHFUWWqIXZKL0qzr3rAcpmVdmajRPPIvXKw6ldO3fAwLqgB36NqH78q+k+aLmqWvQ
 JMRwphQKWJwCW659dlR8JMbFQXC5awS0QDrWWqJ+1vMJwfqhqAMpDEim0y5IWis4jVICrNfrq0PtjVTNydqlj5CYfFPzXp49M+YJAI7JXkBk52PHhzQCZcyMEB7ksDpuFq5YXuHPT1z7pLf1l3KO9xyr6hyEu9nOjD//C6NTHUVNpwMvpAW+J
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
v2: use the block comment style from doc/coding-style.rst (M2), fixes
    the checkpatch BLOCK_COMMENT_STYLE warning reported by the CI bot

 tools/mpris-proxy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 1d7a421e9..e06b9ea3e 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -2954,6 +2954,12 @@ int main(int argc, char *argv[])
 	guint owner_watch, properties_watch, signal_watch;
 	struct sigaction sa;
 
+	/*
+	 * stdout is a pipe to the journal when running as a service, so make
+	 * it line buffered to get the messages out as they happen.
+	 */
+	setlinebuf(stdout);
+
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
-- 
2.55.0


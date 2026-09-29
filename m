Received: from outbound.st.icloud.com (st-2006g-snip4-2.eps.apple.com [57.103.76.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED92258EE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642086; cv=none; b=Y8euN8KFXIj9w2gOnobaot1cE7MrfekS/yf65Pi8ZhHpL9iDTqZzglwbu9jTL3rX94D8JOIjI3UAmOb0WEQxRe6BTbd7LZW2bYdKESMKLUmOVENwainreayW6SGKKi1JgY+B/Kbw4sKtyg1k05LvHQ2EQJqWG0snQBEwPAcuBkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642086; c=relaxed/simple;
	bh=RffSBG0mDyYwLpKscZBXWhJAUMyCF3oW2SWtRGkawQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2pKst5iNTQxnUoP6ClRFtDZAYda7ZvWcWAmeHVTn0qZlJQQ8AlgtF/QkGEET0tWblBXdmYEKZ8WCpCQyEbswTb8YuSURz1CLhM1WpaNW016bvEb9ghtgQy0X3Cls51xz3lq1iPFhwNhOenzt6qAeD/11+vqu/DFxapSrxztU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=SbLqlwqg; arc=none smtp.client-ip=57.103.76.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="SbLqlwqg"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPS id 108871800116;
	Tue, 29 Sep 2026 00:34:40 +0000 (UTC)
X-ICL-RepId: 01a0ea95-cc8d-75b1-8966-18e51e2db338
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhPBkMFWgNeAUgdVQRLVxQEEl4eWgwDMFQdHQ5YBhIWXUVeCBkIXR0ZClBQBUtaFVUXDgJCH1AfTBZXQ0QfHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgZXXloXXk1aAlZNBUoDXwFbC0IASANeA1gAXgpBAFoDUwVdCFVZAEQGVUF5FVZDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790642083; x=1793234083; bh=aUaYfWcZdNeOwkvhvJKoWQC92dTu8OSHU4r6yCFMrLk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=SbLqlwqguzPCidIO1zwhpc1LMjwWxebWbmZsQ1FX3v+kGixx5VwLlr8H5SfigagPRjoci/F2d1ocYA9OxE43gb3uDou6tpMM44rQjQ+h17zcetpnA9Nh9FiL+8E1Kna5VFeKi7Ta38W5agWD+RvcU0aCSlBRUNNKjxTjal0fWei99JE2mooXRvRjitweyPcxCMjp9DdPMlisD/WUwTo0bgd76H0W1tJx/NKjDLLZoZexiGcKbWAC2pEmJdL4MobqN0zb4WPV9htOTJa37Zae3yHG95UVkuO3Dm30wMP817/FDWEQLKGfUolHv7D/SmjS9+EVB41H6YosSphGsy0Qow==
Received: from seonggoc (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPSA id 32CB718000B4;
	Tue, 29 Sep 2026 00:34:39 +0000 (UTC)
From: Seonggon Cho <jmsmg1@me.com>
To: linux-bluetooth@vger.kernel.org
Cc: Seonggon Cho <jmsmg1@me.com>
Subject: [PATCH BlueZ] mpris-proxy: Line-buffer stdout
Date: Tue, 29 Sep 2026 00:34:32 +0000
Message-ID: <20260929003432.3937487-1-jmsmg1@me.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FUBf4xje__pzGeGpStQ0ecNDhBUGqlaf
X-Proofpoint-GUID: FUBf4xje__pzGeGpStQ0ecNDhBUGqlaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAwMSBTYWx0ZWRfXwR+mmW8+ZA7n
 Q/qtkWNJP1OLIstlscpWZrelRig7SdqnFlxvjf4tAjVCjFCWW4UxE3PwzsqVt7edWVvCSzwZTOb
 c6GiKoIl7J0yyfk1EQ5IZ8dFjecfX1LJ/GNoEIWAtRmJqULwQgDAycIMeCcMOxtN8oRhCQ9Y+bs
 Kpn4YkWPyXS9Zg193FhWAvRnyQ8W/Spn8jYL+1U7jw+iKy2x7SEvauHVWg2n2tkygglSije9Q7q
 pkUv58grZbhHz/X5jlcnmPQU5ifF8mcH9MpINOgcNCTquwSsURotv5qyVrBNJ/xix+Q61q+ZYt5
 I0CbPMNilEicKIJPIjw+2q+NpsCDrYtNKZ0rboGE4UZlYFlReE7vkh5XK9yJeo=
X-Authority-Info-Out: v=2.4 cv=WPByn3sR c=1 sm=1 tr=0 ts=6abb07a1
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=f7IdgyKtn90A:10
 a=x7bEGLp0ZPQA:10 a=_XrXW31pRgsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HoQ4qfohMmCRy--Nq4UA:9
X-JNJ: AAAAAAABL4Ol1sY83AAUUEH8ckteTi5mOQ1B8SN7N63k+bdtx0fW2zCeptEduPrbMIB7AlWsD3e3Ala43Vh60eVLrc3RkOn9M85vtubYfgFjkwZJWVf3oaL9v6Z7ylYhOo6R/cSaLusGQCxpS8BOlFG4pVINcXMnWQCSgAcdmJDGSDlMlOlNBVA0Ww1yru7itOPynKV2jpvRaPO9n5NaC1D+uHa7B4J161inObmnkwWlXOlbdj7EQYWBYN3lzSQTg+aUL+4AhAyEHauu8WDqWpMTtd3PnvCAflW6Q6g1G6WYOTUW+dKNkgBSQVAXCrfSwKcViP6YDZmwvvbgB359C6ZUdLOwK3L2msVdBZjcmf0ozkbszo2ZpRzUz41oG8PE26F60/l2MXAd9E9Nelu6HhbGPi/dT8xncIic0Xrtn6foLoehSwXFGyIl6pBq9MfNaDTdZOzHydVbs6FZc0quUj4J95XlQvZLepRTHEAJO6osD65HjkFr2/VlvqcKhdTO8d/0gsVUL2Zh3bN4Pl4ofUNnJX8Xn53ZHqN+Hpg9l06zLGNJw7byz7uT5RwyOEwj0156HAucujdvYQ+Gbg9Dkpa7fSRqRPIJsmRw/1O5uaONeRy8reulK6S0fV4J11hKbRiCKXoM7Mj0YubhWURD2/migdN1045DrQgUBNKPpL9zn28hBgiIQHDbrvUrUDpzadMEwIYohBqpgEdoa5+J20WiyY5w/jpMUPvTdGLxlnAICzLprjIXz1HmJoITUCKhw1i8pdztDcekCqi1f9PJ16gLyiDUdk3sZJY3GPhukShLCcxNboUBNtaLAUy0QluPnkHI9GX1a8XR+kdueYh1JXJq7+q2qcuxDijgwdGJKt7/XxhmFQ7+v2CzF21mmzeCzB8BlLb2XcZ5xiCcrEAADBuwlviCbhwMfFMptKX4jct1gbch4GrIy8kC87oh1+co8lRuns28/I7ep9GxHp+NXocTsv4x7Nq
 t2Gd1z9pNft0i3WaX6wZDSqe3J9zTj9/72TQ17fR2y+orrOlWnKcjI/uz7ahuQgDw4pkQ2BbI3FCEtDfdzMQeRFS1XmtwUARPNhR7eV2n17/ro6ky00j9CV9+DNYvG05ZgXG1NUaCtYNafuw=
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


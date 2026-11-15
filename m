Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794737994;
	b=Dqkwkh9RmzkxqF1ywN+KrPOFVTpaC+TT4vreHhCQ4Pa1jtk0EFLg8LJfdE5ocrmiguxg
	 +w4tWB/BVC8uAvnznpnNc3S2wFFSbZj/6wikTD8p7+q63i8U7WodamlRhjilyXayjvxoA
	 B89fhlMxSLZmC3YFnLFtIVzD4p0lx6CzSRt1acSuOM/BF0XrCZqcw6K/BunZ3bIFONyum
	 lwUwZhU13csMcDx37+bk24fUqVA63OSe3oSNBT3hltneeHJMY9mR+1OcYPbEERA7sVzH/
	 NI7+YdnRVRrIHHB6P4N2AmiNOpT8zc7RZLepxXySCKt3X4R+4GM/kEF1HeKlAmdUusw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794737994;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xttC6qvwnkJaM+T8snQbEM2LebyDZfAQYi3A/c4bnKk=;
	b=fnhQzC+MtCSzfgBh4ym8KBT/wI2A/Xscplv9VMsI6Qp5iU/8JW+4SDpxYUvCJ169Fsxn
	 Ru1RbaLqYbGFgPqTx0Xj4qsl7TuH3SdGJkNlt2dhQhknnWZNOxDDsT578KJWTMkSA0pal
	 DkpixwTh7n8ptKd0Kj2Lp5pYZSqbtcbpHnQFsoM1VCo+rqG62+cszg2aD/VS3xO6aXcJ9
	 nljDbhcsshHj3dhckk3/sXN4KHCieKL08ZeHnVOSSLc/nKexqNcSUKjURvNXlIsohEFMV
	 Qp9FICIzdEzY4LdE9KjSxIDPr6r1OVx73NnRxKtmFRhIDOAzPo4c3kqkYAsG9gTAapw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=FmiRWiCL;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B117D606A31D
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 10:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B117D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=FmiRWiCL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794737992;
	bh=M7U2SUQtL5jU0HeLy8CijY9PWueDv+d6BNytdH7Nn6U=;
	h=From:To:Subject:Date:From;
	b=FmiRWiCLIsjr/A2G5eHdCBXDys+AzDv+ZIkXk9UBz5k5AwHk+hFJTnri2FORRhqLa
	 yxiWZvCptTYmAk1nVxjTTrah7Ji5CId32B7bA+3lb425ZoyJd/R5X4aFe6swgxVJI0
	 bPDUwdz8smeWeHzwjyHz0vLIS7XKRcovenyaXE9uPv06zhvhTn/6dn7MlMzloUC/MJ
	 tgzbJhSAQWo20hka8jH2ThRcPXMZtONi22CWWh7HT0H/EML3SMj/JM0SyABD3oRa1f
	 REjvUA5f0z8HIRf7dj63D51jicpHGJe/6Bw8Nsq9PImg4E8bkjNE3MvyCSQJ28m3V1
	 gaMvZ2MEdeo5w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 209D017E091F
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 11:19:52 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/media: Add hfp-hf supported feature flag
Date: Sun, 15 Nov 2026 11:19:46 +0100
Message-ID: <20261115101946.69033-1-frederic.danis@collabora.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

This flag is set when HFP HF internal plugin is started.
It allows external applications like PipeWire to know that HFP HF can
be managed by BlueZ and they have to register endpoints for the
supported codecs.
---
 profiles/audio/media.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 34ff251c7..3433a7b6e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -3765,11 +3765,23 @@ error:
 	return false;
 }
 
+static bool probe_hfp_hf(struct media_adapter *adapter)
+{
+	struct btd_profile *profile;
+
+	profile = btd_profile_find_remote_uuid(HFP_AG_UUID);
+	if (!profile || profile->external)
+		return false;
+
+	return true;
+}
+
 static const struct {
 	const char *name;
 	bool (*probe)(struct media_adapter *adapter);
 } features[] = {
 	{ "tx-timestamping", probe_tx_timestamping },
+	{ "hfp-hf", probe_hfp_hf },
 };
 
 static gboolean supported_features(const GDBusPropertyTable *property,
-- 
2.43.0


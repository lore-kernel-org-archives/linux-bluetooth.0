Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1F3EEAD7
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842630; cv=none; b=Z9Sp1jDcCxqOKnaGWQaT7OFeFSGbgKsNUvgNPgD7UMM6VAJxX78rYo/x8j3v59hL+u1rSr9+QUehgwhROFnMK7gzSJxT5wZJIzNx70VsaynXWxcrH4eIpJwIGb14WQ7uxZJitFyLFxTfh+pzyfmjqaXdc8CLOLQZpy7vqcilc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842630; c=relaxed/simple;
	bh=yQPnc9MURgbBJVyll3ZWpiUffEa70ofMOn79kj/d7Co=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NAvrFnhcgxGBVAwmCM/EUqJam9u8KGSErnnxLFYaJYM0VbF/rLHyARP6x8zoUZF8M1gn3PvxMP+t7eiKZ0YYzAU0EaC+py34rX3aPzGhGhGiMx5RFQmrh6HVj5wJZmpwVinfy2fLqXICTZVAT/EkRUUb1hbmmg5Cft27LhQWApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 916F93ECCF
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 14:57:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bass: Fix heap buffer overflow allocating subgroup_data array
Date: Thu, 27 Aug 2026 16:56:37 +0200
Message-ID: <20260827145652.1566826-1-hadess@hadess.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTFaJDW2Uts6bpstXi2ABxShFfSJJIeUAfpuzroLYaMxR2WqFl1iQwaj6ZrEDV7Vq9DVy9cS1UuJxzz/tEmoc2+Vwo3s7YH2KGB32IZgE/iuUNeLteSc8Eerly5t8qxfpASnCBtmg9kAYEIUjZ73KOnoReuQaERtTGOdB3cHsChVr6aq5hVWHhgkOiaHbuZfwkTAEdQPh2vZb4YLGetS2z+a2HI6Y27lmCakFkEKMuT47gqXUKTPBTjNnC43hCKBm4HfdEZEiB9NgTmRjsi8WPAtDiycE461ERdbVdSJzfRvHZ/ZiCmAYZyi3/lvPSRFj2RO62EceoCAR35DU9C6rkYyIhrS+qAij4SMN87XomMfvYcAjMcvb8tlkkWXQZO4Q6cYJTuREdcGy9/rs1jv71wZFLb1ATcmaUv7Q2GnAi+i1sFbrq8msFfy3je8hlyG+sajV5DpLKiaERxaS9OhCFk3Ua5zF0g0DHjfEd1dTC7TFBTltkG1bmbGTwbY8hN9/aL8GL9nuGTVEOvt9jFlJ+KPRsHPfF7AZNBDjuRd32NifoWjEJQOTBlQwk/X3FN0OPWGkZOJSz0Lwe4y2o6lqj1BHsY0+wEVoDiy8B3FqTrJkzgbsprlbexOTVJghMZDV2alCqPMtVnqw1981oEsFaLViVUURZHOT1FprjeLLb0Q0A
X-GND-State: clean

bass_build_bcast_src() in src/shared/bass.c parses the Broadcast Receive State
characteristic value received from a remote BASS server.

It reads an attacker-controlled num_subgroups byte (range 0-255) but always
allocates a single bt_bass_subgroup_data entry (24 bytes):
subgroup_data = new0(struct bt_bass_subgroup_data, 1);   // line 337: always 1
for (int i = 0; i < num_subgroups; i++) {                // line 343: up to 255
    subgroup_data[i].bis_sync = bis_sync_state;          // line 355: OOB write

Reported-by: @thaidn and @bronson-calif of Calif.io in collaboration
 with Claude and Anthropic Research
Suggested-by: @trace37labs for the Fixes

Fixes: 8980f4f1f7 ("shared/bass: Functions cleanup")

See: https://github.com/bluez/bluez/security/advisories/GHSA-7wjj-8mrm-jhw4
---
 src/shared/bass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 65ee4a8cbb18..6566b89ae368 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -334,7 +334,7 @@ static int bass_build_bcast_src(struct bt_bcast_src *bcast_src,
 	if (num_subgroups == 0)
 		goto done;
 
-	subgroup_data = new0(struct bt_bass_subgroup_data, 1);
+	subgroup_data = new0(struct bt_bass_subgroup_data, num_subgroups);
 	if (!subgroup_data) {
 		DBG(bcast_src->bass, "Unable to allocate memory");
 		return -1;
-- 
2.55.0


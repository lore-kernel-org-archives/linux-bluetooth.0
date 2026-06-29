Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E053F6C2E
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743223; cv=none; b=dXPz27bXcrr5SDEn4nhsSomdOYrv8JSsV+LWl/ALRkxewW2cU9eFQZ7ag8Ipx8SC9UNJfjz5fw2mIu4JBF/rlGnjgYPd0axUMshIq7axUWYSm4jUufc7oAttL732tN8Q7ONQVKioCcD/aWudLHCyU+6pP1O4xVRujalSW0Y0fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743223; c=relaxed/simple;
	bh=s6hsVPwczfvrarbW9msptPZgE8A7UGv/z7WRX7ac7vE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQHUHUjZy1k6GpZJYAkdDVDigNvvev2JdGdXGJhYQUKPLYcdwzDLi3hzEZriSVJFvytiEWIwrEbjdCrEiUo89WJdCCjQU0q0iIZhW5sz1ZaJ9Gq+W6DupMkdogCYxHTvk7qIcTXy4BA6b5R2tFFs2AM9I/RZ5FNj+jZu211E77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwWf+gNY; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwWf+gNY"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7383cdb7800so1153980137.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782743221; x=1783348021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6xYwL84HKHKXCjzdLtK0via8XkXYBIUjSj6kSdnFLA=;
        b=BwWf+gNY9yELCHsirE0dlvO8Taspt8F+4FvkB+PhD1x7uLtd1/LyU6AwnRmwlnAXEy
         2J4eNKRidzm3KJ56NN/18nlEwV6bJEBE9E3EVfLKiwsUH0Wa7IPabh15goV6moucrMxq
         Z3grgcgoqzdF/X8ketCDP6eyiDSCCUOBVaD95rNazQkYzcU4QzcvqqnGl1h/LCfIx2F4
         5v2ZYshqrrX7rsq8ulx74TFqYwCwUToClqfiqOvpHkB5UuJflWum7KUS5CQOmw/6e0PJ
         MVqMi7kf5x1f0IHEAfJVpY+mTiGfMXpmH84js28HctJ3wEj0LkcynbMxFdTGThG0nB27
         P6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743221; x=1783348021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I6xYwL84HKHKXCjzdLtK0via8XkXYBIUjSj6kSdnFLA=;
        b=qSyV8Egqu679O7vcKpe78LkSzM7lsH3WSCaW18s0PBceLc0JhgPNDJD4HM/b1TuUM4
         9ZWUEaZvo51y3yvhucyAGXqI3kj2dsKEefA1SoWw7fGeCC9uo2CcLSAOBy/W9iOs2cnh
         Lj77uidX63fWJ5Iy8X2AI0xW60DfL9d1tAPeEii6whx02aFxsXzYYMZwxtDmXLOMZ5f9
         Mh8jyJRRYsRjKcftN0HCtZzK4bYHhDuG/KlnOaZmee1Taoh4BUoiVZoso4n0Wh4OsDTD
         ki8z3flER+PVJY77gKasermY72zRwSgHD+MgkQfw7kv/+8KksaQElzd9/oxQk/5+04Uz
         4JHA==
X-Gm-Message-State: AOJu0YzIIEo7KuZqoAz3EcQvg1bm9Qk+C4zeLXSKLZvT1UZzhOVgBmzL
	bMnyiWe+27d/Q/lhb9T1iGgEdEyrLTKKeRGkyP/PRB4OfZxRmdhP7RJQCTaKztp5
X-Gm-Gg: AfdE7clgaVosim2h03QRBBh/zgeeX9ts6oq1NY+4xwHHefd0NiCk5tyKC+sptFp5v/t
	gn4k61ofDq5aU8u9xVfs1myeWBuCWc+MhmDfoWM+d1pafzgXJ9AEeB0131uv0C2U7e2UNuXwQJz
	psNF1MEYu8kSOc9wrqILioO8OfcTcnjWlJ+YUvyl1Z88Qi05BNH5vLsma/2vVjJ/5vQgCjISqA6
	cyUxAk58XLKhgvaQNsNUkwbOl0YbakgYQ9On+EPIfkCNfS1EQePHQLAgiw6pZxBpBpUXWhh/zyE
	N7DEDhixDEpxg/L5gsGENZlnkltgA3v75zqmABObCeQdM6gLrBT2Zjqo72XyCTU5D3n7TS3ytzP
	jx9oEBItULlW8WWna396ylvrm8Q1h0VXH7TpnIOKSJzBC4i1i2FeHFWPUT71hkwUe8uJ1TQFUxE
	7bs1mFRr97LlWpapSQZrhodZUWW1hfs0sE80ZaId8nJ/r90hCTQ6xHfG8S0IzXgZCIu47OKgYxf
	pTalWE=
X-Received: by 2002:a05:6102:3049:b0:737:915b:157e with SMTP id ada2fe7eead31-737915b1bc6mr3253583137.29.1782743220906;
        Mon, 29 Jun 2026 07:27:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-738f72b4cf2sm1350695137.7.2026.06.29.07.26.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 07:27:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/5] shared/bap: Check if stream is valid before attempting to release
Date: Mon, 29 Jun 2026 10:26:46 -0400
Message-ID: <20260629142649.966025-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629142649.966025-1-luiz.dentz@gmail.com>
References: <20260629142649.966025-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

bt_bap_stream_release shall check if the stream is still valid before
attempting to release it just as done with other operations.
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6f2f4fc11f7c..9dd07bc5f2e2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6727,6 +6727,9 @@ unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
 	unsigned int id;
 	struct bt_bap *bap;
 
+	if (!bap_stream_valid(stream))
+		return 0;
+
 	if (!stream || !stream->ops || !stream->ops->release)
 		return 0;
 
-- 
2.54.0


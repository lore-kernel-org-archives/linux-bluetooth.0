Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA5511E99
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748063; cv=none; b=Wv8tKgL3Gcp3YdxWIx+bxGkl7ZU/2d4Cqtbmk/6Op1Ljyd786fHCpn066DRY7d/rCmDViHg3m1Gub35TKEmTc6DNYm65803yfo5zuILp9PSvRXddNMwmjxfbvHMA+1ZC4xi5d0lQDg3LbHbDaeYR1ZiXr5H9ZYJgX3aPd6nIYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748063; c=relaxed/simple;
	bh=cln7gZrDn0TpF9mriJZREUBl+EH/s32tThHytkBdsuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3Q9s7Ulmvl88FBZo6zZ3KKEjfe1PvtlU3cMlODKWtWdj8GaeqWz2JKBZL68xqVzM7nIUWA7DnD/sUn/h1YqcPzqATdqct2/0Zg4XCvZG5tSLiTkKTyfspWRV2ii9jJ++CrhIOg+whFmPEAZxISfmW2G6UN34jF7jKlhMUCB5sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4+Hr2Zw; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4+Hr2Zw"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97eaa1155b1so454437241.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748060; x=1790352860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tZuJafYx6HZUhoGvm0TMM7HYzRbxHW1k4b2Lp6kWXWg=;
        b=R4+Hr2ZwZlVrWVrpaa3JN7OS/yIQA09cIy3zzhoqYXGV4QmKr1hmnjIA+TAN4mWl5n
         W1EY/pgzNr90EOi7qjLKLp4DjklJXbbNCTtl5btqCfEilgVcxP0FTnpHLQgvwLT4BBIi
         2R0TJqa+wWWyFQP4mYT9vYVxP+w2z5vA3ZTVZIe6I8GQ+Gpvh5Yy78cHtL/i81foWJfi
         xlogTOAovJN85VOwZ0AGKEsEmic1joNZWojctoqmGpW08zXWQODI39a2NzWcjUANcs70
         U99mP0cHU96kolRy9XytLnIIBK8AWR/NFN7uSd5ljvKt7kf1mUiOMtVpA745mHo5DkZD
         Hdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748060; x=1790352860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tZuJafYx6HZUhoGvm0TMM7HYzRbxHW1k4b2Lp6kWXWg=;
        b=HgiF6ndUb4jaLDbye+6HZ2EYz/KWKDlx3UUrmT6RFHpuvbcb1AjKOnDXAP5n9IiL2I
         VlZi7BVvVF3MhBOrEFDJTcuQumqj1+mXlYX+epVCmqoT6BpDDX5Utg21OvJ1bWy67j6q
         25M/XP4FrA6lnRHFnqUm5Q9i6ugvKmWLBbE+aAPLXjEpDS6jG/c/jHsQ4631YLzIk5wB
         b0KLVy1VEF0bAlotssxxtfyx5k9WLpH5AOOedxC+mBtixN41Wg/wkNHrKCT/qcLVF8ya
         VfFv+IQjXfePERHVsUEp4Y87W1+hrhML1kXm8eCIK7HaAqFwFmIGTCIVwowXSmQGBGM3
         cwpg==
X-Gm-Message-State: AFuF++kG7DDfubd3kog74BTKQqBaNLYperkGNY6QoeMSi8hrxIcB3nmQ
	/y8hhg5jy689//2pRWAF6+nz+TRl0T7qXHzGnrSlZ7YVz8f/nbi5K1Htv2t+GFOH
X-Gm-Gg: AYBFou2DXte/KkvqJm5fUXa31q3ElwAAJDFFcPr0iCNzxcqT0bBY7VC/+banbG3nzHc
	Iu9VqEsMTVGNNdp6qJfFk5KY7NbsxgsJK0pzTStLSNPtTBzjskB198fDlsu4K9r6uGbYSV5zn/Z
	LfHCISK4s6nFIKt+do9JJ3+jWMmA/uuAerz4jxhAra257yaSXormye4rAahyg1IIsolp7iEqna1
	aSyR1YrqhiWeUTey8YUJQobfh16k1j9HxvhocRWaqniOXb+BrQepwQLujhBAv4HnaMIVwsC3GNH
	mTb7NIxIHrBZUwydbhR35OQ+nWde4XM/WV7+JhAjai4XVJDW94Pv8GA8CKeZHTV5o571CW1Go4P
	GFpKSgUWey364BCkZM+RugsxcpAoWAdTYpAi1eaPXXFO9/nrhrSgMeGKYcMyN14+zMMsfTFgRoF
	Ol0Tn30fDVe9HFvTme+VsEYjnN/Oj76SrTBsS9M7lGfRuZTJmmdar9k6MW8cu0iB9LtlMXAvnkU
	v3BsanqtccYGn41n8epskbAAP+gL9Sk8ytRF2+CfXgkw5LGyMRMBFVXlikfml6zd4eMSSrbSZk=
X-Received: by 2002:a05:6102:3c9f:b0:7a1:f7c3:3a48 with SMTP id ada2fe7eead31-7a55ce82e7emr1564510137.21.1789748060357;
        Fri, 18 Sep 2026 09:14:20 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7a59c569181sm2104078137.11.2026.09.18.09.14.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:14:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/9] monitor/l2cap: Report the channel latency deviation
Date: Fri, 18 Sep 2026 12:14:01 -0400
Message-ID: <20260918161408.2464981-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918161408.2464981-1-luiz.dentz@gmail.com>
References: <20260918161408.2464981-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The channel latency is reported as a range and a moving average, while
the two latency lines either side of it also report the standard
deviation, which is what tells a channel that is consistently slow apart
from one that is unstable.

Report it here as well, so that all three read the same way:

  Channel Latency: 108 msec (48-108 msec ~79 msec +/- 27 msec)

Assisted-by: opencode:claude-opus-5
---
 monitor/analyze.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/monitor/analyze.c b/monitor/analyze.c
index 5a3adedc211c..154303eb7330 100644
--- a/monitor/analyze.c
+++ b/monitor/analyze.c
@@ -298,8 +298,6 @@ static void chan_destroy(void *data)
 	print_stats(&chan->tx, "TX");
 
 done:
-	queue_destroy(chan->rx.plot, free);
-	queue_destroy(chan->tx.plot, free);
 	free(chan);
 }
 
-- 
2.55.0


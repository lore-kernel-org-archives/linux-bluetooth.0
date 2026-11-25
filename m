Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615187;
	b=JuIssRJOiI7l386UeKADkhYU/ORiuRtcoBdLbEh8hLPLn5OoLH+/76g8IxNN7w2kbzkY
	 BmrzCSzhAC+ODqL9Z0TAH+2pioGnwgww89/Qm1gAnkpf0+zWOUi0tJkl7EcmVJACTxvAG
	 wGd4/BqrCkEfI7u6DogrHjZcdudCeLLuPHyz4w+deO9mO9bgN2E6p2vMgK5k6vtzEGW9X
	 0cydi3a3d+xwVlSTdrEervDLVjFvBUH7WPE7jUFcZs6kZjZEZy4Q4Ybe+QADJV1L9yWTt
	 s4fApeOil+UR/KULvCt2MDPlC7o4vWEXWRNRhH6SoDnuQR7udELLIpQyVKy3ddajBEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HeuBNRqTzgwYYrb57/RKEcp/iimloiD/bD7d7kpxQ1c=;
	b=1lZTyRcc74dgDHwVEJq8lrg7ptqqWUOZE43jgPpn8SRzivHfBv9ZlY4VCbGTtt6XDOHX
	 W5QOBhrUah7r2ry5whenIyct2bowfSfs/6BRjQhenJ+b2dqKNFi1IXF/r3P4UGpQwdNR2
	 dpYdDZJjbM9uAojZkkZ2WcKZ5zpDuKCq7NTUu63ClSFi18ef8AAhqbRAXfa9V6ILrImYk
	 ESh1VuCmZunWOYof5aF29LLKA7j1iZPmjTF87NPmtlqy7kTaOhY+gUzlMvRTj6DI+CfRt
	 qDNEy6pzBsCYOrUPnvtQmZ4xji8QT+2D0vmf0xNS+77Y5Ls8Ue17l+NOzHbUGlcA0Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERPy9TSE;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05F606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF05F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ERPy9TSE
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b439e37813so2887410a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795615186; x=1796219986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeuBNRqTzgwYYrb57/RKEcp/iimloiD/bD7d7kpxQ1c=;
        b=ERPy9TSEv0TuqKEv2Wa0h7FjfyCXawyZ+6AWP+wVsxFGNxAESI0XR1bVeynwmn4o2E
         aYu2eGj/dwBbiDyBCw1iZNoqFILgu3lHWxqxnJFd67W0AAWlTnmAucII5wtRgRta4Bdv
         JUsVsUb5r0jQt5zQsu12O8fdcA2SM/iqsg7IhW1prJsUQTwYnnG6EUjpfoR69YRTkEgP
         WJzm25RYCp9RTAtQcJL+1VyhANPYu7ZCncBPT4vFyCiM6RT4ViPofL8FHmyif+yUUAmY
         eV2xiBu2rm6X4NbTiXSyk0pog84CywWVt7Z4b/jNE2droHDgrUZy0bItrKcMetMIwIgn
         eo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795615186; x=1796219986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeuBNRqTzgwYYrb57/RKEcp/iimloiD/bD7d7kpxQ1c=;
        b=pKyzWB47JO8yWppTK2/DezNjNRcIQoZow8jzbe3W/VjVnqDKUg5NY2SA8jNtVuD81j
         /oFltjJbqS+QC4mPHKn+dDmNf246sLLLw8ai994zCtG6IjWYgbOk/A0YiDeZ3uFy0/Nd
         AuzNjYLHXZf3rNqfNHkgMrlaIvdzCtxMTMMwlkZ5i1Nv6NJe0dWPy0TIjAVD8/9zI42c
         lBqEOOERNiGx2baUtFT59DRynAGc4DZcmOyvUC88I75pV57sZhCsaOeTibFPQI44F/JT
         OomzP+s6VJwpVdqc1wj/lsovujmJIQoG2QxNRaulssekHtAIFVxFX52P3wnxoeSYGOIC
         x6bQ==
X-Gm-Message-State: APuU4Z+D4RW0nUbeR7HAqrZxVf53U46m45XU0lpcly8a79g+lo9yQRd0
	xBnvnWcNDKCrSiops47pJ9yikW0XWKy6xRRx5G8sUdVP5talhkEYIbk/
X-Gm-Gg: AZFdTZdOAG77JDlH2oOzsk3igwP2TN1gfszSXvv/5/h6Wrdb3sOXF20ffbXXTMSVZiJ
	4RAVnG+VJGLb6vD9hN+Xt2JMSY/DS8xCw0F30ogc9H6TRtIPuh/9dwi8avwcrNW37ea1SuzC0QZ
	42Wlmup5bIpN91I9+IBE5m50sSlDMpctBxxW7XQO5hF6Z5zAfaAHxv1kYZZ386mbYT94kiN34PM
	55KQUmMT4u8XjtPjXBcPrQIIowwHGXb/TeAwI9fPnB2vi/q/CvCUUcyU88SDVGEl8HxHdZols5i
	qokt4jl5GxKiaToZ+FgPIpMtw4hNQkuD0yWY0HHXI1muEgaOxl4En/odBAcqZw5J8BA7C9aTG5k
	L85OOhaHOw66EZ6NFBkvk7Kn+BRNdBfhqAOWnTtNqin13AaTyaf3fPusZmGd47xIh2zRQgR6Xxz
	DSziBsObzblxG0g1PtyE23Dx6CQZSuI2RF+nqCfV9F6WeJVSlBQkPufMp51VuXkm30yWLjrRQJD
	gUoPNjt+06U3x/ZZrN6rsTYW3mlUS6C0Bjdw/GvCNva+EOrBqLxJ5YymyuaLCszFfzLT0vo7HD9
	UzptGZVm3DFGsJeU0XUzGPcsPYWlHzlGQFuhNAZRDajEwQ==
X-Received: by 2002:a17:90b:3e81:b0:3b3:fd13:683d with SMTP id 98e67ed59e1d1-3b41cb1bc6dmr13472060a91.55.1795615186187;
        Wed, 25 Nov 2026 05:59:46 -0800 (PST)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm9143860a12.2.2026.11.25.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 05:59:45 -0800 (PST)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH 0/2] Bluetooth: L2CAP: Validate responses and serialize security changes
Date: Wed, 25 Nov 2026 21:59:37 +0800
Message-Id: <pm-bluetooth-objects-candidate-0069-v11-7d5800a0c21420dddac0-0@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Channel operations must refer to the intended live channel state.
Match Configuration Responses to the outstanding local request before
applying their options, and hold the connection serializer while a socket
security change uses its fixed SMP child.

Cen Zhang (2):
  Bluetooth: L2CAP: Match configuration responses to channel requests
  Bluetooth: L2CAP: Serialize BT_SECURITY with connection teardown

 net/bluetooth/l2cap_core.c |  50 +++++++++---
 net/bluetooth/l2cap_sock.c | 158 +++++++++++++++++++++----------------
 2 files changed, 126 insertions(+), 82 deletions(-)

---

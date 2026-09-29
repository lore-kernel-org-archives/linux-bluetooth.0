Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF30522699
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708154; cv=none; b=G7womxIy7vLa80prgPhpZl8n2dtv8fb3BZRPff7QR3BJAMMs6WZ7tZh27XyYcl/7Zruhh6wqrIwHp8vu9y8q9BfhFdmabcacO06ze5jqqZqS6dzMsh4RF3Mph5mqOTDh/d2owtG4xmUJo8DJBC9CIQeRPFStofPHRknnA2P+VDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708154; c=relaxed/simple;
	bh=+Uvvp8nHzMwM5iGIpjRG0U3C4Mv1gAmvG8sg2v2ptJU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QalKwdEnKCRaruulLxPY5Np1IpRW21U2GhDZiv4NtPx2WoeRr+31y29h/GBypjgeTHuHLdjofGaGTJYDWqs67p1rKt71DgZUByzVpx7/Wu+boGKbQlH5mBVyf0FYwO0iN+zlT9qZnETUBfzOtY0iRb6y9hgt2UK2VxZT6NZzQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iL9c1s8K; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iL9c1s8K"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5a24e868so393946285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790708152; x=1791312952; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/VzD5ZLRIJ7xTKxlInow9uS8NPChipheS6R6KdCAGRw=;
        b=iL9c1s8KeU7eC7/McmdgN+KC63WOnJ6z/jDJVstq6/3FsET9pkXAEVQs8KvNhh1QIt
         yWvyLwZAoe9aDUnLIYpFBoXz6T79XzQa19uXSJXhMFJvfUCAYedoqpwI5NsSLV3QCJrG
         f522oAoeU5AL4Pau6kXjJzpQRCg25gOuG39U6FMYl9zTfkO3AV1C6ph5JM372XeUM8AE
         sOMPE+YmkksC+yHQLmQobo4Omb7X//pLsqb1Fb+Hw76yTR0TMkB0CQ4nlLgum7aiTN27
         OH491iQMBYzNTpiSHL5P/8/ijFWDYieSwK1bxJ9oG8d/uIoWP9VglCURWhUfr9+Yb/Ux
         vzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790708152; x=1791312952;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VzD5ZLRIJ7xTKxlInow9uS8NPChipheS6R6KdCAGRw=;
        b=VKj0QSIfetfPLKk2krYjfyB5dO9/19ALOyD7QWUhFWu/FZUKLqDBYPKvWhBbkJv50P
         QTI+UV+EsnRxDE7O94roRU+MpUfPkFwAPmAhKGgzXJ/6ipl7g6aJBgv/445gZDlHqLlM
         x+TbqZ7kydP+bmUXSehJ7ZmSYFFLX8oHaQKiQb0OoLMrhbhNNzBlKM2ZW0rNe1tpHU4o
         +EZoZIZvjDvPfBUw5XASIrZdve6Sbt+SWKhr0dTsrBJH8IMNgv8QijQoU2jSZkOghZvQ
         XhPSFNIv7h30TZ48YJMKBiiKvhnDOpXSPlBva3u/iBPcKNAYiKI3W2r4AYwAX1KiAE6/
         hyGg==
X-Gm-Message-State: AFuF++m/qnP8LrcBTEe2rtAk17qprY2rnbFOgDg59iEVwNmxSF3iua2a
	qikwCkHG+Fp65svDcsOCDdEydQwjycTYXpRgdGoaHNl63m6nqVw1Tvu4AaEWCw==
X-Gm-Gg: AYBFou2gg6e1Qr1eC8hvk9gUWIsNKbLMU9S6qE0GphTMcnbgXuAOdZ6bpFTa+Em3z4f
	JYY9dbKEYF2L9VFS1+80A7aPhVm+jjqFz6ajnhJy4kgiq5eE9agmDPVb4+PywkyOONwooebnbRv
	yZIXFfwpEK6yAM7eijRQV/7hUYwFJjc7Zli7YDYR72PL/qeeYjBgw+97R7xnk/un27cmn5KxBHm
	PIgYHVXktVcX1FGmDyddUbHp7wfAIhL1TDN/D7pYLfnv2m/IOEEsdbOf1R0GrzFvsHLVOFHEcC5
	qwjMZN0/yGecS2y1acTsRA2eHcE2ZNUZP+w4qAWEz5iYWovgwDmF8SuYyGpuDvLIJtp06qU7jej
	Qt/Q7AKpWmI4b/CqHcnGkSyNug2EbmDAAUBb1IW2H1iDKyzv0O2HO1duZj/abk1795e9xf5zyj2
	XGcea0CaqiWnAeVecTShFcXEAk51CFpZ/wD4eWVZ+lqT/YuqD9OmyVIONaFnFxjcwEP1KBdwcEw
	YiNU35xAVPI5ro=
X-Received: by 2002:a05:620a:489c:b0:93c:720c:94e0 with SMTP id af79cd13be357-93c9fbc0998mr91124785a.30.1790708151559;
        Tue, 29 Sep 2026 11:55:51 -0700 (PDT)
Received: from [172.17.0.2] ([51.8.152.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c9f4601a9sm37045485a.13.2026.09.29.11.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:55:50 -0700 (PDT)
Message-ID: <6abc09b6.19f6222c.26cb9d.07a0@mx.google.com>
Date: Tue, 29 Sep 2026 11:55:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8808520542825650418=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aurelienrivet@hotmail.fr
Subject: RE: mesh: Fix Command Disallowed on random address change in generic IO
In-Reply-To: <PAXP250MB0544B307EB9802855B711F71CBBB2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
References: <PAXP250MB0544B307EB9802855B711F71CBBB2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8808520542825650418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       mesh: Fix Command Disallowed on random address change in generic IO
   Pull Request: https://github.com/bluez/bluez/pull/2527
   Created:      2026-09-14 13:56:59+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============8808520542825650418==--

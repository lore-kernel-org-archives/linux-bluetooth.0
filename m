Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DB351C0A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005795; cv=none; b=oSbZFs4QcHZYLW1L48sR9HAXIbRTfOCIK9MOZAmnMcj9yMSqOj521wbB7rKy6wWcL4qIRrCiGSN5G0PyCEaP3NvXfKkXxeDFtZDxYKzxODB1srRbkOTbISp6rRLcgx2HY+M24OInDFcuiT9lPi7O6+U7ROV6eti0qwR249A/J3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005795; c=relaxed/simple;
	bh=8BJGx9RZqrIh+eWxG09ALsa9KNbijfSt/c8dfN8TKb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fOQaJasOjpDk7OBWgY4CN+da1rA0diiJHIkye2HzOgAVlynEPs6PTA96yAIs++9u0tdC0XITzoCsVZyAgJuuLMKKogjiTaRC9C6b0CxrbeecQSDa57/iwfbhsblFLtwIwPPq1XT/gw2RGjFamJOVsi8aUgWqVTPeQdfN4iLMhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPmxBbv4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPmxBbv4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b0603ee486so13428235ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774005794; x=1774610594; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8VyJQBxzCjE2+Xkx+mvyR8wSXjPDl2xQEGG8EMwFck=;
        b=EPmxBbv4ayHe1cw4Zunb8ES+elBWoirW3hELt5Apg77efJXBN6+4pxiVYzwMkuy9h7
         MIj4nLc/Kfkq8OzJjE2+8Ho4ZdJprSn1Phzr2ebNhpaD+YLjL9GeGNK5Mq3eJfwXgZGF
         VrOlMgak0rS08GRvEcfJPTsMIWefp/DkSSUVqLGZgTZ5SVI38xBEwIwZwojsFE+923TG
         6+VhvNAD9Vr1Lz3sJWWYsPZJ9+1bnDA7Iq4iyVdfecxuKUiSXVZUDot8D92266KHVI5J
         TpoFgWSgEuV04Q2GMId1VroWDuSzAnVgxtEzvcMWZ+yPn7748yilvwdk/3K0/bT6G/lN
         d49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005794; x=1774610594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8VyJQBxzCjE2+Xkx+mvyR8wSXjPDl2xQEGG8EMwFck=;
        b=hdLJCJs1g3qNDmtkOc0DPmqy0hXjmv1xACCR/01/wfY2OIFytrT1VciLVCQz+oGrsh
         hX+iMVeCxg17KxTbw5cgILYt9pyT0DMmVi+1IBr0NInVM3JbYPUZCsO3D8JxxSKQ4WtA
         JfoPqR70blAKmNmqooRGZLetZ5eTSN7rGwv81LcABeRtV2J8Ya/UcecZj/ghwAWhdPi5
         sgPcHKudKwN2WXeUto9HPoYnqMGvGqZ8k4Q9yNL15Fx4vtYq4FLiCf7GHLi8W9ZdbUVF
         E7r6+L/S5bN9kj11cQsumWoLE0pDkAFieh7dR1n1x57qpCPTl8opLxOdSYwaU9ngBHmZ
         FDsQ==
X-Gm-Message-State: AOJu0YygcjG/ukiSHyYhz4aTdix4yohCi9lyKag44v830qwaMDhb320m
	GpysI3UT/MVqbm6hVORWY1nvnxVwgwY+RqVkfR4BJCNaKQtjRzkwY25tD4BnxA==
X-Gm-Gg: ATEYQzxGGU/xTz/QqWn7W5Qz3P8t7jvBgw47NFw2mcYjf7s17G0DvHtUF7ppjsF5Us5
	9Ph8QCinHyqt++ZZach5V0u2fyofhjgAiF/7ohITv9NJkgueRGHrjhfbjGSjIEQbG3B0h3wV2Bj
	nudPSMOUStp5+WM5qJDL1+qdCMK5so5Z4hvOlNgzLDE+VT5sgS45IPg4lJFrqBd/1FiYeFLRTZ4
	HCzm9azUtBm4wdNYesUN0dTooetDf5N1rIZSGCfqv1N1NDDRdomAwkoa3fANufhTyPxzFNd74FM
	4BnOnkwODf/vmPufxNUqbRAH5oa9mWlhDayQ+jOdJPHGDn26LBTIo/gRwKP5Y+RF3atVjHqr9/E
	qqkumx92/uTIsn+QfH+CIyC48yyS4gT5qD3eiSC8mPW7EHbtkjojTU65STlKz9/2lB5PWBsX18L
	fM4c1C09JY0eNuXJoAH0e3Is6/tT8yt3igtvVJ8cG0MQ==
X-Received: by 2002:a17:902:e846:b0:2b0:624f:8edc with SMTP id d9443c01a7336-2b0826cb353mr22729915ad.12.1774005793694;
        Fri, 20 Mar 2026 04:23:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836a3299sm20863635ad.76.2026.03.20.04.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:23:13 -0700 (PDT)
Date: Fri, 20 Mar 2026 20:23:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH v2] Bluetooth: L2CAP: Fix ERTM re-init and zero pdu_len
 infinite loop
Message-ID: <ab0uHv8K_Jri2J6K@v4bel>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

l2cap_config_req() processes CONFIG_REQ for channels in BT_CONNECTED
state to support L2CAP reconfiguration (e.g. MTU changes). However,
since both CONF_INPUT_DONE and CONF_OUTPUT_DONE are already set from
the initial configuration, the reconfiguration path falls through to
l2cap_ertm_init(), which re-initializes tx_q, srej_q, srej_list, and
retrans_list without freeing the previous allocations and sets
chan->sdu to NULL without freeing the existing skb. This leaks all
previously allocated ERTM resources.

Additionally, l2cap_parse_conf_req() does not validate the minimum
value of remote_mps derived from the RFC max_pdu_size option. A zero
value propagates to l2cap_segment_sdu() where pdu_len becomes zero,
causing the while loop to never terminate since len is never
decremented, exhausting all available memory.

Fix the double-init by skipping l2cap_ertm_init() and
l2cap_chan_ready() when the channel is already in BT_CONNECTED state,
while still allowing the reconfiguration parameters to be updated
through l2cap_parse_conf_req(). Also add a pdu_len zero check in
l2cap_segment_sdu() as a safeguard.

Fixes: 96298f640104 ("Bluetooth: L2CAP: handle l2cap config request during open state")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Keep BT_CONNECTED in allowed states for l2cap_config_req()
- Skip l2cap_ertm_init() and l2cap_chan_ready() when already connected
- v1: https://lore.kernel.org/all/abwTCkavRurEcEGO@v4bel/
---
 net/bluetooth/l2cap_core.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5deb6c4f1e41..b80667c263ef 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2377,6 +2377,9 @@ static int l2cap_segment_sdu(struct l2cap_chan *chan,
 	/* Remote device may have requested smaller PDUs */
 	pdu_len = min_t(size_t, pdu_len, chan->remote_mps);
 
+	if (!pdu_len)
+		return -EINVAL;
+
 	if (len <= pdu_len) {
 		sar = L2CAP_SAR_UNSEGMENTED;
 		sdu_len = 0;
@@ -4312,14 +4315,16 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
-		if (chan->mode == L2CAP_MODE_ERTM ||
-		    chan->mode == L2CAP_MODE_STREAMING)
-			err = l2cap_ertm_init(chan);
+		if (chan->state != BT_CONNECTED) {
+			if (chan->mode == L2CAP_MODE_ERTM ||
+			    chan->mode == L2CAP_MODE_STREAMING)
+				err = l2cap_ertm_init(chan);
 
-		if (err < 0)
-			l2cap_send_disconn_req(chan, -err);
-		else
-			l2cap_chan_ready(chan);
+			if (err < 0)
+				l2cap_send_disconn_req(chan, -err);
+			else
+				l2cap_chan_ready(chan);
+		}
 
 		goto unlock;
 	}
-- 
2.43.0


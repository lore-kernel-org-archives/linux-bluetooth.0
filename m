Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450974;
	b=A6Nrk6Ditz+wlI32lM9hu8cvMgkT1mvJ0aRruD5KsqhkegL6HQU65v11WfmnVKyN/TkK
	 XL46u6vWDe1Y5XsIRkAHKqsprXFecJTHR4V4X+TcZbzD/hTXU3QqPldCDsc1nEhsu6Tgr
	 lTToTNDK3jtrkREdB7Z+OvElp6R/kDSpzswfSYHVgoOnHphLfp9zBIgmwkTKSwe7w2SQ5
	 LLfDmt7VceNyex0GWhmZEzBj8xo6xRgSozSr/y0KSwRBODUxqkk5EH7LaEshDLE8vhcVN
	 NQeKI6KAzBnpg7iT9rf5gBkeRmgbl9gd9w66kbFrPPlle8Xd54Y77Up2FM8aROSWD3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5i4CfZ4wlcGb9NRlKMt6oXQjUvgt+EDKA5P9c2OHIKE=;
	b=qqcVUBFdavkC02o2fS64VdTS4eBI/MBL1yKZRzj29XtLKsooWJ16P7+5IyDycwH/oqCM
	 gFZ896kyPuK0OgtitCaaXWrWy1+JAgGoiOuQZfHmB3U2L35vaGMwSI/5KC938tRMy7twm
	 0Qfpb20VUtH1DrwbKqm9FlWlBQkAqlDgxTiUyhyWyqEXviBAWbYdajJ8CmOqPfKBdFUvS
	 1koemyqWOnnkgz6sFOZWvxPMtOpzkpuNKiow8FJLy6tXenleqcIfB3uIR7QNcD7DdoDpb
	 pCl9kjY4hfisQN3ZiiGj0d9QYHhsX2sQfvfkxJFe2+iy/RJOIVA20zu077kmv0eTr5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="xivRKa6/";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF96606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 16:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CF96606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xivRKa6/
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so22540865e9.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795450972; x=1796055772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5i4CfZ4wlcGb9NRlKMt6oXQjUvgt+EDKA5P9c2OHIKE=;
        b=xivRKa6/OzQXL9o/Hqw/U8+ejenhuvvvUmF7Ydv5UroisRQQwL6ti7LN+13jM5oiRO
         4zx8OODl8FL1l5hIhmw2FCZGWPnNTgW/YRRhsMazt1xwB33dWEluswrc7Vrac1CCYjj3
         7t92jzKA+/bVkjqoLSpwTZyrNfhDeRBeGTBoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795450972; x=1796055772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5i4CfZ4wlcGb9NRlKMt6oXQjUvgt+EDKA5P9c2OHIKE=;
        b=w+W8fmc/XewRJz88VMSCRDJg7ZoU6FOOTHZQeh2MXlITh4ebddfYqZfrca9aOtFNB0
         H+dWsXyYXzFEdXOwGXgs0/VrZhx6dutNY/CT43dRWkbP4IDod0g91mwS0ha0eYPtrac5
         2FdfNAu8hFabLwB1l3vXK63up2yaeE9cBk25NIKIXpitLijmD533cuNqL7DUFaIXLfkN
         E2/NRhIz2c/QHtdHm1EUk+SW4R2l11lWNctkJYsgklP3ZG4AQCUyltb0zwIuGAP8H/TC
         sRfrHXQVRVBj/tQj0Z+0zOpLbx4qCttSoDQ1qAvkG3zI2LLUoZs+LzmFjmb8nallspaY
         Zt4w==
X-Gm-Message-State: APuU4Z8ObQNOZcvW5tPpwMAzm0EocqfOrvlfyembfp9OZGbmJ/hpuk1y
	sq6azkbRQZ+BZdGEGFck2e/ZV4q61DZMZcE6Ws4FtrUz5WUKxaYQ0/lYJkuuWSS23wr78ddHH7h
	uc9VI
X-Gm-Gg: AZFdTZfRH/3x28XDz+2eVZ89rsIZRW7sXEGGpe62H60ciUzu5l6GrMKDkyAdsq08Ks4
	BUlMFYbGoxJhY6ZjV1LYTG2DMlaNZfZKE8xQeehVk7z3u0rzzYxZypGPjsK818+QxyBZJcvQmhG
	T0wdyz8E4gcK1jMYcQxHkapzU6K8+/LiCNPXtlQBA6m1KV56gz5ixi3GAl1k7jagNRUooKBW2D9
	hXwp3ubvdjamR1HRnhwyqtN55P6fBb+ryCnNKxMS1gNYErIJ9dJTj6WLxx6Vakd8SRIVP83I+Ki
	ENxyQ9JV2Vl5XEfeShFjLHCHOTDF/Y4BxbEVVMNSD4Gg35eTyNkbPowOsFrgc7nRq7oWf2+WtL4
	D5lnNgoI1okuDhfZWPHSsi8GMWEf1H9neMsT8kjdCoHBa3LJu11/YQjW00VUjgNxijTmnEWKIAF
	B2hJOlt4LvrNVOAxnD1nAIJnFd16B3l2F3HRPH80S8m7vgjD1jqt4p6FYQXWW+Jjnp81rDLS5Vv
	32T973NGF4lmwFDKVorFd8vBCOuPVqCbFhVbYLcP5Mx2oIelfNbrBG/I09Vcox6Pyi3/vxC6nIr
	UwI+sKpjHB4RcBDchSLaqWpBmt1TwGtYoIpbU/3PFsK57NEO
X-Received: by 2002:a05:600c:4f4a:b0:4bb:6752:8413 with SMTP id 5b1f17b1804b1-4bb8880015bmr280059015e9.8.1795450971695;
        Mon, 23 Nov 2026 08:22:51 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:4fbf:a0ba:28e9:473])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb905f1489sm200275385e9.0.2026.11.23.08.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:22:51 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2] adapter: Fix discovery filter RSSI and Pathloss matching
Date: Mon, 23 Nov 2026 17:22:40 +0100
Message-ID: <20261123162240.387240-1-simon.mikuda@streamunlimited.com>
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
Content-Transfer-Encoding: 8bit

is_filter_match() takes a device as close enough if the RSSI threshold
is unset or met, or if the Pathloss threshold is unset or met. Since a
filter cannot set both, the one left unset lets every device through.
The Pathloss threshold, which the kernel cannot apply, is then never
applied at all, and an RSSI threshold only as far as the kernel filter
goes, which holds the lowest threshold of all clients.

To reproduce, discover a device with an RSSI of -60 dBm and a TX power
of 0 dBm, so a path loss of 60 dB, with a Pathloss filter of 59:

  [bluetooth]# scan.transport bredr
  [bluetooth]# scan.pathloss 59
  [bluetooth]# scan on

The device is reported anyway:

  parse_discovery_filter_dict() filtered discovery params:
      transport: 1 rssi: 32767 pathloss: 59 ...
  device_found_callback() hci0 addr 00:AA:01:01:00:42, rssi -60 ...
  device_set_rssi_with_delta() rssi -60
  device_set_tx_power() tx_power 0

Require each threshold that is set to be met. An RSSI of 127 means it
is not available, so a device reported with it meets neither threshold;
before, it met any RSSI threshold and, as a path loss of tx_power - 127,
any Pathloss threshold.

Fixes: ebcb6aa7c527 ("core/adapter: Filter discovery results")
Assisted-by: Claude:claude-opus-5-5
---
 src/adapter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1439642cb..f56e84324 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7610,11 +7610,13 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 
 		if (got_match) {
 			/* we have service match, check proximity */
-			if (item->rssi == DISTANCE_VAL_INVALID ||
-			    item->rssi <= rssi ||
-			    item->pathloss == DISTANCE_VAL_INVALID ||
-			    (eir_data->tx_power != 127 &&
-			     eir_data->tx_power - rssi <= item->pathloss))
+			if ((item->rssi == DISTANCE_VAL_INVALID ||
+			     (rssi != HCI_RSSI_INVALID &&
+			      item->rssi <= rssi)) &&
+			    (item->pathloss == DISTANCE_VAL_INVALID ||
+			     (rssi != HCI_RSSI_INVALID &&
+			      eir_data->tx_power != 127 &&
+			      eir_data->tx_power - rssi <= item->pathloss)))
 				return true;
 
 			got_match = false;

base-commit: 1adfe662efeff12997df9ddd0960dbd0de9c8ea7
-- 
2.43.0


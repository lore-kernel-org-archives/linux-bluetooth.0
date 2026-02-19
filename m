Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B54352F84
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521256; cv=none; b=pg/0ays5Oj/dl51kquh1J3tsQG4eNot90FK2CRIBOinf8OJVi79dkOy0FgtJrHrN1NOgr7AdY0DphNgZm2euZ5ZT7tA15IhGJ+vdu4whErYgzG4FHsn5gaB7irnsq55LdVCbcEAUIR6JoG5skbCSuuUafIsDjzCDZAurbmHL7vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521256; c=relaxed/simple;
	bh=wtM3KGXEQuicJ8O+1w9NeLqs1Q3c/AYVobYXG6O4xkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAVTnG276/wzX7WAVh7hu6HRW9WnyQ9f0tZPlAK4KmEjIKdpNjhs/d8PSh1j8mImKlKwbgfKjUs22IZzRru7QIWTNPnWlq6KECdPmsTjyih1SuylHcpVSq1xnfgxUS9X8gUELeNo/wsg4yi9f2XjCJaNJy3c+X1xpCpuGf8lcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpEPYB/F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpEPYB/F"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad22a5e245so8656755ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521255; x=1772126055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=ZpEPYB/F3ptJD1G/dWEZjed0xgEBHRqubbvxKeqMB8yXjHJNDc70RDIDfR/SH9bqKK
         TLQwWeazbfydFyIHc42gKGPP16FfhJis6WFaGAQX4iylSm0fY7VZ+6QxGvVUZxoOhqVz
         xUXuHWB58XOEIYeD4s2v7+zKVxsJbbeOp6T74/eHqqjLfv8weOytBW14YYnLvdXjhtQz
         vgjqRSeF1lZY4oEtkUA2bMBxnks+AerEFEBsFHLD7OvNCJ0Ypstr2V8rngP90Y92+zIS
         mKeIs8zxdlzCfvl/Aihdvda6rT9cFunclEoL3BMyzbqbEJj03bA5csUCM5iOyJij5bfQ
         EvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521255; x=1772126055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avVd2rCSlmy3mzSueRF3eaj+JsVil8OR/Q+bsjGDE3A=;
        b=LNGxKkS6xDZ2EcT9bobaE7UtmMzZtDe3IYrcxBN4KUtPIUWJAahlqW6xRxU2vR8NPU
         S+js9Pjrevo83cwAOndcwSeOuO5QojiNVu8/EYUCAKt7XjNObBylt0zGzic1sCrAjH1q
         VaUyZG2SvxcZG04ve9rG9jtTH/jsp2DHDW/tN9kV/8iE8wLYNWAYWVtUbtz0+kn4El8A
         VUr/3c+k8fPgPXyOC+E+7BHwA3GOoTWCiMgRhi8o366EHPmLoX2XrL3xUuC5419uJYCo
         jeaPoNYXPygfPhExcpMmxFJKUdI0kXCkLQVVssx+BtKHHk0+CkWC9h2inV7+QukC9xYN
         nLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6MC3bkkABajGVOVGu35wNZkobibcbZO7z8+3ysi1JXukbdEgwKF1MHHvWGUN/jaI/noVyUjE1hIlVKN94r14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM/w48fYbcn3oqpL+/h6fb4qKpjpazhwRVS2Chcd/ByKAVvCWf
	58B59P9BDUAMnXcv4h7dVj8RY4svwrWPMaYlREGD15qIS34iGBEGt1td
X-Gm-Gg: AZuq6aIj/SWuEJsDX42a0giWNUgyAl5mL/8DBjACAsjB7RaxAbO7zzRHq9xk3nCcQkn
	tQcLmodph0slFUYPYnakiUiia3s1Y+xGjSwekrvTuHwgPPC+fVnXLte36ZxxCUP22r545iUViFP
	WzjWMcnqOutu+79hnBLbA4w4ELS8Np/kfOuTZ+n91xMdVlGNQxboSYIFdFi2j6U9u/x/Egje9/i
	LqIln2L7qs4ZjZwJUxFMsHqec1M9jPBlDBAKTBbWajSqcqAkw75AtaqkS/boj+CHAfT1VqbeI7+
	zxatfAX5BYi4ZXIfXB388L77XMUoZtCkV/3nrz2d26awzxcqzbMqKuYmaLK58QFZ4WEIoU4UapL
	ee80G1ybyF/gW8OMCS1vj1u3j35pKOHn9a2EMQzrFyRGDYL9dNOrBCSuQcBblfCkEKqOq16Twse
	Cjs3KtYoOF8KmRdYNxxXzB0SMlydDwsokmv4Gn7QyntZZW+TN99A==
X-Received: by 2002:a17:902:f54e:b0:2aa:f798:8c7f with SMTP id d9443c01a7336-2ad50fe0da1mr59033605ad.54.1771521254568;
        Thu, 19 Feb 2026 09:14:14 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:14:13 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	Julia.Lawall@inria.fr,
	akpm@linux-foundation.org,
	anna-maria@linutronix.de,
	arnd@arndb.de,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	maz@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sboyd@kernel.org,
	viresh.kumar@linaro.org,
	zouyipeng@huawei.com,
	aha310510@gmail.com,
	linux-staging@lists.linux.dev,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 5.10.y 14/15] Bluetooth: hci_qca: Fix the teardown problem for real
Date: Fri, 20 Feb 2026 02:13:09 +0900
Message-Id: <20260219171310.118170-15-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219171310.118170-1-aha310510@gmail.com>
References: <20260219171310.118170-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit e0d3da982c96aeddc1bbf1cf9469dbb9ebdca657 ]

While discussing solutions for the teardown problem which results from
circular dependencies between timers and workqueues, where timers schedule
work from their timer callback and workqueues arm the timers from work
items, it was discovered that the recent fix to the QCA code is incorrect.

That commit fixes the obvious problem of using del_timer() instead of
del_timer_sync() and reorders the teardown calls to

   destroy_workqueue(wq);
   del_timer_sync(t);

This makes it less likely to explode, but it's still broken:

   destroy_workqueue(wq);
   /* After this point @wq cannot be touched anymore */

   ---> timer expires
         queue_work(wq) <---- Results in a NULL pointer dereference
			      deep in the work queue core code.
   del_timer_sync(t);

Use the new timer_shutdown_sync() function to ensure that the timers are
disarmed, no timer callbacks are running and the timers cannot be armed
again. This restores the original teardown sequence:

   timer_shutdown_sync(t);
   destroy_workqueue(wq);

which is now correct because the timer core silently ignores potential
rearming attempts which can happen when destroy_workqueue() drains pending
work before mopping up the workqueue.

Fixes: 72ef98445aca ("Bluetooth: hci_qca: Use del_timer_sync() before freeing")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Acked-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Link: https://lore.kernel.org/all/87iljhsftt.ffs@tglx
Link: https://lore.kernel.org/r/20221123201625.435907114@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/bluetooth/hci_qca.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 66f416f59a8d..204ba1de624d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -710,9 +710,15 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
+	/*
+	 * Shut the timers down so they can't be rearmed when
+	 * destroy_workqueue() drains pending work which in turn might try
+	 * to arm a timer.  After shutdown rearm attempts are silently
+	 * ignored by the timer core code.
+	 */
+	timer_shutdown_sync(&qca->tx_idle_timer);
+	timer_shutdown_sync(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
-	del_timer_sync(&qca->tx_idle_timer);
-	del_timer_sync(&qca->wake_retrans_timer);
 	qca->hu = NULL;
 
 	kfree_skb(qca->rx_skb);
--

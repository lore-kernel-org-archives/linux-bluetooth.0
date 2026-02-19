Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A740A343D64
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521218; cv=none; b=Wa6hvjarVnNIGJi7xBHM4T6wOQSeBKu7ffD7D8CAFWkCzOTuNSPQsDmQuFsG+sXT3odDKG3CLcmpa1lJP7ZZzxk/veyCrULDhmFtWbI7svYoebg1Y7/v2RG1Wt1+KQLGjKiYst8vxoPUrJWfqM2i++4Eu6+LNQgRXP4YrxH0pFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521218; c=relaxed/simple;
	bh=HhT6z2DVcZ8yTv/m6DHxcDKqHPAmK3H4JJhD4dhIVH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnYBFv4Z5SvB0nBEXpi4RMYGdGUyfpjjROKGmsEGW9qyvVfjWMAzEhuN7z3KkGo1BlecI8Efb9TZDyP7z55i6mcqIayTjs5+ehWfVKdb978Mh7NRhErJvKfTHoAMV4AZVO/3xlUFPE2SGcLWN+a8Lj1uRTABxw3ZKg31IfGL4O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSqKh1Et; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSqKh1Et"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso614582b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771521216; x=1772126016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ivwth3bvYn00MIlpqUjU3pfVj9NAWsfF7rOKTWPDVU=;
        b=iSqKh1EtcQq3Vw7JlOgIlbG/jUIdobO7x/7X68R9/m/62XmQG6tIi4l913RcKGad/u
         ixrurEoIFtrSqU5NDv4klM4yFtm/Qa2NWFBu4Y6HDe9uRdXij2vCLmhXNPn2O6ddtfSk
         0mX0osBfgp/93jWe+fRehNQ74bMml9qc4lAIusGSbdzpelqlZGt71UjSnIqIhl/gJT19
         V+/1t+utSKktCRCyWbSLfs99k5i+bbkdI31jC589PB6cjQRQGia/ygRpAGmZ2ul6jCjo
         P/3z8fQltix+jnxd9iHgEVBvFN2mbgjg386NI0MrR5c1sAjcZ/ZsLwTz+VGxKm22erfM
         +rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771521216; x=1772126016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Ivwth3bvYn00MIlpqUjU3pfVj9NAWsfF7rOKTWPDVU=;
        b=BxvE6KPaZo19srckUJF+NuANu1Z83f0TKr0r60tJZ8Ni1g+DwlJ80rroCjBYbGft+2
         M0VvH9Riwre/jttvTIZp+gteM2dt4xErAMjo2aIboZsdKseY9ln2jGoJoL7NmQsE33ZI
         gDnb67MCkTU0fQPYnBnBvjxyKUin3YFn4xvDfoDofUIjEwwcB2Llvx8uz33Q6sGS9PSk
         UCeW2nJT/oOa01whYy5FnF8W1oevd8rcRyZNAL6sfX/dl3oPV4tp9lcZSvfgOS7QcwoD
         6Jrn4SfRyemgu7Xvq/Pn3yakJQpya5XpKL4Imo1mbEJjEkkg/nAGETxu48qWkyTKSsQb
         7lZw==
X-Forwarded-Encrypted: i=1; AJvYcCVGyInBMGN+b1A/dFzfjs3YTHGJrfmJIum0xFFMt6UCkB2TgXUR/OUgtcgWLHHXKJFxuA4m+fYZqT7ICSABeEM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI704KeAg5naTDtYC6kVkhn6hJG5DsZxMhXyoVYtkBIFVFlFsr
	T8l0/qGrE+2r2EiRlHh9/kt6Ev99iKjhNHxPsDmFSYxRyyRaP12/uHsa
X-Gm-Gg: AZuq6aJ1NlbqgZgcgKh6vhP2ORfWnKvD3FE61fQHdBh3ZtBuTtD+Ia8hio7cpIajf/E
	Sofh/ERyOHmcyCYfppg2VOaDXO1xiyqcbuHCPuN7enMlgX4TnItuNDyDukY4CU+M44PdIPyY+mN
	i5bB7OcCjd0RZLdz369+JlsaNr9DcZn/DhZSXNhq0xmY2u5WGfQSapCxNxCnA7tIz643T0o0/KD
	lERhXPEVR4o2BsL/zI/NrCxDre/IvXd6XdBfPbOHERQzNdRpnGhNVjeOiTtG4Lyo2d1rCkR1hMa
	NUU6N1qjnPGsYZVwSk9xMrWYZrxE1sKd0G0491vrTtnjjN34eAiXEQtO1ldOe/yGQUXVIJOqs4q
	2/EXQR81RF77xaMQppbvgbd+hPS1onKNy9QwcdNEYmqxnRK5ca2Yq74Tza/8WdJ+tXR82DStC+/
	WLPuDCoAY7t7VVtGN2kswfMbabGx6kUFruGqD4o2rveGzjHZzvRRRRcphalp9W
X-Received: by 2002:a05:6a21:6b05:b0:34f:b660:770d with SMTP id adf61e73a8af0-3946c95590dmr18861831637.55.1771521216447;
        Thu, 19 Feb 2026 09:13:36 -0800 (PST)
Received: from name2965-Precision-7820-Tower.. ([121.185.236.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e532fa2e5sm15895002a12.26.2026.02.19.09.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 09:13:35 -0800 (PST)
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
Subject: [PATCH 5.10.y 05/15] timers: Get rid of del_singleshot_timer_sync()
Date: Fri, 20 Feb 2026 02:13:00 +0900
Message-Id: <20260219171310.118170-6-aha310510@gmail.com>
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

[ Upstream commit 9a5a305686971f4be10c6d7251c8348d74b3e014 ]

del_singleshot_timer_sync() used to be an optimization for deleting timers
which are not rearmed from the timer callback function.

This optimization turned out to be broken and got mapped to
del_timer_sync() about 17 years ago.

Get rid of the undocumented indirection and use del_timer_sync() directly.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Link: https://lore.kernel.org/r/20221123201624.706987932@linutronix.de
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/char/tpm/tpm-dev-common.c     | 4 ++--
 drivers/staging/wlan-ng/hfa384x_usb.c | 4 ++--
 drivers/staging/wlan-ng/prism2usb.c   | 6 +++---
 include/linux/timer.h                 | 2 --
 kernel/time/timer.c                   | 2 +-
 net/sunrpc/xprt.c                     | 2 +-
 6 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index 56e56a09cc90..c3fbbf4d3db7 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -157,7 +157,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
 out:
 	if (!priv->response_length) {
 		*off = 0;
-		del_singleshot_timer_sync(&priv->user_read_timer);
+		del_timer_sync(&priv->user_read_timer);
 		flush_work(&priv->timeout_work);
 	}
 	mutex_unlock(&priv->buffer_mutex);
@@ -264,7 +264,7 @@ __poll_t tpm_common_poll(struct file *file, poll_table *wait)
 void tpm_common_release(struct file *file, struct file_priv *priv)
 {
 	flush_work(&priv->async_work);
-	del_singleshot_timer_sync(&priv->user_read_timer);
+	del_timer_sync(&priv->user_read_timer);
 	flush_work(&priv->timeout_work);
 	file->private_data = NULL;
 	priv->response_length = 0;
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 0d869b5e309c..8687e0bf3315 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -1116,8 +1116,8 @@ static int hfa384x_usbctlx_complete_sync(struct hfa384x *hw,
 		if (ctlx == get_active_ctlx(hw)) {
 			spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
 
-			del_singleshot_timer_sync(&hw->reqtimer);
-			del_singleshot_timer_sync(&hw->resptimer);
+			del_timer_sync(&hw->reqtimer);
+			del_timer_sync(&hw->resptimer);
 			hw->req_timer_done = 1;
 			hw->resp_timer_done = 1;
 			usb_kill_urb(&hw->ctlx_urb);
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 4b08dc1da4f9..83fcb937a58e 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -171,9 +171,9 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 		 */
 		prism2sta_ifstate(wlandev, P80211ENUM_ifstate_disable);
 
-		del_singleshot_timer_sync(&hw->throttle);
-		del_singleshot_timer_sync(&hw->reqtimer);
-		del_singleshot_timer_sync(&hw->resptimer);
+		del_timer_sync(&hw->throttle);
+		del_timer_sync(&hw->reqtimer);
+		del_timer_sync(&hw->resptimer);
 
 		/* Unlink all the URBs. This "removes the wheels"
 		 * from the entire CTLX handling mechanism.
diff --git a/include/linux/timer.h b/include/linux/timer.h
index e78521bce565..3c166b4f704d 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -198,8 +198,6 @@ static inline int del_timer_sync(struct timer_list *timer)
 	return timer_delete_sync(timer);
 }
 
-#define del_singleshot_timer_sync(t) del_timer_sync(t)
-
 extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index d4ce3ebe2c8c..6cd908cfbad4 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1912,7 +1912,7 @@ signed long __sched schedule_timeout(signed long timeout)
 	timer_setup_on_stack(&timer.timer, process_timeout, 0);
 	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
-	del_singleshot_timer_sync(&timer.timer);
+	del_timer_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
 	destroy_timer_on_stack(&timer.timer);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2db834318d14..2bccb5a90934 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1160,7 +1160,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 
 	/* Turn off autodisconnect */
-	del_singleshot_timer_sync(&xprt->timer);
+	del_timer_sync(&xprt->timer);
 }
 
 /**
--

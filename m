Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com [74.125.227.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06664F7CD8
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625669; cv=none; b=ejfx6CbfqplBa3/o2nU/+KPQWtcjJaO7dWoD1bwUKXAgHmMIyzN8WMhJ9RmY7ezmLi3WpaQPuESQF+AR8oY2iJfWePS1VzdUUOjf/CgiOjvuHvpP13BD0qLnse5HgOeRaiKchspw/6vTJ6CTwaVkfbZUxMdXIoPLszDTOypvL/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625669; c=relaxed/simple;
	bh=MCtXU6jORncu6C1mn/3nWvg3pyh0Yy/IZYXWD7L4gcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1hjoXjDKfECdLS5edv76ohRXXuAjGnBj/52rf483MN2Ahxf2xEGs8dt1HC8IaAnmRFsG4tqff8GvXqTTHuKf7DnPO+fOqexXNNU6ZUnEiqGp3vSxume6hnOv7XDx7p72k9x6bOgmWU1A6B2FS5AMM5lNM+sqaocSc9c9ZVZ920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4FJK3tD; arc=none smtp.client-ip=74.125.227.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4FJK3tD"
Received: by mail-vs2-f38.google.com with SMTP id 71dfb90a1353d-5cda0838062so1717387e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625667; x=1791230467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wmpled/rN0zNoXcxBvURKWw3It3zyjAw18vJYhST+ZY=;
        b=c4FJK3tDXEskwwbkJkOEirqcKj3GRIY8YSYlQROLHM/PkEmCd+65Z06Ctu1M8kqm+4
         2dydECHtRVvuExQDs/zBA0bT9mIJsUSBPL2ubnfityBIyFRLPoji2dDjOHXP4S+yqPNI
         dGWWXJKkrIoR0AQY+m4bmUSHNKWSd1VTkQWbP0HiQDMr1UsALgCW1TQEIr3ngfVvlETp
         PpYIZn5mj4KSwXxUbtOK7I847GxOD2Tr55QZNX2WYv3dco1ArMHz06zRdb0okKSmA0ci
         hUdnClNtFPzYgjs0uVwTAVWpnntO+79s//qMLrH9faYUZEXjnzSpEykk44M06V0HXtWp
         pseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625667; x=1791230467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wmpled/rN0zNoXcxBvURKWw3It3zyjAw18vJYhST+ZY=;
        b=1nEmicsHkAeTcu2X5bqW4VaF4LtPjX9C2PAN8h2kCCfYVnHBtirL2RmiWy7ZQDVAM/
         gnHt3MmjGswtx2Fqh6l4wWbTgx9bRC/Y9gwAtTtkPHqONAioBOMo0VicO2FLjqLpWOEu
         htijBLwJVZW09ASu7ouCg8JuFkXGoiDyJYXEVNhTedMzMXDvhYNb+BVsChGjgT6iyYtL
         thJnM5qkrmEUGlveNXMXkk/Tm+KhZV5dKo950McOFfTB6nLCnt/x+oI74Xy1VPoE9scK
         pCM7SEzMOMAk+3OQdqfSgXHni7X5m4b2kIfqikwQikqUyGEziMH/Q97U2Fgm1Itobg5p
         txyQ==
X-Gm-Message-State: AFq9FYLSQovaQtiE7yH3+8hun50uFo4GAJG5S01fsF2HzhwkGFoodlyV
	QiGK7hbLKvG4Xw4Ht9Kjo9HGCSXF7Ndq2ZdInuaXnAdyfGSLMd8HFG05zG6qdtbJR4g=
X-Gm-Gg: AYBFou3Hwnxi9HgYY0IIAFkFyh+u9r1WZHOKjNAKhrPq3a77ZqAXZWaAoj/NMovY5Cy
	FBgd1LctU6F2mXbFt9A8uZOFbAqPvuYl269DLHZI6HymMFGhpmFOXNsDqqeG7Bk3TkQkt5CvPME
	m5GQH5Yt/jg564ZyU86LbhMSTQbzpZrZ+QsmzRYaNoKpBpUSByLbxa3Yvc6E4Cbe0hpVC+gGys+
	iFCpb3k4IAHiefJIKeY0jscUS2rmWVTEmyO503UPpeKQ2FwK4/CKAGFxnGfbWeb5lI4KzifSzQK
	m2PzHBhNw8FNWFU9iSXEibQ8Ik53WrjgqYjkGB91i6Au1PcS7UEEyRfyBUfo5K++6WXapQi/QzE
	rNwM4G/GtSHGwxglOkH7AbgD1SRW4kvFyKPqI/SjniMXeJ/g5Av5YsnuDpPWvLrPBH409xpx3U8
	7doGuR6jrdqGPFOLjIc8krP1rrNYNVUjMiJWKgNRDShwDHADw4/FQwJ3YjJhZ78CKlHJbHgDgBS
	2wX7pp0Gk/pBVt5vSxolKf/ITAX7q/ibvZ5AmrRm3tl51sUZYDnFIn9ItcPxSxa9p+KJEpzdJw=
X-Received: by 2002:a05:6122:f8c:b0:5c7:9445:f468 with SMTP id 71dfb90a1353d-5cb09707140mr6200162e0c.6.1790625666636;
        Mon, 28 Sep 2026 13:01:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.01.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:01:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 12/23] shared/tester: Allow expecting a PDU with no response
Date: Mon, 28 Sep 2026 16:00:18 -0400
Message-ID: <20260928200031.1209311-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

IOV_NULL following an expected PDU used to send an empty PDU, unless
followed by another IOV_NULL chaining the PDUs to send, so it was not
possible to expect a PDU with no response, e.g. a Write Command,
followed by another expected PDU.

Wait for the next PDU instead of sending an empty one in that case.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/tester.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index e99cc452cd07..eb2e923fd790 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -948,6 +948,25 @@ static bool test_io_send(struct io *io, void *user_data)
 	if (!iov)
 		return false;
 
+	/* IOV_NULL following an expected PDU means there is no response to
+	 * it, e.g. a Write Command: wait for the next PDU instead, unless
+	 * followed by another IOV_NULL chaining the PDUs to send.
+	 */
+	if (!iov->iov_base) {
+		/* Nothing left to send or to expect */
+		if (!test->iovcnt) {
+			if (test->io_complete_func)
+				test->io_complete_func(test->test_data);
+			return false;
+		}
+
+		if (test->iov->iov_base)
+			return false;
+
+		test_get_iov(test);
+		return test_io_send(io, user_data);
+	}
+
 	len = io_send(io, iov, 1);
 
 	tester_monitor('<', 0x0004, 0x0000, iov->iov_base, len);
-- 
2.55.0


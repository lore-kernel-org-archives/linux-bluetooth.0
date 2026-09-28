Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7974E020A
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616797; cv=none; b=FlxGNlebpdxA+gGbm6qHsiHhNjwFIva6GBNEhQhgX0L0Iwebkqp4bNT3R8Bq+ewqrpZ3vSoC4ujDcZZvb67knCyhPjJ8uZ6TmwuWHiMTG+e+B689QulsG1hhcxHhz0bKuAg4/hPQOu6xiczuSBaIquR1uXXnpWNknANC42CxBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616797; c=relaxed/simple;
	bh=MCtXU6jORncu6C1mn/3nWvg3pyh0Yy/IZYXWD7L4gcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhcAEoLXP7YYn+Rd3onDTFP/pAjdWoSiimEl3b4/VT7gsF1MjmazedGBcFNowmEUD/asHEI8ZKb4JvMdcLg8PxEL2lGihNRBA2YePeGJifoP+y8UkM9WHxLie1rKhHAnAG0jqmlCx2biHomLN/kBJSGSQnkiYl7g4khBQi7rR5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvvNAurk; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvvNAurk"
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b451f1e66fso1125049137.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616795; x=1791221595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wmpled/rN0zNoXcxBvURKWw3It3zyjAw18vJYhST+ZY=;
        b=RvvNAurk3zRtpN7f/aVo8232LdG0vNZdoalvkdAf2ZgjNJ2Lf9x7MLy7X6MfXOm5C+
         y//LDRbBMDjmElL4hYJ6VmEvO4EtfpU1uXyBLpH+YS3cQHvlDM7hlcq9TYDKWEY68HHS
         nYV40+H+Zn1/fl6IjLPoX/aelnZ6CuG3iLiEwVa/vuV6aHA7TrE3lLe8ImXNCUyAGNv8
         7YqaYJfr/Hxy2ANLr5A63C6h+CKqaCLHQo3r06PNUhUD0PHzFWpliL0Y6m2154GEXj93
         Q8osNd8x/Ic2+VOVT8tbQLwogyHXQGlmO1Pi4c9xYZkqrlkC9nnLhoUvXClV4vwST3ea
         wuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616795; x=1791221595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wmpled/rN0zNoXcxBvURKWw3It3zyjAw18vJYhST+ZY=;
        b=RrBlf5alETITa6WnBg/pNMC/xal+PGAJ2fX5kUYbnP+/+f2cZicrKcqpkExY0k1B94
         6WmQaojCyf6ooKgIU8jE5Mvhp/kemxA7rZuTI3rgbDkZS6radCHvbCTDC+drpWku+KZV
         p9qg9oHu5gBZr2gNZRXLJcDYyJENxa7H9E/3fyPms3zgk4qAX6Pgcvi+ws3qD8RcR92U
         GYCOu4eR3EWxUO9B+7DJQ0ayyR7pDzjOv6qL7r6JcVcJT7ePhS+aw+EtPVZtmlL1ty6g
         HJVwaVwkgbegXXiqyQf1BuICXP8qz950Ag9aqvBx81O0UeDenJXDjulfAg1xtd1Bb7M7
         Fk0Q==
X-Gm-Message-State: AFq9FYJTIDfHpskXG15yuKGTI7wyPsD9D+OqVa+wC4lT2mk9rahJ0ObR
	gWHhSOhIt2YpRPABW1OJZnp6NW4lfAonMFwlKO7XlXPnaZGz9hUyLTwkdhLPkB1HyTo=
X-Gm-Gg: AYBFou0ElJVXl9VJfSV4+43dNe8Fb111yO00KMWNE/1LJKqU9cZoaQcvHrBZTnyf7Ab
	B9BVjPJ1W7KAOcGrqrzr7hOBUieBXiSxqfWbhwF5l9tGgApwpzs90pnRkpn9EaO/8NpluR8RBFN
	9uyxQRREkB/PcZTXJ/ysV9/f/rBV1cliznKdqgOdG/3RajtnaMQi0a9e39TT7MczIutbf/8y29Y
	u0sk6ptTnO7ZrvrQezCJe/YpztoeP5A1EuzcEYRcxO5AvkU2PUQOsYnIPy9B9prK+lG0tniz4UL
	zPZXnCGt+XYPVVs3xBLvCEPxMXd5NcA1K2FrLZrTW32RN5ghQKg7YYLLZQypgMbXi5xdO9T6ZAd
	UI5ffb7vflgZCgRxlCu3c/fzPsLvGz47uNVk7sk+XBVIZkaedQxF6P6alkIDq+OhGxIN7onaDtO
	55VtG5TEf70HN8lfwJUptqU2E/Piw7E1iMqnjxtgC7mw5alh29RHobJfxSLww4DzUxKj9NmgmZ4
	VnItEBw1Xee5zgZ6I/OS2YY+RkB+aL9Dp5rqNqHF5ALOGGcgPL451s8g0XdZwoO58HUxMUjHXQ=
X-Received: by 2002:a05:6102:2910:b0:7b3:54c7:7ce4 with SMTP id ada2fe7eead31-7b354d6cbb7mr2407361137.35.1790616794189;
        Mon, 28 Sep 2026 10:33:14 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 12/21] shared/tester: Allow expecting a PDU with no response
Date: Mon, 28 Sep 2026 13:32:31 -0400
Message-ID: <20260928173243.1073509-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
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


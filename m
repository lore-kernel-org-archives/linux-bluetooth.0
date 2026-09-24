Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20D440632
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289069; cv=none; b=PmPI5oqudWFTRogTQmTisuPTbHGR5aeUtwDPww2Xt9vrqAT5loHDfNa/LWaRBckks3C5O+AwZ6c0z+gJy4L6NHrnZPWNJVsI4mosl5tJ7/B/MN6QiZXeqjw3XjcOBxXZ8NBbN2VUe24l3metCtbthcM6Fz7uUHthIA7qa6TUe64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289069; c=relaxed/simple;
	bh=MCtXU6jORncu6C1mn/3nWvg3pyh0Yy/IZYXWD7L4gcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ll1+6y09r5qggnl+mXJuKst13qYbYsPEiHjk6ISo7j1L5tUu9JbyEQDKtHMPoN5uVF+XRXjFUSqUZKnITMPH0RId/i8V7Ax1zR7AoAsz2RwbI+g1Oiqjo7jdR5ANJjDDJvxDzs9y90eP2UFUMwDKF1MZboEM5x6lOWq0Ko9QEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw++PiP6; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw++PiP6"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5cca96ec1feso10060e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289067; x=1790893867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wmpled/rN0zNoXcxBvURKWw3It3zyjAw18vJYhST+ZY=;
        b=Kw++PiP6VVUibvQNaNBQ7+iPTvUWB7tQkuhTZ4hGmaPgnoWmzBNtA0EpG/g7ozdicO
         Ws5UXvlFlZB9D6EvFwTFmMIwrt9npHOsL2wglJ1sq7XfpJVlcy0v6tYvh81Sy5VVylIB
         XXaa3eROoPH2ZSa/rrCJFWiLJcuc5z24llyfdjE7HTjEA5jsNcRpHy49Xp9q9OtwaGJU
         ro+5a1xg0isdLehc7ujnET+ZwkcfUTVlLm+p4swoQGjS/UIjjXCypygSLbsiXyEvJbyS
         nUY7iE9OYxNMvPL0sfnFR2bge8bRrhA3hR94uIjacMmL4qR7f8b1/EihWnvQhgvrw1Ch
         Tk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289067; x=1790893867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wmpled/rN0zNoXcxBvURKWw3It3zyjAw18vJYhST+ZY=;
        b=Zwsb6q4v7iOJQbonJK86UtvTLGphKKy+G4bF7bgbBKB7lZaEpbg09sZM7MI/MYSj6D
         8ZaFIYoCCf3mqEFACvKRrmFhxFP/z+vn+QlvSfy+qG5PwNroWOMMEn54meqlP7wFDfcU
         ETjwBXH1dBDtE9cTCiHCqQy9lY3GLCBpFAqwnuiy6zGVp+MfRwfmUGTPJQBunXpeOB28
         zkIUTATzAnZ6uRfgu0MhkWSqHAJaatQYLKbqfevotYUDoar5Qtj/Qo66hy0c5i57NaXx
         hR57X9yGycOWunvjlWS+RkixGzw1b+7roi2bxewtUbOduAN2iPnBqx0nvGsWvl8i3wj7
         8wYA==
X-Gm-Message-State: AFuF++nH2h1lmV1jCheK1CTOb4SOJjPu8BEJrA4BoBprmGmZxBAz/QeR
	HdcGAou44PNWknLI5nxKpoSkYt0qXNGMdB1FW6WT5KB+cfwXa/kXXlJ+HuH7Tqu0gLur3w==
X-Gm-Gg: AYBFou3bsw19Ze/eFgoCM3JLhaRZ2PkEoQZcHTt043iyzRDBbeflVZQ2dr7WU/mSa73
	f+pgd91qqc9om7KwCvq1NfxHwEtq6HbGGvwhv1ipsfvS1UDtDoiGuHKX9eTLZ0jQmifVxfrStUv
	W6Hh7+zSVDC1FyFpeKEJshFdNJwV2O/lEi0mspgtVTqdGFnTS85JfEwWRk03PyFN5O23czK/h0a
	t165ZJItqKpq6G4KQ+U351LfFqPk0hgDriY5IDcYvmsqYA07L2oD29iOOVGyOCYEcOe8Fjthu3A
	nMj+/goUEbGuojPJDmOq8h4P692z7IgNzINqANhTV+mVYzPreXQA7uQyv46lIFdKl7kvKBh1gaF
	4mHBKpsOTJlITLJeEpQeGvtO9lRcnDTJQBSrXCmLqsfSR4oBEOvwN7hNFG6ltKtCAy2eL/esqbK
	94esb1Sn6ydSVSLzfgE8Lq5zHDoebPYGkFkqfYWCzK8opfl2maZ1Yu8Ub6zwP2VGjxb2vuWKZNr
	ujJJ769eM2aJjOt5CwlkjZHg1Yjy2mpuhG0hyxCiWkhFSqZpjaO/IHPrUM/I6r6
X-Received: by 2002:a05:6122:1da7:b0:5c9:a60b:e5d0 with SMTP id 71dfb90a1353d-5cb09dfde31mr2133582e0c.10.1790289066802;
        Thu, 24 Sep 2026 15:31:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 12/20] shared/tester: Allow expecting a PDU with no response
Date: Thu, 24 Sep 2026 18:30:37 -0400
Message-ID: <20260924223046.605543-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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


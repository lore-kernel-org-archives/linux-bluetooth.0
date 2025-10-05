Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537AC21FF5F
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Oct 2025 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759702694; cv=pass; b=lKsRG7NGj1xWBy15hm3s8ERhkAMwn+EQ6EYyaNCmjEpFwDerCFa7+R1Dwi+RUhUfWgNvearmyOMa4/jfqMObrGIpm/1aC/TQ9r+Y40R0XUNaMAxl7b6UqG5Mq1hYdDty4XMmYg2B+e1wPG1sFgvSYiOfySSPNOlRxGIg73QirkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759702694; c=relaxed/simple;
	bh=PCsehrZhUdbJa6CaG8HcKUQK9tAbIUbmpzTZNM4Eh9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6wIrj3xZFOotfV8U8jfpjQfG80vwpoaHaHfwW4YegatR8FzWI7J9un6qqDlrkfUdt75JbZZd0rwkYNun8zSwWBqOuswKLbnNu+LxFHXfZT3r3f19Z1OzJAL/TcYQFtyXhtBncjkji8THi7nXYS9hFvkueXDu0JxgMtT4Yjf1a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rXQXu25E; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rXQXu25E"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cfxcH1TCwzyYr;
	Mon,  6 Oct 2025 01:18:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759702687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+RFWUq6Lz6/XgStITPP/NVIJqhqAIPjL/lNQOvhwFw=;
	b=rXQXu25EbOwT8k6K1LM8mE8Kcg0shtfLcjXzTIVoDJVHgdt2ASeK2+RpTb2Z5JQB65NoCu
	EW9uGTRBGAh62OQ6borxHNyI8g+Y2nEV8QLrtj4+0LaZXSIIV//+TOjYMLRtiqQFSkFwHj
	dXElZF4WaBLH1ukrLXVrglv/06xXCNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759702687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+RFWUq6Lz6/XgStITPP/NVIJqhqAIPjL/lNQOvhwFw=;
	b=y/vBIxXtaer4iqVbHhgRMgLBAmsOIdpVsS1RXMvMj9CNwei7mh5SfFx8kSVUNkvZ/0RqbQ
	OFQ+8r9hoBSiJPsdvrzpzPMJcfBkwxT8I1QYx5OgopMRGFz0BqrP0eBRua6Vmkm4jYd3tO
	pRMKy8ngIlwbeGro+ujs8FrcvEf4Mk4=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759702687; a=rsa-sha256; cv=none;
	b=iFu9cbiIvjXxlrQMXY4IM6hBlt1irbe/sCgZ0u5rSQmaYHe3BxJg/PtvGZguLvpH6Kjsdl
	YRf1nJ255fXk5NQy7xOdtSSBGb3l4EdgHb4CP7JpbroU8M3rvlv5FfcVSGp7tJguvkb4Qc
	epOUVnnHfxqJevGc5Oo6uYe6KmOcsj4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] doc: enable 6lowpan in tester.config and explain in test-runner.rst
Date: Mon,  6 Oct 2025 01:17:42 +0300
Message-ID: <957ec749e439584821102186e547ef4608eb07fa.1759702519.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759702519.git.pav@iki.fi>
References: <cover.1759702519.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that there is a 6lowpan-tester, enable requirements in tester
config, and explain what is needed in test-runner.rst
---
 doc/test-runner.rst | 10 ++++++++++
 doc/tester.config   |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index cb56d5b94..d3e5f2984 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -92,6 +92,16 @@ Bluetooth
 
 	CONFIG_UHID=y
 
+For 6lowpan-tester, the following are required:
+
+.. code-block::
+
+   CONFIG_6LOWPAN=y
+   CONFIG_6LOWPAN_DEBUGFS=y
+   CONFIG_BT_6LOWPAN=y
+   CONFIG_PACKET=y
+
+
 Lock debugging
 --------------
 
diff --git a/doc/tester.config b/doc/tester.config
index 24a0ca1eb..4ee306405 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -60,6 +60,11 @@ CONFIG_USB_XHCI_PLATFORM=y
 
 CONFIG_SERIAL_DEV_BUS=y
 
+CONFIG_6LOWPAN=y
+CONFIG_6LOWPAN_DEBUGFS=y
+CONFIG_BT_6LOWPAN=y
+CONFIG_PACKET=y
+
 #
 # Bluetooth device drivers
 #
-- 
2.51.0


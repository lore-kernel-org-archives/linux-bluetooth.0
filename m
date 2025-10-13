Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035321C860E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 17:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378281; cv=pass; b=K05wR8J2rHX7jPknBEcSe7LmMpd+aSZWIagkokJGYMobL9WNWe2hSdWvS9LFP4GwTYuFi7p3Njj8FpbMyWE3/CMTlL87cS1jz/e0OJTZfhasloOH4FE05KcfxFYFuMhpSSVdzDuDyqVZyhOifgTfpmWvFra0qzqE8c2FV437jc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378281; c=relaxed/simple;
	bh=PCsehrZhUdbJa6CaG8HcKUQK9tAbIUbmpzTZNM4Eh9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AplAQTeV6Hb+FYdw4tI0bBag2eHH/CJ098TkO1Reyg3RbJzBzPIYZvcK4uxxNhPRIEaq+4ePWpDR6SH8HRhs0qjwQSRJ2TYgqwSsSiT9rhAMfQVn34ZQwbHPG71U3CIaJcng7y1+Hcv0qSE6WaZPVLFBPun7ynQRTTNrXPaeqYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XcVZoKmf; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XcVZoKmf"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cllSK0HRxzyV8;
	Mon, 13 Oct 2025 20:57:52 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1760378273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+RFWUq6Lz6/XgStITPP/NVIJqhqAIPjL/lNQOvhwFw=;
	b=XcVZoKmfNrebepRsfI5UOjiDW58Bh7TOrJE27TtuZlEKNVqogutw8FUHiMyoVxZuXn/Ej8
	QZvFP7waIkJoPryZ6KxB1w6PtcqnI6imL3VJfs8u36hZ2sqViK/wu1o1RclRi/tLMTjzEt
	qINceOUo00R0aIOjgq/dlrkgYgbOoAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1760378273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+RFWUq6Lz6/XgStITPP/NVIJqhqAIPjL/lNQOvhwFw=;
	b=Yq9vhMG3WZiKHzdHdyqk4JqfSLX16GWH4Ws4J2NmLE01ty4UHLsxUJveQ6CwoS1Nh4vw+u
	p/AJ97JcrzD20lJM7dljy8L8V0IJtv3svpybr1BbaoXbH63zm5K83LYn4nU6IVVkAvR5DA
	gbO/C99CNYFCPqUUggdmHguZW1ten6E=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1760378273; a=rsa-sha256; cv=none;
	b=KFnia6yYYNi9Bvjf6uXuiXRZSWC7gW5JmyBjB7CANJgN599C7ityApM2Dxpj3uawQ4EFQD
	skmsGgAJ5GcN4UjsLqFS74UwZYmfiWHTzEsT0T95v048ZVFA9VmKBQ41qxOxnOh61JHIp6
	IB3rRBJNi43BvoVk82/nmMUrH0tBVS0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/2] doc: enable 6lowpan in tester.config and explain in test-runner.rst
Date: Mon, 13 Oct 2025 20:57:44 +0300
Message-ID: <3211fa5f4245dec5743fea44e46eb8cf59491f50.1760378120.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <ced3d6d6e7591bbce715a683a3902cc564c6d3fc.1760378120.git.pav@iki.fi>
References: <ced3d6d6e7591bbce715a683a3902cc564c6d3fc.1760378120.git.pav@iki.fi>
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


Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F039C012
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432835; cv=pass; b=Ei+hsAuShF2oPMsGzxPRNNuZ92vKy9F0Gu8knJcpzgm7+5mn9yWMMUioxLG/CT1huO9bO1wUFro3V2vamXbP6buPZhKjhx4jUQzSlqNlGWcaBcfUvi5FCaq0PPvfR7BdBJBJDGP7R3zMLEjxojJEDIskb+qcEcumR13SyvRP6v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432835; c=relaxed/simple;
	bh=FT0dymlvmytiygNXsJJWvpnxOO/06OhGcw9GqQ+akk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ5UNFuERiA9hnfoWGfHMi9vMbel1e/mDzDbYrgtbouXmhdBBe3i3Va1Ra68TU67LD7to04tXFxig7LAYioi9pAtO/ixHXUMDfkXtuSH1VRW7KqrT4ezlO3VMp8DNC8QWCKDl3rCS6lGxe6AvnD1UoQWah19WtD2Fj4G7kvyfqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ZKR0zs1E; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ZKR0zs1E"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdTvf71ZRz10D3;
	Sun, 14 Jun 2026 13:27:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781432831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdPeKbsPJeMBc4B6S56Xix3EG90RSZvCvJy1AG2h+hM=;
	b=ZKR0zs1EUgcu5xruBGAzWfgHaWvbuiRFVwGY879mam1b00cea4SAj0urbfij33yqlrGmeZ
	5UyKsSKnn7tAyOd/Jzou9olvMeKwZOcB76x6qZReXoQMjIQtrpNXZbgpQCBbNkarAqABHH
	7PnZqOVGIYkxvoQMA/gl0GNm+l/OTmo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781432831;
	b=KTqOdjmTmrPDI9I3JNn6j1aaJ0tyXv12/1WB84ztHlPxKkr5ogY6zVOqAOOrMcVT8zH+3u
	FgARX639AIG1ci2GulB6TXfQX6V5TZuOiijp1gnJCa/gISmxSFNgJ/z/TeYWU9RlD8foCs
	KuQQ6AIB4X7pJM7L7ogtij9UDAsKcrE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781432831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdPeKbsPJeMBc4B6S56Xix3EG90RSZvCvJy1AG2h+hM=;
	b=yvhiHGVnhNsZeQqYoPbTpmtOb+LXCqGN7fk5fbPYmljLzKlXLpqWDMhh/kp87uiouO7Jjr
	fu7RK5wx3qt2Ahwey5qCsyOZyk9Ja6O/fg7hDjDkZWUUMvTL6bwE8ZWvOKF3w5RQyV5AsZ
	D6s/s/3wmekM5+GUYE+4EdfD9Hl6/po=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 5/5] Bluetooth: enable context analysis
Date: Sun, 14 Jun 2026 13:27:06 +0300
Message-ID: <10709d3c2f82cf32b3e85d1d2ed5758f5fb4a0a7.1781432726.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781432726.git.pav@iki.fi>
References: <cover.1781432726.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable compiler context analysis for Bluetooth subsystem and drivers.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 drivers/bluetooth/Makefile    | 2 ++
 net/bluetooth/Makefile        | 2 ++
 net/bluetooth/bnep/Makefile   | 2 ++
 net/bluetooth/hidp/Makefile   | 2 ++
 net/bluetooth/rfcomm/Makefile | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index bafc26250b63..e6b1c1180d1d 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -50,3 +50,5 @@ hci_uart-$(CONFIG_BT_HCIUART_AG6XX)	+= hci_ag6xx.o
 hci_uart-$(CONFIG_BT_HCIUART_MRVL)	+= hci_mrvl.o
 hci_uart-$(CONFIG_BT_HCIUART_AML)	+= hci_aml.o
 hci_uart-objs				:= $(hci_uart-y)
+
+CONTEXT_ANALYSIS := y
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 41049b280887..ff466ea97436 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -25,3 +25,5 @@ bluetooth-$(CONFIG_BT_MSFTEXT) += msft.o
 bluetooth-$(CONFIG_BT_AOSPEXT) += aosp.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
+
+CONTEXT_ANALYSIS := y
diff --git a/net/bluetooth/bnep/Makefile b/net/bluetooth/bnep/Makefile
index 8af9d56bb012..f42015cc3245 100644
--- a/net/bluetooth/bnep/Makefile
+++ b/net/bluetooth/bnep/Makefile
@@ -6,3 +6,5 @@
 obj-$(CONFIG_BT_BNEP) += bnep.o
 
 bnep-objs := core.o sock.o netdev.o
+
+CONTEXT_ANALYSIS := y
diff --git a/net/bluetooth/hidp/Makefile b/net/bluetooth/hidp/Makefile
index f41b0aa02b23..53e139e41bdc 100644
--- a/net/bluetooth/hidp/Makefile
+++ b/net/bluetooth/hidp/Makefile
@@ -6,3 +6,5 @@
 obj-$(CONFIG_BT_HIDP) += hidp.o
 
 hidp-objs := core.o sock.o
+
+CONTEXT_ANALYSIS := y
diff --git a/net/bluetooth/rfcomm/Makefile b/net/bluetooth/rfcomm/Makefile
index 593e5c48c131..15f909f40f25 100644
--- a/net/bluetooth/rfcomm/Makefile
+++ b/net/bluetooth/rfcomm/Makefile
@@ -7,3 +7,5 @@ obj-$(CONFIG_BT_RFCOMM) += rfcomm.o
 
 rfcomm-y			:= core.o sock.o
 rfcomm-$(CONFIG_BT_RFCOMM_TTY)	+= tty.o
+
+CONTEXT_ANALYSIS := y
-- 
2.54.0


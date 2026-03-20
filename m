Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BF368971
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041081; cv=pass; b=GSX4oF77245iS4WxpiP7+E9fJQoTKyoCBGHt+wFlJlKDTb1VODRPCMHzlwQXrdVY7phiTywJ/eqpkwldEkOa0sXKccDke888htpg1m0nIOSwqg//dwTrXwtWbjy1d3uxcqoC0VWyc0Hv9BQpuia7gu9ME/s2VvvsynQWyNmgLbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041081; c=relaxed/simple;
	bh=ISKrlIYuEWro/9lX/ytK0xZCWwSiuJ6gpEn5YXD2Bho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuM3iHsIc9yfFiqI98oQ9Xkc3Y/nyWOB+ObJl+dTOpL/dJXOUxhmLL9H6037AQ/bTDrpfMEEpY/VqE1+VeR7MFCYSOnBhgbYo0G6C2JH481+va9KEgMKMQTzRwgkDFRLfcCeRJ/KtZDRLx9AQsdyvvFjKqR5LKULK7cmQV4MrvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Zr6iF7mt; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Zr6iF7mt"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGW4R4Yz1019;
	Fri, 20 Mar 2026 23:11:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=Zr6iF7mt/d8xY3U4LcWe9M3GlkEOaknp6NJgg++FNunAK5NucQXAD2TTcfjHDG56neU7bQ
	IrmLkRLsQMTE7775TcKovKHDIaoC9u4DxXZ/kraZMzx3VVRsHZcmo8EE98jQYPAKeBhP7K
	mgOxqFtBtIyXZPm5NrPidvwLgyrOkv8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041076;
	b=Or1SgwJZ7/F9twlHm8cfOQXMNI1Th3M0F6MlzgQLumyjxQu6L4wL3wBTzuI74lGI1Xb41T
	2QpQ4+BgDVbtYR9UhYbynXlcDm1pyyy+YHee0JY4KVZxeBoFkCTjr+Kl4ao0XWl0ZyATO3
	3kJCeZOubDtLkxta202LMRcXpZ7uRH0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=uL6BiuQibp7mhLo3IqG2aqtQTXQILYFsu1yt7D3Q0VN+RjKhXG3yL/lFR9LIzr0kr7caPO
	hW0XskIcxRusxUxjdlEzbyzXTZIHGk+40EjzwVsBo8XPSguvgovtfA09bMY7sa3h9XXG4k
	mzDAwEILvPKl/fAa2kQXei2ETlzqMRY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 08/20] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
Date: Fri, 20 Mar 2026 23:10:52 +0200
Message-ID: <a3b0ea0154cf5184060a6ca6f319a5ff6539b161.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.
---
 doc/ci.config       | 1 +
 doc/test-runner.rst | 1 +
 doc/tester.config   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/doc/ci.config b/doc/ci.config
index 31e49ba96..a48c1af9d 100644
--- a/doc/ci.config
+++ b/doc/ci.config
@@ -6,6 +6,7 @@
 
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
 
 CONFIG_NET=y
 CONFIG_INET=y
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 64715e2e7..d030787a4 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -45,6 +45,7 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 
 	CONFIG_VIRTIO=y
 	CONFIG_VIRTIO_PCI=y
+	CONFIG_VIRTIO_CONSOLE=y
 
 	CONFIG_NET=y
 	CONFIG_INET=y
diff --git a/doc/tester.config b/doc/tester.config
index 4ee306405..015e7cc1a 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -1,6 +1,7 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
 
 CONFIG_NET=y
 CONFIG_INET=y
-- 
2.53.0


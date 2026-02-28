Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0543093B2
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Feb 2026 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283098; cv=pass; b=fS5gGDYzMFLtMxz0dZyPbKSN8vglxXB6teiqLLJdQBvPyh+I6e+2jhwIeg10OrdoHQm4w+00qcn9/yZroK5W2ye8NzYOK6lbKK6+vQyKAiwHR5IpbgnacDj0bPAVrz1lFdk39UslzagKNTKm1sqb6XE2SX2hKWyjGmx4bDq5W10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283098; c=relaxed/simple;
	bh=ISKrlIYuEWro/9lX/ytK0xZCWwSiuJ6gpEn5YXD2Bho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXFJNTHT0Um7P8Tk4wl1zFCCNT14CQ/drbTXaMIMUzc1IKphH+7S/uCIk2wBfDTKyW/WGnLt3WjRy3MmR/f0Fn72GkFjAJJl1gL/oEOecBnvcOMGV3vgAKzS0qQXjaRVablSZE5/E8WOgA/yE5QTWPJViNxR8SjJh3iC/TdKvM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g3h5zTPf; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g3h5zTPf"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fNQ701CG9zyNV;
	Sat, 28 Feb 2026 14:51:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1772283084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=g3h5zTPfLkjOPfpXRh+zv+wcLhzUfrLtCrBjEufCShlgpAPRM6fdXXpDKhgt4E/gcZk0Q8
	mNA+CUmS0PcjaA/UNJ7XfPl/gNsNcncfgw02GuppsjQG6qPJT8sITAJLsyOq2ZT8t0OJzr
	+4ioVGb9RjizYAR7lEI5JKJDZCJBws0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1772283084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=s35JV99CekgXxQBxloeuYDmR9smS35+lDxATlkbwDacGkfafSTGt53Qwfp0+UOS3Lc++Vs
	OJW6pw1J6zMxGVCN0Ejr52RPCSK9XR0SC643emskgtMkdf0+RmHffpvWrLLj9fZGKG6YDT
	/VDPspt+EIECp+ATj+Ns/JZz9/AgHQQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1772283084;
	b=Ci9Wx37ANWpVxprigKJ3b4IX+dnPDEZ9Aqwje2oXjiPE2D07rlfdXQA2tN8dzkp828Xba+
	wvU3oIHg1RoF9/vbFhhkQ3j8fwJkKb34aPrUGcdc3VfGOnxLG7tZGeLaetTEKa++qYCcOc
	nBX0WUQdpvVrNDAK2/rkVO3feHvCrbs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 06/11] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
Date: Sat, 28 Feb 2026 14:51:12 +0200
Message-ID: <565eda3e788389ca53d66547f3f957aa54e01cbc.1772282574.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772282574.git.pav@iki.fi>
References: <cover.1772282574.git.pav@iki.fi>
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


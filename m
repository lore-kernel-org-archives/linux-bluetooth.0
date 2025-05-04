Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDA146A72
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374542; cv=pass; b=cjUKuPvjgD34XZi9YooXELw25s7krHAi6WfjO9SLMFzz1NdLbiGEjTlQ9uxNf0/zkbvpTNXnYyyrIYHwtuKUDfp1/K/YVebvLJ3T7+tE/a50uEEiL9o4FOsrPBcEzgRicfb/9hzKjCEpPUczrHZ+sABY6+ag1oQXx9vmgLJ4nHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374542; c=relaxed/simple;
	bh=CVDQ1Ecq32mkVTv2WTPthkWQ3lAZURlPO2+YdOHSRFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNK2SPohb5BeF40yVNbeogIrDfyEsSHkFQGaKtWGbycp8GGFqyHXsetWvCVnFLdktb/LV0TCk687HxMYUrHzMhkCDcHn1NYHT2ewdEn3RM3mAPIlF4mDzQQUCPHOnAMOg20RyWMSPFEzWdiPtmjZb7UNtD5jpAZs1rYMrloYaIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cBROGUpz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cBROGUpz"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8YZ1rCLzyfh;
	Sun,  4 May 2025 19:02:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msJ5a0oYaJ/s3qvajVISY/Q6bQeFQhIlLqczm9Yoj+A=;
	b=cBROGUpzfJ/1JV7X/D3ioCfQIO7ZYv38GL6hcNtOOi5Ys0tHtVehgS+JHJHsXaqmlm0S+W
	uAfteIKt1IpjBhEHdscEeu8tZPPFSaFiJAbyHW/7dcunQIZW5zUGx5/Kau7oqZgsRXOV7k
	tstU9E8SEM596m9wOGSOkRum6uOaC0g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msJ5a0oYaJ/s3qvajVISY/Q6bQeFQhIlLqczm9Yoj+A=;
	b=YFLBepgOlRJ4haCzgpLdPLgN0coHZanvvNKZNQIB3xmAj7FTdsKRN7VVtJvoJFIy156qfE
	t0eoP1oCFbylqF/pUSYARa49hQm3rmPPK+hfljI8ZBHE4kiwWtXWzRJch4b7VPBcRF47wg
	uGom5p7J82uIlArjlja6pWUN6SfURA8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374530; a=rsa-sha256; cv=none;
	b=vt8OBXwovLWEO3I8aSw9RMneimIAG/tgV3Gdr3/EnFRH2xTnCwfvvQPEGVgWBIL6EafQz/
	k4k8OZ0U/G0+nTTZPmRd5xpzolrXFzui1y7PfLvyGiP7eni403gg6PNulxBzEtYFr6xQHp
	m80vY2+jPrTE019/2aSTh+U4xvdpzIo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 02/11] org.bluez.MediaEndpoint: add client role Reconfigure
Date: Sun,  4 May 2025 19:01:54 +0300
Message-ID: <ed7012536eeeccf3e372fba42f5ee17e31605f10.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple way for the sound server to reconfigure a BAP unicast
endpoint, by calling org.bluez.MediaEndpoint.Reconfigure().

This shall destroy all streams of the endpoint, and restart the
SelectProperties() configuration flow from the beginning.

Since it may be necessary to reconfigure multiple endpoints at once to
correctly make bidirectional CIS, add Defer argument to just mark eps
for configuration.

In future, org.bluez.MediaEndpoint.SetConfiguration() could be changed
to handle unicast in the same way as broadcast: only create streams.
This allows sound server to have full control over stream configuration
itself, and not rely on bt_bap_select().
---
 doc/org.bluez.MediaEndpoint.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index b81106f0b..ea555a7d3 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -115,6 +115,28 @@ void ClearConfiguration(object transport)
 	path given is the path of this endpoint, all its streams are
 	closed.
 
+void Reconfigure(dict properties)
+`````````````````````````````````
+
+	[ISO only]
+
+	Reconfigure a BAP unicast endpoint. This closes all existing
+	streams of the endpoint, and restarts the configuration
+	selection flow which e.g. triggers calls to *SelectProperties*
+	allowing the sound server to modify the configuration.
+
+	The following arguments are taken in *properties*:
+
+	:boolean Defer [optional]:
+
+		If True, mark endpoint for reconfiguration, but
+		postpone it until a non-deferred *Reconfigure()*
+		operation is made on an endpoint of the same device.
+
+		This is necessary to use when reconfiguring source and
+		sink streams with the intention that they be combined
+		into the same CIG, possibly forming bidirectional CIS.
+
 void Release()
 ``````````````
 
-- 
2.49.0


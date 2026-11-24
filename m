Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535616;
	b=fpEMc5uOs4OGB0ZFa15bV25QVpcTvQ1a1q7iugB7+ILRcYbLiUbXZ4iArve1TaLERtSE
	 QleHZXAQItWBQksxkDrKUZYmhIaMuZVxTkJZrp/iIRiiIA/QHzUdgC90g/jcil9nA6JiY
	 uNn+NUSzXvqzk+agczRWvOZxTHCjn4agjKOLcOkNSZWzzKJ1+9GJvspTFeOrbtw9kddoD
	 /JZUz4WhjllqUVT0pBrkNClbqDaGA2LAbIMmK1HXuc/YCZrq5oVOp/aQn2WiZXBxFAe0B
	 JX/NNmSNOQ2ymfiRZMWnP4u0EnJ+Gq1TnatIM/BdkGxjc3+mQ8kL9knre5Oyqa0qLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535616;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=PAtvlxiTEalXBeWFQ4YzPFQf0j4nMUYdSAAWEuAXq08=;
	b=X+RXQvAxlC5in4ZoU46SvWx7dhSZFTFydS8X3en1lkuncqqG9xUvFrAjPmqYHuBVdpwK
	 KMv33LoC/A13Vn2G5WT8SxzLLv3EcmxExmlXd9+kSApRa21GGNiwbD0XeWZQpBakFcP1W
	 yPdX3zbA4YielIPiNaELr5i6oUBqmjDgLItnRsLYhvxNhZ/gp73aw3zpmetpnktJK95AS
	 N0GG4PdBZCxcPoiF7AgqxC/L8F5P32fjMtBCajvKxwPyAHnKaqaife1MFSWj404BiXtZU
	 UifW33I1LY+WpuoK+/1jAgrNoCMvS2VLx43moI4hOU9Li5gKVJ+6y/Sbi6sV/4G7Vyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D38606A335
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50D38606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id BFB103F5A5
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 05/14] emulator: Install the emulator if built
Date: Tue, 24 Nov 2026 16:50:36 +0100
Message-ID: <20261124155319.1752879-6-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTGkBQPJBgyPp3EQcm81e1o6okEqvhg68CbVpV7cswzi9J34puYBUcRJblDMvhLWDqHk0B4IQEOuTrP0jemR+UlnuQBF6s+RQBIrWF2me6rXh4X0IfiZxsBBo+5ja+bxgJ1w3dPYvN60ahlXEBHvwwxXhfROQqxR8oh7NaBuAdTnR99qN9ElNArhTI5/fEBObzxTBYDDRV90DTrZYWVQrlqYQtDFdCVW5Q86cZ8Z7EYd8vUecONBX0RUZTpzr+cvizy+EUgnBDezhvgi7gaTx+eiUjngG2Cw9BthUGRuc7RRbx74AqH5NLJBGm64XpJK6j+rQiyyg19+JNOPFsqhIjMFCzJMtGKSVMPMNSIUGsomfmL9Otzxp9yBrrkZSfLoqZLQUmA989tvMaw0x9JgdeHXebLBcTR1aoLDhBTXBVzuqtTUmn0QTM+nTvVAF3kzm6S8XyZr1bJZ1AZF3SUy2mozQW3kHFKZAerIOK/a7L/F5P3zf+Cyb+oGnnmfZ+0+SHvOAMMAweTW+AohUpUCUbaueLTwj+yy0naf4aPXf2hLXmut8+zBE/C5fHu2EppGF2Gw1wyrUCG6B6Qh41O9f8odbeiGXw3I/sfdccYBHVm8OvtqZXxMCiMMjpwWWp1LIr2yi93buev+XU0AckcE40PikPzXiF6rrmlzaBHB0Q+4DA
X-GND-State: clean

It's useful for testing.
---
 emulator/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/emulator/meson.build b/emulator/meson.build
index f3be41c8cd3f..10447f6f5218 100644
--- a/emulator/meson.build
+++ b/emulator/meson.build
@@ -24,6 +24,8 @@ if get_option('tests').allowed()
       'vhost.c',
     ],
     dependencies: [ libbluetooth_internal_dep, libshared_mainloop_dep ],
+    install: true,
+    install_dir: pkglibexecdir
   )
 
   executable('b1ee',
-- 
2.56.0


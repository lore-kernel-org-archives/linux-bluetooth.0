Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535616;
	b=Z4wJQBSN7r29n+2zmxFULx34ikjKXyQp0tqtX2HJV0OkpFxXDxsoeKQOkPoIn1mgOJHd
	 kjAkSinLSIMrAIsbNiMbWUgv4nHZ/t9WXqOpcuN4LsQr7W1n3dPORLqxox/jpeeJ61myT
	 suF9RUGl39iIujagElbfhZzhGPsfjLLaUXMQ2BgEumchzAaDeif/w+G9I2zxBKHsb2e9h
	 pmwHczcHYVT4YdSFWNvf+SzBh9SGOlnQ1NI8SnBzR0ekLrqTMYcmBE98mmBPS9k60IF9v
	 59p56Vmx8pIkZx7Hflvrnd5//ykqrXtWABWS7w00Iwkh7Aa3QB/0iK93hbjw2RsoofA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535616;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-GND-Sasl:X-GND-Score:X-GND-Cause:X-GND-State;
	bh=mtpST4y2SZLbom7YAndP/4GEHyUxz2MyTrX4v6g+WYE=;
	b=ySL5nhxfysyhWRgldVTBQWCKzSmjc/PaWN0ZUBrIFIIzKltRXtgLOHOJJ+1fsvgrTC9Z
	 xKmZHTWVoKX0wtOIGbfuBaJAj+wRoVpqXb0cv1nFGrSR+QiJ3eOFY0Y7btAUtHnHmAzm4
	 dgPjoslj8a3UmKQgLiRhRDwcCNdV0MKKzBpk7d2ZboCPdLn37Tnt63IypMhwXnUimNBNy
	 y26oams+408o1h5AaDtTRhxYQKb7yw4kU9iB/pi+w86cSpOe/O3nN9BPi/Z5UHc9WnqBB
	 4wt21D17/d7uQWjlfwuTiNdIOSfIzwr6heWUj6pB5a6jigFwVkea2Pt4AZt9Uzv3bcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15D606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E15D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 644993F5A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:28 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 03/14] build: Separate systemd and libsystemd dependencies
Date: Tue, 24 Nov 2026 16:50:34 +0100
Message-ID: <20261124155319.1752879-4-hadess@hadess.net>
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
X-GND-Cause: dmFkZTGkBQPJBgyPp3EQcm81e1o6okEqvhg68CbVpV7cswzi9J34puYBUcRJblDMvhLWDqHk0B4IQEOuTrP0jemR+UlnuQBF6s+RQBIrWF2me6rXh4X0IfiZxsBBo+5ja+bxgJ1w3dPYvN60ahlXEBHvwwxXhfROQqxR8oh7NaBuAdTnR99qN9ElNArhTI5/fEBObzxTBYDDRV90DTrZYWVQrlqYQtDFdCVW5Q86cZ8Z7EYd8vUecONBX0RUZTpzr+cvizy+EUgnBDezhvgi7gaTx+eiUjngG2Cw9BthUGRuc7RRbx74AqH5NLJBGm64XpJK6j+rQiyyg19+JNOPFsqhIjMFoLNpf0px+oN2TWhSyHxlLBG82xSUO5vbpBd9H3Fbt2TOfRdTFg7Axr3e+4dP33D7f3CInp6+EgAew0z5SUypPnwhXYGnpjJAXdWRbOX1k/dnPODnWEydlfBfHxqbEeh0HKBB5HJB5TUD35jp4kczeDM6H/2xG15Pbc0z1bVcky3+ZmKXuNRPCDv/Yw0RSm+hlblCkxeNvVn+MVZyn8jg5b1pfBHg2dfzLuPOy3ZKM1Ddgxq1RI3l+F4FJwAyFUKln8csCf/wOR0t2JG3kBZHo/BXx4uSVUt8+fknX9CDiqyxdPSgvRsIfCcW5eh1Qo8/vD/nv4i4CT85cFyDv8eE9A
X-GND-State: clean

One is to install systemd service files, the other to enable deeper
logind integration into obexd.
---
 meson.build       | 3 ++-
 meson_options.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 178a1659b401..a842ab37ea96 100644
--- a/meson.build
+++ b/meson.build
@@ -148,7 +148,8 @@ readline_dep = dependency('readline',
   required: get_option('client').enabled() or
     get_option('mesh').enabled())
 systemd_dep = dependency('systemd', required: get_option('systemd'))
-libsystemd_dep = dependency('libsystemd', required: get_option('systemd'))
+libsystemd_dep = dependency('libsystemd',
+  required: get_option('obex').enabled() and get_option('logind').enabled())
 
 ell_args = {
   'version': '>= 0.39',
diff --git a/meson_options.txt b/meson_options.txt
index 4a0c726c2098..54cfdbb0d7c1 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -6,7 +6,8 @@ option('tests', type: 'feature', value: 'auto', description: 'Enable testing too
 option('tools', type: 'feature', value: 'enabled', description: 'Enable Bluetooth tools')
 option('monitor', type: 'feature', value: 'enabled', description: 'Enable Bluetooth monitor')
 option('client', type: 'feature', value: 'enabled', description: 'Enable command line client')
-option('systemd', type: 'feature', value: 'enabled', description: 'Enable systemd integration')
+option('systemd', type: 'feature', value: 'enabled', description: 'Install systemd service files')
+option('logind', type: 'feature', value: 'enabled', description: 'Enable logind integration in obexd')
 option('udev', type: 'feature', value: 'enabled', description: 'Enable udev device support in tools')
 option('datafiles', type: 'feature', value: 'enabled', description: 'Install configuration and data files')
 option('manpages', type: 'feature', value: 'auto', description: 'Enable building of manual pages')
-- 
2.56.0


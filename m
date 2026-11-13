Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546891;
	b=sKde2rVYJ27QcyafsWiP2qTj/ZcFanaKv4Di3map2P9vRxI14Y6Jcz/jhnKx5TJLMzsa
	 jj0ff9wuEJFt+sJiDjvA1KeDbN2BbQeOammsThWMES9UoVJNXKTVelLalRnfJsxte2bpW
	 4dUetJO5eG5MOgO8UQyd5dNf2gL8H8FPgmkdGbl4bBWBxP9wVBEp8YmQYIiWVFicugv7Q
	 EHrJGQgnUy5vGXw3GMoXyLl0LMPumDM028jKwd/w445yBQPP/XCOWw4APiTsJ4FxcMggR
	 zTh6rw1HsIYWCRIpEKPhACzroz4rhiRRly7eDOY66Endu3ijb61q/4OB4jnh3qyGABQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1S0PUCTqOS8eFXCxu02A0PzNb/E1NG1VgSnLMk+Sf4k=;
	b=TY6rr72A43BbrmUy0yMTdQ6UgQNF8E+3uA63GgqIiffRhazA+uBNuU2ovTyP5jmXf4rI
	 MteyODITVOwQtOu03Du1ZtIiKsXAePtEX51E38vRgA1GD9anVJn5j5Iq5FZaTYPkuzCFe
	 31MxJu1b4vCLG9yB+6Rlck325nvm9coumZ6Kf9UXfjt59WOQByyAOA18LTtXSFlxoigCN
	 mQSJva90dzSv5+TS/zBtRmbdLoJZUNUKZ5PZ81/f14bPhs3CkZRRlAnF4kIqnX9ZQIzOL
	 Nn3atckY3ftWjYhCluVlVJ8jaL00+xv1YhG4CunwHff9oNrbMADATH1sO9pEOZS6P0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=iO7hO4qs;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484D606A334
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 05:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C484D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=iO7hO4qs
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1216327eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 21:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794546890; x=1795151690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1S0PUCTqOS8eFXCxu02A0PzNb/E1NG1VgSnLMk+Sf4k=;
        b=iO7hO4qsWLWs0qoHHEfD6X4tWVyarfXfEfedy+xNEJ04jxs1LXyUCFM9F7V7z6JISp
         P3G8l/YVdghjWZ4O5R9jAJpNX0MnC30eBf7zD9MOVjL/iNYpft+rnW0MaM87JYx+pCW+
         cRKtjVAfZq3m8V/g8zBWgeHNLJRC/KwkKqNWevyKqVmS57icdRaHkivOUVKZuB3ROStE
         qrQAORlERNuGQCZnS2W1GgKtmnuOhFQwNoRVwSZCIsVbKHu6D4HsWvk8a/iKlgBMjcfo
         kyKX4SmRVGyBhkvBFAkmULhrZ1dk0IYNZrfcetSHutibytepKr1bnOvHKym3TAYHDwU9
         gjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794546890; x=1795151690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1S0PUCTqOS8eFXCxu02A0PzNb/E1NG1VgSnLMk+Sf4k=;
        b=kz+FD9MIFNJ7gM0JUGE1ZJpYkqvHJAOkZP/7tGXO8WeZqVsJNWd1BQmPlhXMdW8A73
         qiPIy35mX2z2ePVJ50/+RIQM0IBHzVu58bM/q+z/39ZwyP4Z+o6vQWCoaEThzIwWBPOE
         BUmqyGvUK241V/s1nCYOfopnSXy3y4oW8FbQElyonD1NNWoUrVqnTqDWa65xIzwEFXrn
         XP+NdjJfkXvlI8d/Khf2Xcpx9KWS5VzfQga3iqeiYIN9Mz5Ie4+n4tXSPogKYiQEHHey
         Z2ifFjppOYr6yjBF0bFYJK3K1vWL4ZIk2oNy1yv8WYzKeMbJS0QMwzRECCqrgPu50WQ0
         HtZA==
X-Gm-Message-State: APuU4Z+UPJvZBIzHPZ4obT3ydvJ3xcIel1JUpUm8PLW6B3psVaE1A2XE
	/p0ABr+ps9wvsLIFUo0lx7t6dOjT7gBBS8hKZwBsOky9hkbc3aLhzX+HB3/TsWQTYezNXWgDKjq
	ykRx/gcY=
X-Gm-Gg: AYBFou0uox7s3lrC5YC14gLasnXTwp3axxYt6RPbNHAvzjcdAV1Q2gudOQ/YTyfk+ge
	SRD9GppK+U8b/7bgU/k0sasmR5i4d/4HLysMKXUk317Lp1K9fMvMalI32BGGmE5oME5bOfkQzA3
	HRjPZJOl0TR6bVoLFilftnbHXbEbNgVuKwaTzL4MKI52d7XKNq6XW60+jbXy4C/IkWp4sXPi65c
	lO3Ga4AbzGeNS8fEsxbE/I+KaYgGK8tl1DXyjRRyGX3EiVI1+rAblw1XzJ2b68FavzDkAWU+R0E
	pXgrtZ5N74c+OAUwdeSk3WVuBysFkyMGgZfYTWjTzzV0XVEkHotXiV2949IxbeFHmtrfuG4njGv
	kjL3TuB5rascwmtQsWD3M870MoM2oUsuccuUtxQ5ehdxgSb7Bv27Kk9h9CHNZl9tUTS6Y4D9xDR
	ekbXEOGCO0rX6Vd2FMHAIfZ1oS+M0yIC2vMR3vMM15uXH1vo53gLGx8YY3zAgOtbxolf6K+bAYp
	Bhi9Vsl38gMa53MOb4X4EeP5H4zwq8F6bvGE+tfZW2z0EFFRHks78Uuy8BLyXygqMy6w/CmkvBS
	xTaeo3Z6fxMYyTwNcZcpY/2HHflrEDvLvrgwGm2NSHPTE089iUTuaii8LKquwM2Mei8VgH3Vd6H
	VremW8g57zW46+iOzMp6XZzgo+07IrnAiNLCpif5fTNAuhD4TEQCMAR921HNGvNI0RAM9Z8I=
X-Received: by 2002:a05:7301:b10:b0:369:ef92:bd7b with SMTP id 5a478bee46e88-37967be1271mr1219819eec.41.1794546889811;
        Thu, 12 Nov 2026 21:14:49 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955a1c5c2sm3597550eec.14.2026.11.12.21.14.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 21:14:49 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v2 4/4] test: functional: add bearer ReadRSSI test
Date: Thu, 12 Nov 2026 21:14:38 -0800
Message-ID: <20261113051438.75230-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113051438.75230-1-kevin@simpleble.org>
References: <20261113051438.75230-1-kevin@simpleble.org>
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

Read the RSSI of the LE connection from a host with testing interfaces
enabled, check ReadRSSI fails with NotConnected once disconnected, and
check a host without testing interfaces does not expose it.

Assisted-by: Claude:claude-opus-5.5
---
 test/functional/test_bearer.py | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
index 59ce8ef7d..41134221a 100644
--- a/test/functional/test_bearer.py
+++ b/test/functional/test_bearer.py
@@ -54,6 +54,9 @@ UPDATE_CONF = LE_CONF + "[LE]\nMinConnectionInterval = 80\nMaxConnectionInterval
 
 CONN_PARAMS = ("Interval", "Latency", "SupervisionTimeout", "Subrate")
 
+# ReadRSSI is a testing method
+TESTING_CONF = LE_CONF + "Testing = true\n"
+
 
 class Bearers(HostPlugin, EventPluginMixin):
     """
@@ -283,6 +286,45 @@ def test_bearer_le_conn_params(hosts):
             assert host.bearers.get(remote.bdaddr, LE_INTERFACE, name) is None
 
 
+@host_config(
+    [
+        Bluetoothd(conf=TESTING_CONF, args=ARGS),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+    [
+        Bluetoothd(conf=LE_CONF, args=ARGS),
+        LeAdvertiser(),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+)
+def test_bearer_le_read_rssi(hosts):
+    host0, host1 = hosts
+
+    connect_le(host0, host1)
+
+    for host, remote in peers(host0, host1):
+        wait_until(
+            lambda: host.bearers.get(remote.bdaddr, LE_INTERFACE, "Connected") is True
+        )
+
+    # The emulated controller reports -1 dBm for every connection
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "ReadRSSI")
+    reply = host0.bearers.expect(f"{LE_INTERFACE}.ReadRSSI:reply")
+    assert reply.values == (-1,)
+
+    host1.bearers.call(host0.bdaddr, LE_INTERFACE, "ReadRSSI")
+    error = host1.bearers.expect(f"{LE_INTERFACE}.ReadRSSI:error").error
+    assert error.get_dbus_name() == "org.freedesktop.DBus.Error.UnknownMethod"
+
+    disconnect(host0, host1, LE_INTERFACE)
+
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "ReadRSSI")
+    error = host0.bearers.expect(f"{LE_INTERFACE}.ReadRSSI:error").error
+    assert error.get_dbus_name() == "org.bluez.Error.NotConnected"
+
+
 @host_config(
     [
         Bluetoothd(conf=LE_CONF, args=ARGS),
-- 
2.54.0 (Apple Git-157)


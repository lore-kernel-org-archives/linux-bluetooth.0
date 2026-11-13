Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590629;
	b=bDA8iFczXh8Wkpdp+ImcSmGfNt6mN0/ZQzVYi3VQVSSYnJ0tJvQnajp8Dak0zwkS1Paz
	 c8OjMe2XgRQ6TvbgWYdmC+ZCk77B+Z32UU+EF3e874d7ZJr65tBNcAXrNJ0BmuNitq4oq
	 IxotGxobfEyTymCjnSEZ4pnjledQ4tMA6/bghoHrF0nRPjHuGDshTkqYoWSwWYQBgh2NO
	 y7RuPqeKH4foxTCeWT2N1GbLUEYRIeuudAnmi9QKuHuU7nx0g78Iddc+SBbINHhQCRehr
	 WW8iB3ZtP3h4NC5QvhQsaN0YcE0ox9mZffLKTcv4+7jVs66RS6mxryeeI45eHerbgYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
	b=QM+GpgpHLIXqWzRr35lrc8x52VW0/Yw/+GKs1e3CVnpDDQzBCjui57ZufGZ+niWcdkfd
	 gido6lQLvUrrqcjhkCTHbBHZnDngipmpkqL0oOfrPUUQBR6WLO2Je4dNM4RoHKZlbQBtT
	 Lr9gQYeN6JwCowbwzpH9LhM6ZZM7EmiewJiVyZDwpWEONy+1rBOQiziqYHylnQPaQhTAZ
	 UUIcUbf1lztsUmZVJ6ZVuq9CSSSHExlp5pUJJfNBQfbopwBSpuGNhWBKA9ePhTZs1KbPk
	 T/g4sJmyqEfwuHMmKGq92mDHdOGkSC7D4o5ml0HeckQUfwKrkQkc3iUBVzx/M7LEwtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=GsN5aGJU;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCE360A260C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 17:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BCE360A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=GsN5aGJU
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc758830601so1861367a12.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794590628; x=1795195428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
        b=GsN5aGJUO7qzJDMFWRS/CSJldQJnZdZGl12ZBu43Q/1DjsUp9vYgPM9JmpWfGXqw5m
         6CppFLhkXXNyzjF1aSTZuBC6hjyjd2BcRnaVcjDjugFagV35KZkXrvU3UPc1AIJcQUWl
         +YahIRP+Y+ZSyI/lFhxjG4FnVREKHSjgX/5TDrJ2P3Ex4xkg/fGIiH73p8o+i1ucSzUP
         Figu/KhkgwO99gDpXfrCVteNEGNibUojIfiTVtLPZqORIbScEvPZNjS3gsdeylCAvrky
         z/RM6m+4T1dcI6TyFWKIdMusIORBkaG9G+s442mmI7S6xpk79ibkl7wQYLw3AVM6CsEs
         tveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794590628; x=1795195428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
        b=QT67zL0AnrjJ6k40hyW7qXP7XaP0baSuiT/ZDRY0T6HS5Wrs3pmGR145nNwAdqKzfx
         qH17BwKvSNzquWqaNiENwo94Yle/eQ6F9aRzQe53TnAP6760UIxYg0Ymoe+HrYql1CiH
         uCSWHSC0Zbo4OTVSVOGbMdoLHN1o7xzMReIh8xH+IjAek+Jamw87U1NtjRq87hFnxlAm
         UUVgLYE8/W9qCjHyZCS+4a8sZ8bm60OMdE5lfwUmf2sai2ZMSxRAVGX4m6CyprdktTHO
         R3J2Q4FxPXz2KKyZwmtn3BBkaB1wXyQJp87OpgZtZjZRI22QEXkyyrNpyCk2xnjcA4+M
         T5VA==
X-Gm-Message-State: APuU4Z88PbpMHKMzkhwdcEsy4tTTDVa/PuJOjTYhNZWHkVDeZ7BR6uOM
	JhMNMC84r+1Ekpt4TiJ0YXD22MQz2/+010/LO/LZdxFh1M3qunJlAbsJjaF2sRloSGooTv0xIOt
	5MqesUy3xTA==
X-Gm-Gg: AYBFou0gdlFbxW/Ar/bqavsWQBKYjCcx3M0CeQRUjIwTH0tNxLl8ViN/+9/8CfM5On0
	5eTEoCjdktdDtpk5wNwvGFao46E7PaUQCh6x3g164cdRXpBoHadxqsp+fcfeyQAnseuQzK5D3gy
	IVBvM5dK9O6xVBVwUDa62wPQ9aPHsLR/Gu823JYxhw/PysxSzet0Tujs8EFv1EErcSLcoHtJM5q
	FK0BdSdD56uGubd14iLLDNj7lsOrJthIGu+oEgE9601gGS+kraSyUeGAWrmLS/P6ZAmxnIQL/zz
	RtSFaIoxQ3gx7vm4fjxM3QoC2BO0Leq1Px/BxdTWUVjfBoGm1KbmgKNQmslXfo64R9g9SRCl758
	I15QrVg445KYF/aXwUKGTPNceXMGNK00Ix4x9mibOPWshflJ0cnp+oXdt2D/azKi2lC+0kNrpaG
	FR6d/btQwcUaMNZqJm21kBzBsRoBodcniEm8C11lSJdEArzLUz/jzncxm8uZqWfUvmFftVMWpEe
	sodyUnqJPmKsUujDEnZrbPQkClNLNd9SegJ0wD+zPFePIx05+CX4LsE5xa67IbIegeEK+k0lJGY
	tKDVDayHUwgQIDqKOHBapDChgLjN0fUZNI2o4lPsMmRyNG/KRx2wgFKYCX20nAZ2OWtQEDiu2mk
	VxsmJQkCh25aTIPSJ5PMv36kxD5oRk49ay+T29jhi59FNf1OAlPsmxBXHiSug8S6x7XMgjdjbox
	5FueBb9Rka6q1AUhcT
X-Received: by 2002:a05:701a:844c:10b0:1a2:2da2:b278 with SMTP id a92af1059eb24-1b5030e2b35mr3230456c88.14.1794590628172;
        Fri, 13 Nov 2026 09:23:48 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e008sm8151800c88.6.2026.11.13.09.23.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 09:23:47 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 4/4] test: functional: add bearer ReadRSSI test
Date: Fri, 13 Nov 2026 09:23:39 -0800
Message-ID: <20261113172339.54683-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113172339.54683-1-kevin@simpleble.org>
References: <20261113172339.54683-1-kevin@simpleble.org>
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
 test/functional/test_bearer.py | 58 ++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
index 59ce8ef7d..3f1033b35 100644
--- a/test/functional/test_bearer.py
+++ b/test/functional/test_bearer.py
@@ -54,6 +54,9 @@ UPDATE_CONF = LE_CONF + "[LE]\nMinConnectionInterval = 80\nMaxConnectionInterval
 
 CONN_PARAMS = ("Interval", "Latency", "SupervisionTimeout", "Subrate")
 
+# ReadRSSI is a testing method
+TESTING_CONF = LE_CONF + "Testing = true\n"
+
 
 class Bearers(HostPlugin, EventPluginMixin):
     """
@@ -206,6 +209,22 @@ def conn_params(host, remote):
     return dict(zip(CONN_PARAMS, map(int, values)))
 
 
+def read_rssi(host, remote):
+    """
+    The RSSI ReadRSSI returns for the LE bearer host has for remote, or
+    None if the kernel has not finished setting up the connection yet.
+    """
+    host.bearers.call(remote.bdaddr, LE_INTERFACE, "ReadRSSI")
+    event = host.bearers.expect(
+        (f"{LE_INTERFACE}.ReadRSSI:reply", f"{LE_INTERFACE}.ReadRSSI:error")
+    )
+    if event.kind.endswith(":error"):
+        assert event.error.get_dbus_name() == "org.bluez.Error.NotReady"
+        return None
+
+    return int(event.values[0])
+
+
 def connect_le(host0, host1):
     discover(host0, host1)
 
@@ -283,6 +302,45 @@ def test_bearer_le_conn_params(hosts):
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
+    wait_until(lambda: read_rssi(host0, host1) is not None)
+
+    # Controllers report the RSSI of a connection from -127 to 20 dBm
+    assert -127 <= read_rssi(host0, host1) <= 20
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


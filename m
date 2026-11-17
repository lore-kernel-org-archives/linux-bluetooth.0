Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939724;
	b=XQgVVvnlNb6THyoswjIVNlvhAcS9majJbZ+Iv/40TGcBjZIY0+J5hO/Wh/XWMAthKVCE
	 QgUStlDNOQ+5p36/N9GYe2l7ULUquhpxuNbiBdbjtJuBx17K/yKjNcRQuFO4LvIR8ICOw
	 Kjw778EnkKbAOGQ/eRRoAGShGNn7EGNV9Es4l+Hn9bP3irT5rqaeJ2Z1+ZwKfFJWphVgz
	 I4fhtZ4WSrLfq8u4Mv1L7WXnXyssMISh+2nqAWVHonzwtg6lKhShJ6hxBaRRAvJ7O1Jeg
	 uVtJV48Nfq/Sr2jDSiICeCtuEwhkF3eIo/SA6lLXT0TzUdtHPSPkW6ycqs9hX2xQ+VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
	b=1mwJ5XK1Qd92uQyYcCXi9VcG7N+iLOXMikqlszYkpIEgXhbsfnOdrl+X7VSBBuW3Eous
	 DINTr9JVTnQgSfGz4s5ifOshbRyFu4azjKWfklt8aknoDsT5aqptgStGWvepJuL+Hms/B
	 CiNVY26JdKifOsze8ixF/6lRvzLP5EkgGtiWY0xT/E1vJ4h6B259Dpj+iZeLqjKhr4QEr
	 7FOLa4W3cLbV/u5z025QUW5QFR30231BDRHS145p9igZtm8jgo8EeOTHf59wbWHNLq6SB
	 HNZEhCr6CAjzhNBKPrp+UpV9YkwQqTXlvFo0g+6B3iJ9jk7PMScKNDmmvTIHSFa+mYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=O54PPThV;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5938F606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5938F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=O54PPThV
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so195170c88.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794939723; x=1795544523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
        b=O54PPThVekFf3Gzp4sQYj2+JeYts8oOTkpd8tm3gXXezy6zn3o+xt3deHIq75vEBjM
         K44TpYgkXMg1BsW8UrH9FVMUUBywRgYNELWtvDyJ3qyyi/o04zJoNYlOlp9zhzRu7mv2
         2yAlvHP3ihwPXAefF/d0h3RVEgtQax9/2hfCkVkzYPZCtizvOlecyMatI7tY/rR88cAx
         lkkaAcOVVoRUhx0+eajt+MJ0ZaoQEQX8+C+gqUwHAp8IFSc81bGtrJ8mPpfAWSOaCF66
         Td9Ag+3h90j0+GL4J7r6sz94j2VPg+leZiSWcVye1DWlwHrRZbVaX4SKojg1BWyTP5DX
         bFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939723; x=1795544523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
        b=BQc77SrJYy5rfPJhgE7bDc5yBIqSO1eJplQS26kak5uy7I3fPJHTOSI0UXEncP9YIJ
         3wO9xwdQW9Rn88a6xhM32DRBYkANMAmy2nWMgy8qLciDxq4HZDkLWyER5GhkFA8UP/ee
         8FV2U4VqZJ4UHQgIwnBlR/fR6MdcmNxxpJsejAmGoq4xgpCTIFljiwLQXnRUr5itL75I
         tWnIJ/VPr3PF7cjORi/lM6xXbs2H1VnUBml87qQUCZHunWHSQFJrwvDuiJ1AhMVGucn2
         1/fKhlZuPi+g/XtRL+l2tQY6lHWp7PwWDhWVsqlkoV1qkItb8dbikjLgE0mAPck4bW/L
         Hkkw==
X-Gm-Message-State: APuU4Z8sFTvHCbBf2AVQwRL7gv5Tj+zBENVePWtVIf5jvb6fKlHr8PZ/
	yxdKv43y4Q5ir8mNp2sJa+xvG15+bnhHAI3NboSYOZRrE9LptlRvt0Fp7BScWX/Hax13wtnTotm
	r90lfZ1E=
X-Gm-Gg: AZFdTZckrvUoKhNalvwF1sPuCMLbPRzLWcGxgORcAHhfkRgngXEagOET0VafEjV2tPb
	no7PJj/x5UVszahuCR+rCBamKrZYnnso3iM1L2Yc+XbzlAeN/D3CBpBoJpYZwIn8OCO2o4Huz/U
	IK76Xd4cNoGo6RJWLW/ATGXgP9gRpk1Ho0O+DVbR9xU0XW2uqj8LnJdjvkx8PyVMnjVay05myYQ
	FWZrCbyqww8n4r5pCSX1Fr6zj0AHGLrRtAO8mX2wzq28fv0OS0DLrgscsgQamXL7ARbnMMZhOM1
	r1cVpwMmlILFirsfyorEEq1vhwNZGwXQVQ7C/FcyPw2sk8gG8Y8WilQMTnEFgAxtgp8LEsf4Zie
	W7B6pAr37GlTkuk8wnp6eyOM7poDcuSXRLbq+vSrNMZXnz9mCZCV/5PzsFQsDD0vBphSlwGRuG0
	IWxUdHXzZmZWldY9uHBh4TcH9Iyss0JCdTxTT3FG8MSFI3bM3OTU1xTmnO/rRXieAvSCStGNfYf
	kQ49yKdY7Kj7HYfBj4dMr58bx1K20KEq+rMraq3gFO64t5hn8GagMULgh60qGt8UlelMZ13wiuD
	l1hIBRm/qJaAfb6IuPniLo3I3mocEQAHTAJExQFruLd544YMcnVd7z2ywgPPvPBjv6RrTOkvP35
	DYDxT4ueOocxlafQEJdG2+i89dITwao0wFS96cbcqi2x5DuzysG/mABOfGfg5Ni7Ri0GU8hQ=
X-Received: by 2002:a05:7300:7f19:b0:358:dfed:d0fe with SMTP id 5a478bee46e88-3827d81f0c0mr281115eec.5.1794939723061;
        Tue, 17 Nov 2026 10:22:03 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380d5135221sm10503213eec.24.2026.11.17.10.22.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:22:02 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v5 4/4] test: functional: add bearer ReadRSSI test
Date: Tue, 17 Nov 2026 10:21:51 -0800
Message-ID: <20261117182151.73722-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117182151.73722-1-kevin@simpleble.org>
References: <20261117182151.73722-1-kevin@simpleble.org>
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


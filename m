Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690880;
	b=sC/UrvIJJ6YlkipJ2DZvMaWe40fDT08IbI48H+5dh6f6dTbKzjs9i5qGOC13guXDO1xW
	 Dyu+aaNTaP51BBIX/MyRn7SP6RIqEFNzku5QvgwhhoPi//P6PjxOcLxwXVk+vsbq8Y2QR
	 rh8BbqsHUk6zq/N9eH3d49AGM9Z608Zlq0T1h3F4IV6wIu8xXFgKLhw7/ZkrvzNDNg3Yn
	 a8yzL+vbK7hJu0t3dLQmh5WbknYmZ8MC/StW/2z9vTh0LNwCOLToYBtefUFY+cqJAD5gV
	 rgT7nt3hDYksIgHOa//PQTGwa0yonEsSGcz/noOxKssmjqEwqDfEFcc8IjkQRRIM9NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TWag0FRpuiOenAvvfnrRZiSGw9X4a/4KpNjP51N1+2I=;
	b=GbtJFI6UObPwDWjt7EKZ6Ly1aAA9Pll9EPQQzUJ3tZBSBIKOmtnWzc6rSE/694vtV+Xf
	 Pwv2sqdsRr+8kWzWCqDcMgbAR+0rq9BPYPmvkUIAXxSJSTE6TCr2eUoM+LQuPXerpyTwl
	 Pskr+HOVCv4JNHNT6gMKY+kj9WjRR4tOtkpoNRU2eFYFbDHwV56Is7hYesDJICGZ28VJq
	 2xcZayllQlK2hw56pb4UoBaO6Dvouf5AXERoy+6iAnDvSLNkazDSJpn1GDH6QA5bkbucT
	 /fiWjFlo3ZKLkOsNQI1WeQjDJbShhmM/Htos27RWLdFE0zbO8Z8PT6eRZzSqhPkC4vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=THzzFEUP;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BE606A335
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 07:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 944BE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=THzzFEUP
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2761c69fbso6451847c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 23:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1793690879; x=1794295679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWag0FRpuiOenAvvfnrRZiSGw9X4a/4KpNjP51N1+2I=;
        b=THzzFEUPpHrJK8OgxbpVoXSa+4i/XPRRwEae/M3giCwrk8ydNcB/8nU5IOkaP8kOQ+
         CB8PUnuZSu02bRvHOmuNBIEVsnb6sEXF2BxPt4MJT3Wzpj2li2am6qiZB4Axacy6ynpB
         yR8oEbPDCmNRO/CHwaPcTvFctNIWMxIM+nnWg8O71E121RFPJOAxMuomV9SDLEQexFrg
         /bg2QrNL75Cn50OXVQ/E04xILoFTlQSL3FdiiHShuVpG41x/I0aImAy2NQIDgvCFnZzw
         KiMZuGYr2NSAX/DwPZwkRUFhopfV9SYZoUdfnVCq/SdTn71T7JO8WnbtqBjWmu60Jcdf
         kqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690879; x=1794295679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TWag0FRpuiOenAvvfnrRZiSGw9X4a/4KpNjP51N1+2I=;
        b=uSWa17bZopbEMmXtBnwxD1iE4Lih8rVONw8SJdiP/9jI4CDtWqXvHb4LF6uSRextyw
         w227dKJ84f/V0LkWPk5/miHb3IAGxmr6nZlq+8Rv+zaBj0tasIFKulgYYeut7ZPyU698
         OG35J/E5npkmSB9bXDX+BewOt0p9fQfEr9ftqRrgTXlW40I1AVkIcjl12qO5wZt0eEuD
         PX1qeN13FElfO7Liuyiw80uvKylMKX/SbqOyyf+6ISvTYAlYY1YBkEUjfloaddri4Vkt
         BObokenMBUOWSJsVblDl4M+lnz4vpVgj8ODRHbMaDr9LHRUxTpM0SoW3fzqtNUzzoAQ1
         jh7w==
X-Gm-Message-State: APuU4Z/RImy+fj0rTRxEDc7th/vRplwKzvRGsxGfTDEdYd1U7/fwcA6F
	aBZlgWWZeKiXX/MWznUYJWUfS11stw2pkx/z5WeIZFwWm9qFiCerTYD+J9DZQli81rT8YEvHWg0
	QvHRUSAo=
X-Gm-Gg: AYBFou03cJnV6IYYjZejkbPUzVHmsAw6PoK3Ctq1R1thwXZJRSXSHgwMusQTr9Fw5A3
	CvzBIZTeWB2CYVTJT+qrNuN1AePA0+03DfR2cFBbKNsFnlVF6vDaWApWXQQ33Rs+26s5KQjbuUI
	l4NmqBAIHvDntDHbYYhr+xAc+JKIO4ZQYz7oJUTx8kunN1odWVoNvLY3TjQ7whHcgheJcwjKemt
	3jtx22HyC0EfgbgkXs+HrJzdR3qpLSQvXhjiobUCCHzddAaP/NIK3PRuLRv8Jap92IFGNgjmgHq
	dLDPH4IUAN0PGybKTRffN5tNijfU2JlIyLcyXCrcTrOWCPoq3UnF444gmZKenFH5G3dWt41Bhf6
	+Q4C/CfbR9dzmQVwObXWw4SgwuXfY/8D4rSuczjDHatSbX8EDcBFjP4JNNoA2Yxq53fr0izXzqC
	19sronKmDfUmyDUGm38G1u2ZPTJn1B6z4rGb4nBxpu2Wy+Z0YJz5+zImByChP6Le+eOkI/mgvzB
	thu72WcsUdONYsi+rpSrQVL8No4ys1cT/ifhyP5q65Jr8l6TGt4CgMn5FNbTSx8Fx0RaQPX4sjq
	V/bFQcedwQd4wNrJ9DpfaLjEBgeSXJtiAOKZ87UAaAznpuuvwuOnyyeeuF5AlqwjdvrTcImv/cL
	ip9Uaa4fRoRVfkc/RydWPNA7PuaPb0oibMb5SLVRxzGEsD2bUP5mmFhJ27E5020DBfFdyHRQ=
X-Received: by 2002:a05:7022:d98:b0:19e:fbee:5167 with SMTP id a92af1059eb24-1ac5ab53b29mr17007036c88.21.1793690878277;
        Mon, 02 Nov 2026 23:27:58 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm42437988c88.12.2026.11.02.23.27.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 23:27:58 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 5/5] test: functional: add bearer connection parameter tests
Date: Mon,  2 Nov 2026 23:27:49 -0800
Message-ID: <20261103072749.50979-6-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103072749.50979-1-kevin@simpleble.org>
References: <20261103072749.50979-1-kevin@simpleble.org>
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

This adds test_bearer_le_conn_params, which checks both hosts report the
same connection parameters on the LE bearer while connected and that
they are gone once disconnected, and test_bearer_le_conn_update, which
checks Interval follows a connection update the peripheral asks for,
and documents them in functional-bearer.

Assisted-by: Claude:claude-opus-5.5
---
 doc/functional-bearer.rst      | 43 +++++++++++++++++++
 test/functional/test_bearer.py | 78 ++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/doc/functional-bearer.rst b/doc/functional-bearer.rst
index de69b489b..8331a2a6d 100644
--- a/doc/functional-bearer.rst
+++ b/doc/functional-bearer.rst
@@ -62,6 +62,49 @@ test_bearer_le_connect
 	   ``org.bluez.Reason.Remote`` on host1. ``Connected`` is false on
 	   both hosts and ``Role`` is no longer present.
 
+test_bearer_le_conn_params
+--------------------------
+
+:Setup: As above, over LE.
+
+:Steps:
+	1. host0 connects to host1, as in test_bearer_le_connect.
+	2. Both hosts read ``Interval``, ``Latency``, ``SupervisionTimeout``
+	   and ``Subrate`` on the LE bearer.
+	3. host0 calls ``org.bluez.Bearer.LE1.Disconnect``.
+
+:Expected:
+	1. ``Connect`` replies.
+	2. Both hosts report the same values, ``Subrate`` is 1, and the
+	   supervision timeout is longer than twice ``(1 + Latency) *
+	   Interval``, as the Core specification requires, which also
+	   checks the units of the properties.
+	3. ``Disconnect`` replies, and the four properties are no longer
+	   present on either host.
+
+:Notes: The values are not checked against the defaults, as the kernel
+	of host0 may keep connection parameters for host1 from an earlier
+	test on the same VM instance, e.g. after pairing.
+
+test_bearer_le_conn_update
+--------------------------
+
+:Setup: As above, over LE, except host1 runs **bluetoothd(8)** with a
+	connection interval of 100 ms (``MinConnectionInterval`` and
+	``MaxConnectionInterval`` of 80).
+
+:Steps:
+	1. host0 connects to host1, as in test_bearer_le_connect.
+	2. Both hosts read ``Interval`` on the LE bearer.
+
+:Expected:
+	1. ``Connect`` replies.
+	2. ``Interval`` becomes 100000 on both hosts.
+
+:Notes: host0 connects with a shorter interval, which is outside the
+	range of host1, so the kernel of host1 asks host0 to update the
+	connection with an L2CAP Connection Parameter Update Request.
+
 test_bearer_le_connectable
 --------------------------
 
diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
index 69eed15c4..59ce8ef7d 100644
--- a/test/functional/test_bearer.py
+++ b/test/functional/test_bearer.py
@@ -48,6 +48,12 @@ BROADCAST_UUID = "6e2c1d84-7a3b-4f50-9c1e-5b8d2a7f0e13"
 # other host exports, which would need an agent reply in every test
 ARGS = ("-P", "midi")
 
+# host1 wants a 100 ms connection interval (80 units of 1.25 ms), so it asks
+# host0 to update the connection once connected
+UPDATE_CONF = LE_CONF + "[LE]\nMinConnectionInterval = 80\nMaxConnectionInterval = 80\n"
+
+CONN_PARAMS = ("Interval", "Latency", "SupervisionTimeout", "Subrate")
+
 
 class Bearers(HostPlugin, EventPluginMixin):
     """
@@ -188,6 +194,25 @@ def peers(host0, host1):
     return ((host0, host1), (host1, host0))
 
 
+def conn_params(host, remote):
+    """
+    The connection parameters of the LE bearer host has for remote, or
+    None if they are not present.
+    """
+    values = [host.bearers.get(remote.bdaddr, LE_INTERFACE, n) for n in CONN_PARAMS]
+    if None in values:
+        return None
+
+    return dict(zip(CONN_PARAMS, map(int, values)))
+
+
+def connect_le(host0, host1):
+    discover(host0, host1)
+
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "Connect")
+    host0.bearers.expect(f"{LE_INTERFACE}.Connect:reply")
+
+
 def disconnect(host0, host1, interface):
     """
     Disconnect the bearer from host0, and check it is reported as
@@ -230,6 +255,59 @@ def test_bearer_le_connect(hosts):
         assert host.bearers.get(remote.bdaddr, LE_INTERFACE, "Role") is None
 
 
+@le_config
+def test_bearer_le_conn_params(hosts):
+    host0, host1 = hosts
+
+    connect_le(host0, host1)
+
+    for host, remote in peers(host0, host1):
+        wait_until(lambda: conn_params(host, remote) is not None)
+
+    # The parameters are not known in advance, as the kernel of host0 may
+    # keep connection parameters for host1 from an earlier test, but both
+    # ends of the connection report the same ones
+    params = conn_params(host0, host1)
+    assert conn_params(host1, host0) == params
+    assert params["Subrate"] == 1
+
+    # The supervision timeout is longer than twice the time between the
+    # connection events the peripheral listens to
+    timeout = params["SupervisionTimeout"] * 1000
+    assert timeout > 2 * (1 + params["Latency"]) * params["Interval"]
+
+    disconnect(host0, host1, LE_INTERFACE)
+
+    for host, remote in peers(host0, host1):
+        for name in CONN_PARAMS:
+            assert host.bearers.get(remote.bdaddr, LE_INTERFACE, name) is None
+
+
+@host_config(
+    [
+        Bluetoothd(conf=LE_CONF, args=ARGS),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+    [
+        Bluetoothd(conf=UPDATE_CONF, args=ARGS),
+        LeAdvertiser(),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+)
+def test_bearer_le_conn_update(hosts):
+    host0, host1 = hosts
+
+    connect_le(host0, host1)
+
+    for host, remote in peers(host0, host1):
+        wait_until(
+            lambda: host.bearers.get(remote.bdaddr, LE_INTERFACE, "Interval")
+            == "100000"
+        )
+
+
 @host_config(
     [Bluetoothd(conf=SCANNER_CONF, args=ARGS), Agent(), Bearers()],
     # A broadcaster, so neither connectable nor discoverable
-- 
2.54.0 (Apple Git-157)


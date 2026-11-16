Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813392;
	b=dTV9IwvQDh3Q6ZT6hFPkiNDKkbFGcsxUSuS1Ba25+UtBRzgyBV9naWFpLal+z2oJ9T1x
	 PQra4DgSUsxEWgHKdCvg/yvnhZTSYWbCrqYeSShIKR9fyYPLGYBTYYlKcGzVi4lQtohop
	 drVPPGTvAhSD6nUGsTfSWYfO59KtWLxkDQA4iRO2Re01A5WI41w27MtSxVtk0h/95xF4a
	 P8DOIel/d0uBx7Itcb9q7Ozxe+uRUs4zCeX0PaBrlfQOrj5VTiqGbkZwkE1Fcrh2TOWKG
	 49pN5GlFxdH5fZYhGaY8INXQPk+rhnqr+UYPb2WeBTG8OS34zqnQjmUPk5UtjQuL93g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
	b=pbXVECQ+cUILHILdmrOzj+gE61emlIVx0qpSJ7M34/PbOqeqCs0bKzE1YWVz4wU1d0rD
	 z17JShQd15ehiWtSZE/GKeB3SDUB5/JbsiIOmtzExc/YPD40s6g3GKOt6rsqaeZmjJVkI
	 YJCAOMnV3xSuLaj/NaFcd4lhx2tg4QPoNe3loEIbsvdRfDfwM43VJqMNmJFpkuaS8WOLA
	 fIO8HhRdV0LYpkKUdowYng9TM9muGCr5Joxf18Gm+Gmg8vLjoqwnG7YGs5ZgAnceP+erI
	 UMSjXEgkDuHA03cmRYmgu3389yRIqAABbgMz5cybc19ou8MAIFpXAfZelwRqqSjpcjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=odVr0BGM;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78306606A332
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 07:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78306606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=odVr0BGM
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1a2af4c8d00so6378213c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 23:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794813392; x=1795418192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
        b=odVr0BGMZDr64U44azHRUvgrUNsFN8fT7BuOiesE9z9v4U0fO9Lo0SqzK63hkxTEO7
         GhlSmtuAx1pmA1GxlSosUWWFo/aYIqpG19fzu49UcSfK4NVSl5YixCe/qU/bEN+OHIwq
         kOJ3iLFVTuIlvRP6tuParXSanU+Z/TVJtJ1uWLY6uUFkPTJ8RWKx6GCrRnRHy3b+HWDA
         1La4it6xS6nJaay/JY7uWbf8tsm2c6YI0lSoeSWHByu36GOl/e4qRkzhxeVrhSC+d71+
         nJ4dUC86TMOltNZ/OZEQeHJnjnZSb0rRjOyawrMaMUH9qffldD2rMclRjl3W27zmnPCL
         nlRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813392; x=1795418192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7Y7vqGa80cawwwxSZovqIQGbKG+YqWbNOxNZfTga5I=;
        b=Oqh5+gixXAis9gW67PrQ6FjlIyY9x4jX9PSWR42miClAszZ9XH3xt8oqwDNxE/XJt1
         UJtiB4/LILi/vrOXzmjx5oEmb+aQlfkPANAo16yObflF+SYQiojC5vLv9FDhMswpnUG6
         9RptkddxaQmj4GclNKXIWjDmkLdNnBEYNDphg+UcC+F84/b12NTqnTBK8MQmXxK94zgk
         dlleWYSX9acYYQzotuQ+jT6Oqq02LB/d7gVK57W2/MXY16aW73HBcHv8p2RCiMpdsIBX
         dPl/rbJJkCQBccMRpNlbjMg+ydirDU0y2dNOIO3qOCvwKbRmcATtYDbLjd+iTsi7ne6v
         QUbw==
X-Gm-Message-State: APuU4Z8x3toe3nT5xIYUU9IH1yMipPyhguAsdbuwftnuLFjT08f6kEHK
	m/xHe6HcGJDoF8d/cHa8Xw7U5bcb1Im+BNWygo4Y7qsFazPvl63VqLkuBb/YUzSBT6xLzo59fbl
	lQISUJXE=
X-Gm-Gg: AYBFou0zzmCheo0iHpAoaK+SeM1A4rjUOkqrTNDEVgPkPxTDavkuRamlIvi+ootjDw8
	tuxktClY06qsJv9o4Cgt2YcRGhV423L+V6uI9sMgvbpR8woUJUzF2D7sjWwic0yU0jYpFQS328f
	NwWjPR2QE9kIW+g0sV1w4AQcyz2pY/Zuwrlk191lUuHUzuE03/pFGVZD+4S/5BAXySfC98ZBisr
	I3NMt1onhjECptXXG8qAVKAAYry9NU+cJloqX0BSC2aM4qJ02BbV/ija8yJyG+KoFmWt6NKdfLC
	A5DGndAdnLnwRaAQrwFtbivcLovn5mGT3Kbbo+Ioyrh0FI+DtlIE9veho4r/NzgVn+Zs999+aKC
	saEbrulEDu4iwT1q9mEXpxyVExjQr+ykK8vuMx9gdyB/jwZr61cPTFNpLMvWFXiwnfxaodBDgAe
	eWK5UUFhzbBKbZPsKaAEdXrtEvwOlM2m6BU5kslU8GNtIX6i0GeE6zQSeDSuZnNJl7eloEroaI2
	V1uTVi7RRkg9JAfDnDTSVTSx55VvBTxLL4yCOSGH7co2qj7CYCisC9WrYGPFEUAcaZQ9pgZu/TT
	KaZU6W8wVVglHmFplD4C9JCbYy4WzUxGgkS8IhWtKJTtd2KKo7v7yUZw4gWmD2VHjfQqab1PV/w
	C6DKKN5LtGXSlgIr4YyUh2CNyXd6NlljiMCmpO88MvKWTeuS09hT8/gJ/yyuLgKyRhfKVZ4uvIl
	q0SowB7eR1hD/BszrDOg==
X-Received: by 2002:a05:701b:450d:20b0:181:ccdd:ed2a with SMTP id a92af1059eb24-1b50315f88bmr9158055c88.43.1794813391487;
        Sun, 15 Nov 2026 23:16:31 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm40571430c88.9.2026.11.15.23.16.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:16:30 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v4 4/4] test: functional: add bearer ReadRSSI test
Date: Sun, 15 Nov 2026 23:16:21 -0800
Message-ID: <20261116071622.35355-5-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116071622.35355-1-kevin@simpleble.org>
References: <20261116071622.35355-1-kevin@simpleble.org>
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


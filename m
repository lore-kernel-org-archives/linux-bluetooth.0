Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395798;
	b=t0Wcuh/IiEE+Ybbd3XLG7OrLiRwycTAiBsFVzDMrCuIk8pUHHTvnwzBBBVqfo+4hi0j7
	 ZG/PYczecDtgXzvOmTtfKzuPr7K7B8ID/WI9vEpif1hZ50MIW6zgFnMB2GZLmqyyCJTfh
	 pdICGaEKZH5JNhlqkM+BG68bwRTnDbMseNh8uIoHAi4nNR45HfzRyGOvUHEzmgps2kD8W
	 rbepNC/yRPxOWNDP53lEuoIX/8YKiTEGNYBmsmnExpZnUcbQr289wFNM6uWz1nUWtyfVj
	 U3qH4G2qzqKgQ2TlhTDBwFBexaRO1zFh5DFgwEx8s+KQm8iZzFRyC74jFWzpYfG1hWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YdMrQDTl5SkRU6arY0MPpzg4LXI9PcmXkVnMw0RzR1U=;
	b=L09+mY8IYtNSq9vaWh+NkJF69Uibv/l6eyIPmIh37FiiiJDBYl8vcwbLBjQGnWE9nQRU
	 4SHWNW7iRL6sfgNLWZlqSgdr8uplem6RPY9ZvzUH2/7MLAMYEw9BHqrfeaxadj1cq9IOC
	 Y0zNfyF/byCdYq4/lcdKeOeZ0dgIYnxVyepI1yR5C9wrVCNKgJMXGM1SqfpuqnxinFWi5
	 gu9Zw7wqM+VYpflNNdG0ODMzWvpB/xojgNTotJAeOM9GIIupRclA19W9ipWX2IHErN0r0
	 7oqT0dxrNmz+2LWVQpKLzTtipd0yCo4ocDHqiAfcDQ87sfPq+QTYJQxDsMfhSkV0ZDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDFjIP30;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EEC606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 21:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63EEC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SDFjIP30
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eac3b6b2ceso292365e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395797; x=1794000597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YdMrQDTl5SkRU6arY0MPpzg4LXI9PcmXkVnMw0RzR1U=;
        b=SDFjIP30w493SlKDiRsIKztGzl6+iV7AW7gUlywDZEGujCEgz5gYcCqR58rW8rAykJ
         hLsWhn1/oxv3CqGNXf3LT7aczXDU5CUl8uEIuPZUdEFRZYPYbrPySb3uTu7Eb2GFWP5+
         6t2aKl5x9Dp4blIoSnfMC7SobV78XM1yQGo3jKcbeMB5kBVTf7JmdhqZA54E9ranyHuz
         3KXX6aok6IcnhRtEbyO+rkfAV2n4X8LThxSSiDOCBNJVR0aYtN69uJZ989L/RuhH6Tev
         sWI/GLvQDERCIysNlvWXP22icRwyUlG37+EljkSDXb59MR8bAhD9xfcRwoB/KR44z468
         R21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395797; x=1794000597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YdMrQDTl5SkRU6arY0MPpzg4LXI9PcmXkVnMw0RzR1U=;
        b=pSmaWctmWlZe5Mfo64sCm0OXp2YHsRxjGMujL9sUujqrSSXD+bWmcwTWvuc5DUlT3M
         dZSjX9HvuVj9HnhKrQpRjGUhJTHq+mncVupSmwSvfMb1nTJFCir85f0XGLyNHWH0q1By
         gtKE33v6yole5WFEMNgT+137J6o8kbOESH3xHFOby/+ue0VWdWGbSKo+S+W3S8yv8MIL
         +RZYD53RvV/VAymCID8Y0Okb0MLVOx6UoBZ2foDIlOqs4nkMUNNTAXL8EyjWSKOU5l8O
         OSMkO34vH3pfuje6cbvkO5s4/RIWZ+L3zIpeUPg6AkWDHtUC464HknMvnGJIM7bu2KT+
         qV6Q==
X-Gm-Message-State: AFq9FYLKI+0tYpPuUgum4hrwyaWbWop9fPAW9evuhDYkJvxXjVOdC+LT
	7yvhQfCtqZIlb7lbki8hzvFO21Hnn+ZYMRdFcjpCnfe5RCINzedvOIOiHgB8Ew==
X-Gm-Gg: AYBFou2dNYb1Nk5SDx8QhhFw5JiAAre9EV32kqdwCD6V3Aprj1+ovDTtQHkOG5/dDag
	YOYhqo+7LKGFxuVQQiMzysDUOsUIoifwwF0sxuKqNhFv+UUu/iT2KRJ9PjzzMGCFFoAlV8LxPuQ
	zl+7yJzXgn4N0sYLokV8pyI3eXYlKVw+fFLUOPktXQ2Jh8JlppF5j3c5EoRpkaTLjJgOuckpIdQ
	QuYuoDqx54LYb5omL7L9TYTfDi+mqCScjEEDQsrslOk/K93yGKWBeuDZiidmLxhxboUOsrNkiag
	2vxbT3txBw0d/yDpuO7ifJczJU5LzZeVFy+hFb6QCsqv/d1t11v9t4GNaIXUrx16mxDQnjKhY0w
	8iIjqVE27NIzSHqs0nARIan5ZUKbLimVSodJNzcIOk2WPFvRm7A7KFy1CgwpkwVWctfQa97FHqb
	HhCMFttJ5eTLgqPUPajivmABwSvwzwxVI3pm6aQc8rz0LJ3q+wNCD75I2dAiW3FTuno/cPxROcI
	NjndqhBqep62P3hUDql4qj+H618tYl7gmyAxJ3zfsfm181ppgF9kOjt7od4pnA/iAUKT6oigti7
	zDlGwtakjhdgv6ssTRCvRSAoY3jjdoQpmrXge0i0OZV6kOFdnxyI6QLA8l2qT3aY2limqBkrXZy
	C6osyGo9wr8xHUfOnspzKcMGtAwdmyBL5ms0N6E/NpqXXMH/lKqEJzAPaWLisgJMBOKv1kWDK6N
	AaTmE=
X-Received: by 2002:a05:6122:4697:b0:5ea:fae8:e69e with SMTP id 71dfb90a1353d-5ec688311c2mr2259917e0c.11.1793395797294;
        Fri, 30 Oct 2026 14:29:57 -0700 (PDT)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c9c554sm3696412e0c.14.2026.10.30.14.29.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:29:56 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/10] test: Cover A2DP reconnection with a pending disconnection
Date: Fri, 30 Oct 2026 17:29:39 -0400
Message-ID: <20261030212940.753771-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030212940.753771-1-luiz.dentz@gmail.com>
References: <20261030212940.753771-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Stop bluetoothd on the sink while the source disconnects and connects
again, so that the disconnection of the previous link and the AVDTP
connection of the new one are pending together when it resumes, which
made the new connection be refused.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-a2dp.rst      | 32 ++++++++++++++++++++++++++++++++
 test/functional/test_a2dp.py | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/doc/functional-a2dp.rst b/doc/functional-a2dp.rst
index f38a458bb7c2..367992159b7b 100644
--- a/doc/functional-a2dp.rst
+++ b/doc/functional-a2dp.rst
@@ -134,3 +134,35 @@ test_a2dp_disconnect_during_setconf[accept|reject]
 	``auto_config()``. A late ``yes`` used to also leave the stale
 	transport registered, failing the next connection with
 	``Resource temporarily unavailable``.
+
+test_a2dp_reconnect_pending_disconnect
+--------------------------------------
+
+:Setup: As above, with the stream configured and the transport created.
+
+:Steps:
+	1. Peripheral: stop `bluetoothd` with ``SIGSTOP``.
+	2. Central: ``disconnect <peripheral bdaddr>``.
+	3. Central: ``connect <peripheral bdaddr>``.
+	4. Peripheral: once the new link is up, resume `bluetoothd` with
+	   ``SIGCONT``.
+
+:Expected:
+	1. `bluetoothd` on the peripheral stops processing events.
+	2. ``Disconnection successful`` on the central.
+	3. The new ACL link is established by the kernels, and the AVDTP
+	   connection of the central waits for `bluetoothd` on the
+	   peripheral to accept it.
+	4. ``Connection successful`` on the central, and a transport
+	   appears on both hosts.
+
+:Notes: Regression test for `bluetoothd` on the peripheral handling the
+	incoming AVDTP connection of the new link before the disconnection
+	of the previous one. It used to take the connection for a transport
+	channel of the A2DP channel of the previous link, still registered,
+	and refuse it, or, once that channel was gone, the disconnection
+	cancelled the service authorization of the new channel
+	(``Access denied: org.bluez.Error.Canceled``). In both cases the
+	central failed with ``Connection refused``. Without the pause the
+	two events are rarely pending at the same time, mostly under the
+	slower timing of User Mode Linux.
diff --git a/test/functional/test_a2dp.py b/test/functional/test_a2dp.py
index 12348ea05ae2..c07a2b2a1232 100644
--- a/test/functional/test_a2dp.py
+++ b/test/functional/test_a2dp.py
@@ -4,6 +4,9 @@
 Tests for A2DP using bluetoothctl in VM instances
 """
 
+import signal
+import subprocess
+
 import pytest
 
 from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
@@ -200,3 +203,36 @@ def test_a2dp_disconnect_during_setconf(hosts, reply):
     sink.send("yes\n")
     source.expect("Connection successful")
     source.expect(TRANSPORT_RE)
+
+
+def vm_signal_bluetoothd(sig):
+    subprocess.run(["pkill", f"-{sig}", "-x", "bluetoothd"], check=True)
+
+
+@a2dp_host_config
+def test_a2dp_reconnect_pending_disconnect(a2dp_hosts):
+    host0, host1, source, sink = a2dp_hosts
+
+    source.expect(TRANSPORT_RE)
+    sink.expect(TRANSPORT_RE)
+
+    # Stop the sink's bluetoothd so that the disconnection of the link and
+    # the AVDTP connection on the new one are pending together when it
+    # resumes, as when it is slow to process the disconnection
+    host1.call(vm_signal_bluetoothd, signal.SIGSTOP)
+    try:
+        source.send(f"disconnect {host1.bdaddr}\n")
+        source.expect("Disconnection successful")
+
+        source.send(f"connect {host1.bdaddr}\n")
+        source.expect(f"Device {host1.bdaddr.upper()} Connected: yes")
+    finally:
+        host1.call(vm_signal_bluetoothd, signal.SIGCONT)
+
+    # The transport may be reported before or after the reply
+    pending = ["Connection successful", TRANSPORT_RE]
+    while pending:
+        idx, _ = source.expect(pending)
+        pending.pop(idx)
+
+    sink.expect(TRANSPORT_RE)
-- 
2.56.0


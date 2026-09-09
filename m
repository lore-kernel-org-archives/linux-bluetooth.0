Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF183DC4BD
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981808; cv=none; b=gAIQePHXY/Ynm/TevqaqNVBFuPaCFiZUImodip5TV3Ifu5+MCN0NpTl9qlOUcznuiOg6FvdiCijwsqZ/RxTEBWMoft3U0774R9WBCvDQXGIQBpk3LOvYxKhn3Fdv56zMe1Vs8YP6eJW58u2eRpvYrkwvB14NESD+2McGMfmwpiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981808; c=relaxed/simple;
	bh=Sx9wWpzB73jIkBqguWJx5IXkcz+y5tZTYK8Jf0dZQTs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI7bRvccI4Oe9avlTYrr8z1Gqyz75ecWd6TBzSxfzOFpG21q48DS+V7+6PtpIIh6PUmOxKgd6giOU6KbN2ilREzUQyqorNehF3zl5RPKxBww7c76aUPOGn4VJdXdQUuHuDuVAXLJ85cae2q27/hAsP+SBqxzye3wkhRqrtSshbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ngq6yWQw; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ngq6yWQw"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c82d057971so893643e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981805; x=1789586605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AZrRySdqS01bhY44wjnKUvbz89nm5+9QP44FWm2cmZI=;
        b=Ngq6yWQwRRRQY7FL8cVKHnD0bAAbxSrA6YNeHS032w5hqwnWzXkXtkIrl0hZo1BhN2
         CiV8inPIIZwrn8xvfDUncR72maaWEET7cpGf1a29pbgWDFVjS6uX+IfLCc8WwUr8b1tN
         VQr4IcqFHDTqV0qyaAqh73xYGqPKxObWvfT0mJNPqxk5q/wV33xhP9kSUDoejRi2zWCU
         O/OFprnnXrPLSHGglhqKmF577/P8/dGZ/8m9CFuM9/pdpQiJcI2HgCIrXC/h1TlwXS4o
         iezsT5wY+T8FN1Ts2mZBuV1CGhCJBXuorT9ubh8k06B+XgKgNWGDLPaDxgM1fJUYfW6q
         2usA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981805; x=1789586605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AZrRySdqS01bhY44wjnKUvbz89nm5+9QP44FWm2cmZI=;
        b=G0ac7+d4XErVO7fRVZ1dV4aY5VzNxhof+2WTuN4swrW21kWzrv3aYaExi5hZdJnm0n
         zTHYvNQjTpxrp+EvxK/Oo4TkReEOSp+vUt0cdunTrsCJ1KCgsvCJPRhhvHxdBLBUxrG/
         m6gvUOEDFqJkz5xpEx+GK92688bbytaDvqJ5/n99h0HE7uhq0EVDE45Cf9WumJr5PAOV
         nhHtKbexyYxIyidhZ3280AQ+bvnmU8gEUD8DZ8WI2CjbnVny3wUfsRpVrkzsD29P9zRY
         /gjoGm3PLMaNJhbwHkjRf30cafVjDhE8xx2elGgE9HDE0F0+ERl+MXKwmgj12TfLeRpX
         m31Q==
X-Gm-Message-State: AFuF++l9jcj9gcRDI+Kz9Ym2anGOazRBSNlK9V+911UA1ye277GE1ZKb
	tDs9JalDv0hhpm+wkzV+GSbe+U9VXHXLYsf/1Qgeal7+zA09DVky8sx1LZ2WaCFg
X-Gm-Gg: AYBFou2pcns01eiSGGCU16r8wDyuIHsnTMs+BIod6mWYGeUj53KF29vTqMX+CukXjZE
	jwedbwr73GOp/RBdBwU2kpnsPh2wIYq4N8etNNwzw7IA5Y0dxHoy5mVrR3AaufecxvEghm1YVJt
	R4ig2J0Q3rJeUR53GWI4KWDfyMk5wFqynlsopgjC7iWjtiSWRE+f7WZ+f3dszuoqsh6QZ7lYbWB
	n2bDyBm/NrUh5C+YhXwpoDmf38vZpyFkkkRcj/9lixdDvveBnnggYwiGnOhXMh4tNlaN2WjkHfH
	FL0CAMuUjBQvrGDsP1f24uP/xqjh6MO3769ee7BPZUrqrUJgFvFQkwN+lNLorn75WICtmE+8nV9
	Ioa1eug/KApX/rD+g7Pb0J315KDBgvE2Z2UczdZ6tLQaTVVLPUxp9LG+5aQLT99FbkFHzZC0WxU
	PnV0UFL1eX1/iRjs+ZHW6HBE8qW5qz57a6pVJcU3KEbdZw59QE3qa1ge9PJ7H/7PqzohvR7Fcz6
	OGd+0h/Ysz//ojSP0yJ9gPWkOumILHkbaCyJ9+i5LhXW1248XhameTy6XSFpHReXg==
X-Received: by 2002:a05:6122:488b:b0:5c6:8480:35c8 with SMTP id 71dfb90a1353d-5c7ed933392mr23176402e0c.8.1788981805532;
        Wed, 09 Sep 2026 12:23:25 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 08/12] doc: bluetoothctl: document init script option and scripts
Date: Wed,  9 Sep 2026 15:23:04 -0400
Message-ID: <20260909192308.1306567-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The --init-script option was not documented. Document it, along with
the scripts shipped in client/scripts and the roles they set up.

Assisted-by: opencode:claude-opus-5
---
 doc/bluetoothctl.rst | 105 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/doc/bluetoothctl.rst b/doc/bluetoothctl.rst
index 0c55092b880f..ed4cd0703281 100644
--- a/doc/bluetoothctl.rst
+++ b/doc/bluetoothctl.rst
@@ -38,6 +38,7 @@ OPTIONS
 -a capability, --agent capability        Register agent handler: <capability>
 -e, --endpoints                  Register Media endpoints
 -m, --monitor                    Enable monitor output
+-s file, --init-script file      Run the commands in the given script file
 -t seconds, --timeout seconds    Timeout in seconds for non-interactive mode
 -v, --version       Display version
 -h, --help          Display help
@@ -589,6 +590,110 @@ Using Here Docs to show information about the Bluetooth controller.
    show
    EOF
 
+Commands can also be read from a file with the **--init-script** option.
+The tool stays interactive after the script has been executed, which is
+useful to set up a role and then drive it by hand:
+
+.. code::
+
+   bluetoothctl --init-script client/scripts/power-on.bt
+
+Lines starting with **#** are comments, and lines are also used to answer
+the prompts of the commands, in the order the prompts appear.
+
+SCRIPTS
+=======
+
+The scripts shipped in **client/scripts** set up common roles. Scripts
+registering a media endpoint are named
+*<profile>-<role>-<codec>[-<preset>].bt*, where the preset is only part
+of the name if the script also configures the stream.
+
+Controller setup
+----------------
+
+``power-on.bt``, ``power-on-off.bt``
+	Power the controller on, or power it off and on again.
+
+``scan-on.bt``, ``scan-on-off.bt``, ``scan-le.bt``, ``scan-bredr.bt``
+	Start discovery, optionally restricted to a transport.
+
+``advertise-on.bt``, ``advertise-peripheral.bt``, ``advertise-broadcast.bt``, ``advertise-rsi.bt``
+	Start advertising with the given type.
+
+A2DP
+----
+
+``a2dp-source-sbc.bt``
+	Register a local A2DP Source endpoint (``0000110a-...``) with SBC,
+	i.e. act as the device sending audio, such as a phone.
+
+``a2dp-sink-sbc.bt``
+	Register a local A2DP Sink endpoint (``0000110b-...``) with SBC,
+	i.e. act as the device receiving audio, such as a speaker.
+
+Once connected, the stream is configured automatically and a transport
+is created, which can be acquired with **transport.acquire**.
+
+BAP unicast
+-----------
+
+``bap-source-lc3.bt``
+	Register a local PAC Source endpoint (``00002bcb-...``) with LC3,
+	i.e. act as the initiator sending audio.
+
+``bap-sink-lc3.bt``
+	Register a local PAC Sink endpoint (``00002bc9-...``) with LC3,
+	i.e. act as the acceptor receiving audio.
+
+The initiator configures a remote endpoint with **endpoint.config**,
+choosing a preset, which creates the transport:
+
+.. code::
+
+   endpoint.config /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_snk0 \
+	   /local/endpoint/ep0 16_2_1
+
+``preset-custom.bt``
+	Add a custom LC3 preset, instead of using one of the presets
+	defined by the specification.
+
+BAP broadcast
+-------------
+
+``broadcast-source.bt``, ``broadcast-source-2bis.bt``, ``broadcast-source-pbp.bt``
+	Register a Broadcast Source endpoint (``00001852-...``) with LC3,
+	configure it with the 16_2_1 preset and acquire the transport,
+	which starts the broadcast. The variants set up two BISes and the
+	Public Broadcast Profile respectively.
+
+``broadcast-sink.bt``
+	Register a Broadcast Sink endpoint (``00001851-...``) with LC3 and
+	scan, to sync to a Broadcast Source without the help of a
+	Broadcast Assistant.
+
+``scan-delegator.bt``, ``broadcast-delegator.bt``
+	Register a Broadcast Sink endpoint and advertise, to be used as
+	Scan Delegator by a Broadcast Assistant. The stream is then synced
+	using PAST, and the transport moved to broadcasting with
+	**transport.select** before it is acquired.
+
+``broadcast-assistant.bt``
+	Scan, to discover a Scan Delegator to connect to and Broadcast
+	Sources to offer it with **assistant.push**.
+
+Channel Sounding
+----------------
+
+``cs-initiator.bt``, ``cs-reflector.bt``
+	Set up the two sides of a Channel Sounding procedure.
+
+GATT
+----
+
+``gatt-batt.bt``
+	Register a Battery Service with a notifiable Battery Level
+	characteristic.
 
 RESOURCES
 =========
-- 
2.55.0


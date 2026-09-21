Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95304F5E00
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024497; cv=none; b=k5ELqXFl5m5Fzg3LCJ+7mTlQ2VQAgHprGOhHyhg9GNcxrDLBL/Fct+MN4+bZERjmAnthm32fHozU8dIpZWYthbFHa5ky1Nzpg7ZIvmJk9by2+oapK0PIfR1QgD/Cx/zbjovBXomdZ93cRNOPmDFpeb6c5peMmChiRoYM1NaZcX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024497; c=relaxed/simple;
	bh=ex7p8aMhjIZ7GbXYUP6woDay2PrTGWBcwyw3mv69cdY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQVKK5iITgPqW3Xaw4j2Pz8e9ID8KL3fmLzN+1rSm/gdqqIRQsiyAYfJq7WDfHPnWlVBgGLTIaabVbWPl7llng/sWy/+aOhV/xcwB3fVMasimbWp+t1QbJQ4MCtGf588pX8hMzE35et2Lld/kGGFZJuzWuY7HzEnmFkHizN29yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MND2NcO+; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MND2NcO+"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e97e2c7b3so1923874241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024494; x=1790629294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Kx+r2BePDPuCtgI2kk2+liyCfTwJKc/h7GAQ5M7DNZY=;
        b=MND2NcO+rAPUzhWNrIspyckQTkI7Gsd0SAqRSsM2JETjhl0Wtm3dHkvv25OuEOnm+F
         QAAfMMhVV2KmNy+Tq66YGNeAzD/pCcyf0waausoejB+MGpnXQ2yv/r4J9IxXKNAt+1PB
         P5bow9BCPsf4bRK4QzzRPq7yRgsECCKGq5KqpWJc8JT/q+7yhfqrvpD4O3ZUQE2/tvdu
         NvvZFFKOohPeZoiktUucXUa4l2Q+NeFycG0n2E+X7orpQ8jRfKKiBqncPKfv5O81+BZV
         c2OM5Ekb4c951KV6GfrbX8H7QgcDKcnfL9Rzj5RLyVVHo0hcvltgqu984NENtyz3Gzed
         QHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024494; x=1790629294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Kx+r2BePDPuCtgI2kk2+liyCfTwJKc/h7GAQ5M7DNZY=;
        b=YyV0hBX0mxlYoPv4fj9OquT2b2DNiinXzpEYBTTTSXPA/GR9EZYsMV89HMp8PItGBU
         qwp5tQfvjQzSaEoMM2F2BpTbXsLtd8HJihLshIMGVYDJEcKyI5qDtH3JTyue2sMxblS5
         /0bgjwb9boobMDXigv0WPyZqOzaSNJZAynhYWj3kiyV8CXtTrHYu+uNfIHFzUDTwn9OW
         oxsGE4ZVqp+fwIw0zDayX+/fIRo0FFyY0VQ0Xcpj8qnPE3sl6K91O+NSOcqQwVeBV1MP
         j4lCsVECrBTaF+ls4uvrPDatuJsWDIzzl+dwFnk3yLmJU/czRTYYjSBzyFv9CeAwmNSv
         XkWg==
X-Gm-Message-State: AFuF++lTaePJgc7xcFjW0KzUBa+Svez2mZD/peVsfddSUy9xCQ2/Q7F9
	WtGlJ7pT6o6f/MhG4tNRP/yOgDpGyXv8o0RfazxJOArjrNUannsiK3TzuZz+iKDP
X-Gm-Gg: AYBFou2zpKvn7+1xqZ2Jd4bRFzXYsJ6bQJSYxJaDzcmtHhEcG3QLK46Je2LlSgKqKdG
	xX31+pWcKxh16SAPKLgjQoAOrjzJKzO2UP6t138yFrx4hiL7KjnPsJxH47eBcwOyOuEd8/8GFVM
	IpaVvhwHZB2wS3yDaKAcPPvyNSa2aCnOVh4de3ozEodow9/H7pPFxndWeKwb/Lt843hAbkWsItL
	AOnrJ9z2sOHwaQwqbAzx/14CE8G07RtggzUIbfDhNBXfDQS3m1ZYBcY8lClBA296KwT1+dheIoL
	cPYRrm3EKmI/7TUGVcWbZ/4qSkEdC4RPYFRDt/kI7kwjuyiOlL37iJaSCj2YiqLcU1GCIb0j9zR
	VcF3rsHMywWH7n1RAAI9IXUw8Bx/PC20pm+0ew/ZWREDSIXakVwzUmaUgekpj9Dk2hP11aiOX7d
	o3FZ2+mD7jyx9i/zDfcIX4CBF1zFg0AgVYFQo8Cx8p+rrXoiV/XNT33qEJLzGK9pHZ3ffIJg4zG
	xUaktJzR99KqHoI3vaYsp0bEGZhqiRSKEginbXubP0m808byc8xU2MYoSWz7ipDIYVwiDgZw9Y=
X-Received: by 2002:a05:6122:3704:b0:5c8:228:5ea6 with SMTP id 71dfb90a1353d-5c9b58a531emr7630562e0c.5.1790024494467;
        Mon, 21 Sep 2026 14:01:34 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/6] doc: describe the true wireless broadcast test cases
Date: Mon, 21 Sep 2026 17:01:18 -0400
Message-ID: <20260921210123.3690449-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921210123.3690449-1-luiz.dentz@gmail.com>
References: <20260921210123.3690449-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Assisted-by: opencode:claude-opus-5
---
 doc/functional-bap.rst | 112 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 60c38c5ed0e0..926d9a54a632 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -221,6 +221,118 @@ test_bap_broadcast_transport_acquire[lc3|pbp]
 	match the one the source encrypted the BIG with, otherwise the
 	sink cannot decrypt the stream.
 
+TRUE WIRELESS BROADCAST
+=======================
+
+Three hosts, with the two sinks acting as the sides of a true wireless
+pair, e.g. a pair of earbuds, each one a device of its own:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |    extended +   | host1                  |
+	| Broadcast Source       |    periodic     | Broadcast Sink, left   |
+	| bluetoothctl -a auto   |   advertising   | bluetoothctl -a auto   |
+	| broadcast-source-2bis  | --------------> | broadcast-sink-left.bt |
+	| BCAA endpoint (0x1852) |                 | BAA endpoint (0x1851)  |
+	|                        |  BIS 1, F.Left  | Front Left             |
+	|                        | ==============> |                        |
+	|                        |                 +------------------------+
+	|                        |
+	|                        |    extended +   +------------------------+
+	|                        |    periodic     | host2                  |
+	|                        |   advertising   | Broadcast Sink, right  |
+	|                        | --------------> | bluetoothctl -a auto   |
+	|                        |                 | broadcast-sink-right   |
+	|                        |  BIS 2, F.Right | BAA endpoint (0x1851)  |
+	|                        | ==============> | Front Right            |
+	+------------------------+                 +------------------------+
+
+	one BIG holding one BIS per channel, and each side syncing to the
+	BIS carrying its own channel
+
+	--> advertising is scanned by       ==> audio flows towards
+
+There is no connection at all here, not between the source and the
+sides and not between the sides either: each side scans, finds the
+Broadcast Source, syncs to the periodic advertising, reads the BASE and
+syncs to the BIG on its own.
+
+``client/scripts/broadcast-source-2bis.bt`` on host0
+	Registers a Broadcast Source endpoint
+	(``00001852-0000-1000-8000-00805f9b34fb``) with LC3 and configures
+	it twice with the 16_2_1 preset, in the same BIG, once with Front
+	Left and once with Front Right as the channel allocation, so the
+	BIG carries one BIS per channel. Both transports are acquired,
+	which starts the broadcast, encrypted with the broadcast code
+	`bluetoothctl` uses by default.
+
+``client/scripts/broadcast-sink-left.bt`` on host1
+	Registers a Broadcast Sink endpoint
+	(``00001851-0000-1000-8000-00805f9b34fb``) with LC3 and Front Left
+	as its only location, and scans.
+
+``client/scripts/broadcast-sink-right.bt`` on host2
+	As above, with Front Right as its only location.
+
+Registering a single location is what makes a side take a single
+channel: `bluetoothctl` adds the channel count to the capabilities, and
+`bluetoothd` only creates a transport for a BIS whose Channel
+Allocation is covered by the locations of the local PAC. A sink
+registering both locations, as in the BROADCAST section above, takes
+every BIS of the BIG instead.
+
+test_bap_broadcast_earbuds_transport_created
+--------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the source script on host0.
+	2. Start `bluetoothctl` with the sink scripts on host1 and host2.
+	3. Each side: ``transport.list``, to check that nothing besides
+	   the transport of its own BIS was created.
+
+:Expected:
+	1. ``Endpoint /local/endpoint/ep0 registered``, then two
+	   ``Acquire successful: fd <fd> MTU <read>:<write>`` on the
+	   source, one per BIS, i.e. it is broadcasting both channels.
+	2. Each side syncs to the periodic advertising on its own and
+	   creates exactly one transport, for the BIS carrying its own
+	   channel: ``.../sid0/bis1/fdN`` on the left side and
+	   ``.../sid0/bis2/fdN`` on the right one.
+	3. Each transport reports ``Codec: 0x06`` for LC3 and
+	   ``State: idle``.
+
+:Notes: The BIS index of the path is what tells the two apart, as each
+	side only ever sees its own.
+
+	Both transports of the source have to be acquired, as for the CIS
+	of a CIG: the BIG is only created once every BIS of it is ready.
+
+test_bap_broadcast_earbuds_transport_acquire
+--------------------------------------------
+
+:Setup: As above, with the transport of each side already created.
+
+:Steps:
+	1. Each side: ``transport.select <transport>``.
+	2. Answer ``Enter bcode[value/no]:`` with the broadcast code the
+	   source used.
+
+:Expected: On each side the transport moves to ``State: broadcasting``,
+	i.e. it synced to the BIG, then ``Acquire successful: fd <fd> MTU
+	<read>:<write>`` and ``State: active``.
+
+:Notes: The two sides sync independently, so each has to be given the
+	broadcast code of its own, and one side reaching ``active`` says
+	nothing about the other: both are checked.
+
+	Nothing keeps the sides in step, unlike a coordinated set, where
+	they are at least discovered and connected together. Rendering
+	them in sync is left to the BIG itself, through the presentation
+	delay.
+
 BROADCAST ASSISTANT
 ===================
 
-- 
2.55.0


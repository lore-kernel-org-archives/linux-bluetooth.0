Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D34A4408
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506945; cv=none; b=d5fka5SHkQZP7jK4fv647PhEtdWFI/a3V3+jCEIxtpKpwAnnqCkCo+yLMWOyt1bLtEQXaGXZh/01m8pg43DBvcpgLtgxE5+UxMfwip/wck8dOhwV9ju5J3TrpW/zJszaXXH5pG/9wf9qQWlzpKq9e8GWl+VyM4INIPxYWnvCIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506945; c=relaxed/simple;
	bh=fcmZga7aSNzH8u/Bredl9Z8ZbrKgCAuBXR4lRdthQBE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1N6goSc4v3cmgzAfmIw+baRXrkwKfc6vxvewdiqbWxo8V1b+etMlwoksjoELO7tqn0lJmecqU5nGdJdm7/S77bg5LlLytYkYOkRzLNLWl4IRsmsfkTcuyOkOp7j3IPF6ke00u2yW6P5pNvCt8HPLGYQZeztAE7ECnBagoFQfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BIj/uagh; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIj/uagh"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-790ec94be85so73810137.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506943; x=1790111743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=L9bxwFQLq7dLKXtIqXczossTLMTtMuPa8dy3hDo/ozU=;
        b=BIj/uaghGzKKQSF3nFrfP9wEI3EyXkIzURY/UJMSnmDaKC+cS0CKt9CwTXy/NX0Zxs
         mD7xq7hdb0+nAgboFhAvIySid6TGz/x0Td5qTWU3BTUr0dDcD9ngh0AxklX/xs2uoQKY
         PSDajwDWxbReaRlZbp3J0cGmuEvTSnmzaVU/HYr4SatWAN8IAzs453X2/EX5Wyrf6Y8e
         kgmzFyZjxIdHgA3gWOXhZ14rUw7UMBOTArfVqRvnEttWgMRlNprzgokdO2ixCapvEViH
         aFg3EKbEvqTdW+PoA8apoRcLZkItKfLlu+gUItGw11Ak3QFmI8SwMiyYS7jmhoy1qx52
         xYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506943; x=1790111743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=L9bxwFQLq7dLKXtIqXczossTLMTtMuPa8dy3hDo/ozU=;
        b=LQbODJ9VTXnBPrNtSo6VbTyfQ/S7c/XPWagBl+OgNszYVbbJOJaorN2q2PH9OECvdb
         slT8Ya6P+Ha4DPzK1GjA5BobPpsJvRonLpoHEay/lz9W0wbb1lMPbSOCUCrKMj4yIJl6
         qrNM7h+8s8XWTi/7jTjJSzcnJR+jyhW7K6GCwh0zrDb9APAS4J93P+8eAi5l/41id234
         XB2oG+GYpy2n6r1uo0h8XzvUEh3O8SEqWWAGaiVmz/VcDbtUZ2wuCHYYq7tEZtjMypsh
         LnlZtXqSGxedmAbXoJenIv1U4ZX+cBD9in58c2555Zp8iwRUXBN5SYh5m4vCVrT1PgPr
         uPBQ==
X-Gm-Message-State: AFuF++nLpDZow3mNPAmX+rUwh4AeymSMtX/QVgjW79dLntZYrTDZ6LVo
	n/38WFt0ot9rBOY5pUigoucNN/d/wbJWArsBFgsbYoyM0DKrMVlFxMepwG49zRY5
X-Gm-Gg: AYBFou2m71KXrSOwudkqih7EaGoc8vvq4XfMssc1qTMaTeZm1nJOk5/eHcloBSch1iB
	e/hPY269wdmcmCfxWSMdPGVzp4WxkoAB+O7cH0XaLi0k5/Gr6Ra640ZXmvvodSnQSPLpBLX5H1e
	OfoAj8taErd/7vB7OsmAaubRYQlf1oPELhCEM/BzJkOXCNXkBJ+VvAbsQXJUqGQjsbmuCMRR14O
	Nqxbn2p0nhJ3lofdAQy9FLm/StU0M92LnYEmcK30Zr8kTcV58S1X8nv5NXIkrz/xtaQNLldMsIA
	DaXTUNcMVnUB07SC6d393hkQCyHkBPDvKzvxyrejzWmao8ECN6Eo1srHoyJv0aRMAIMOVsek5s8
	IdyGh1nnVPWyoAmc62hupFALOYAbnqr67FNM1QrmQm49vJmtSHLPEC1txwbnQegttiAxy7P8Vqi
	Zo3+XyMFOFM4IZFjZwMu2kSkAvgxXkigiOYRy6/mqT/poYkjjbWI9P6WjIkn05qPDyDtLTwhD+w
	Ce//lDhY14mtmhHNM6MmfLc7FGGDZpUml6XGb9ZHHHW30mczbvvQZ4nOrib0PPE7A==
X-Received: by 2002:a05:6102:f8f:b0:79a:7895:c36a with SMTP id ada2fe7eead31-7a029f1425amr461086137.13.1789506942699;
        Tue, 15 Sep 2026 14:15:42 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/11] doc: describe the BAP coordinated set test cases
Date: Tue, 15 Sep 2026 17:15:22 -0400
Message-ID: <20260915211528.1223784-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
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
 doc/functional-bap.rst | 101 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index f9392bd2dbce..78411f4dd47d 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -288,3 +288,104 @@ test_bass_past_transport_acquire
 	The stream is verified on the delegator rather than through the
 	state of the MediaAssistant object, as an object created for a
 	local stream stays in the ``local`` state.
+
+COORDINATED SET
+===============
+
+Three hosts, with the two acceptors forming a coordinated set, one for
+each side, so the initiator has to discover both before it can stream:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host1                  |      LE ACL     | host0                  |
+	| acceptor, left         | <-------------- | initiator (central)    |
+	| bluetoothctl -a auto   |                 | bluetoothctl -a auto   |
+	| bap-sink-lc3-left.bt   |  CIS 0x00 (LC3) | bap-source-lc3.bt      |
+	| PAC Sink, Front Left   | <============== | PAC Source endpoint    |
+	+------------------------+                 |                        |
+	                                           |                        |
+	+------------------------+      LE ACL     |                        |
+	| host2                  | <-------------- |                        |
+	| acceptor, right        |                 |                        |
+	| bluetoothctl -a auto   |  CIS 0x01 (LC3) |                        |
+	| bap-sink-lc3-right.bt  | <============== |                        |
+	| PAC Sink, Front Right  |                 |                        |
+	+------------------------+                 +------------------------+
+
+	both acceptors share the same SIRK, so they are resolved into a
+	single set, and one CIS per member carries its channel
+
+	--> connection is initiated by      ==> audio flows towards
+
+The acceptors run `bluetoothd` with the same SIRK, so the initiator
+resolves them into one set:
+
+.. code-block::
+
+	[CSIS]
+	SIRK = 861FAE703ED681F0C50B34155B6434FB
+	Size = 2
+	Rank = 1
+
+``Rank`` differs per member, 1 for the left and 2 for the right one,
+while ``SIRK`` and ``Size`` are the same, as they describe the set.
+
+Each acceptor also has to include the RSI in its advertising, with
+``advertise.rsi on``, otherwise the initiator cannot tell the two are
+members of the same set, and the resolved set does not appear as a
+**org.bluez.DeviceSet(5)** object.
+
+``client/scripts/bap-sink-lc3-left.bt`` on host1
+	Registers a local PAC Sink endpoint
+	(``00002bc9-0000-1000-8000-00805f9b34fb``) with LC3 and Front Left
+	as its only location, and advertises with the RSI.
+
+``client/scripts/bap-sink-lc3-right.bt`` on host2
+	As above, with Front Right as its only location.
+
+Each acceptor takes a single channel, unlike the stereo unicast case
+where one acceptor takes both: registering exactly one location makes
+`bluetoothctl` add the channel count to the capabilities, so a member
+is only ever configured for its own channel.
+
+test_bap_unicast_set_transport_created
+--------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the scripts on the three hosts.
+	2. Pair the initiator with each acceptor over LE.
+	3. Initiator: ``endpoint.config <remote endpoint>
+	   /local/endpoint/ep0 16_2_1``, for the remote PAC Sink endpoint
+	   of each member.
+
+:Expected:
+	1. ``Endpoint /local/endpoint/ep0 registered`` on the three hosts.
+	2. ``Pairing successful`` for both, and the members are resolved
+	   into a single set, reported as
+	   ``[NEW] DeviceSet /org/bluez/hci0/set_<sirk>`` listing both
+	   devices.
+	3. A transport is created for each member, one per channel, i.e.
+	   one for the Front Left endpoint and one for the Front Right
+	   one.
+
+:Notes: Without the same SIRK, or without the RSI in the advertising,
+	the members are not resolved into a set and each is streamed to
+	on its own, which is not what this test covers.
+
+test_bap_unicast_set_transport_acquire
+--------------------------------------
+
+:Setup: As above, with the transports already created.
+
+:Steps: Initiator: ``transport.acquire <left> <right>``, for the
+	transports of both members.
+
+:Expected: ``Acquire successful: fd <fd> MTU <read>:<write>`` for each
+	transport, and both move to ``State: active``.
+
+:Notes: As for a stereo stream to a single acceptor, the CIS are only
+	created once every CIS of the CIG is ready, so the transports of
+	both members have to be acquired.
-- 
2.55.0


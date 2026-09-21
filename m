Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B21502781
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024500; cv=none; b=bmS+fqxJRfpEY2sePZRm4XSlGS+VliUC3nwz7DSQe5wafCF4quAYXtiPBw0K8KtJDk8IPEU00Ty7rNokxeM2X6pnh2rwLAFn3/TUzXJp7bTxKVzK3yM4rf5N5n57YAPZGoLpD/9JidSy3Q0f5TFLBipu1WqsJlOSEMlCugYpNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024500; c=relaxed/simple;
	bh=mapttVJgdFWreKVdamrxtK41XvegvBBI22reLGWlI/A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6hrrpEqi6Fbie2Kun0kn7rCZYR7bZloPzE+Ymitz6oHqC2XxtS8Rxkyp0yTnueIafHlb+qocO5a0/B/W28GnAX123aO27ETcuQTHcR/cNLEhD/EfYhAxZDctN1zamBZMha9tYqG/bZtpGRU2a8V+Qj7DcBYyNKn2WmpPfUu98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YhDi3aj8; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhDi3aj8"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4d8d8aso2324695e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024498; x=1790629298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jrJG1be11rth4VcVNhy44F0kqRsho+aBVRy5KzwFlh0=;
        b=YhDi3aj8TrpcBtkEibrbj0yEaBBRF7vQgm1MIAiMfz70AbyyJOEZ2EA08r3+fiSHte
         865QDaUqvqGCLjTK/9BKXSNWLSGtbu4LhaXg2Unb+DpD9dPKf6lw+c9tExkgnhAWD66b
         bvMOA5jdkOTDbFQQJJDITzyswijAhZodE9QctAkgvBTYMxdL6yIDJbOH++mDu667WHl8
         us1QNVzD8u9i4ADKaFx8YUgOwpIoO2yzIBwfEldmhpNsKfgM9eNL1TRmrslB/ZULnNsg
         igNGlvmKm/8v4ETVkWMcDi8ERO0MUNU7nHcQZ5CTS7eWcP4s4z1lDGLV6qjkntuX09Gt
         hFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024498; x=1790629298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jrJG1be11rth4VcVNhy44F0kqRsho+aBVRy5KzwFlh0=;
        b=cvw5njiMf/L2j8Bgz4ogqEK9W6+JEYKdh2I7+IISJJt7sxXYiyIuNYIeoMxQrPV+Rt
         DxOq9yqJOi8UrRVgA+pDwylMPLmYbjLS+AQy0lgyEBzTbEUxhIlpwRtNZZlh8mge0KvV
         C+i9DxIvbTyyIc5mrnB6D0+bO/DyOKyGivxbCMOpuwvs04Cv5kvYkMzaYjcPSAKv9Jga
         LTZx9mrJGajGPn6lVSCJ4k1uZv+AeifUUueGzjc6/bvOxguu4JCIfQPho/eQo9+qTX2p
         s+OFAutzfAVgtG8LO0VM50qOTL/XV/CH4EkVR1Q0RMmLbgOLd/pEfIeTi6raCdbpRv4O
         SSMw==
X-Gm-Message-State: AFuF++nOAUQH/1MpgkDn6wXFgdLyKV2BrobsE9EO+SfBd57jFYZcw9sr
	pvji/B+LBtk4tw7l/dEqO7IAf1SNreR2zCfKPbbKHngvFFLpnDN7ZwiPNo7IVorV
X-Gm-Gg: AYBFou1+c0Yta3WiFQeTIVPjZyITllIDHBM8HVkmySNn/89SpxfTjzKd6RzUmzoS61V
	9KFOFHAcbGRzx6aMvcGLlT3P8JjzKGWise9pZdTUCbHR5jepZ9QmboEI2+wDOVdr5ung42Ew91v
	afarMY8kG/8PCYjIKx9vpk5uStE0Yej9zcfsPzgLFlCuONszMUc8T743d+mwqfl5ikq2ea9pX9c
	04QRDvUI8tye5lmfPQA87JV52+WmnD1jFDhyvWs96PxPy15iq7HN8cyPU+v1dxWtOX8EyEBcauU
	8eN6WUc49NV+7gUZguiC4f7f8iceWyXpnauPGjxTSwfH8sxja+Wlwoz7PeSboWAVrpl6EJqJ3QD
	lqpXS50bmTi2f8PsNLn3VlfkNxq2PPQSifUbwwwb9sNxcRSq1v/5BfoyMKEf58ydjE0pCpC+f1X
	6KV/pXhtEwWut4ChRFiuc+mJ462KFWawdp6E8GDrQpUxdJQdutHRZyz23mTGKtnr+PodV7zG2+C
	E4qdVMtLnf+JIY8fvqMaIlRPBmHyOztaUFUDKk0YUjghem57iIT6CRkg0azMdE4
X-Received: by 2002:a05:6122:390f:b0:5c7:ebed:1018 with SMTP id 71dfb90a1353d-5c9b58e992dmr7371198e0c.8.1790024495110;
        Mon, 21 Sep 2026 14:01:35 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/6] doc: describe the true wireless broadcast assistant test case
Date: Mon, 21 Sep 2026 17:01:19 -0400
Message-ID: <20260921210123.3690449-3-luiz.dentz@gmail.com>
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
 doc/functional-bap.rst | 122 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 926d9a54a632..87917065e1eb 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -537,3 +537,125 @@ test_bap_unicast_set_transport_acquire
 	are only created once every one of them is active, so the
 	transports of both members have to be acquired: acquiring only
 	one leaves the group incomplete and no CIS is created at all.
+
+TRUE WIRELESS BROADCAST ASSISTANT
+=================================
+
+Three hosts, with the Broadcast Source and the Broadcast Assistant
+colocated on host0, and the two sides of a true wireless pair as Scan
+Delegators forming a coordinated set:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |  extended +     | host1                  |
+	| Broadcast Source       |  periodic adv   | Scan Delegator, left   |
+	| + Broadcast Assistant  | --------------> | bluetoothctl -a auto   |
+	| bluetoothctl -a auto   |                 | broadcast-delegator-   |
+	| broadcast-source-2bis  |  BIS 1, F.Left  |   left.bt              |
+	| BCAA endpoint (0x1852) | ==============> | BAA endpoint (0x1851)  |
+	|                        |                 | Front Left, rank 1     |
+	|                        | ACL, BASS, PAST |                        |
+	|                        | --------------> |                        |
+	|                        |                 +------------------------+
+	|                        |
+	|                        |  extended +     +------------------------+
+	|                        |  periodic adv   | host2                  |
+	|                        | --------------> | Scan Delegator, right  |
+	|                        |                 | bluetoothctl -a auto   |
+	|                        | BIS 2, F.Right  | broadcast-delegator-   |
+	|                        | ==============> |   right.bt             |
+	|                        |                 | BAA endpoint (0x1851)  |
+	|                        | ACL, BASS, PAST | Front Right, rank 2    |
+	|                        | --------------> |                        |
+	+------------------------+                 +------------------------+
+
+	the two delegators share the same SIRK, so they are resolved into
+	a single set and connecting one connects the other
+
+	the assistant pushes one BIS to each side, and each of them
+	receives the periodic advertising sync over its own connection
+
+	--> advertising is scanned by       ==> audio flows towards
+
+This combines the two topologies above: the BIG carries one BIS per
+channel, as in TRUE WIRELESS BROADCAST, while the sides are members of
+a coordinated set, as in COORDINATED SET, so the assistant discovers
+and connects them as one device.
+
+The delegators run `bluetoothd` with the same ``[CSIS]`` configuration
+as the acceptors of the COORDINATED SET section, with ``Rank`` 1 for
+the left one and 2 for the right one, and both advertise the RSI.
+
+``client/scripts/broadcast-source-2bis.bt`` on host0
+	As in TRUE WIRELESS BROADCAST: a BIG with one BIS per channel,
+	encrypted with the broadcast code `bluetoothctl` uses by default.
+	The two local streams are exposed as MediaAssistant objects in
+	the ``local`` state, under the adapter path, i.e.
+	``/org/bluez/hci0/sid0/bis1`` and ``/org/bluez/hci0/sid0/bis2``.
+
+``client/scripts/broadcast-delegator-left.bt`` on host1
+	Registers a Broadcast Sink endpoint
+	(``00001851-0000-1000-8000-00805f9b34fb``) with LC3 and Front Left
+	as its only location, enables automatic transport selection and
+	acquisition, and advertises with the RSI, so the Broadcast
+	Assistant can discover it as a member of the set and connect.
+
+``client/scripts/broadcast-delegator-right.bt`` on host2
+	As above, with Front Right as its only location and rank 2.
+
+test_bass_past_earbuds_transport_acquire
+----------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the source script on host0 and the
+	   delegator scripts on host1 and host2.
+	2. Assistant: ``scan on``, wait for both members to be found,
+	   ``scan off``, then ``pair`` one of them.
+	3. Assistant: ``assistant.push /org/bluez/hci0/sid0/bis1``,
+	   answering the device prompt with the device path of the left
+	   delegator, and ``assistant.push /org/bluez/hci0/sid0/bis2``
+	   with the right one.
+
+:Expected:
+	1. Two ``Acquire successful: fd <fd> MTU <read>:<write>`` on the
+	   source, i.e. it is broadcasting both channels, with the local
+	   streams exposed as ``[NEW] Assistant <adapter>/sid0/bis1`` and
+	   ``<adapter>/sid0/bis2``. On both delegators,
+	   ``Advertising object registered``.
+	2. ``Pairing successful``, the members are resolved into a single
+	   set, reported as
+	   ``[NEW] DeviceSet /org/bluez/hci0/set_<sirk>``, and the other
+	   member is connected and bonded on its own, with the services
+	   of both resolved.
+	3. ``Assistant <path> pushed`` for both pushes.
+	4. On each delegator a transport is created for the BIS that was
+	   pushed to it, and selected and acquired automatically, reaching
+	   ``State: broadcasting``, i.e. it synced to the BIG, and then
+	   ``State: active``.
+
+:Notes: Only one member is paired: finding a member of a set triggers
+	connecting the remaining ones. Both links still have to be
+	encrypted before the pushes, as the Broadcast Receive State
+	characteristic of each member is read over its own connection,
+	which is why the services of both are waited for.
+
+	Each member gets a push of its own: BASS has no notion of a set,
+	so the assistant adds the source to the Broadcast Receive State
+	of each delegator separately, and each of them receives the
+	periodic advertising sync over its own ACL (PAST).
+
+	A push carries the BIS to sync to, but the location of the member
+	is what decides whether a transport is created for it: pushing
+	the right BIS to the left side leaves it without one, as the
+	Channel Allocation does not match its PAC.
+
+	The broadcast code of the local streams is handed to the
+	delegators by the pushes, so their automatic transport selection
+	does not have to prompt for it on either side.
+
+	As in the BROADCAST ASSISTANT case, the streams are verified on
+	the delegators rather than through the state of the MediaAssistant
+	objects, which stay in the ``local`` state.
-- 
2.55.0


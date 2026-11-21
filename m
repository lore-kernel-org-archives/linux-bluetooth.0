Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795240418;
	b=XlY0AfMa9gy6qC0zzjlsc5ap+pcA4Dme9oCMeebp3/AfAUzzi62PniDzp15krhkFC18p
	 ZcRwkFeReuW3Gz2ZzXVeFg7uHwL6yWJbVMj8Akcfe8OLhu+RXU51P6IjBrYHXmAfH6LCP
	 HcEra4JIJTP1+l0WeNJFTAJQHo7ZT8SVEQfXOt2pbISBQu8yH/kl7sU0LvUvnkf89LpRL
	 fi9kUWuynxIZ+qsbn7QIgVyQA4vbzubYOZae4zNFKai5g9Wz4as59fabM+EtCvoi3dPKR
	 uHgsEteM2ibSGbAIJVJfjfg2kUjWlLnQlhcGdyYLKYGwRGhhKePTnpkzN7Fu4GzRuzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795240418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dVyV4HmKBDoJrrfx5VhTh6nEmgVsaW1JdMHUHgcDgXg=;
	b=K25PYttx5IdMmz9Vre6vTmQ6nHE8i0JYsxBlJV1j12owim5Rx13CUWA2sQ2gwwzL5vml
	 joMPViET8wG4GAoF0nEOPPdUHZlhl1P/YeVR0f0Jc1poIP1b0db9YaHf7hgYHrWNfJBGO
	 qxur2U6fbADjWZ6IJsTxt4WvajHU75tv6UMaBqMclVgAhHj5vDZXxdoinUrAuBpddwPFA
	 RoLEm5i08Qwh50MCFKHxEoJoPkM13VvN8fsN1m9hW1siuCBs7bXKrqdLbNn399CHX2jSG
	 vGp5qCilZM/VDt19I4SrjesrhVEpBrNFyKoCS8fYN1F2wZ4XA4beRo/a4nTx4tC27Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IHk7maEG;
	arc=none smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E3606A68A
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 05:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13E3606A68A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IHk7maEG
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5495d549924so17727341cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 21:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795240415; x=1795845215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dVyV4HmKBDoJrrfx5VhTh6nEmgVsaW1JdMHUHgcDgXg=;
        b=IHk7maEG5OQBNi6j1N5OsDX8vhCs5hFU3M55NO6YYQquPGxzYWKS1trMzukv+XBvHu
         yvFVI+9lHIPVRyf8VGPqQRTPZp948+419WixHB/PxmKNblEF0QnRtmIX7oPagnYvqMIM
         bHXHy+7Z3CCrTiqah3Z8QWNPvHToRQh2wI/h5ejDJ7F5Fp700lwpj47FCggXJPHZRg0G
         ePWuW4MUw5Yf3w338X1+Dr4HPtbgCotcIjE92TfTXYTjdzs5Tu6+LL+kQxLlLAMmSutS
         w8hacEsNdulLKfWXEB95lkZB2iUb6QJ8C4jb08O6uhgh4Ay+TZZvz3cWK8N1B7lxhWfb
         7GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795240415; x=1795845215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dVyV4HmKBDoJrrfx5VhTh6nEmgVsaW1JdMHUHgcDgXg=;
        b=kChydNaolYjxcXr9U/vHAVQv8LZnG3kbRuHJwq5QXxbQc3FEecjLyvguNT2QYjFIOW
         nPBckmIbTvp8UM6Aorp9s8HEk7PmBONhRIpxCQiHX/e8BrKm/lcXCDipXwkBN3C1jKSi
         84dvXcBC8txOd0Z8StVUDK50FWa7K/p8rQBXR1UU++kBhXZeg8hf4lIKEQnqu5zzM/mC
         CaQ6Ld2F2I1f3b8sKvqxuAiP+oeItfYa8NC85v7BbRL5G6052p4XkcO/0LbbIMjay4yw
         SZXm7SoLusl2luVmLlrQG05ky42rNzHZCdWKVo0lItJiTTYTqIfCZdC91gIldklwbc3q
         Jzkw==
X-Gm-Message-State: APuU4Z+mkiHHn/T8cL8t1fUxobdmJVXlbjos2ACtr1LF693RPPoFPVIn
	TkaXUteiBaY6tCcFDdxn/WuUO02gopnzZiNXGL2p0NdNnUUO02Lev7eHVxeYYA8F
X-Gm-Gg: AZFdTZeg1MByjiOGOIFOvAYQ6y7HK1xsBtFrM2bNcbRydvSzpRgKC35aEEtWwbZ/aAl
	vdKWFDNbLP7+6h4TcneqCqWrhj9M3IopnIxLYouVmJpV0ygKuPjjr6WaRJ0R7u4OL+0KJlfDB9n
	i9jxxP2iPm08IFMubJCJYjWJHS1SVTdsHrfCqNrk2Mr6fBWtX21HnOHmhwW2komKW3bn/h0o6yt
	ry1SoyaRyGnraXPOMKZzJSy6HWkOPnpskREugWAuQW8z1CMSIC4wU6n/HGbdzl5hAbeKjjIvMEK
	KrRSqXIIfusu1C146BAtZCMKqYreUNMRvMnp39FzKyb16xm/eGjjT8LcQfM2deG/4oPWCW/E8hU
	a427me3f22Wy8RKLL2FrGpvnCJ7/WPL4ppKBu97x+SfN1BIvAE+KL+wv4HSoka3PsEmsptDjigr
	iD62aQe/699mrfoiBzo/c7KCjksyWToOJYPCpzFBjdmZ+cZ8iGGUY0EGfmzBCPY8YAAyrvSMiqZ
	8CA9mOYrIax68or84GB2y6cdWMei0RL7V7d/TW/2kwwMXXMd8tyePLID6HfL1mVNAaEkHRf7Nb4
	+eIBp+m3Pvo52HQ73psn7kVV/co9AZ73F4hfxkxGGOYqhAD6Ddp7rgM8rYFVD9k9PB3GsoxFXIe
	gyihRDnoJnplSaD/qmO/CnYUizh0nd84rSvJQKRQ/c1ddqvVesarC50fjzI3N+QZY
X-Received: by 2002:a05:622a:8cb:b0:55a:5056:d3c1 with SMTP id d75a77b69052e-55d769e1659mr91269861cf.13.1795240414439;
        Fri, 20 Nov 2026 21:53:34 -0800 (PST)
Received: from fishcake-omen-transcend.uwaterloo.ca (wn-res-nat-129-97-125-157.dynamic.uwaterloo.ca. [129.97.125.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm41259421cf.17.2026.11.20.21.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:53:33 -0800 (PST)
From: Muxian Li <muxianli5401@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Muxian Li <muxianli5401@gmail.com>
Subject: [PATCH BlueZ v2 2/2] test: functional: Cover SDP records without handle
Date: Sat, 21 Nov 2026 00:51:57 -0500
Message-ID: <20261121055157.131496-2-muxianli5401@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261121055157.131496-1-muxianli5401@gmail.com>
References: <20261121055157.131496-1-muxianli5401@gmail.com>
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

Make host1 answer SDP itself, without bluetoothd, with records that
lack the ServiceRecordHandle attribute, like those of a Nintendo
Switch 2. Check that bluetoothd on host0 keeps and caches each record
once, that a record keeps its cache key from one discovery to the
next, and that records with and without a handle do not overwrite each
other, also when host1 goes out of range during a discovery.

Document the tests in functional-sdp(7).

Assisted-by: Claude:claude-mythos-5-2
---
v2:
- Check the responses host1 sent, the cache keys and the cached
  records themselves.
- Add test_sdp_out_of_range.py and test_sdp_cache.py.
- Move the documentation to functional-sdp(7).

 Makefile.am                              |   1 +
 doc/functional-sdp.rst                   | 619 +++++++++++++++++++
 doc/functional-testing.rst               |   3 +
 test/functional/test_sdp.py              | 333 ++++++++++
 test/functional/test_sdp_cache.py        | 739 +++++++++++++++++++++++
 test/functional/test_sdp_out_of_range.py | 723 ++++++++++++++++++++++
 6 files changed, 2418 insertions(+)
 create mode 100644 doc/functional-sdp.rst
 create mode 100644 test/functional/test_sdp.py
 create mode 100644 test/functional/test_sdp_cache.py
 create mode 100644 test/functional/test_sdp_out_of_range.py

diff --git a/Makefile.am b/Makefile.am
index 37302ed47..b51a6ff30 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -506,6 +506,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/functional-hog.rst \
 				doc/functional-mpris-proxy.rst \
 				doc/functional-obex.rst \
+				doc/functional-sdp.rst \
 				doc/settings-storage.txt
 
 EXTRA_DIST += doc/hci-protocol.rst doc/mgmt-protocol.rst \
diff --git a/doc/functional-sdp.rst b/doc/functional-sdp.rst
new file mode 100644
index 000000000..5e40b9717
--- /dev/null
+++ b/doc/functional-sdp.rst
@@ -0,0 +1,619 @@
+==============
+functional-sdp
+==============
+
+DESCRIPTION
+===========
+
+SDP client functional tests, `test/functional/test_sdp.py`,
+`test/functional/test_sdp_out_of_range.py` and
+`test/functional/test_sdp_cache.py`, covering the service discovery of
+**bluetoothd(8)** over BR/EDR and the SDP records it caches. See
+**functional-testing(7)** for the conventions used here, and
+**test-functional(1)** for how to run the suite.
+
+SETUP
+=====
+
+Two hosts, connected over BR/EDR. host0 runs **bluetoothd(8)** with an
+agent. host1 runs no bluetoothd: `btmgmt` makes it connectable and
+discoverable, and it answers SDP on PSM 1 itself:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |      BR/EDR     | host1                  |
+	| bluetoothd, agent      | --------------> | SDP server, PSM 1      |
+	| discovers, browses     |                 | no bluetoothd          |
+	+------------------------+                 +------------------------+
+
+	--> connection is initiated by
+
+host0 discovers the services of host1 as follows:
+
+1. host0 calls ``org.bluez.Adapter1.StartDiscovery`` until it has a
+   device object for host1, then ``StopDiscovery``.
+2. host0 sets ``Trusted`` on it, as bluetoothd only keeps a device that
+   is paired or trusted once its link is lost.
+3. host0 calls ``org.bluez.Device1.Connect``, which browses the SDP
+   records of host1 with a Service Search Attribute request for the
+   L2CAP UUID, and then one for the PnP Information UUID. ``Connect``
+   returns an error, as host1 offers no service to connect.
+
+bluetoothd caches the records in the ``ServiceRecords`` group of the
+cache file of host1, using their handle as key (see
+`doc/settings-storage.txt`). A record without the ServiceRecordHandle
+attribute has no handle, so bluetoothd chooses a key for it.
+
+The tests in `test_sdp_cache.py` have host1 return these records:
+
+A, B, C, E
+	Records of the service classes 0x7001, 0x7002, 0x7003 and 0x7005,
+	which no profile of bluetoothd handles, as ``Connect`` only
+	discovers the services of a known device again if it finds no
+	service to connect. Returned for the L2CAP search, without handle
+	unless a test says otherwise.
+
+D
+	A PnP Information record without handle, returned for the PnP
+	Information search unless a test says otherwise.
+
+A changed record is the same record with attribute 0x0200 set to
+another value.
+
+Unless a test says otherwise, it checks that the cache holds exactly
+the records named, each of them once, that every key is ``0x``
+followed by 8 uppercase hexadecimal digits, and that a record with a
+handle is cached under it.
+
+Some tests run **bluetoothd(8)** with ``Experimental = true``, for
+``org.bluez.Device1.GetServiceRecords``, which returns the records
+bluetoothd has in memory. host1 connects to host0 first, as the method
+requires a connected device, which does not make host0 discover its
+services again.
+
+TEST CASES
+==========
+
+test_sdp_records_without_handle[switch2]
+----------------------------------------
+
+:Setup: As above, host1 answers with the records of a Nintendo Switch
+	2, none of which has the ServiceRecordHandle attribute: Audio
+	Source, A/V Remote Control and A/V Remote Control Target for the
+	L2CAP search, and PnP Information for the PnP Information search.
+
+:Steps:
+	1. host0 calls ``org.bluez.Adapter1.StartDiscovery`` until it has a
+	   device object for host1, then ``StopDiscovery``.
+	2. host0 calls ``org.bluez.Device1.Connect``.
+	3. Wait until ``org.bluez.Device1.UUIDs`` of host1 contains the
+	   Audio Source UUID of its first record.
+
+:Expected:
+	1. ``UUIDs`` also contains the A/V Remote Control Target, A/V
+	   Remote Control and PnP Information UUIDs of the other records.
+	2. host1 sent the PnP Information record in its second response
+	   only.
+	3. The cache holds each of the 4 records once.
+
+:Notes: Skipped if `btmgmt` is not built.
+
+test_sdp_records_without_handle[duplicate]
+------------------------------------------
+
+:Setup: As above, but host1 also returns the PnP Information record
+	for the L2CAP search.
+
+:Steps: As above.
+
+:Expected: As above, except host1 sent the PnP Information record in
+	both responses. It is cached once.
+
+test_sdp_new_without_handle_down_before_second_response
+-------------------------------------------------------
+
+:Setup: As for test_sdp_records_without_handle[switch2], except host1
+	goes out of range when it receives the second request: it stops
+	page scan, disconnects with the reason Connection Timeout and
+	powers off.
+
+:Steps: host0 discovers the services of host1.
+
+:Expected:
+	1. ``Connect`` returns ``br-connection-create-socket``.
+	2. ``UUIDs`` of host1 is empty, as the discovery did not complete.
+	3. The cache holds the 3 records of the first search.
+
+:Notes: btvirt has no link supervision timeout, so host1 disconnects
+	with that reason itself, which btvirt passes on to host0 as it is.
+
+test_sdp_cache_same_record_twice
+--------------------------------
+
+:Setup: As above, host1 returns A, A and C for the L2CAP search.
+
+:Steps: host0 discovers the services of host1.
+
+:Expected: The cache holds A, C and D.
+
+test_sdp_cache_in_memory_after_discovery
+----------------------------------------
+
+:Setup: As above, with ``Experimental = true``. host1 returns A, B and
+	C.
+
+:Steps:
+	1. host0 discovers the services of host1.
+	2. host1 connects to host0, and host0 calls
+	   ``org.bluez.Device1.GetServiceRecords``.
+
+:Expected: ``GetServiceRecords`` returns A, B, C and D, each once.
+
+test_sdp_cache_in_memory_after_rediscovery
+------------------------------------------
+
+:Setup: As above, with ``Experimental = true``.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A, B and
+	   C.
+	2. host0 discovers them again, host1 returning A and C.
+	3. host1 connects to host0, and host0 calls
+	   ``org.bluez.Device1.GetServiceRecords``.
+
+:Expected:
+	1. ``GetServiceRecords`` returns A, C and D, each once.
+	2. The cache holds A, B, C and D.
+
+test_sdp_cache_same_records
+---------------------------
+
+:Setup: As above.
+
+:Steps: host0 discovers the services of host1 twice, host1 returning
+	A, B and C both times.
+
+:Expected: The cache holds A, B, C and D, each under the key it had
+	after the first discovery.
+
+test_sdp_cache_records_in_other_order
+-------------------------------------
+
+:Setup: As above.
+
+:Steps: As for test_sdp_cache_same_records, except host1 returns C, A
+	and B the second time.
+
+:Expected: As for test_sdp_cache_same_records.
+
+test_sdp_cache_record_in_both_searches_again
+--------------------------------------------
+
+:Setup: As above.
+
+:Steps: As for test_sdp_cache_same_records, except host1 returns A, B,
+	C and D for the L2CAP search the second time.
+
+:Expected: As for test_sdp_cache_same_records, and host1 sent D in
+	both responses of the second discovery.
+
+test_sdp_cache_fewer_records
+----------------------------
+
+:Setup: As above.
+
+:Steps: As for test_sdp_cache_same_records, except host1 returns A and
+	C the second time.
+
+:Expected: As for test_sdp_cache_same_records: B stays cached, as
+	bluetoothd keeps the records with a handle it no longer finds.
+
+test_sdp_cache_changed_record_read_back
+---------------------------------------
+
+:Setup: As above, with ``Experimental = true``.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A, B and
+	   C.
+	2. host0 discovers them again, host1 returning A, B and a changed
+	   C.
+	3. **bluetoothd(8)** is restarted on host0, with the same state
+	   directory.
+	4. host1 connects to host0, and host0 calls
+	   ``org.bluez.Device1.GetServiceRecords``.
+
+:Expected: ``GetServiceRecords`` returns A, B, both versions of C and
+	D, each once, the first version of C before the changed one.
+
+:Notes: bluetoothd can not tell a changed record without handle from a
+	new one. A lookup by UUID finds the first record of that UUID.
+
+test_sdp_cache_changed_record_every_discovery
+---------------------------------------------
+
+:Setup: As above.
+
+:Steps: host0 discovers the services of host1 four times. host1
+	returns A, B and C, with C changed at each discovery.
+
+:Expected: After each discovery the cache holds one more record, the
+	new version of C, and every record cached before under the key it
+	had.
+
+test_sdp_cache_added_record[added-last]
+---------------------------------------
+
+:Setup: As above.
+
+:Steps: As for test_sdp_cache_same_records, except host1 returns A, B,
+	C and E the second time.
+
+:Expected: The cache holds A, B, C, D and E. A, B, C and D have the key
+	they had after the first discovery.
+
+test_sdp_cache_added_record[added-first]
+----------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except host1 returns E, A, B and C the second time.
+
+:Expected: As above.
+
+test_sdp_cache_added_record_down_before_second_response[added-last]
+-------------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As for test_sdp_cache_added_record[added-last], except host1
+	goes out of range when it receives the second request of the
+	second discovery.
+
+:Expected: As for test_sdp_cache_added_record[added-last]: D, which
+	host0 did not get again, stays cached.
+
+test_sdp_cache_added_record_down_before_second_response[added-first]
+--------------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except host1 returns E, A, B and C the second time.
+
+:Expected: As above.
+
+test_sdp_cache_written_without_fix
+----------------------------------
+
+:Setup: As above. Before the discovery, B is written to the cache file
+	of host1 under ``0xFFFFFFFF``, as a bluetoothd that only keeps one
+	record without handle caches it.
+
+:Steps: host0 discovers the services of host1, which returns A, B and
+	C.
+
+:Expected: The cache holds A, B, C and D, B still under
+	``0xFFFFFFFF``.
+
+test_sdp_cache_value_no_record[first-key]
+-----------------------------------------
+
+:Setup: As above. Before the discovery, the value ``DEADBEEF``, which
+	is no SDP record, is written to the cache file of host1 under
+	``0xFFFFFFFF``.
+
+:Steps: host0 discovers the services of host1, which returns A, B and
+	C.
+
+:Expected: The cache holds A, B, C and D, and the entry written before
+	as it was.
+
+test_sdp_cache_value_no_record[second-key]
+------------------------------------------
+
+:Setup: As above, but the value is written under ``0xFFFFFFFE``.
+
+:Steps: As above.
+
+:Expected: As above.
+
+test_sdp_cache_value_no_record[empty]
+-------------------------------------
+
+:Setup: As for test_sdp_cache_value_no_record[first-key], but the
+	value is empty.
+
+:Steps: As above.
+
+:Expected: As above.
+
+test_sdp_cache_value_no_record[not-hex]
+---------------------------------------
+
+:Setup: As for test_sdp_cache_value_no_record[first-key], but the
+	value is ``not hex``.
+
+:Steps: As above.
+
+:Expected: As above.
+
+test_sdp_cache_read_back_after_restart
+--------------------------------------
+
+:Setup: As above, with ``Experimental = true``.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A, B and
+	   C.
+	2. host0 discovers them again, host1 returning A and C.
+	3. **bluetoothd(8)** is restarted on host0, with the same state
+	   directory.
+	4. host1 connects to host0, and host0 calls
+	   ``org.bluez.Device1.GetServiceRecords``.
+
+:Expected: ``GetServiceRecords`` returns A, B, C and D, each once.
+
+test_sdp_cache_handle_equal_to_key_same_search[first]
+-----------------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A and C,
+	   and reads the key of C from the cache.
+	2. host0 calls ``org.bluez.Adapter1.RemoveDevice`` on host1, and
+	   finds it again.
+	3. host0 discovers the services of host1, which returns R, A and
+	   C. R is a record of service class 0x7004 with the key of C as
+	   handle.
+
+:Expected: The cache holds A, R, C and D, R under its handle.
+
+:Notes: The key is read from an earlier discovery, so the test does
+	not depend on how bluetoothd chooses the keys of records without
+	handle.
+
+test_sdp_cache_handle_equal_to_key_same_search[middle]
+------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except host1 returns A, R and C.
+
+:Expected: As above.
+
+test_sdp_cache_handle_equal_to_key_same_search[last]
+----------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except host1 returns A, C and R, so R is found after
+	C got that key.
+
+:Expected: As above.
+
+test_sdp_cache_handle_equal_to_key_later_search[key-of-first]
+-------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A and C
+	   and no PnP Information record, and reads the key of A from the
+	   cache.
+	2. host0 removes host1 and finds it again.
+	3. host0 discovers the services of host1, which returns A and C,
+	   and for the PnP Information search a PnP Information record R
+	   with the key of A as handle.
+
+:Expected: The cache holds A, C and R, R under its handle.
+
+test_sdp_cache_handle_equal_to_key_later_search[key-of-second]
+--------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, with the key of C.
+
+:Expected: As above.
+
+test_sdp_cache_handle_equal_to_key_later_discovery[key-of-c-complete]
+---------------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A, B and
+	   C, and reads the key of C from the cache.
+	2. host0 discovers them again, host1 returning A, B, C and R. R is
+	   a record of service class 0x7004 with the key of C as handle.
+
+:Expected: The cache holds A, B, C, D and R, R under its handle. C is
+	cached under another key, and A, B and D have the key they had
+	after the first discovery.
+
+test_sdp_cache_handle_equal_to_key_later_discovery[key-of-c-down]
+-----------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except host1 goes out of range when it receives the
+	second request of the second discovery.
+
+:Expected: As above.
+
+test_sdp_cache_handle_equal_to_key_later_discovery[key-of-d-down]
+-----------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, with the key of D, which host0 does not get again.
+
+:Expected: As above, D being the record cached under another key.
+
+test_sdp_cache_handle_equal_to_key_later_discovery[key-of-d-first-down]
+-----------------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except host1 returns R, A, B and C.
+
+:Expected: As above.
+
+test_sdp_cache_handle_equal_to_key_later_discovery[key-of-dropped-b]
+--------------------------------------------------------------------
+
+:Setup: As above.
+
+:Steps: As for
+	test_sdp_cache_handle_equal_to_key_later_discovery[key-of-c-complete],
+	with the key of B, host1 returning A, C and R the second time.
+
+:Expected: As above, B being the record cached under another key.
+
+test_sdp_cache_key_equal_to_cached_handle[dropped]
+--------------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A and E
+	   and no PnP Information record, and reads the key of E from the
+	   cache.
+	2. host0 removes host1 and finds it again.
+	3. host0 discovers the services of host1, which returns A, and
+	   for the PnP Information search a PnP Information record P with
+	   the key of E as handle.
+	4. host0 discovers them again, host1 returning A and E and no PnP
+	   Information record.
+
+:Expected: The cache holds A, E and P. A and P have the key they had
+	after step 3.
+
+test_sdp_cache_key_equal_to_cached_handle[down]
+-----------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, except in step 4 host1 still returns P, and goes out
+	of range when it receives the second request.
+
+:Expected: As above.
+
+test_sdp_cache_handle_0xffffffff
+--------------------------------
+
+:Setup: As above. R is a record of service class 0x7004 with the
+	handle 0xFFFFFFFF.
+
+:Steps: host0 discovers the services of host1, which returns B, R and
+	C.
+
+:Expected: The cache holds B, R, C and D, R under ``0xFFFFFFFF``.
+
+:Notes: 0xFFFFFFFF is also the value the handle of a record without
+	the ServiceRecordHandle attribute has in bluetoothd.
+
+test_sdp_cache_same_handle_twice
+--------------------------------
+
+:Setup: As above. R1 and R2 are records of the service classes 0x7004
+	and 0x7006, both with the handle 0xFFFFFFFF.
+
+:Steps: host0 discovers the services of host1, which returns R1 and
+	R2.
+
+:Expected:
+	1. The cache holds R1 and D.
+	2. ``UUIDs`` of host1 contains the UUID of R1, and not the one of
+	   R2.
+
+:Notes: The second record is dropped as a duplicate of the first, as
+	for any handle.
+
+test_sdp_cache_same_handle_changed
+----------------------------------
+
+:Setup: As above. R is a record of service class 0x7004 with the
+	handle 0xFFFFFFFF.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A and R.
+	2. host0 discovers them again, host1 returning A and a changed R.
+
+:Expected: The cache holds A, the changed R and D.
+
+test_sdp_cache_handles_gained_or_lost[gains]
+--------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns A and C.
+	2. host0 discovers them again, host1 returning A, C and D with the
+	   handles 0x00010001, 0x00010003 and 0x00010004.
+
+:Expected: The cache holds the records of both discoveries, those of
+	the first under the key they had.
+
+test_sdp_cache_handles_gained_or_lost[loses]
+--------------------------------------------
+
+:Setup: As above.
+
+:Steps: As above, with the two discoveries in the other order.
+
+:Expected: As above.
+
+test_sdp_cache_many_records
+---------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. host0 discovers the services of host1, which returns 10000
+	   records of service class 0x7001 for the L2CAP search, each with
+	   a handle of its own and another value of attribute 0x0200.
+	2. host0 removes host1 and finds it again.
+	3. host0 discovers the services of host1, which returns the same
+	   records without handle.
+
+:Expected:
+	1. The cache holds 10001 records after each discovery.
+	2. host0 takes at most twice as long from the response to the
+	   L2CAP search to its PnP Information search in step 3 as in
+	   step 1.
+
+:Notes: host1 sends a response that does not fit in the L2CAP MTU in
+	parts of 600 bytes, with a continuation state. The time is taken
+	on host1, so it does not include the transfer of the response.
+	The keys and the records themselves are not checked.
+
+test_sdp_cache_public_browse_group[alone]
+-----------------------------------------
+
+:Setup: As above. X and Y are records of service class 0x1002 without
+	handle. host1 returns no record for the L2CAP and the PnP
+	Information search, and X and Y for the Public Browse Group
+	search.
+
+:Steps: host0 discovers the services of host1.
+
+:Expected:
+	1. host1 received three searches.
+	2. The cache holds X and Y.
+
+:Notes: bluetoothd only searches for the Public Browse Group if the
+	L2CAP search returns no record, and only keeps records of that
+	service class from it. It handles the records of its last search
+	twice.
+
+test_sdp_cache_public_browse_group[after-pnp]
+---------------------------------------------
+
+:Setup: As above, but host1 returns D for the PnP Information search.
+
+:Steps: As above.
+
+:Expected: As above, the cache holding X, Y and D.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 371258261..6c9689dfa 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -19,6 +19,9 @@ are documented separately:
 - **functional-hog(7)**: `test/functional/test_hog.py`
 - **functional-mpris-proxy(7)**: `test/functional/test_mpris_proxy.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
+- **functional-sdp(7)**: `test/functional/test_sdp.py`,
+  `test/functional/test_sdp_out_of_range.py` and
+  `test/functional/test_sdp_cache.py`
 
 Each test case is described as:
 
diff --git a/test/functional/test_sdp.py b/test/functional/test_sdp.py
new file mode 100644
index 000000000..2a27ea4df
--- /dev/null
+++ b/test/functional/test_sdp.py
@@ -0,0 +1,333 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the bluetoothd SDP client using VM instances
+"""
+
+import configparser
+import glob
+import os
+import re
+import socket
+import struct
+import subprocess
+import threading
+
+import dbus
+import pytest
+
+from pytest_bluezenv import (
+    host_config,
+    Agent,
+    HostPlugin,
+    find_exe,
+    run,
+    wait_until,
+    mainloop_wrap,
+    get_dbus,
+)
+
+pytestmark = [pytest.mark.vm]
+
+SDP_PSM = 0x0001
+SDP_SVC_SEARCH_ATTR_REQ = 0x06
+SDP_SVC_SEARCH_ATTR_RSP = 0x07
+L2CAP_UUID = 0x0100
+PNP_INFO_UUID = 0x1200
+
+SDP_DE_UINT = 1
+SDP_DE_UUID = 3
+SDP_DE_SEQ = 6
+SDP_DE_ALT = 7
+
+# Key format of doc/settings-storage.txt: the handle in hexadecimal
+KEY = re.compile(r"0x[0-9A-F]{8}")
+
+# Attribute lists sent by a Nintendo Switch 2 for the L2CAP and PnP searches
+# of bluetoothd, over the full attribute range. None of its records has the
+# ServiceRecordHandle attribute (0x0000).
+SWITCH2_RECORDS = {
+    L2CAP_UUID: bytes.fromhex(
+        "36009c"
+        # Audio Source
+        "360030090001350319110a090004351035061901000900193506190019090103"
+        "0900093508350619110d090104090311090000"
+        # A/V Remote Control, A/V Remote Control Controller
+        "360033090001350619110e19110f090004351035061901000900173506190017"
+        "0901040900093508350619110e090106090311090002"
+        # A/V Remote Control Target
+        "360030090001350319110c090004351035061901000900173506190017090104"
+        "0900093508350619110e090106090311090001"
+    ),
+    PNP_INFO_UUID: bytes.fromhex(
+        "36002e"
+        "36002b0900013503191200090200090103090201090553090202092060090203"
+        "0901000902042801090205090001"
+    ),
+}
+
+
+def de_span(buf, pos):
+    """Type, and start and end of the data, of the data element at pos"""
+    dtype, index = buf[pos] >> 3, buf[pos] & 7
+    pos += 1
+
+    if dtype == 0:
+        return dtype, pos, pos
+
+    if index < 5:
+        return dtype, pos, pos + (1 << index)
+
+    size = 1 << (index - 5)
+    start = pos + size
+    return dtype, start, start + int.from_bytes(buf[pos:start], "big")
+
+
+def de_parse(buf, pos=0):
+    """
+    Value of the data element at pos and the position after it. How its
+    size was encoded is left out, so that equal values compare equal.
+    """
+    dtype, start, end = de_span(buf, pos)
+
+    if dtype not in (SDP_DE_SEQ, SDP_DE_ALT):
+        return (dtype, bytes(buf[start:end])), end
+
+    items = []
+    while start < end:
+        item, start = de_parse(buf, start)
+        items.append(item)
+
+    return (dtype, tuple(items)), end
+
+
+def record_attrs(attr_list):
+    """Attributes of a record as a sorted tuple of (id, value)"""
+    dtype, start, end = de_span(attr_list, 0)
+    if dtype == SDP_DE_SEQ and end == len(attr_list):
+        attr_list = attr_list[start:end]
+
+    attrs = {}
+    pos = 0
+    while pos < len(attr_list):
+        (dtype, attr), pos = de_parse(attr_list, pos)
+        assert dtype == SDP_DE_UINT and len(attr) == 2
+        attrs[int.from_bytes(attr, "big")], pos = de_parse(attr_list, pos)
+
+    return tuple(sorted(attrs.items()))
+
+
+def split_records(attr_lists):
+    """Attribute lists of the records of a Service Search Attribute response"""
+    _, pos, end = de_span(attr_lists, 0)
+
+    records = []
+    while pos < end:
+        _, start, pos = de_span(attr_lists, pos)
+        records.append(attr_lists[start:pos])
+
+    return records
+
+
+def search_uuids(params):
+    """UUID16 values of the ServiceSearchPattern of a request"""
+    if params[0] == 0x35:
+        size, pos = params[1], 2
+    elif params[0] == 0x36:
+        size, pos = struct.unpack(">H", params[1:3])[0], 3
+    else:
+        return set()
+
+    pattern = params[pos : pos + size]
+    return {
+        struct.unpack(">H", pattern[i + 1 : i + 3])[0]
+        for i in range(0, len(pattern) - 2, 3)
+        if pattern[i] == 0x19
+    }
+
+
+def search_attr_rsp(tid, attr_lists):
+    params = struct.pack(">H", len(attr_lists)) + attr_lists + b"\x00"
+    return struct.pack(">BHH", SDP_SVC_SEARCH_ATTR_RSP, tid, len(params)) + params
+
+
+class Switch2SdpServer(HostPlugin):
+    """
+    SDP server without bluetoothd that answers Service Search Attribute
+    requests with the records of a Nintendo Switch 2.
+    """
+
+    name = "switch2_sdp"
+
+    def presetup(self, config):
+        try:
+            self.btmgmt = find_exe("tools", "btmgmt")
+        except FileNotFoundError as exc:
+            pytest.skip(reason=f"btmgmt: {exc!r}")
+
+    def setup(self, impl):
+        self.records = dict(SWITCH2_RECORDS)
+        self.answered = []
+
+        for cmd in (("connectable", "on"), ("power", "on"), ("discov", "yes")):
+            run(
+                [self.btmgmt, "--index", "0", *cmd],
+                check=True,
+                stdin=subprocess.DEVNULL,
+            )
+
+        self.sock = socket.socket(
+            socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET, socket.BTPROTO_L2CAP
+        )
+        self.sock.bind((socket.BDADDR_ANY, SDP_PSM))
+        self.sock.listen(1)
+        threading.Thread(target=self.serve, daemon=True).start()
+
+    def serve(self):
+        while True:
+            try:
+                conn, _ = self.sock.accept()
+            except OSError:
+                return
+
+            with conn:
+                self.answer(conn)
+
+    def answer(self, conn):
+        while True:
+            try:
+                pdu = conn.recv(1024)
+            except OSError:
+                return
+
+            if not pdu:
+                return
+
+            if len(pdu) < 6 or pdu[0] != SDP_SVC_SEARCH_ATTR_REQ:
+                continue
+
+            tid = struct.unpack(">H", pdu[1:3])[0]
+            attr_lists = b"\x35\x00"
+            for uuid in search_uuids(pdu[5:]):
+                attr_lists = self.records.get(uuid, attr_lists)
+
+            conn.send(search_attr_rsp(tid, attr_lists))
+            self.answered.append(split_records(attr_lists))
+
+    def get_answered(self):
+        """Records of each response sent, as attribute lists"""
+        return list(self.answered)
+
+    def answer_pnp_in_l2cap_search(self):
+        """
+        Also return the PnP Information record for the L2CAP search, so
+        that bluetoothd gets it from both of its searches.
+        """
+        l2cap = self.records[L2CAP_UUID][3:]
+        pnp = self.records[PNP_INFO_UUID][3:]
+        self.records[L2CAP_UUID] = (
+            struct.pack(">BH", 0x36, len(l2cap) + len(pnp)) + l2cap + pnp
+        )
+
+    def teardown(self):
+        self.sock.close()
+
+
+@mainloop_wrap
+def device_uuids(address):
+    bus = get_dbus()
+    manager = dbus.Interface(
+        bus.get_object("org.bluez", "/"), "org.freedesktop.DBus.ObjectManager"
+    )
+
+    for ifaces in manager.GetManagedObjects().values():
+        device = ifaces.get("org.bluez.Device1")
+        if device is not None and device["Address"].lower() == address.lower():
+            return [str(uuid) for uuid in device.get("UUIDs", [])]
+
+    return []
+
+
+@mainloop_wrap
+def bluetoothd_state_directory():
+    """State directory of the bluetoothd that owns org.bluez"""
+    bus = get_dbus()
+    bus_daemon = dbus.Interface(
+        bus.get_object("org.freedesktop.DBus", "/org/freedesktop/DBus"),
+        "org.freedesktop.DBus",
+    )
+    pid = bus_daemon.GetConnectionUnixProcessID("org.bluez")
+
+    with open(f"/proc/{pid}/environ", "rb") as f:
+        env = dict(var.split(b"=", 1) for var in f.read().split(b"\0") if b"=" in var)
+
+    # Set by the Bluetoothd plugin; src/textfile.c uses its first path
+    return env[b"STATE_DIRECTORY"].split(b":")[0].decode()
+
+
+def cached_records(address):
+    """
+    Service records in the cache file bluetoothd keeps for a device, as
+    (key, value)
+    """
+    state_dir = bluetoothd_state_directory()
+    paths = glob.glob(os.path.join(state_dir, "*", "cache", address.upper()))
+    assert len(paths) == 1, paths
+
+    cache = configparser.ConfigParser(interpolation=None)
+    cache.optionxform = str
+    cache.read(paths[0])
+
+    if not cache.has_section("ServiceRecords"):
+        return []
+
+    return list(cache["ServiceRecords"].items())
+
+
+@host_config([Agent()], [Switch2SdpServer()])
+@pytest.mark.parametrize("duplicate", [False, True], ids=["switch2", "duplicate"])
+def test_sdp_records_without_handle(hosts, duplicate):
+    host0, host1 = hosts
+
+    if duplicate:
+        host1.switch2_sdp.answer_pnp_in_l2cap_search()
+
+    host0.agent.adapter_method("StartDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+
+    wait_until(host0.agent.has_device, host1.bdaddr)
+
+    host0.agent.adapter_method("StopDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StopDiscovery:reply")
+
+    # Connecting browses the SDP records of host1; host1 offers no profile
+    # to connect, so the result of Connect itself does not matter.
+    host0.agent.device_method(host1.bdaddr, "Connect")
+
+    # All UUIDs of a browse are added at once
+    audio_source = "0000110a-0000-1000-8000-00805f9b34fb"
+    wait_until(lambda: audio_source in host0.call(device_uuids, host1.bdaddr))
+
+    uuids = host0.call(device_uuids, host1.bdaddr)
+    assert "0000110c-0000-1000-8000-00805f9b34fb" in uuids
+    assert "0000110e-0000-1000-8000-00805f9b34fb" in uuids
+    assert "00001200-0000-1000-8000-00805f9b34fb" in uuids
+
+    # bluetoothd got the PnP Information record from both searches, if
+    # duplicate, else from the second only
+    answered = host1.switch2_sdp.get_answered()
+    pnp = split_records(SWITCH2_RECORDS[PNP_INFO_UUID])
+    assert len(answered) == 2
+    assert answered[1] == pnp
+    assert (answered[0][-1:] == pnp) == duplicate
+
+    # Each record is cached once, also the PnP record received twice, under
+    # a key of the documented format
+    cached = host0.call(cached_records, host1.bdaddr)
+    for key, _ in cached:
+        assert KEY.fullmatch(key), key
+
+    expected = split_records(SWITCH2_RECORDS[L2CAP_UUID]) + pnp
+    assert sorted(record_attrs(bytes.fromhex(v)) for _, v in cached) == sorted(
+        map(record_attrs, expected)
+    )
diff --git a/test/functional/test_sdp_cache.py b/test/functional/test_sdp_cache.py
new file mode 100644
index 000000000..16e94d97f
--- /dev/null
+++ b/test/functional/test_sdp_cache.py
@@ -0,0 +1,739 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the keys under which bluetoothd caches the SDP records of a
+BR/EDR device, using VM instances
+
+bluetoothd caches each record of a device under its ServiceRecordHandle.
+A record without that attribute (0x0000) has no handle, so bluetoothd
+chooses a key for it. These tests check that such a record keeps its key
+from one discovery to the next, that no record is cached twice or
+overwritten by another, and that no cached record is removed while the
+device is known.
+
+The records are of service classes no profile of bluetoothd handles, so
+that Device1.Connect discovers the services of a known device again: it
+only does so when it finds no service to connect.
+"""
+
+import configparser
+import glob
+import os
+import struct
+
+import dbus
+import pytest
+
+from pytest_bluezenv import (
+    host_config,
+    Agent,
+    wait_until,
+    mainloop_wrap,
+    get_dbus,
+)
+
+from .test_sdp import (
+    L2CAP_UUID,
+    PNP_INFO_UUID,
+    bluetoothd_state_directory,
+    record_attrs,
+)
+from .test_sdp_out_of_range import (
+    BASE_UUID,
+    CONNECTING,
+    SEARCH1,
+    SEARCH2,
+    ExperimentalBluetoothdRestart,
+    OutOfRangeSdpServer,
+    add_handle,
+    browse,
+    cached_records,
+    check_records,
+    device_properties,
+    find_and_trust,
+    find_device,
+    read_back,
+    record_uuid,
+    service_records,
+)
+
+pytestmark = [pytest.mark.vm]
+
+PUBLIC_BROWSE_GROUP = 0x1002
+
+# A cached value that is no SDP record
+NOT_A_RECORD = "DEADBEEF"
+
+# Records of a response that takes bluetoothd long to handle if it compares
+# every record with every other by content
+MANY_RECORDS = 10000
+
+
+def record(n, handle=None, version=None, svclass=None):
+    """
+    Attribute list of a record of service class svclass, by default
+    0x7000 + n, with the given ServiceRecordHandle, and with attribute
+    0x0200 set to version to tell versions of a record apart.
+    """
+    attrs = (
+        # ServiceClassIDList
+        bytes.fromhex("0900013503")
+        + struct.pack(">BH", 0x19, svclass or 0x7000 + n)
+        # ProtocolDescriptorList: L2CAP
+        + bytes.fromhex("09000435053503190100")
+    )
+
+    if version is not None:
+        attrs += struct.pack(">BHBH", 0x09, 0x0200, 0x09, version)
+
+    return attrs if handle is None else add_handle(attrs, handle)
+
+
+def pnp(handle=None):
+    """Attribute list of a PnP Information record"""
+    attrs = bytes.fromhex(
+        "090001350319120009020009010309020109ffff090202090001090203090001"
+        "0902042801090205090001"
+    )
+
+    return attrs if handle is None else add_handle(attrs, handle)
+
+
+# Records without ServiceRecordHandle
+A, B, C, E = (record(n) for n in (1, 2, 3, 5))
+D = pnp()
+
+
+def answers(l2cap, pnp_records=(D,)):
+    """Records host1 returns for the L2CAP and the PnP Information search"""
+    return {L2CAP_UUID: list(l2cap), PNP_INFO_UUID: list(pnp_records)}
+
+
+def all_records(records):
+    return [r for rs in records.values() for r in rs]
+
+
+def uuid_of(attr_list):
+    return record_uuid(record_attrs(attr_list))
+
+
+def cache_value(attr_list):
+    """
+    A record as bluetoothd writes it to the cache file: in a sequence with
+    an 8 bit size if the whole fits in 255 bytes, else a 16 bit one.
+    """
+    if len(attr_list) + 2 <= 0xFF:
+        header = struct.pack(">BB", 0x35, len(attr_list))
+    else:
+        header = struct.pack(">BH", 0x36, len(attr_list))
+
+    return (header + attr_list).hex().upper()
+
+
+def seed_cache(address, entries):
+    """
+    Add entries to [ServiceRecords] of the cache file of a device, as an
+    earlier bluetoothd may have left them. Returns the cached records.
+    """
+    state_dir = bluetoothd_state_directory()
+    (adapter_dir,) = glob.glob(os.path.join(state_dir, "??:??:??:??:??:??"))
+    path = os.path.join(adapter_dir, "cache", address.upper())
+    os.makedirs(os.path.dirname(path), exist_ok=True)
+
+    cache = configparser.ConfigParser(interpolation=None)
+    cache.optionxform = str
+    cache.read(path)
+
+    if not cache.has_section("ServiceRecords"):
+        cache.add_section("ServiceRecords")
+
+    for key, value in entries.items():
+        cache["ServiceRecords"][key] = value
+
+    with open(path, "w") as f:
+        cache.write(f, space_around_delimiters=False)
+
+    return cached_records(address)
+
+
+def check_cache(hosts, expected, others=None):
+    """
+    Check that host0 caches exactly the expected records of host1, each
+    once, under a key of the documented format, those with a
+    ServiceRecordHandle under it, and besides them exactly the entries of
+    others, by key. Returns the key of each record, by record_attrs().
+    """
+    host0, host1 = hosts
+    others = others or {}
+    cached = host0.call(cached_records, host1.bdaddr)
+
+    assert {key: value for key, value in cached if key in others} == others
+
+    return check_records([e for e in cached if e[0] not in others], expected)
+
+
+def check_kept(before, after, records):
+    """Check that the given records kept their key"""
+    for attrs in map(record_attrs, records):
+        assert after[attrs] == before[attrs]
+
+
+def discover(hosts, records, down_at=None):
+    """
+    Let bluetoothd on host0 discover the services of host1, which returns
+    the given records and goes down at the given point, if any.
+    """
+    host0, host1 = hosts
+    host1.sdp_peer.configure(records, down_at)
+
+    # Its UUID is only added when a discovery of a new device is complete,
+    # and for a known device Connect only fails once the discovery is done
+    done_uuid = uuid_of(all_records(records)[0])
+
+    return browse(hosts, down_at, done_uuid)
+
+
+def rediscover(hosts, first, second, down_at=None):
+    """
+    Let bluetoothd on host0 discover the services of host1 twice: host1
+    returns the records first, and then the records second, and goes down
+    at the given point of the second discovery, if any. Returns the key
+    of each record cached after the first discovery.
+    """
+    find_and_trust(hosts)
+
+    discover(hosts, first)
+    before = check_cache(hosts, all_records(first))
+
+    discover(hosts, second, down_at)
+    return before
+
+
+@mainloop_wrap
+def remove_device(address):
+    path, _ = find_device(address)
+    adapter = dbus.Interface(
+        get_dbus().get_object("org.bluez", path.rsplit("/", 1)[0]),
+        "org.bluez.Adapter1",
+    )
+    adapter.RemoveDevice(path)
+
+
+def remove_and_find_again(hosts):
+    """Remove host1 from bluetoothd on host0, and let it find host1 again"""
+    host0, host1 = hosts
+
+    host0.call(remove_device, host1.bdaddr)
+    wait_until(lambda: host0.call(device_properties, host1.bdaddr) is None)
+
+    find_and_trust(hosts)
+
+
+def learn_keys(hosts, records):
+    """
+    Let bluetoothd on host0 discover the given records of host1, and then
+    remove host1 so that it is a new device again. Returns the key each
+    record got, so that tests do not depend on how bluetoothd chooses the
+    keys of records without handle.
+    """
+    find_and_trust(hosts)
+    discover(hosts, records)
+    keys = check_cache(hosts, all_records(records))
+
+    remove_and_find_again(hosts)
+    return keys
+
+
+def cached_count(address):
+    return len(cached_records(address))
+
+
+def key_handle(keys, attr_list):
+    """The cache key of a record, as a handle value"""
+    return int(keys[record_attrs(attr_list)], 16)
+
+
+def in_memory(hosts):
+    """
+    Records bluetoothd on host0 has in memory for host1, as sorted
+    record_attrs(). host1 connects to host0 for that, which does not make
+    host0 discover its services again.
+    """
+    host0, host1 = hosts
+    steps = host1.sdp_peer.get_steps()
+
+    host1.sdp_peer.connect(host0.bdaddr)
+    wait_until(lambda: host0.call(device_properties, host1.bdaddr)["Connected"])
+
+    records = host0.call(service_records, host1.bdaddr)
+    assert host1.sdp_peer.get_steps() == steps
+
+    return sorted(map(record_attrs, records))
+
+
+config = host_config([Agent()], [OutOfRangeSdpServer()])
+
+# With Device1.GetServiceRecords
+experimental_config = host_config(
+    [ExperimentalBluetoothdRestart(), Agent()], [OutOfRangeSdpServer()]
+)
+
+
+#
+# Records without ServiceRecordHandle
+#
+
+
+@config
+def test_sdp_cache_same_record_twice(hosts):
+    """The same record twice in one response is cached once"""
+    find_and_trust(hosts)
+
+    discover(hosts, answers([A, A, C]))
+
+    check_cache(hosts, [A, C, D])
+
+
+@experimental_config
+def test_sdp_cache_in_memory_after_discovery(hosts):
+    """
+    Right after a discovery, bluetoothd has each record of it in memory
+    once.
+    """
+    find_and_trust(hosts)
+
+    discover(hosts, answers([A, B, C]))
+
+    assert in_memory(hosts) == sorted(map(record_attrs, [A, B, C, D]))
+
+
+@experimental_config
+def test_sdp_cache_in_memory_after_rediscovery(hosts):
+    """
+    Right after a discovery of a known device, bluetoothd has in memory
+    each record of that discovery once, while the cache also keeps the
+    record host1 stopped returning.
+    """
+    rediscover(hosts, answers([A, B, C]), answers([A, C]))
+
+    assert in_memory(hosts) == sorted(map(record_attrs, [A, C, D]))
+    check_cache(hosts, [A, B, C, D])
+
+
+@config
+def test_sdp_cache_same_records(hosts):
+    """The same records discovered again keep their key"""
+    before = rediscover(hosts, answers([A, B, C]), answers([A, B, C]))
+
+    after = check_cache(hosts, [A, B, C, D])
+    assert after == before
+
+
+@config
+def test_sdp_cache_records_in_other_order(hosts):
+    """Records returned in another order keep their key"""
+    before = rediscover(hosts, answers([A, B, C]), answers([C, A, B]))
+
+    after = check_cache(hosts, [A, B, C, D])
+    assert after == before
+
+
+@config
+def test_sdp_cache_record_in_both_searches_again(hosts):
+    """
+    A record returned by both searches of a discovery of a known device is
+    cached once, and keeps its key.
+    """
+    _, host1 = hosts
+    before = rediscover(hosts, answers([A, B, C]), answers([A, B, C, D]))
+
+    # host1 sent D in its response to both searches
+    assert host1.sdp_peer.get_answered() == [[A, B, C, D], [D]]
+
+    after = check_cache(hosts, [A, B, C, D])
+    assert after == before
+
+
+@config
+def test_sdp_cache_fewer_records(hosts):
+    """
+    A record host1 stops returning stays cached, as bluetoothd keeps the
+    records with a handle it no longer finds. The others keep their key.
+    """
+    before = rediscover(hosts, answers([A, B, C]), answers([A, C]))
+
+    after = check_cache(hosts, [A, B, C, D])
+    assert after == before
+
+
+@experimental_config
+def test_sdp_cache_changed_record_read_back(hosts):
+    """
+    After a restart, bluetoothd reads both versions of a changed record
+    back, the old one first: it was cached first, and a lookup by UUID
+    finds the first record of that UUID.
+    """
+    C2 = record(3, version=2)
+    rediscover(hosts, answers([A, B, C]), answers([A, B, C2]))
+
+    records = read_back(hosts, ordered=True)
+    assert sorted(records) == sorted(map(record_attrs, [A, B, C, C2, D]))
+    assert records.index(record_attrs(C)) < records.index(record_attrs(C2))
+
+
+@config
+def test_sdp_cache_changed_record_every_discovery(hosts):
+    """
+    A record that host1 returns changed at every discovery adds a cached
+    record each time, as none is removed, and every record cached before
+    keeps its key.
+    """
+    versions = [C] + [record(3, version=v) for v in (2, 3, 4)]
+
+    find_and_trust(hosts)
+    discover(hosts, answers([A, B, C]))
+    cached = [A, B, C, D]
+    before = check_cache(hosts, cached)
+
+    for version in versions[1:]:
+        discover(hosts, answers([A, B, version]))
+        after = check_cache(hosts, cached + [version])
+        check_kept(before, after, cached)
+
+        cached.append(version)
+        before = after
+
+
+@config
+@pytest.mark.parametrize("first", [False, True], ids=["added-last", "added-first"])
+def test_sdp_cache_added_record(hosts, first):
+    """A record host1 returns in addition does not take the key of another"""
+    l2cap = [E, A, B, C] if first else [A, B, C, E]
+    before = rediscover(hosts, answers([A, B, C]), answers(l2cap))
+
+    after = check_cache(hosts, [A, B, C, D, E])
+    check_kept(before, after, [A, B, C, D])
+
+
+@config
+@pytest.mark.parametrize("first", [False, True], ids=["added-last", "added-first"])
+def test_sdp_cache_added_record_down_before_second_response(hosts, first):
+    """
+    host1 returns one more record in its first search, and goes out of
+    range before the response to the second: the record of the second
+    search that bluetoothd did not get again stays cached.
+    """
+    l2cap = [E, A, B, C] if first else [A, B, C, E]
+    before = rediscover(hosts, answers([A, B, C]), answers(l2cap), SEARCH2)
+
+    after = check_cache(hosts, [A, B, C, D, E])
+    check_kept(before, after, [A, B, C, D])
+
+
+@config
+def test_sdp_cache_written_without_fix(hosts):
+    """
+    bluetoothd without support for records without handle cached one of
+    them only, under 0xFFFFFFFF. That record keeps its key and is not
+    cached twice.
+    """
+    host0, host1 = hosts
+    find_and_trust(hosts)
+
+    seeded = host0.call(seed_cache, host1.bdaddr, {"0xFFFFFFFF": cache_value(B)})
+    assert seeded == [("0xFFFFFFFF", cache_value(B))]
+
+    discover(hosts, answers([A, B, C]))
+
+    keys = check_cache(hosts, [A, B, C, D])
+    assert keys[record_attrs(B)] == "0xFFFFFFFF"
+
+
+@config
+@pytest.mark.parametrize(
+    "key, value",
+    [
+        ("0xFFFFFFFF", NOT_A_RECORD),
+        ("0xFFFFFFFE", NOT_A_RECORD),
+        ("0xFFFFFFFF", ""),
+        ("0xFFFFFFFF", "not hex"),
+    ],
+    ids=["first-key", "second-key", "empty", "not-hex"],
+)
+def test_sdp_cache_value_no_record(hosts, key, value):
+    """
+    A cache entry that is no record is left alone by the records without
+    handle.
+    """
+    host0, host1 = hosts
+    find_and_trust(hosts)
+
+    seeded = host0.call(seed_cache, host1.bdaddr, {key: value})
+    assert seeded == [(key, value)]
+
+    discover(hosts, answers([A, B, C]))
+
+    check_cache(hosts, [A, B, C, D], others={key: value})
+
+
+@experimental_config
+def test_sdp_cache_read_back_after_restart(hosts):
+    """
+    After a restart, bluetoothd reads each cached record back once, also
+    after host1 stopped returning one of them.
+    """
+    rediscover(hosts, answers([A, B, C]), answers([A, C]))
+
+    assert read_back(hosts) == sorted(map(record_attrs, [A, B, C, D]))
+
+
+#
+# Records with and without ServiceRecordHandle from one device
+#
+
+
+@config
+@pytest.mark.parametrize("position", [0, 1, 2], ids=["first", "middle", "last"])
+def test_sdp_cache_handle_equal_to_key_same_search(hosts, position):
+    """
+    A record with a handle equal to the key that bluetoothd gives a record
+    without handle of the same search, C: all are cached, the one with a
+    handle under it. Coming last, it is found after C got that key.
+    """
+    keys = learn_keys(hosts, answers([A, C]))
+
+    R = record(4, handle=key_handle(keys, C))
+    l2cap = [A, C]
+    l2cap.insert(position, R)
+    discover(hosts, answers(l2cap))
+
+    check_cache(hosts, [A, R, C, D])
+
+
+@config
+@pytest.mark.parametrize("target", [0, 1], ids=["key-of-first", "key-of-second"])
+def test_sdp_cache_handle_equal_to_key_later_search(hosts, target):
+    """
+    A record with a handle equal to the key a record without handle got in
+    the first search comes in the second search.
+    """
+    keys = learn_keys(hosts, answers([A, C], ()))
+
+    R = pnp(handle=key_handle(keys, [A, C][target]))
+    discover(hosts, answers([A, C], [R]))
+
+    check_cache(hosts, [A, C, R])
+
+
+@config
+@pytest.mark.parametrize(
+    "target, l2cap, down_at",
+    [
+        ("C", "ABCR", None),
+        ("C", "ABCR", SEARCH2),
+        ("D", "ABCR", SEARCH2),
+        ("D", "RABC", SEARCH2),
+        ("B", "ACR", None),
+    ],
+    ids=[
+        "key-of-c-complete",
+        "key-of-c-down",
+        "key-of-d-down",
+        "key-of-d-first-down",
+        "key-of-dropped-b",
+    ],
+)
+def test_sdp_cache_handle_equal_to_key_later_discovery(hosts, target, l2cap, down_at):
+    """
+    host1 returns a new record R with a handle equal to the key of a cached
+    record without handle, which must be moved, not overwritten: C, which
+    bluetoothd got again before R; D, which bluetoothd does not get again
+    as host1 goes out of range before the response to the second search;
+    or B, which host1 no longer returns.
+    """
+    find_and_trust(hosts)
+
+    discover(hosts, answers([A, B, C]))
+    before = check_cache(hosts, [A, B, C, D])
+
+    moved = {"B": B, "C": C, "D": D}[target]
+    R = record(4, handle=key_handle(before, moved))
+    records = {"A": A, "B": B, "C": C, "R": R}
+    discover(hosts, answers([records[r] for r in l2cap]), down_at)
+
+    after = check_cache(hosts, [A, B, C, D, R])
+    check_kept(before, after, [r for r in (A, B, C, D) if r != moved])
+
+
+@config
+@pytest.mark.parametrize("down_at", [None, SEARCH2], ids=["dropped", "down"])
+def test_sdp_cache_key_equal_to_cached_handle(hosts, down_at):
+    """
+    A new record without handle does not take the key of a cached record
+    with that handle, P: also when host1 no longer returns P, or goes out
+    of range before the response to the search that returns it.
+    """
+    keys = learn_keys(hosts, answers([A, E], ()))
+
+    P = pnp(handle=key_handle(keys, E))
+    discover(hosts, answers([A], [P]))
+    before = check_cache(hosts, [A, P])
+
+    discover(hosts, answers([A, E], () if down_at is None else [P]), down_at)
+
+    after = check_cache(hosts, [A, E, P])
+    check_kept(before, after, [A, P])
+
+
+@config
+def test_sdp_cache_handle_0xffffffff(hosts):
+    """
+    A record with handle 0xFFFFFFFF, the value bluetoothd gives a record
+    without handle, is cached under it like any record with a handle.
+    """
+    R = record(4, handle=0xFFFFFFFF)
+    find_and_trust(hosts)
+
+    discover(hosts, answers([B, R, C]))
+
+    keys = check_cache(hosts, [B, R, C, D])
+    assert keys[record_attrs(R)] == "0xFFFFFFFF"
+
+
+@config
+def test_sdp_cache_same_handle_twice(hosts):
+    """
+    Of two different records with the handle 0xFFFFFFFF, the second is
+    dropped as a duplicate of the first, as for any handle.
+    """
+    handle = 0xFFFFFFFF
+    host0, host1 = hosts
+    R1 = record(4, handle=handle)
+    R2 = record(6, handle=handle)
+    find_and_trust(hosts)
+
+    discover(hosts, answers([R1, R2]))
+
+    check_cache(hosts, [R1, D])
+    uuids = host0.call(device_properties, host1.bdaddr)["UUIDs"]
+    assert uuid_of(R1) in uuids
+    assert uuid_of(R2) not in uuids
+
+
+@config
+def test_sdp_cache_same_handle_changed(hosts):
+    """
+    A record with the handle 0xFFFFFFFF that host1 changes is overwritten
+    under it, as for any handle.
+    """
+    handle = 0xFFFFFFFF
+    R1 = record(4, handle=handle)
+    R2 = record(4, handle=handle, version=2)
+
+    rediscover(hosts, answers([A, R1]), answers([A, R2]))
+
+    check_cache(hosts, [A, R2, D])
+
+
+@config
+@pytest.mark.parametrize("to_handles", [True, False], ids=["gains", "loses"])
+def test_sdp_cache_handles_gained_or_lost(hosts, to_handles):
+    """
+    host1 returns the same records with a handle each after it returned
+    them without, or the other way round. The records of the first
+    discovery stay cached under their keys, as records host1 stops
+    returning, next to those of the second.
+    """
+    without = answers([A, C])
+    with_handles = answers(
+        [record(1, handle=0x00010001), record(3, handle=0x00010003)],
+        [pnp(handle=0x00010004)],
+    )
+    first, second = (without, with_handles) if to_handles else (with_handles, without)
+
+    before = rediscover(hosts, first, second)
+
+    after = check_cache(hosts, all_records(first) + all_records(second))
+    check_kept(before, after, all_records(first))
+
+
+#
+# Many records
+#
+
+
+@config
+def test_sdp_cache_many_records(hosts):
+    """
+    bluetoothd does not take longer to handle a response of many records
+    without handle than one of as many records with a handle each: it is
+    busy for that time, and the device chooses the number of its records.
+    """
+    host0, host1 = hosts
+    times = {}
+
+    find_and_trust(hosts)
+
+    for with_handle in (True, False):
+        l2cap = [
+            record(1, handle=0x00010000 + v if with_handle else None, version=v)
+            for v in range(MANY_RECORDS)
+        ]
+        discover(hosts, answers(l2cap))
+
+        # All of them are different records
+        assert host0.call(cached_count, host1.bdaddr) == MANY_RECORDS + 1
+
+        # From the response to the L2CAP search to the PnP Information search
+        times[with_handle] = host1.sdp_peer.get_handling_times()[0]
+
+        if with_handle:
+            remove_and_find_again(hosts)
+
+    assert times[False] <= 2 * times[True], times
+
+
+#
+# The Public Browse Group search
+#
+
+
+def discover_public_browse_group(hosts, records):
+    """
+    Let bluetoothd on host0 discover the services of host1, which returns
+    the given records. bluetoothd only searches for the Public Browse Group
+    when the L2CAP search returns no record, and only keeps records of the
+    service class 0x1002 from it, as for the PnP Information search.
+    """
+    host0, host1 = hosts
+    host1.sdp_peer.configure(records)
+
+    host0.agent.device_method(host1.bdaddr, "Connect")
+
+    done_uuid = BASE_UUID % PUBLIC_BROWSE_GROUP
+    wait_until(
+        lambda: done_uuid in host0.call(device_properties, host1.bdaddr)["UUIDs"]
+    )
+    host0.agent.expect("org.bluez.Device1.Connect:error")
+
+    assert host1.sdp_peer.get_steps() == [CONNECTING, SEARCH1, SEARCH2, "search3"]
+
+
+@config
+@pytest.mark.parametrize("with_pnp", [False, True], ids=["alone", "after-pnp"])
+def test_sdp_cache_public_browse_group(hosts, with_pnp):
+    """
+    The records without handle of the Public Browse Group search are cached
+    once each, also when the PnP Information search returned a record:
+    bluetoothd handles the records of its last search twice.
+    """
+    X = record(6, svclass=PUBLIC_BROWSE_GROUP)
+    Y = record(7, svclass=PUBLIC_BROWSE_GROUP, version=2)
+    records = {PUBLIC_BROWSE_GROUP: [X, Y]}
+    if with_pnp:
+        records[PNP_INFO_UUID] = [D]
+
+    find_and_trust(hosts)
+    discover_public_browse_group(hosts, records)
+
+    check_cache(hosts, [X, Y] + ([D] if with_pnp else []))
diff --git a/test/functional/test_sdp_out_of_range.py b/test/functional/test_sdp_out_of_range.py
new file mode 100644
index 000000000..9c6508d91
--- /dev/null
+++ b/test/functional/test_sdp_out_of_range.py
@@ -0,0 +1,723 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for what bluetoothd keeps of a BR/EDR device that goes out of range
+while its services are being discovered over SDP, using VM instances
+
+bluetoothd on host0 browses host1 with a Service Search Attribute request
+for the L2CAP UUID and then one for the PnP Information UUID, both on the
+same L2CAP channel. It gets the records of a search when the response is
+complete, caches them right away, and adds the UUIDs of all of them to
+the device once the last search is done. host1 can go down at one of:
+
+  ``connecting``          while the SDP channel is being set up, before any
+                          request. This is the only point at which
+                          bluetoothd gets the error of the link itself,
+                          and so the only one where it matters whether
+                          host1 got out of range or was powered off: it
+                          tries again in the latter case.
+  ``search1``             after the first request, before any response.
+  ``search1-continued``   after the first part of the first response, when
+                          the rest of it is requested.
+  ``search2``             after the first response, when the second
+                          request is received.
+  ``search2-continued``   after the first part of the second response.
+  ``done``                after the last response, for reference.
+
+"""
+
+import configparser
+import glob
+import os
+import socket
+import struct
+import subprocess
+import threading
+import time
+
+import dbus
+import pytest
+
+from pytest_bluezenv import (
+    host_config,
+    Agent,
+    Bluetoothd,
+    HostPlugin,
+    find_exe,
+    run,
+    wait_until,
+    mainloop_wrap,
+    get_dbus,
+)
+
+from .test_sdp import (
+    SDP_PSM,
+    SDP_SVC_SEARCH_ATTR_REQ,
+    SDP_SVC_SEARCH_ATTR_RSP,
+    SDP_DE_SEQ,
+    SDP_DE_UUID,
+    L2CAP_UUID,
+    PNP_INFO_UUID,
+    SWITCH2_RECORDS,
+    KEY,
+    bluetoothd_state_directory,
+    de_span,
+    record_attrs,
+    split_records,
+)
+
+pytestmark = [pytest.mark.vm]
+
+SOL_L2CAP = 6
+L2CAP_CONNINFO = 0x02
+SOL_BLUETOOTH = 274
+BT_DEFER_SETUP = 7
+
+HCI_COMMAND_PKT = 0x01
+HCI_OP_DISCONNECT = 0x0406
+HCI_ERROR_CONNECTION_TIMEOUT = 0x08
+
+SDP_ATTR_RECORD_HANDLE = 0x0000
+
+# Attribute list bytes host1 sends per response, so that a response fits
+# in the default L2CAP MTU of 672
+MAX_RSP_SIZE = 600
+SDP_ATTR_SVCLASS_ID_LIST = 0x0001
+
+BASE_UUID = "0000%04x-0000-1000-8000-00805f9b34fb"
+
+CONNECTING = "connecting"
+SEARCH1 = "search1"
+SEARCH1_CONTINUED = "search1-continued"
+SEARCH2 = "search2"
+SEARCH2_CONTINUED = "search2-continued"
+DONE = "done"
+
+ERR_CREATE_SOCKET = "br-connection-create-socket"
+
+
+def record_uuid(attrs):
+    """
+    First service class UUID of the record_attrs() of a record, which is
+    the one bluetoothd adds to the UUIDs of a device.
+    """
+    dtype, items = dict(attrs)[SDP_ATTR_SVCLASS_ID_LIST]
+    assert dtype == SDP_DE_SEQ and items[0][0] == SDP_DE_UUID
+    return BASE_UUID % int.from_bytes(items[0][1], "big")
+
+
+def join_records(records):
+    attr_lists = b"".join(struct.pack(">BH", 0x36, len(r)) + r for r in records)
+
+    if len(attr_lists) > 0xFFFF:
+        return struct.pack(">BI", 0x37, len(attr_lists)) + attr_lists
+
+    return struct.pack(">BH", 0x36, len(attr_lists)) + attr_lists
+
+
+def add_handle(record, handle):
+    return struct.pack(">BHBI", 0x09, SDP_ATTR_RECORD_HANDLE, 0x0A, handle) + record
+
+
+def switch2_records():
+    """
+    Records host1 returns for each search of bluetoothd, as attribute
+    lists: those of a Nintendo Switch 2, which have no ServiceRecordHandle.
+    """
+    return {
+        uuid: split_records(SWITCH2_RECORDS[uuid])
+        for uuid in (L2CAP_UUID, PNP_INFO_UUID)
+    }
+
+
+def search_request(params):
+    """UUID16 values searched for by a request, and its continuation state"""
+    _, start, end = de_span(params, 0)
+    uuids = {
+        struct.unpack(">H", params[i + 1 : i + 3])[0]
+        for i in range(start, end - 2, 3)
+        if params[i] == 0x19
+    }
+
+    # MaximumAttributeByteCount, AttributeIDList
+    _, _, end = de_span(params, end + 2)
+
+    return uuids, params[end + 1 : end + 1 + params[end]]
+
+
+def search_attr_rsp(tid, attr_lists, cstate=b""):
+    params = (
+        struct.pack(">H", len(attr_lists)) + attr_lists + bytes([len(cstate)]) + cstate
+    )
+    return struct.pack(">BHH", SDP_SVC_SEARCH_ATTR_RSP, tid, len(params)) + params
+
+
+class OutOfRangeSdpServer(HostPlugin):
+    """
+    SDP server without bluetoothd, whose host can go out of range at a
+    given point of the service discovery of its peer.
+
+    Out of range means that the peer stops hearing from this host, so
+    that its controller reports the link as lost with Connection Timeout
+    once the link supervision timeout expires, and that it can not be
+    paged any more. btvirt has no link supervision timeout, so the
+    Disconnection Complete event of the peer is produced right away
+    instead, by disconnecting with that reason from here: btvirt passes
+    the reason of a HCI Disconnect command on to the peer as it is.
+
+    With power_off=True the host is powered off instead. The peer then
+    sees Remote Device Terminated Connection due to Power Off, for which
+    L2CAP reports ECONNRESET rather than ETIMEDOUT.
+    """
+
+    name = "sdp_peer"
+
+    def presetup(self, config):
+        try:
+            self.btmgmt = find_exe("tools", "btmgmt")
+        except FileNotFoundError as exc:
+            pytest.skip(reason=f"btmgmt: {exc!r}")
+
+    def setup(self, impl):
+        self.records = {}
+        self.down_at = None
+        self.power_off = False
+        self.is_down = threading.Event()
+        self.conn = None
+        self.out = None
+        self.steps = []
+        self.answered = []
+        self.answered_at = None
+        self.handling_times = []
+        self.lock = threading.Lock()
+
+        # Without the UUIDs an earlier bluetoothd may have left in the
+        # extended inquiry response of this host, which the peer shows
+        # for a device until its services are discovered
+        for cmd in (
+            ("clr-uuids",),
+            ("connectable", "on"),
+            ("power", "on"),
+            ("discov", "yes"),
+        ):
+            self.mgmt(*cmd)
+
+        self.sock = socket.socket(
+            socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET, socket.BTPROTO_L2CAP
+        )
+        self.sock.bind((socket.BDADDR_ANY, SDP_PSM))
+        self.sock.listen(1)
+        threading.Thread(target=self.serve, daemon=True).start()
+
+    def mgmt(self, *cmd):
+        run(
+            [self.btmgmt, "--index", "0", *cmd],
+            check=True,
+            stdin=subprocess.DEVNULL,
+        )
+
+    def configure(self, records, down_at=None, power_off=False):
+        """
+        Set the records to return for each search, and the point of the
+        next service discovery to go down at. With DONE this is left to
+        go_down(). Starts get_steps(), get_answered() and
+        get_handling_times() over.
+        """
+        self.records = records
+        self.down_at = down_at
+        self.power_off = power_off
+
+        with self.lock:
+            self.steps = []
+            self.answered = []
+            self.answered_at = None
+            self.handling_times = []
+
+        # Leave the L2CAP Connection Request of the peer pending
+        self.sock.setsockopt(SOL_BLUETOOTH, BT_DEFER_SETUP, down_at == CONNECTING)
+
+    def step(self, name):
+        with self.lock:
+            self.steps.append(name)
+
+    def get_steps(self):
+        """Points reached so far, and "down" once gone down"""
+        with self.lock:
+            return list(self.steps)
+
+    def sent(self, records):
+        with self.lock:
+            self.answered.append(list(records))
+            self.answered_at = time.monotonic()
+
+    def searched(self):
+        """Note how long the peer took from the last response to a request"""
+        with self.lock:
+            if self.answered_at is not None:
+                self.handling_times.append(time.monotonic() - self.answered_at)
+                self.answered_at = None
+
+    def get_handling_times(self):
+        """
+        Seconds the peer took from each response sent in full to its next
+        search, which is the time it took to handle the records of it
+        """
+        with self.lock:
+            return list(self.handling_times)
+
+    def get_answered(self):
+        """Records of each response sent in full, as attribute lists"""
+        with self.lock:
+            return list(self.answered)
+
+    def get_down(self):
+        return self.is_down.is_set()
+
+    def go_down(self):
+        """Go out of range, or power off"""
+        with self.lock:
+            conn = self.conn
+
+        if self.power_off:
+            self.mgmt("power", "off")
+        else:
+            # Stop page scan first, so that there is no moment in which
+            # the link is lost but the peer could connect again
+            self.mgmt("connectable", "off")
+
+            try:
+                handle = struct.unpack(
+                    "<H3s", conn.getsockopt(SOL_L2CAP, L2CAP_CONNINFO, 5)
+                )[0]
+            except (AttributeError, OSError):
+                # No link left to lose
+                handle = None
+
+            if handle is not None:
+                with socket.socket(
+                    socket.AF_BLUETOOTH, socket.SOCK_RAW, socket.BTPROTO_HCI
+                ) as hci:
+                    hci.bind((0,))
+                    hci.send(
+                        struct.pack(
+                            "<BHBHB",
+                            HCI_COMMAND_PKT,
+                            HCI_OP_DISCONNECT,
+                            3,
+                            handle,
+                            HCI_ERROR_CONNECTION_TIMEOUT,
+                        )
+                    )
+
+            self.mgmt("power", "off")
+
+        self.step("down")
+        self.is_down.set()
+
+    def at(self, point):
+        """Note that a point was reached, go down if it is the one set"""
+        self.step(point)
+
+        if self.down_at != point:
+            return False
+
+        self.go_down()
+        return True
+
+    def serve(self):
+        while True:
+            try:
+                conn, _ = self.sock.accept()
+            except OSError:
+                return
+
+            with self.lock:
+                self.conn = conn
+
+            try:
+                self.answer(conn)
+            except Exception as exc:
+                self.step(f"error: {exc!r}")
+
+            # The connection is left open; closing it would tell the peer
+
+    def answer(self, conn):
+        search = 0
+        rest = b""
+        pending = []
+
+        if self.at(CONNECTING):
+            return
+
+        while True:
+            try:
+                pdu = conn.recv(1024)
+            except OSError:
+                return
+
+            if not pdu:
+                return
+
+            if len(pdu) < 6 or pdu[0] != SDP_SVC_SEARCH_ATTR_REQ:
+                continue
+
+            tid = struct.unpack(">H", pdu[1:3])[0]
+            uuids, cstate = search_request(pdu[5:])
+
+            if cstate:
+                point = f"search{search}-continued"
+                if self.down_at == point and self.at(point):
+                    return
+
+                part, rest = rest[:MAX_RSP_SIZE], rest[MAX_RSP_SIZE:]
+                conn.send(search_attr_rsp(tid, part, b"\x01" if rest else b""))
+                if not rest:
+                    self.sent(pending)
+                continue
+
+            self.searched()
+
+            search += 1
+            if self.at(f"search{search}"):
+                return
+
+            records = []
+            attr_lists = b"\x35\x00"
+            for uuid in uuids:
+                if uuid in self.records:
+                    records = self.records[uuid]
+                    attr_lists = join_records(records)
+
+            if self.down_at == f"search{search}-continued":
+                # Return the first half only, and ask to be asked for more
+                half = len(attr_lists) // 2
+                rest = attr_lists[half:]
+                pending = records
+                conn.send(search_attr_rsp(tid, attr_lists[:half], b"\x01"))
+            else:
+                # In parts, if it does not fit in one response
+                part, rest = attr_lists[:MAX_RSP_SIZE], attr_lists[MAX_RSP_SIZE:]
+                pending = records
+                conn.send(search_attr_rsp(tid, part, b"\x01" if rest else b""))
+                if not rest:
+                    self.sent(records)
+
+    def come_back(self):
+        """
+        Come back in range, or power on again, without going down at any
+        point of a service discovery. Starts get_steps() over.
+        """
+        self.configure(self.records)
+        self.mgmt("power", "on")
+        self.mgmt("connectable", "on")
+
+    def connect(self, address):
+        """Bring up an ACL link by connecting to the SDP server of a peer"""
+        self.out = socket.socket(
+            socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET, socket.BTPROTO_L2CAP
+        )
+        self.out.connect((address, SDP_PSM))
+
+    def teardown(self):
+        self.sock.close()
+
+        if self.out is not None:
+            self.out.close()
+
+        with self.lock:
+            if self.conn is not None:
+                self.conn.close()
+
+
+class BluetoothdRestart(HostPlugin):
+    """
+    Restarts the bluetoothd of the Bluetoothd host plugin, which keeps
+    its state directory.
+    """
+
+    name = "bluetoothd_restart"
+    depends = [Bluetoothd()]
+
+    def setup(self, impl):
+        self.impl = impl
+
+    @mainloop_wrap
+    def restart(self):
+        bluetoothd = self.impl.plugins["bluetoothd"]
+        agent = self.impl.plugins.get("agent")
+        bus = get_dbus()
+
+        old = bluetoothd.job
+        old.terminate()
+        old.wait()
+
+        bus_daemon = dbus.Interface(
+            bus.get_object("org.freedesktop.DBus", "/org/freedesktop/DBus"),
+            "org.freedesktop.DBus",
+        )
+        wait_until(lambda: not bus_daemon.NameHasOwner("org.bluez"))
+
+        state_dir = os.path.join(bluetoothd.tmpdir.name, "state")
+        bluetoothd.job = subprocess.Popen(
+            old.args,
+            env=dict(os.environ, STATE_DIRECTORY=state_dir),
+            stdin=subprocess.DEVNULL,
+            stdout=bluetoothd.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        def powered():
+            try:
+                adapter = dbus.Interface(
+                    bus.get_object("org.bluez", "/org/bluez/hci0"),
+                    "org.freedesktop.DBus.Properties",
+                )
+                return bool(adapter.Get("org.bluez.Adapter1", "Powered"))
+            except dbus.DBusException:
+                return False
+
+        wait_until(powered)
+
+        if agent is not None:
+            # Expected to be registered when the Agent plugin is unloaded
+            agent.manager = dbus.Interface(
+                agent.bus.get_object("org.bluez", "/org/bluez"),
+                "org.bluez.AgentManager1",
+            )
+            agent.manager.RegisterAgent(agent.path, agent.capability)
+
+
+class ExperimentalBluetoothdRestart(BluetoothdRestart):
+    """
+    BluetoothdRestart for a bluetoothd with experimental interfaces, for
+    Device1.GetServiceRecords. Has to come before Agent, so that Agent
+    does not add a Bluetoothd of its own.
+    """
+
+    depends = [Bluetoothd(conf="[General]\nExperimental = true\n")]
+
+
+def find_device(address):
+    """Path and properties of the device object of bluetoothd, if any"""
+    bus = get_dbus()
+    manager = dbus.Interface(
+        bus.get_object("org.bluez", "/"), "org.freedesktop.DBus.ObjectManager"
+    )
+
+    for path, ifaces in manager.GetManagedObjects().items():
+        device = ifaces.get("org.bluez.Device1")
+        if device is not None and device["Address"].lower() == address.lower():
+            return path, device
+
+    return None, None
+
+
+@mainloop_wrap
+def device_properties(address):
+    """Properties of the device object of bluetoothd, None without one"""
+    _, device = find_device(address)
+    if device is None:
+        return None
+
+    return {
+        "UUIDs": sorted(str(uuid) for uuid in device.get("UUIDs", [])),
+        "Connected": bool(device["Connected"]),
+    }
+
+
+@mainloop_wrap
+def service_records(address):
+    """Records bluetoothd returns from Device1.GetServiceRecords"""
+    path, _ = find_device(address)
+    device = dbus.Interface(
+        get_dbus().get_object("org.bluez", path), "org.bluez.Device1"
+    )
+
+    return [bytes(r) for r in device.GetServiceRecords()]
+
+
+def read_back(hosts, ordered=False):
+    """
+    Restart bluetoothd on host0 and return the records it then reads back
+    from its cache for host1, as sorted record_attrs(), or with ordered in
+    the order bluetoothd has them, which is the order of the cache file.
+    host1 comes back and connects to host0 for that, which does not make
+    host0 discover its services again.
+    """
+    host0, host1 = hosts
+
+    host0.bluetoothd_restart.restart()
+    wait_until(lambda: host0.call(device_properties, host1.bdaddr) is not None)
+
+    host1.sdp_peer.come_back()
+    host1.sdp_peer.connect(host0.bdaddr)
+    wait_until(lambda: host0.call(device_properties, host1.bdaddr)["Connected"])
+
+    records = host0.call(service_records, host1.bdaddr)
+    assert host1.sdp_peer.get_steps() == []
+
+    records = list(map(record_attrs, records))
+    return records if ordered else sorted(records)
+
+
+@mainloop_wrap
+def trust_device(address):
+    path, _ = find_device(address)
+    props = dbus.Interface(
+        get_dbus().get_object("org.bluez", path), "org.freedesktop.DBus.Properties"
+    )
+    props.Set("org.bluez.Device1", "Trusted", dbus.Boolean(True))
+
+
+def cached_records(address):
+    """
+    Service records in the cache file bluetoothd keeps for a device, as
+    list of (key, record). Empty if there is no cache file.
+    """
+    state_dir = bluetoothd_state_directory()
+    paths = glob.glob(os.path.join(state_dir, "*", "cache", address.upper()))
+    assert len(paths) <= 1, paths
+
+    cache = configparser.ConfigParser(interpolation=None)
+    cache.optionxform = str
+    cache.read(paths)
+
+    if not cache.has_section("ServiceRecords"):
+        return []
+
+    return list(cache["ServiceRecords"].items())
+
+
+def find_and_trust(hosts):
+    """Let bluetoothd on host0 find host1, and keep it"""
+    host0, host1 = hosts
+
+    host0.agent.adapter_method("StartDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+
+    wait_until(host0.agent.has_device, host1.bdaddr)
+
+    host0.agent.adapter_method("StopDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StopDiscovery:reply")
+
+    # bluetoothd only keeps a device that is paired or trusted once its
+    # link is lost: any other is made temporary again, and is removed
+    # together with its cached records when its timer expires or when it
+    # can not be paged.
+    host0.call(trust_device, host1.bdaddr)
+
+    before = host0.call(device_properties, host1.bdaddr)
+    assert before["UUIDs"] == []
+    assert host0.call(cached_records, host1.bdaddr) == []
+
+
+def browse(hosts, down_at=None, done_uuid=None):
+    """
+    Let bluetoothd on host0 discover the services of host1. host1 goes
+    down at the given point, with DONE once host0 has the done_uuid that
+    only a complete discovery adds. Returns the error of Connect.
+    """
+    host0, host1 = hosts
+
+    # Connecting browses the SDP records of host1
+    host0.agent.device_method(host1.bdaddr, "Connect")
+
+    if down_at in (None, DONE):
+        # All UUIDs of a browse are added at once, when it is complete
+        wait_until(
+            lambda: done_uuid in host0.call(device_properties, host1.bdaddr)["UUIDs"]
+        )
+
+    if down_at == DONE:
+        host1.sdp_peer.go_down()
+
+    # host1 offers no service to connect, so Connect fails in any case
+    error = host0.agent.expect("org.bluez.Device1.Connect:error").error
+
+    if down_at is None:
+        assert host1.sdp_peer.get_steps() == [CONNECTING, SEARCH1, SEARCH2]
+
+        host0.agent.device_method(host1.bdaddr, "Disconnect")
+        host0.agent.expect(
+            (
+                "org.bluez.Device1.Disconnect:reply",
+                "org.bluez.Device1.Disconnect:error",
+            )
+        )
+    else:
+        wait_until(host1.sdp_peer.get_down)
+
+    wait_until(lambda: not host0.call(device_properties, host1.bdaddr)["Connected"])
+
+    if down_at is None:
+        pass
+    elif down_at == DONE:
+        assert host1.sdp_peer.get_steps() == [CONNECTING, SEARCH1, SEARCH2, "down"]
+    else:
+        # host1 went down where it was supposed to, and was not reached again
+        points = [CONNECTING, SEARCH1, SEARCH1_CONTINUED, SEARCH2, SEARCH2_CONTINUED]
+        expected = [
+            p
+            for p in points[: points.index(down_at) + 1]
+            if not p.endswith("-continued") or p == down_at
+        ]
+        assert host1.sdp_peer.get_steps() == expected + ["down"]
+
+    return error.get_dbus_message()
+
+
+def first_uuid(records):
+    return record_uuid(record_attrs(records[L2CAP_UUID][0]))
+
+
+def check_records(cached, records):
+    """
+    Check that the cache holds exactly the given records, each of them
+    once, under a key of the documented format, and a record with a
+    ServiceRecordHandle under it. Returns the key of each record, by
+    record_attrs().
+    """
+    keys = {}
+    for key, value in cached:
+        assert KEY.fullmatch(key), key
+
+        attrs = record_attrs(bytes.fromhex(value))
+        assert attrs not in keys, f"{keys[attrs]} and {key} hold the same record"
+        keys[attrs] = key
+
+    assert sorted(keys) == sorted(record_attrs(r) for r in records)
+
+    for attrs, key in keys.items():
+        handle = dict(attrs).get(SDP_ATTR_RECORD_HANDLE)
+        if handle is not None:
+            assert key == "0x%08X" % int.from_bytes(handle[1], "big")
+
+    return keys
+
+
+#
+# A device bluetoothd sees for the first time
+#
+
+
+@host_config([Agent()], [OutOfRangeSdpServer()])
+def test_sdp_new_without_handle_down_before_second_response(hosts):
+    """
+    host1 goes down after bluetoothd has the response to its first search
+    but not the one to its second: it caches the records of the first
+    search, but adds no UUID as the discovery did not complete.
+    """
+    host0, host1 = hosts
+    records = switch2_records()
+
+    host1.sdp_peer.configure(records, SEARCH2)
+
+    find_and_trust(hosts)
+    message = browse(hosts, SEARCH2, first_uuid(records))
+
+    props = host0.call(device_properties, host1.bdaddr)
+    assert props is not None
+
+    assert message == ERR_CREATE_SOCKET
+    assert props["UUIDs"] == []
+    check_records(host0.call(cached_records, host1.bdaddr), records[L2CAP_UUID])
-- 
2.53.0


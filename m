Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461657C71B
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195489; cv=none; b=HPe7Jsy5HCtY5pkhvi7lNCRzsqXEksjBp+Ygk1lfHqUFYVitQ3c7G+em/7uRVClB+t79klhPweH6zygiPFMXFiL6bAkl5bZoHWZN2JpiX0dCgHAGOwR968/aSsXcgyiIO6VynisbGJEiqwBjnn+QzMbnKApw/YEAIGhrkkFUipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195489; c=relaxed/simple;
	bh=38MrQF7gJjAQwOqc2H4zEs8czLvG3NsFG8Lg8nEVht8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DJs4hLyrIJwyA/mZBsv/uLQswtpCdesTBB3x8PF7GFKnTLCFNozNodnC/urDlWu6IPbHnW3NjEWvaoQ8g/kvRnAF81+dXplWyekg2I40WAE/PECNbp6p27nVXQEdgI+pr9XOnlyTUjVmnT/VEBtV2yIEUinzjTdVaguULgkNVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X044Ttk+; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X044Ttk+"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-795a0ab5227so542297137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790195475; x=1790800275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=92wfspUZEloN50TM82QS4YyKLBJwJECnziWx0WG7ys8=;
        b=X044Ttk+QDOx3tEsQ/FccplhSF559+f0cwC/ZtBqessu/IXYHZT571ivHbfyvXVQgq
         LHuf/3OZHutKjZoikJlCU0J6Z+NCITMR1QrL035GGKJ0Vz3aFs9DF1BX/8sHUnKz06u3
         i7eFTgN1aedEjUp/FgOw/l5rbqvczV7jz8oDM6xvPCAIrcK4XfSXxl03XY1kCHKQtysF
         P3tGpT2vdmpIatr49IGTawO3kZe3duDJlxe++8EuPTbQeTk0R3i8DlDo/vUP2qScCt1J
         CsMn/n3ikNsGli+5OK8rUXWh9T/mq82Bql9/hgD38LJX3UlI1SpdoFFxg5JJuz4VCKLq
         gwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195475; x=1790800275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=92wfspUZEloN50TM82QS4YyKLBJwJECnziWx0WG7ys8=;
        b=ZPIpBIdOWSif1mNDM9G32DITZuUT8tJF4t5O2nipxaT1yeZwL67xhLdmFHeud1Vtzp
         3zA47AIc69Dm0ivJ2mGIkUxJj7OCathOutqir/ky2GJj15Ipo00gNGS50aqOOAjVoGRe
         wg+rf9x5k9AWqYbJ9OW9F8zoQHGDb+G02Jfm3BavNO5A3TtULcxcLdfn7V+7P+UxH+Kp
         CFpt1EUVjv0s3Gpn89/p+Ov30EUtl+kJGm51yOsy/ZGlHBLE+Tiq0/QZDpeHM6ZNAIkR
         lzZaxdpr6OWhQhdqZ4yT+P+Uay7Y1rJkln0gWYF2GGNEDX9ZlUdEjp8ZapZZdHvVs/lf
         VCEw==
X-Gm-Message-State: AFuF++njm4EJHrEDfWDgdkFAHpdeZohBcMByNYFNNbvmCswD9DicI5bg
	pldiASo6tLVeP1eQa5xvLhpaVBSfIb2ZdY3yNM8JnIXiFubTq+bZqqKe/L/BVdhcmMX0aA==
X-Gm-Gg: AYBFou2Y+sZ8uyZWA049d5F0mn6hkRQ51UwPECYZPugezRIQbJ2aQ7tQC/+Jb/tgbgT
	POMA/3IVT0vdaqtw17r4S4Lhnrlr6niKrd/rnoHk82Aehip86Azj8gY2Xz82F11+yhDz68L0+zi
	KAI4t3z5Rw4g0MuplV+Vk7f7PxGefAGqFWPZsGyvFTPDQDIIokjajzoVtXkmYFDg8vWSwp1t7uB
	y4rR6j13zLz4Wz6+HwV22ACb71WsKfPDGBy7E8wICTwUBoPZcUKZHVuSItVr2oFY5pYWHEZDEtk
	lInDisa/zbYqUrISMaqW4dxi8e3pFhQ2oY8cw4NeounDBc59ixHthSEM+41s7JQc6NJqBykfwob
	9SxrzNKrFcHrLlFX+mOIjMks1dK+YwCnpLHEZ25NfERJdsT2Etcz9p5X4E41icvpj9zyMNBYZIl
	imhgEQfnWeRA6VQQbZ7imnBVdDGiikkCg1iNqovxfqnrAsS6gqmt+o64OfD8fo0/izujW9xTDqa
	+EnMu7Edzr1VXQlxsOUMeOL66+WOi3yJo+UFnLMVFOTNlxqsy1Di4bl/CFb+pUxk0ljesS8Af8=
X-Received: by 2002:a05:6102:160c:b0:7a2:4b76:55fe with SMTP id ada2fe7eead31-7af1eaeade3mr296647137.21.1790195475057;
        Wed, 23 Sep 2026 13:31:15 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98527fd0592sm266655241.1.2026.09.23.13.31.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:31:14 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC] doc: Add functional-hfp documentation
Date: Wed, 23 Sep 2026 16:31:05 -0400
Message-ID: <20260923203105.264648-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Document the HFP functional test cases, using the BlueZ HF
implementation driven through bluetoothctl telephony submenu, and a
minimal AG implemented by the test with org.bluez.Profile1:

- profile connection and disconnection
- audio connection (SCO) with CVSD and mSBC

Document what is supported today, i.e. the SLC and calls, and the
changes needed for the audio test cases, i.e. codec negotiation and
audio connection in the HF, which are expected to fail until then.
---
 Makefile.am                |   1 +
 doc/functional-hfp.rst     | 286 +++++++++++++++++++++++++++++++++++++
 doc/functional-testing.rst |   1 +
 3 files changed, 288 insertions(+)
 create mode 100644 doc/functional-hfp.rst

diff --git a/Makefile.am b/Makefile.am
index e5587c55d2dd..0248d439cb55 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -501,6 +501,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/functional-a2dp.rst \
 				doc/functional-avrcp.rst \
 				doc/functional-bap.rst \
+				doc/functional-hfp.rst \
 				doc/functional-hog.rst \
 				doc/functional-mpris-proxy.rst \
 				doc/functional-obex.rst \
diff --git a/doc/functional-hfp.rst b/doc/functional-hfp.rst
new file mode 100644
index 000000000000..ab67b42d0148
--- /dev/null
+++ b/doc/functional-hfp.rst
@@ -0,0 +1,286 @@
+==============
+functional-hfp
+==============
+
+DESCRIPTION
+===========
+
+Hands-Free Profile (HFP) functional tests, `test/functional/test_hfp.py`,
+using the BlueZ HFP Hands-Free (HF) implementation
+(`profiles/audio/hfp-hf.c`) driven through the **telephony** submenu of
+**bluetoothctl(1)**, see **bluetoothctl-telephony(1)**. See
+**functional-testing(7)** for the conventions used here, and
+**test-functional(1)** for how to run the suite.
+
+STATUS
+======
+
+Supported today
+---------------
+
+HF role (host0)
+	The ``hfp`` plugin (`profiles/audio/hfp-hf.c`, experimental,
+	enabled with ``Experimental = true``) connects to the AG found in
+	the SDP records of the peer and sets up the Service Level
+	Connection (SLC) over RFCOMM using `src/shared/hfp.c`:
+	``AT+BRSF``, ``AT+CIND=?``, ``AT+CIND?``, ``AT+CMER``, and after
+	the SLC ``AT+CHLD=?`` (when the AG supports three-way calling),
+	``AT+COPS``, ``AT+CLIP``, ``AT+CCWA``, ``AT+CMEE``, ``AT+NREC`` and
+	``AT+CLCC``.
+
+	It exposes an **org.bluez.Telephony1** object per connected AG,
+	with the indicators reported by the AG (``Service``, ``Signal``,
+	``Roaming``, ``BattChg``), ``OperatorName`` and ``InbandRingtone``,
+	and an **org.bluez.Call1** object per call reported by the AG
+	(``+CIEV``, ``+CLIP``, ``+CCWA``, ``+CLCC``).
+
+	Of the call control, ``Dial``, ``Call1.Answer`` and
+	``Call1.Hangup`` are supported.
+
+bluetoothctl (host0)
+	The **telephony** submenu lists and shows the audio gateways and
+	calls, and can ``dial``, ``answer`` and ``hangup``.
+
+AG role (host1)
+	Not implemented by BlueZ, the test implements a minimal AG with
+	**org.bluez.Profile1**. This is enough for the SLC and calls, and
+	for the SCO socket once the HF supports audio.
+
+btvirt
+	Emulates SCO and eSCO links, with the CVSD and transparent air
+	modes, and forwards the SCO data between the controllers, so no
+	emulator changes are expected for the audio test cases.
+
+This covers test_hfp_connect and test_hfp_disconnect.
+
+Changes needed
+--------------
+
+Codec negotiation, in `src/shared/hfp.c`
+	- Set Codec Negotiation (``HFP_HF_FEAT_CODEC_NEGOTIATION``, 0x80)
+	  in the HF supported features sent with ``AT+BRSF``, which are
+	  currently fixed by ``HFP_HF_FEATURES``.
+	- Send ``AT+BAC=<codecs>`` after ``AT+BRSF`` when the AG supports
+	  codec negotiation (0x200 in ``+BRSF``), listing CVSD and mSBC.
+	- Handle ``+BCS: <codec>`` from the AG, replying ``AT+BCS=<codec>``
+	  when the codec is supported, and report the selected codec to the
+	  user of `src/shared/hfp.c`.
+	- Optionally, request an audio connection with ``AT+BCC``.
+
+Audio connection, in `profiles/audio/hfp-hf.c`
+	- Listen for SCO connections from the AG, only accepting them from
+	  a connected AG, and with the voice setting of the selected codec:
+	  ``BT_VOICE_CVSD_16BIT`` for CVSD, ``BT_VOICE_TRANSPARENT`` for
+	  mSBC.
+	- Report the audio connection over D-Bus. The test cases assume a
+	  **org.bluez.MediaTransport1** object for the telephony object, as
+	  done for A2DP, with the ``Codec`` in use and its ``State``, which
+	  the user acquires to get the SCO socket. This needs HFP support in
+	  `profiles/audio/transport.c`, which only handles A2DP, BAP and
+	  ASHA transports.
+
+bluetoothctl
+	- The errors of all the telephony commands are reported as
+	  ``Failed to answer: <error>`` (`client/telephony.c`), which is
+	  misleading for ``dial`` and ``hangup``.
+	- Nothing to do for the audio connection when using a transport, as
+	  the **transport** submenu already shows and acquires transports.
+
+Other limitations, not needed by the test cases
+	- ``HangupAll``, ``SwapCalls``, ``ReleaseAndAnswer``,
+	  ``ReleaseAndSwap``, ``HoldAndAnswer``, ``CreateMultiparty`` and
+	  ``SendTones`` return ``org.bluez.Error.NotSupported``, so
+	  ``telephony.hangup-all`` fails.
+	- ``HangupActive`` and ``HangupHeld`` are documented in
+	  **org.bluez.Telephony(5)** but not implemented.
+	- The HF does not publish an SDP record nor listen for RFCOMM
+	  connections, so the SLC can only be connected by the HF.
+
+The audio test cases, test_hfp_sco, are marked as expected to fail
+(``xfail``) until these changes are done.
+
+SETUP
+=====
+
+Two hosts, connected over BR/EDR:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |     BR/EDR      | host1                  |
+	| HF                     | --------------> | AG                     |
+	| bluetoothd (hfp)       |   RFCOMM (AT)   | bluetoothd             |
+	| bluetoothctl           |                 | Python AG (Profile1)   |
+	|                        | <=============> |                        |
+	+------------------------+       SCO       +------------------------+
+
+	--> connection is initiated by      ==> audio flows towards
+
+host0, the Hands-Free unit
+	Runs **bluetoothd(8)** with ``Experimental = true``, as the ``hfp``
+	plugin is experimental, and `bluetoothctl` to pair, connect and
+	use the **telephony** submenu.
+
+host1, the Audio Gateway
+	BlueZ does not implement the AG role, so the test implements it:
+	it registers an **org.bluez.Profile1** for the HFP AG UUID
+	(``0000111f-0000-1000-8000-00805f9b34fb``) with ``Role = server``,
+	which also publishes the SDP record the HF looks for. It answers the
+	AT commands of the HF over the RFCOMM socket handed over by
+	``NewConnection``, and handles the SCO socket for the audio
+	connection. The AG supported features, in ``+BRSF``, are
+	configurable, in particular Codec Negotiation (0x200), and the
+	codecs it supports.
+
+Both hosts run `bluetoothctl` with an agent answering the pairing
+automatically. The AG profile is registered *before* pairing, so its
+SDP record is in place when the HF resolves the services.
+
+The HF connects the SLC itself, as the AG does not connect it: the hosts
+are paired over BR/EDR, trust each other, and host0 connects.
+
+Codecs
+------
+
+``CVSD`` (codec ID 1)
+	Narrowband speech, mandatory. Used when codec negotiation is not
+	supported by either side, or when the AG selects it. The SCO socket
+	uses the default voice setting (``BT_VOICE_CVSD_16BIT``).
+
+``mSBC`` (codec ID 2)
+	Wideband speech. Requires codec negotiation on both sides: the HF
+	lists it in ``AT+BAC=1,2`` and the AG selects it with ``+BCS: 2``,
+	confirmed by the HF with ``AT+BCS=2``. The SCO socket uses the
+	transparent voice setting (``BT_VOICE_TRANSPARENT``), i.e. the
+	controller does not transcode the audio.
+
+TEST CASES
+==========
+
+test_hfp_connect
+----------------
+
+:Setup: As above, with the AG not supporting codec negotiation.
+
+:Steps:
+	1. host1: register the AG profile.
+	2. host0: pair with host1 over BR/EDR, and ``trust`` each other.
+	3. host0: ``connect <host1 bdaddr>``.
+	4. host0: ``telephony.list``.
+	5. host0: ``telephony.show``.
+
+:Expected:
+	1. The AG profile is registered.
+	2. ``Pairing successful``, ``trust succeeded`` on both hosts.
+	3. ``Connection successful``. The AG receives the SLC setup, in
+	   order: ``AT+BRSF=<features>``, ``AT+CIND=?``, ``AT+CIND?``,
+	   ``AT+CMER=3,0,0,1``, then the commands following the SLC, e.g.
+	   ``AT+COPS=3,0``, ``AT+CLIP=1``, ``AT+CCWA=1``, ``AT+CMEE=1``,
+	   ``AT+NREC=0`` and ``AT+CLCC``.
+	4. ``[NEW] Telephony /org/bluez/hci0/dev_XX/telephony0`` and the
+	   audio gateway listed.
+	5. ``Audio gateway /org/bluez/hci0/dev_XX/telephony0`` with
+	   ``UUID: Handsfree Audio Gateway (0000111f-...)``,
+	   ``State: connected``, and the indicators reported by the AG
+	   (``Service``, ``Signal``, ``Roaming``, ``BattChg``), and
+	   ``OperatorName`` as reported with ``+COPS``.
+
+:Notes: Supported today.
+
+	``connect`` has to be issued by the HF, as the ``hfp`` plugin
+	does not listen for incoming connections. Without ``trust``, the
+	AG blocks on an **org.bluez.Agent1.AuthorizeService** prompt.
+
+test_hfp_disconnect
+-------------------
+
+:Setup: As test_hfp_connect, with the SLC connected.
+
+:Steps: host0: ``disconnect <host1 bdaddr>``.
+
+:Expected:
+	1. The AG sees the RFCOMM socket closed.
+	2. ``[DEL] Telephony /org/bluez/hci0/dev_XX/telephony0`` on host0.
+	3. ``Disconnection successful``.
+
+:Notes: Supported today.
+
+test_hfp_sco[cvsd]
+------------------
+
+:Setup: As test_hfp_connect, with the AG not supporting codec
+	negotiation.
+
+:Steps:
+	1. Connect the SLC as in test_hfp_connect.
+	2. host1: connect SCO to host0 with the CVSD voice setting.
+	3. host1: send audio data over the SCO socket.
+	4. host1: close the SCO socket.
+
+:Expected:
+	1. The SLC is connected, the HF does not send ``AT+BAC``.
+	2. The HF accepts the audio connection, which is reported on host0
+	   as a transport for the telephony object, with ``Codec: 0x01``
+	   (CVSD) and ``State: active``.
+	3. The audio data is received on host0 over the transport.
+	4. The transport is removed on host0.
+
+:Notes: Needs changes: audio connection in the HF, see STATUS.
+	Expected to fail until then.
+
+test_hfp_sco[msbc]
+------------------
+
+:Setup: As test_hfp_connect, with the AG supporting codec negotiation
+	(0x200 in ``+BRSF``) and the CVSD and mSBC codecs.
+
+:Steps:
+	1. Connect the SLC as in test_hfp_connect.
+	2. host1: send ``+BCS: 2``.
+	3. host1: connect SCO to host0 with the transparent voice setting.
+	4. host1: send audio data over the SCO socket.
+	5. host1: close the SCO socket.
+
+:Expected:
+	1. The HF supports codec negotiation, 0x80 in ``AT+BRSF``, and
+	   lists its codecs with ``AT+BAC=1,2`` after ``AT+BRSF``.
+	2. The HF confirms the codec with ``AT+BCS=2``, and the AG replies
+	   ``OK``.
+	3. The HF accepts the audio connection, with the transparent air
+	   mode, which is reported on host0 as a transport for the
+	   telephony object, with ``Codec: 0x02`` (mSBC) and
+	   ``State: active``.
+	4. The audio data is received on host0 over the transport.
+	5. The transport is removed on host0.
+
+:Notes: Needs changes: codec negotiation and audio connection in the
+	HF, see STATUS. Expected to fail until then.
+
+	The AG only connects SCO after the codec has been confirmed with
+	``AT+BCS``. If the HF replies with another codec, or with
+	``ERROR``, the AG shall select the codec again or fall back to
+	CVSD.
+
+test_hfp_sco[msbc-to-cvsd]
+--------------------------
+
+:Setup: As test_hfp_sco[msbc], except the AG only supports CVSD while
+	supporting codec negotiation.
+
+:Steps:
+	1. Connect the SLC as in test_hfp_connect.
+	2. host1: send ``+BCS: 1``.
+	3. host1: connect SCO to host0 with the CVSD voice setting.
+
+:Expected:
+	1. The HF lists its codecs with ``AT+BAC=1,2``.
+	2. The HF confirms the codec with ``AT+BCS=1``.
+	3. The HF accepts the audio connection, reported on host0 as a
+	   transport with ``Codec: 0x01`` (CVSD).
+
+:Notes: Needs changes: codec negotiation and audio connection in the
+	HF, see STATUS. Expected to fail until then.
+
+	This checks that the HF follows the codec selected by the AG
+	rather than always using mSBC when both support codec
+	negotiation.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 7b3cad1c66b1..79aade8e58ff 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -15,6 +15,7 @@ are documented separately:
 - **functional-a2dp(7)**: `test/functional/test_a2dp.py`
 - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
 - **functional-bap(7)**: `test/functional/test_bap.py`
+- **functional-hfp(7)**: `test/functional/test_hfp.py`
 - **functional-hog(7)**: `test/functional/test_hog.py`
 - **functional-mpris-proxy(7)**: `test/functional/test_mpris_proxy.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
-- 
2.55.0


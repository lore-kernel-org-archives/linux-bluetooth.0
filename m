Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431319A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569661; cv=none; b=jecwyzCYen29aOJnh49cY8mZ5GgOtbMFlaUCHEPzy/cjB52YU2ZjH5lVNH+9jhDcjMHeEDHxTDV8zJx7V16jHmKjS3TyJ8tcuNEbLJKWBJ9wmnU0AAo2EsP3klgc24Edlgtv1fenG4aO9EAzkiiRgYW6Kwa+QVWao+g2q3Aa8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569661; c=relaxed/simple;
	bh=rogn0yHHgre1NF+PTU5CQ7upbAUYOn1+69ho8a+3JRg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=olbnH+t0aGO/TRPfcjiDXv7T2jHmIKgAuWomWI3QosrweIEsuwYbER1ZxsMSY62FJ2bTokM1XhY1Zc6t/AzX3u4LQ2t4WPI6O3FldZ9eyxt3py/tL3KRln83Ga2H0VaMu9xRComPS5egi71GWqaidfHRsqiEhDwMLEG/i8lzTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=P6a2ndTr; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="P6a2ndTr"
Received: from github.com (hubbernetes-node-c7e061a.ac4-iad.github.net [10.52.164.26])
	by smtp.github.com (Postfix) with ESMTPA id 33C3064084B
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751569659;
	bh=LubKWWgFAtQmaRRjmk6M2WBgw6Qxyl/HK2rz00iIppU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=P6a2ndTrwgCcdjnn0Ae4bTyVbO82p4au639Q15tcZbStOFTuXadxJUDi5YGwQfYJO
	 srsryWx3XiLGRnEEPZxOm53WpURAgaKTC09MxDtWt0qmdHm2LbD0P2g2X36SYeA2SS
	 iZi1XWs9wF3Mdyn3thnO8+/OYittv3bw1taUBqMc=
Date: Thu, 03 Jul 2025 12:07:39 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/50fb90-655421@github.com>
Subject: [bluez/bluez] a21564: unit: Remove dependencies to android
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a2156408b13fa129644482b5714febff2786da18
      https://github.com/bluez/bluez/commit/a2156408b13fa129644482b5714febff2786da18
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-02 (Wed, 02 Jul 2025)

  Changed paths:
    M Makefile.am
    A unit/avctp.c
    A unit/avctp.h
    A unit/avdtp.c
    A unit/avdtp.h
    A unit/avrcp-lib.c
    A unit/avrcp-lib.h
    A unit/avrcp.c
    A unit/avrcp.h

  Log Message:
  -----------
  unit: Remove dependencies to android

This add copies of android specific dependencies used by unit testing.


  Commit: f0512114aacfaf82fcd06e086884c0478c4ae124
      https://github.com/bluez/bluez/commit/f0512114aacfaf82fcd06e086884c0478c4ae124
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-02 (Wed, 02 Jul 2025)

  Changed paths:
    M Makefile.am
    R android/Android.mk
    R android/Makefile.am
    R android/README
    R android/a2dp-sink.c
    R android/a2dp-sink.h
    R android/a2dp.c
    R android/a2dp.h
    R android/audio-ipc-api.txt
    R android/audio-msg.h
    R android/audio_utils/resampler.c
    R android/audio_utils/resampler.h
    R android/avctp.c
    R android/avctp.h
    R android/avdtp.c
    R android/avdtp.h
    R android/avdtptest.c
    R android/avrcp-lib.c
    R android/avrcp-lib.h
    R android/avrcp.c
    R android/avrcp.h
    R android/bluetooth.c
    R android/bluetooth.h
    R android/bluetoothd-snoop.c
    R android/bluetoothd-wrapper.c
    R android/bluetoothd.te
    R android/bluetoothd_snoop.te
    R android/client/haltest.c
    R android/client/history.c
    R android/client/history.h
    R android/client/if-audio.c
    R android/client/if-av-sink.c
    R android/client/if-av.c
    R android/client/if-bt.c
    R android/client/if-gatt.c
    R android/client/if-hf-client.c
    R android/client/if-hf.c
    R android/client/if-hh.c
    R android/client/if-hl.c
    R android/client/if-main.h
    R android/client/if-mce.c
    R android/client/if-pan.c
    R android/client/if-rc-ctrl.c
    R android/client/if-rc.c
    R android/client/if-sco.c
    R android/client/if-sock.c
    R android/client/pollhandler.c
    R android/client/pollhandler.h
    R android/client/tabcompletion.c
    R android/client/terminal.c
    R android/client/terminal.h
    R android/compat/readline/history.h
    R android/compat/readline/readline.h
    R android/compat/wordexp.h
    R android/cts.txt
    R android/cutils/properties.h
    R android/gatt.c
    R android/gatt.h
    R android/hal-a2dp-sink.c
    R android/hal-a2dp.c
    R android/hal-audio-aptx.c
    R android/hal-audio-sbc.c
    R android/hal-audio.c
    R android/hal-audio.h
    R android/hal-avrcp-ctrl.c
    R android/hal-avrcp.c
    R android/hal-bluetooth.c
    R android/hal-gatt.c
    R android/hal-handsfree-client.c
    R android/hal-handsfree.c
    R android/hal-health.c
    R android/hal-hidhost.c
    R android/hal-ipc-api.txt
    R android/hal-ipc.c
    R android/hal-ipc.h
    R android/hal-log.h
    R android/hal-map-client.c
    R android/hal-msg.h
    R android/hal-pan.c
    R android/hal-sco.c
    R android/hal-socket.c
    R android/hal-utils.c
    R android/hal-utils.h
    R android/hal.h
    R android/handsfree-client.c
    R android/handsfree-client.h
    R android/handsfree.c
    R android/handsfree.h
    R android/hardware/audio.h
    R android/hardware/audio_effect.h
    R android/hardware/bluetooth.h
    R android/hardware/bt_av.h
    R android/hardware/bt_gatt.h
    R android/hardware/bt_gatt_client.h
    R android/hardware/bt_gatt_server.h
    R android/hardware/bt_gatt_types.h
    R android/hardware/bt_hf.h
    R android/hardware/bt_hf_client.h
    R android/hardware/bt_hh.h
    R android/hardware/bt_hl.h
    R android/hardware/bt_mce.h
    R android/hardware/bt_pan.h
    R android/hardware/bt_rc.h
    R android/hardware/bt_sock.h
    R android/hardware/hardware.c
    R android/hardware/hardware.h
    R android/health.c
    R android/health.h
    R android/hidhost.c
    R android/hidhost.h
    R android/init.bluetooth.rc
    R android/ipc-common.h
    R android/ipc-tester.c
    R android/ipc.c
    R android/ipc.h
    R android/log.c
    R android/main.c
    R android/map-client.c
    R android/map-client.h
    R android/pan.c
    R android/pan.h
    R android/pics-a2dp.txt
    R android/pics-avctp.txt
    R android/pics-avdtp.txt
    R android/pics-avrcp.txt
    R android/pics-bnep.txt
    R android/pics-did.txt
    R android/pics-dis.txt
    R android/pics-gap.txt
    R android/pics-gatt.txt
    R android/pics-gavdp.txt
    R android/pics-hdp.txt
    R android/pics-hfp.txt
    R android/pics-hid.txt
    R android/pics-hogp.txt
    R android/pics-hsp.txt
    R android/pics-iopt.txt
    R android/pics-l2cap.txt
    R android/pics-map.txt
    R android/pics-mcap.txt
    R android/pics-mps.txt
    R android/pics-opp.txt
    R android/pics-pan.txt
    R android/pics-pbap.txt
    R android/pics-rfcomm.txt
    R android/pics-scpp.txt
    R android/pics-sdp.txt
    R android/pics-sm.txt
    R android/pics-spp.txt
    R android/pixit-a2dp.txt
    R android/pixit-avctp.txt
    R android/pixit-avdtp.txt
    R android/pixit-avrcp.txt
    R android/pixit-bnep.txt
    R android/pixit-did.txt
    R android/pixit-dis.txt
    R android/pixit-gap.txt
    R android/pixit-gatt.txt
    R android/pixit-gavdp.txt
    R android/pixit-hdp.txt
    R android/pixit-hfp.txt
    R android/pixit-hid.txt
    R android/pixit-hogp.txt
    R android/pixit-hsp.txt
    R android/pixit-iopt.txt
    R android/pixit-l2cap.txt
    R android/pixit-map.txt
    R android/pixit-mcap.txt
    R android/pixit-mps.txt
    R android/pixit-opp.txt
    R android/pixit-pan.txt
    R android/pixit-pbap.txt
    R android/pixit-rfcomm.txt
    R android/pixit-scpp.txt
    R android/pixit-sdp.txt
    R android/pixit-sm.txt
    R android/pixit-spp.txt
    R android/pts-a2dp.txt
    R android/pts-avctp.txt
    R android/pts-avdtp.txt
    R android/pts-avrcp.txt
    R android/pts-bnep.txt
    R android/pts-did.txt
    R android/pts-dis.txt
    R android/pts-gap.txt
    R android/pts-gatt.txt
    R android/pts-gavdp.txt
    R android/pts-hdp.txt
    R android/pts-hfp.txt
    R android/pts-hid.txt
    R android/pts-hogp.txt
    R android/pts-hsp.txt
    R android/pts-iopt.txt
    R android/pts-l2cap.txt
    R android/pts-map.txt
    R android/pts-mcap.txt
    R android/pts-mps.txt
    R android/pts-opp.txt
    R android/pts-pan.txt
    R android/pts-pbap.txt
    R android/pts-rfcomm.txt
    R android/pts-scpp.txt
    R android/pts-sdp.txt
    R android/pts-sm.txt
    R android/pts-spp.txt
    R android/sco-ipc-api.txt
    R android/sco-msg.h
    R android/sco.c
    R android/sco.h
    R android/socket-api.txt
    R android/socket.c
    R android/socket.h
    R android/system-emulator.c
    R android/system/audio.h
    R android/test-ipc.c
    R android/tester-a2dp.c
    R android/tester-avrcp.c
    R android/tester-bluetooth.c
    R android/tester-gatt.c
    R android/tester-hdp.c
    R android/tester-hidhost.c
    R android/tester-main.c
    R android/tester-main.h
    R android/tester-map-client.c
    R android/tester-pan.c
    R android/tester-socket.c
    R android/utils.h
    M configure.ac
    M unit/test-avctp.c
    M unit/test-avdtp.c
    M unit/test-avrcp.c

  Log Message:
  -----------
  Remove android support


  Commit: 655421a962636d3e2ed2124eee8f588b0815ae3b
      https://github.com/bluez/bluez/commit/655421a962636d3e2ed2124eee8f588b0815ae3b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-07-03 (Thu, 03 Jul 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix not calling pre_run for main menu

When calling bt_shell_run the main menu pre_run was not being called
which cause tools with just one menu to not work as intended.

Fixes: https://github.com/bluez/bluez/issues/1319


Compare: https://github.com/bluez/bluez/compare/50fb9042e1ad...655421a96263

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ll6w+p2f"
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA726C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 07:18:26 -0800 (PST)
Received: from github.com (hubbernetes-node-5cc27f7.ash1-iad.github.net [10.56.146.37])
	by smtp.github.com (Postfix) with ESMTPA id 0B6631012A8
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 07:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1701098306;
	bh=Tvs8Ty/QldtOHST/05oiR3Chwo6NZWAd1ZQ2pQO4MU4=;
	h=Date:From:To:Subject:From;
	b=Ll6w+p2fPML1p5QWRSa71ZxXUcIPNeVKps9CWQUMQ1v2nM+vkBQ21u9FXiCzZlndy
	 husj38IfnoxPjkU1D3i7v9IxNlD/W8B45IX0cYXgt5GvqqBx0EAgX49HedqggR/1R/
	 4q+4noNDdYNT0BAPXGVVYl0xnW12FpxtVV44tE/8=
Date: Mon, 27 Nov 2023 07:18:26 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/58e6ef-8b4484@github.com>
Subject: [bluez/bluez] e94853: shared/util: Add GMAP related UUIDs
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
  Commit: e94853608c8033c4c1cf2047981354484c0500cb
      https://github.com/bluez/bluez/commit/e94853608c8033c4c1cf2047981354484c0500cb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-21 (Tue, 21 Nov 2023)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Add GMAP related UUIDs

This adds GMAP 1.0[1] UUIDs following the assigned numbers[2].

[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496
[2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3


  Commit: 6af3b7290a3a36469f23e3eaaf6b2c0d09994efd
      https://github.com/bluez/bluez/commit/6af3b7290a3a36469f23e3eaaf6b2c0d09994efd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-21 (Tue, 21 Nov 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add GMAS attribute decoders

This adds GMAS attribute decoders.


  Commit: c9b48a6f84a803b6bad43be26a12c5ba6b7f5590
      https://github.com/bluez/bluez/commit/c9b48a6f84a803b6bad43be26a12c5ba6b7f5590
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-22 (Wed, 22 Nov 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add presets from GMAP

This adds the following presets from GMAP:

ISO QoS 48_1_gc - Success                            Passed
ISO QoS 48_2_gc - Success                            Passed
ISO QoS 48_1_gr - Success                            Passed
ISO QoS 48_2_gr - Success                            Passed
ISO QoS 48_3_gr - Success                            Passed
ISO QoS 48_4_gr - Success                            Passed


  Commit: 506413dba87230b1c579eb23901bd88e52ef6825
      https://github.com/bluez/bluez/commit/506413dba87230b1c579eb23901bd88e52ef6825
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-22 (Wed, 22 Nov 2023)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Add presets from GMAP

This adds the following presets from GMAP:

16_1_gs
16_2_gs
32_1_gs
32_2_gs
48_1_gs
48_2_gs
32_1_gr
32_2_gr
48_1_gr
48_2_gr
48_3_gr
48_4_gr


  Commit: 813e1ce1199345f633ffaeb0f218accecdf9ff83
      https://github.com/bluez/bluez/commit/813e1ce1199345f633ffaeb0f218accecdf9ff83
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-22 (Wed, 22 Nov 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add presets from GMAP

This adds the following presets from GMAP:

16_1_gs
16_2_gs
32_1_gs
32_2_gs
48_1_gs
48_2_gs
32_1_gr
32_2_gr
48_1_gr
48_2_gr
48_3_gr
48_4_gr
32_1_gr_l+r
32_2_gr_l+r
48_1_gr_l+r
48_2_gr_l+r
48_3_gr_l+r
48_4_gr_l+r


  Commit: 8b448400ece60dd51d786367dddf25ab58cc7f4b
      https://github.com/bluez/bluez/commit/8b448400ece60dd51d786367dddf25ab58cc7f4b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-27 (Mon, 27 Nov 2023)

  Changed paths:
    M src/shared/bap-debug.c
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Enable passing a label to util_debug_bit

This adds a label parameter to be passed to util_debug_bit instead of
just prepending a '\t'.


Compare: https://github.com/bluez/bluez/compare/58e6ef54e672...8b448400ece6

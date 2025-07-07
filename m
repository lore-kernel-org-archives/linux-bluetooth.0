Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA5B28A1CC
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900774; cv=none; b=iYjaWcj8k14mBlmLr3ikAFiuJsHfHI7VMJG8T8j73+a6KtV6AFCpE5fYd+UUx1LJQxNWfRWLzynuGfw2UnHgNDPfwqi88qTbK9//wbmDsz4iQegTa/z3SFFtlfemhZZ/HtKuADcN/bSHsDsOd8dZIMK4Myq+le12tXUA7/+qXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900774; c=relaxed/simple;
	bh=vH+M48peXFpOYXJo3qlH8Td3YdsZcNMWmdaH11mdUcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=k+SWAoL1XlwRsy0lm+0P6TWuHGYEjL1IV7TkJnQjHMnFEpn5ZTspYTqyPbGkXXZeT0ecyiiqn02O6zFVj7Sn625EVdd9fnyvq8Kt1PjZcABsF5qxkY48Z20n9jlK+utBdbFCUZJPAu1nEJ+nVsya7PCDkOsSH1HlopLBETNi2Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D7A2C61E64841;
	Mon, 07 Jul 2025 17:06:04 +0200 (CEST)
Message-ID: <74520873-23f0-4470-8839-53e213f8ae5b@molgen.mpg.de>
Date: Mon, 7 Jul 2025 17:06:04 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v1 2/2] Remove android support
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250702192610.1547665-1-luiz.dentz@gmail.com>
 <20250702192610.1547665-2-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20250702192610.1547665-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Luiz,


Thank you for your patch.

Am 02.07.25 um 21:26 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>

Could you please elaborate, why this is removed? It doesn’t work and is 
unmaintained?


Kind regards,

Paul


> ---
>   Makefile.am                        |    2 -
>   android/Android.mk                 |  857 ----
>   android/Makefile.am                |  327 --
>   android/README                     |  454 --
>   android/a2dp-sink.c                |   71 -
>   android/a2dp-sink.h                |   12 -
>   android/a2dp.c                     | 1762 -------
>   android/a2dp.h                     |   12 -
>   android/audio-ipc-api.txt          |   87 -
>   android/audio-msg.h                |   69 -
>   android/audio_utils/resampler.c    |  260 -
>   android/audio_utils/resampler.h    |   99 -
>   android/avctp.c                    | 1637 ------
>   android/avctp.h                    |  170 -
>   android/avdtp.c                    | 3476 -------------
>   android/avdtp.h                    |  278 --
>   android/avdtptest.c                |  897 ----
>   android/avrcp-lib.c                | 3604 --------------
>   android/avrcp-lib.h                |  343 --
>   android/avrcp.c                    | 1161 -----
>   android/avrcp.h                    |   15 -
>   android/bluetooth.c                | 5505 --------------------
>   android/bluetooth.h                |  102 -
>   android/bluetoothd-snoop.c         |  242 -
>   android/bluetoothd-wrapper.c       |   83 -
>   android/bluetoothd.te              |   47 -
>   android/bluetoothd_snoop.te        |   17 -
>   android/client/haltest.c           |  467 --
>   android/client/history.c           |   87 -
>   android/client/history.h           |   10 -
>   android/client/if-audio.c          |  525 --
>   android/client/if-av-sink.c        |  129 -
>   android/client/if-av.c             |  133 -
>   android/client/if-bt.c             | 1013 ----
>   android/client/if-gatt.c           | 2666 ----------
>   android/client/if-hf-client.c      |  658 ---
>   android/client/if-hf.c             | 1052 ----
>   android/client/if-hh.c             |  444 --
>   android/client/if-hl.c             |  367 --
>   android/client/if-main.h           |  187 -
>   android/client/if-mce.c            |   77 -
>   android/client/if-pan.c            |  203 -
>   android/client/if-rc-ctrl.c        |  104 -
>   android/client/if-rc.c             |  390 --
>   android/client/if-sco.c            |  805 ---
>   android/client/if-sock.c           |  340 --
>   android/client/pollhandler.c       |  106 -
>   android/client/pollhandler.h       |   15 -
>   android/client/tabcompletion.c     |  364 --
>   android/client/terminal.c          |  813 ---
>   android/client/terminal.h          |   51 -
>   android/compat/readline/history.h  |   18 -
>   android/compat/readline/readline.h |   97 -
>   android/compat/wordexp.h           |   31 -
>   android/cts.txt                    |   58 -
>   android/cutils/properties.h        |   82 -
>   android/gatt.c                     | 7474 ----------------------------
>   android/gatt.h                     |   30 -
>   android/hal-a2dp-sink.c            |  152 -
>   android/hal-a2dp.c                 |  154 -
>   android/hal-audio-aptx.c           |  260 -
>   android/hal-audio-sbc.c            |  418 --
>   android/hal-audio.c                | 1632 ------
>   android/hal-audio.h                |   91 -
>   android/hal-avrcp-ctrl.c           |  135 -
>   android/hal-avrcp.c                |  678 ---
>   android/hal-bluetooth.c            | 1129 -----
>   android/hal-gatt.c                 | 2093 --------
>   android/hal-handsfree-client.c     |  642 ---
>   android/hal-handsfree.c            |  882 ----
>   android/hal-health.c               |  286 --
>   android/hal-hidhost.c              |  393 --
>   android/hal-ipc-api.txt            | 2737 ----------
>   android/hal-ipc.c                  |  460 --
>   android/hal-ipc.h                  |   22 -
>   android/hal-log.h                  |   24 -
>   android/hal-map-client.c           |  149 -
>   android/hal-msg.h                  | 2322 ---------
>   android/hal-pan.c                  |  200 -
>   android/hal-sco.c                  | 1521 ------
>   android/hal-socket.c               |   86 -
>   android/hal-utils.c                |  408 --
>   android/hal-utils.h                |  141 -
>   android/hal.h                      |   43 -
>   android/handsfree-client.c         | 2191 --------
>   android/handsfree-client.h         |   12 -
>   android/handsfree.c                | 3028 -----------
>   android/handsfree.h                |   13 -
>   android/hardware/audio.h           |  657 ---
>   android/hardware/audio_effect.h    | 1000 ----
>   android/hardware/bluetooth.h       |  540 --
>   android/hardware/bt_av.h           |   93 -
>   android/hardware/bt_gatt.h         |   51 -
>   android/hardware/bt_gatt_client.h  |  407 --
>   android/hardware/bt_gatt_server.h  |  186 -
>   android/hardware/bt_gatt_types.h   |   46 -
>   android/hardware/bt_hf.h           |  291 --
>   android/hardware/bt_hf_client.h    |  353 --
>   android/hardware/bt_hh.h           |  175 -
>   android/hardware/bt_hl.h           |  113 -
>   android/hardware/bt_mce.h          |   44 -
>   android/hardware/bt_pan.h          |   77 -
>   android/hardware/bt_rc.h           |  286 --
>   android/hardware/bt_sock.h         |   48 -
>   android/hardware/hardware.c        |  115 -
>   android/hardware/hardware.h        |  217 -
>   android/health.c                   | 2035 --------
>   android/health.h                   |   12 -
>   android/hidhost.c                  | 1586 ------
>   android/hidhost.h                  |   12 -
>   android/init.bluetooth.rc          |   38 -
>   android/ipc-common.h               |   25 -
>   android/ipc-tester.c               | 1501 ------
>   android/ipc.c                      |  424 --
>   android/ipc.h                      |   37 -
>   android/log.c                      |  203 -
>   android/main.c                     |  793 ---
>   android/map-client.c               |  190 -
>   android/map-client.h               |   13 -
>   android/pan.c                      |  891 ----
>   android/pan.h                      |   12 -
>   android/pics-a2dp.txt              |  162 -
>   android/pics-avctp.txt             |   75 -
>   android/pics-avdtp.txt             |  236 -
>   android/pics-avrcp.txt             |  644 ---
>   android/pics-bnep.txt              |   26 -
>   android/pics-did.txt               |   23 -
>   android/pics-dis.txt               |   59 -
>   android/pics-gap.txt               |  788 ---
>   android/pics-gatt.txt              |  326 --
>   android/pics-gavdp.txt             |   38 -
>   android/pics-hdp.txt               |  307 --
>   android/pics-hfp.txt               |  232 -
>   android/pics-hid.txt               |  291 --
>   android/pics-hogp.txt              |  409 --
>   android/pics-hsp.txt               |  103 -
>   android/pics-iopt.txt              |  223 -
>   android/pics-l2cap.txt             |  178 -
>   android/pics-map.txt               |  175 -
>   android/pics-mcap.txt              |  141 -
>   android/pics-mps.txt               |  337 --
>   android/pics-opp.txt               |  187 -
>   android/pics-pan.txt               |  152 -
>   android/pics-pbap.txt              |  475 --
>   android/pics-rfcomm.txt            |   65 -
>   android/pics-scpp.txt              |  143 -
>   android/pics-sdp.txt               |  140 -
>   android/pics-sm.txt                |   96 -
>   android/pics-spp.txt               |   99 -
>   android/pixit-a2dp.txt             |   30 -
>   android/pixit-avctp.txt            |   39 -
>   android/pixit-avdtp.txt            |   31 -
>   android/pixit-avrcp.txt            |   36 -
>   android/pixit-bnep.txt             |   30 -
>   android/pixit-did.txt              |   24 -
>   android/pixit-dis.txt              |   26 -
>   android/pixit-gap.txt              |   60 -
>   android/pixit-gatt.txt             |   32 -
>   android/pixit-gavdp.txt            |   32 -
>   android/pixit-hdp.txt              |   32 -
>   android/pixit-hfp.txt              |   41 -
>   android/pixit-hid.txt              |   31 -
>   android/pixit-hogp.txt             |   29 -
>   android/pixit-hsp.txt              |   30 -
>   android/pixit-iopt.txt             |   23 -
>   android/pixit-l2cap.txt            |   59 -
>   android/pixit-map.txt              |   44 -
>   android/pixit-mcap.txt             |   37 -
>   android/pixit-mps.txt              |   47 -
>   android/pixit-opp.txt              |   27 -
>   android/pixit-pan.txt              |   39 -
>   android/pixit-pbap.txt             |   37 -
>   android/pixit-rfcomm.txt           |   28 -
>   android/pixit-scpp.txt             |   25 -
>   android/pixit-sdp.txt              |   45 -
>   android/pixit-sm.txt               |   72 -
>   android/pixit-spp.txt              |   19 -
>   android/pts-a2dp.txt               |   70 -
>   android/pts-avctp.txt              |   43 -
>   android/pts-avdtp.txt              |  237 -
>   android/pts-avrcp.txt              |  242 -
>   android/pts-bnep.txt               |   60 -
>   android/pts-did.txt                |   20 -
>   android/pts-dis.txt                |   40 -
>   android/pts-gap.txt                |  432 --
>   android/pts-gatt.txt               | 1422 ------
>   android/pts-gavdp.txt              |   23 -
>   android/pts-hdp.txt                |  296 --
>   android/pts-hfp.txt                |  250 -
>   android/pts-hid.txt                |   74 -
>   android/pts-hogp.txt               |  102 -
>   android/pts-hsp.txt                |   41 -
>   android/pts-iopt.txt               |   26 -
>   android/pts-l2cap.txt              |  191 -
>   android/pts-map.txt                |   95 -
>   android/pts-mcap.txt               |   80 -
>   android/pts-mps.txt                |   60 -
>   android/pts-opp.txt                |  119 -
>   android/pts-pan.txt                |   71 -
>   android/pts-pbap.txt               |  145 -
>   android/pts-rfcomm.txt             |   38 -
>   android/pts-scpp.txt               |   24 -
>   android/pts-sdp.txt                |   77 -
>   android/pts-sm.txt                 |  102 -
>   android/pts-spp.txt                |   22 -
>   android/sco-ipc-api.txt            |   37 -
>   android/sco-msg.h                  |   27 -
>   android/sco.c                      |  338 --
>   android/sco.h                      |   38 -
>   android/socket-api.txt             |   61 -
>   android/socket.c                   | 1309 -----
>   android/socket.h                   |   19 -
>   android/system-emulator.c          |  239 -
>   android/system/audio.h             | 1408 ------
>   android/test-ipc.c                 |  564 ---
>   android/tester-a2dp.c              |  239 -
>   android/tester-avrcp.c             |  587 ---
>   android/tester-bluetooth.c         | 1258 -----
>   android/tester-gatt.c              | 3682 --------------
>   android/tester-hdp.c               |  552 --
>   android/tester-hidhost.c           |  722 ---
>   android/tester-main.c              | 3375 -------------
>   android/tester-main.h              |  788 ---
>   android/tester-map-client.c        |  143 -
>   android/tester-pan.c               |  229 -
>   android/tester-socket.c            |  450 --
>   android/utils.h                    |   31 -
>   configure.ac                       |   16 -
>   unit/test-avctp.c                  |    2 +-
>   unit/test-avdtp.c                  |    2 +-
>   unit/test-avrcp.c                  |    4 +-
>   231 files changed, 4 insertions(+), 102811 deletions(-)

[…]

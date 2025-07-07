Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AED2E2EE2
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901654; cv=none; b=o7fZ6Q9V+8WrexgliSMlZ7OvpsWXXFwUSlixaE+eh3Wm22K2pA4CVtPKzHlb6mf6oU1g7AfoO2VNh1rbA8yoCQ7Oeh2FRHmLzTeWTgNq+sm5r5U3LxAIXRsH9qtKYSJ/LTFcgDCMSq7eKi1DEJoCrrhyrOYTHpWSsx4zD4RG7mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901654; c=relaxed/simple;
	bh=4TU4FvNX/raNYv9IZ4kz/NW63KNFilDtcs/jMHcbrgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzP0QxKDjn1yQkeeaCnnlJQ1qOGf6slKuTq5vSxYKm0NJhjWk6Wu3wW/0+KJvASG1qVgjUO/OIndWi+Z74j+JFdbpiD96iJOYU+ah0qFScjq/zNJ3jdBYf/MXw65oWDsMlACm6ChHlLsPX1AWiW7otJ4Kta7hvkZmy9IiekIwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWZpcW1i; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWZpcW1i"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso38906771fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751901650; x=1752506450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxSEqDuJuMbrFFMard9RmG4AdoDA649q8TyZW+XG7pk=;
        b=nWZpcW1iPTPp46s2XFwPw/tRRbTOsNhcIwmK3B2CqqIMsEVHYZLQIOx20F3OUMawNC
         snWTEWiiDj5uoJ+9P544eoQ4Ld5uaHbVvj6TlBA+7plO33l3fiN+gyZmN7XzDUGuaUmf
         UTKOTj5d0qk8HTwn6c2y4op56JHs/D1oDpCbMCl8OTpas7sBUxm9C2swm6i+dns8OltM
         t4bKxuscloBgXBojMpbqpNDPFgoUBMsxTn7hewXE3lcZovwhAfMhU1J3tW01Mj2TFbkj
         eiRx6p4XtUSkeFBG+Hi6WLd4uZLrhkLGxIgcLzvZXCLCHx6WLrTrzTUp9eafnhOBdW2O
         xi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901650; x=1752506450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxSEqDuJuMbrFFMard9RmG4AdoDA649q8TyZW+XG7pk=;
        b=u3AvlqvV6QhXV3zKLNeJMeAnqK8uIHmJJq5f6YWPmCVBTf6n+rJTzEDxosdBQvJC5s
         cR8CdIQP2hQ68gbxtOOETK2I8TNJ9q+fRZO2x2yFfOF/1RWTVyeNO6dixLPa4s70eLH7
         4DrQhizldLXjoTOqDw5menrqRmwUi02WIPUSegdKR2Id5FBGkoTIoM47/CNJg3HyvenA
         /Rf1y9L7HR62k/+yJZpe2nSp+nNU2UvzFIdCKQdU4gZzvyRI5A8YzBz8CHkEzx6XfLKD
         RVlu5BXWxZtUjgkmLDb+Kg5yuV3u6/K+SXg340KFrJy/1zhvUsJQA7gDBjIKSmGsPSSu
         hIBw==
X-Gm-Message-State: AOJu0YwBLuF+FJcNc27n8vHdOFYEqlB4hoQIl+b6qiEk8Z97DIWavRqf
	90rN8Y2hFnhrU18YgQBYK6xiFgacO5OQSJeeuT7/g7MlcQ5y4cJiHeSwhSiCjavQeA+dpVz9L0g
	iCo10335GU09XS+FW1bH0DZmJBla1phY=
X-Gm-Gg: ASbGncsv6TTmb+SRZdJ5+hQKOID6KEUaE3vNKflaVrOl08OQi/A5YSt9QBcbmHsty1K
	hKftOQqG3aUYRUG2g0y5jyH68jwjKg3d9kurnNzSrAMRPUGOYYdf4WBe2uTbRH6r6kjWzPLz4SZ
	JMIh6QLxNRkXqpVYxMyKedGYtnb2RBFVZ8jlWdeXdi0Q==
X-Google-Smtp-Source: AGHT+IHrKDZNjAep7nWOcHLDarm7xBEUHfXY9W+OxDnfPbDbCZMoVbQ8wfOFxEK59RyPiGSJp6TY2rBdIEZ5szcGjxg=
X-Received: by 2002:a2e:b8c8:0:b0:32a:80bc:1755 with SMTP id
 38308e7fff4ca-32f197c18c7mr28625781fa.0.1751901649105; Mon, 07 Jul 2025
 08:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702192610.1547665-1-luiz.dentz@gmail.com>
 <20250702192610.1547665-2-luiz.dentz@gmail.com> <74520873-23f0-4470-8839-53e213f8ae5b@molgen.mpg.de>
In-Reply-To: <74520873-23f0-4470-8839-53e213f8ae5b@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 7 Jul 2025 11:20:36 -0400
X-Gm-Features: Ac12FXwJDne2U_uypWHXSERpQqcjDZbGD9-KbR-X_vEvKvqCZukJ-rXMkPA70mg
Message-ID: <CABBYNZ+ahsB921P2_c++PsKd+iL1MO5-Yei-sfqf4xWLn=w=Cw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] Remove android support
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Jul 7, 2025 at 11:06=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Luiz,
>
>
> Thank you for your patch.
>
> Am 02.07.25 um 21:26 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>
>
> Could you please elaborate, why this is removed? It doesn=E2=80=99t work =
and is
> unmaintained?

It is unmaintained, it should be easy to tell given how long it hasn't
receive any update.

>
> Kind regards,
>
> Paul
>
>
> > ---
> >   Makefile.am                        |    2 -
> >   android/Android.mk                 |  857 ----
> >   android/Makefile.am                |  327 --
> >   android/README                     |  454 --
> >   android/a2dp-sink.c                |   71 -
> >   android/a2dp-sink.h                |   12 -
> >   android/a2dp.c                     | 1762 -------
> >   android/a2dp.h                     |   12 -
> >   android/audio-ipc-api.txt          |   87 -
> >   android/audio-msg.h                |   69 -
> >   android/audio_utils/resampler.c    |  260 -
> >   android/audio_utils/resampler.h    |   99 -
> >   android/avctp.c                    | 1637 ------
> >   android/avctp.h                    |  170 -
> >   android/avdtp.c                    | 3476 -------------
> >   android/avdtp.h                    |  278 --
> >   android/avdtptest.c                |  897 ----
> >   android/avrcp-lib.c                | 3604 --------------
> >   android/avrcp-lib.h                |  343 --
> >   android/avrcp.c                    | 1161 -----
> >   android/avrcp.h                    |   15 -
> >   android/bluetooth.c                | 5505 --------------------
> >   android/bluetooth.h                |  102 -
> >   android/bluetoothd-snoop.c         |  242 -
> >   android/bluetoothd-wrapper.c       |   83 -
> >   android/bluetoothd.te              |   47 -
> >   android/bluetoothd_snoop.te        |   17 -
> >   android/client/haltest.c           |  467 --
> >   android/client/history.c           |   87 -
> >   android/client/history.h           |   10 -
> >   android/client/if-audio.c          |  525 --
> >   android/client/if-av-sink.c        |  129 -
> >   android/client/if-av.c             |  133 -
> >   android/client/if-bt.c             | 1013 ----
> >   android/client/if-gatt.c           | 2666 ----------
> >   android/client/if-hf-client.c      |  658 ---
> >   android/client/if-hf.c             | 1052 ----
> >   android/client/if-hh.c             |  444 --
> >   android/client/if-hl.c             |  367 --
> >   android/client/if-main.h           |  187 -
> >   android/client/if-mce.c            |   77 -
> >   android/client/if-pan.c            |  203 -
> >   android/client/if-rc-ctrl.c        |  104 -
> >   android/client/if-rc.c             |  390 --
> >   android/client/if-sco.c            |  805 ---
> >   android/client/if-sock.c           |  340 --
> >   android/client/pollhandler.c       |  106 -
> >   android/client/pollhandler.h       |   15 -
> >   android/client/tabcompletion.c     |  364 --
> >   android/client/terminal.c          |  813 ---
> >   android/client/terminal.h          |   51 -
> >   android/compat/readline/history.h  |   18 -
> >   android/compat/readline/readline.h |   97 -
> >   android/compat/wordexp.h           |   31 -
> >   android/cts.txt                    |   58 -
> >   android/cutils/properties.h        |   82 -
> >   android/gatt.c                     | 7474 ---------------------------=
-
> >   android/gatt.h                     |   30 -
> >   android/hal-a2dp-sink.c            |  152 -
> >   android/hal-a2dp.c                 |  154 -
> >   android/hal-audio-aptx.c           |  260 -
> >   android/hal-audio-sbc.c            |  418 --
> >   android/hal-audio.c                | 1632 ------
> >   android/hal-audio.h                |   91 -
> >   android/hal-avrcp-ctrl.c           |  135 -
> >   android/hal-avrcp.c                |  678 ---
> >   android/hal-bluetooth.c            | 1129 -----
> >   android/hal-gatt.c                 | 2093 --------
> >   android/hal-handsfree-client.c     |  642 ---
> >   android/hal-handsfree.c            |  882 ----
> >   android/hal-health.c               |  286 --
> >   android/hal-hidhost.c              |  393 --
> >   android/hal-ipc-api.txt            | 2737 ----------
> >   android/hal-ipc.c                  |  460 --
> >   android/hal-ipc.h                  |   22 -
> >   android/hal-log.h                  |   24 -
> >   android/hal-map-client.c           |  149 -
> >   android/hal-msg.h                  | 2322 ---------
> >   android/hal-pan.c                  |  200 -
> >   android/hal-sco.c                  | 1521 ------
> >   android/hal-socket.c               |   86 -
> >   android/hal-utils.c                |  408 --
> >   android/hal-utils.h                |  141 -
> >   android/hal.h                      |   43 -
> >   android/handsfree-client.c         | 2191 --------
> >   android/handsfree-client.h         |   12 -
> >   android/handsfree.c                | 3028 -----------
> >   android/handsfree.h                |   13 -
> >   android/hardware/audio.h           |  657 ---
> >   android/hardware/audio_effect.h    | 1000 ----
> >   android/hardware/bluetooth.h       |  540 --
> >   android/hardware/bt_av.h           |   93 -
> >   android/hardware/bt_gatt.h         |   51 -
> >   android/hardware/bt_gatt_client.h  |  407 --
> >   android/hardware/bt_gatt_server.h  |  186 -
> >   android/hardware/bt_gatt_types.h   |   46 -
> >   android/hardware/bt_hf.h           |  291 --
> >   android/hardware/bt_hf_client.h    |  353 --
> >   android/hardware/bt_hh.h           |  175 -
> >   android/hardware/bt_hl.h           |  113 -
> >   android/hardware/bt_mce.h          |   44 -
> >   android/hardware/bt_pan.h          |   77 -
> >   android/hardware/bt_rc.h           |  286 --
> >   android/hardware/bt_sock.h         |   48 -
> >   android/hardware/hardware.c        |  115 -
> >   android/hardware/hardware.h        |  217 -
> >   android/health.c                   | 2035 --------
> >   android/health.h                   |   12 -
> >   android/hidhost.c                  | 1586 ------
> >   android/hidhost.h                  |   12 -
> >   android/init.bluetooth.rc          |   38 -
> >   android/ipc-common.h               |   25 -
> >   android/ipc-tester.c               | 1501 ------
> >   android/ipc.c                      |  424 --
> >   android/ipc.h                      |   37 -
> >   android/log.c                      |  203 -
> >   android/main.c                     |  793 ---
> >   android/map-client.c               |  190 -
> >   android/map-client.h               |   13 -
> >   android/pan.c                      |  891 ----
> >   android/pan.h                      |   12 -
> >   android/pics-a2dp.txt              |  162 -
> >   android/pics-avctp.txt             |   75 -
> >   android/pics-avdtp.txt             |  236 -
> >   android/pics-avrcp.txt             |  644 ---
> >   android/pics-bnep.txt              |   26 -
> >   android/pics-did.txt               |   23 -
> >   android/pics-dis.txt               |   59 -
> >   android/pics-gap.txt               |  788 ---
> >   android/pics-gatt.txt              |  326 --
> >   android/pics-gavdp.txt             |   38 -
> >   android/pics-hdp.txt               |  307 --
> >   android/pics-hfp.txt               |  232 -
> >   android/pics-hid.txt               |  291 --
> >   android/pics-hogp.txt              |  409 --
> >   android/pics-hsp.txt               |  103 -
> >   android/pics-iopt.txt              |  223 -
> >   android/pics-l2cap.txt             |  178 -
> >   android/pics-map.txt               |  175 -
> >   android/pics-mcap.txt              |  141 -
> >   android/pics-mps.txt               |  337 --
> >   android/pics-opp.txt               |  187 -
> >   android/pics-pan.txt               |  152 -
> >   android/pics-pbap.txt              |  475 --
> >   android/pics-rfcomm.txt            |   65 -
> >   android/pics-scpp.txt              |  143 -
> >   android/pics-sdp.txt               |  140 -
> >   android/pics-sm.txt                |   96 -
> >   android/pics-spp.txt               |   99 -
> >   android/pixit-a2dp.txt             |   30 -
> >   android/pixit-avctp.txt            |   39 -
> >   android/pixit-avdtp.txt            |   31 -
> >   android/pixit-avrcp.txt            |   36 -
> >   android/pixit-bnep.txt             |   30 -
> >   android/pixit-did.txt              |   24 -
> >   android/pixit-dis.txt              |   26 -
> >   android/pixit-gap.txt              |   60 -
> >   android/pixit-gatt.txt             |   32 -
> >   android/pixit-gavdp.txt            |   32 -
> >   android/pixit-hdp.txt              |   32 -
> >   android/pixit-hfp.txt              |   41 -
> >   android/pixit-hid.txt              |   31 -
> >   android/pixit-hogp.txt             |   29 -
> >   android/pixit-hsp.txt              |   30 -
> >   android/pixit-iopt.txt             |   23 -
> >   android/pixit-l2cap.txt            |   59 -
> >   android/pixit-map.txt              |   44 -
> >   android/pixit-mcap.txt             |   37 -
> >   android/pixit-mps.txt              |   47 -
> >   android/pixit-opp.txt              |   27 -
> >   android/pixit-pan.txt              |   39 -
> >   android/pixit-pbap.txt             |   37 -
> >   android/pixit-rfcomm.txt           |   28 -
> >   android/pixit-scpp.txt             |   25 -
> >   android/pixit-sdp.txt              |   45 -
> >   android/pixit-sm.txt               |   72 -
> >   android/pixit-spp.txt              |   19 -
> >   android/pts-a2dp.txt               |   70 -
> >   android/pts-avctp.txt              |   43 -
> >   android/pts-avdtp.txt              |  237 -
> >   android/pts-avrcp.txt              |  242 -
> >   android/pts-bnep.txt               |   60 -
> >   android/pts-did.txt                |   20 -
> >   android/pts-dis.txt                |   40 -
> >   android/pts-gap.txt                |  432 --
> >   android/pts-gatt.txt               | 1422 ------
> >   android/pts-gavdp.txt              |   23 -
> >   android/pts-hdp.txt                |  296 --
> >   android/pts-hfp.txt                |  250 -
> >   android/pts-hid.txt                |   74 -
> >   android/pts-hogp.txt               |  102 -
> >   android/pts-hsp.txt                |   41 -
> >   android/pts-iopt.txt               |   26 -
> >   android/pts-l2cap.txt              |  191 -
> >   android/pts-map.txt                |   95 -
> >   android/pts-mcap.txt               |   80 -
> >   android/pts-mps.txt                |   60 -
> >   android/pts-opp.txt                |  119 -
> >   android/pts-pan.txt                |   71 -
> >   android/pts-pbap.txt               |  145 -
> >   android/pts-rfcomm.txt             |   38 -
> >   android/pts-scpp.txt               |   24 -
> >   android/pts-sdp.txt                |   77 -
> >   android/pts-sm.txt                 |  102 -
> >   android/pts-spp.txt                |   22 -
> >   android/sco-ipc-api.txt            |   37 -
> >   android/sco-msg.h                  |   27 -
> >   android/sco.c                      |  338 --
> >   android/sco.h                      |   38 -
> >   android/socket-api.txt             |   61 -
> >   android/socket.c                   | 1309 -----
> >   android/socket.h                   |   19 -
> >   android/system-emulator.c          |  239 -
> >   android/system/audio.h             | 1408 ------
> >   android/test-ipc.c                 |  564 ---
> >   android/tester-a2dp.c              |  239 -
> >   android/tester-avrcp.c             |  587 ---
> >   android/tester-bluetooth.c         | 1258 -----
> >   android/tester-gatt.c              | 3682 --------------
> >   android/tester-hdp.c               |  552 --
> >   android/tester-hidhost.c           |  722 ---
> >   android/tester-main.c              | 3375 -------------
> >   android/tester-main.h              |  788 ---
> >   android/tester-map-client.c        |  143 -
> >   android/tester-pan.c               |  229 -
> >   android/tester-socket.c            |  450 --
> >   android/utils.h                    |   31 -
> >   configure.ac                       |   16 -
> >   unit/test-avctp.c                  |    2 +-
> >   unit/test-avdtp.c                  |    2 +-
> >   unit/test-avrcp.c                  |    4 +-
> >   231 files changed, 4 insertions(+), 102811 deletions(-)
>
> [=E2=80=A6]



--=20
Luiz Augusto von Dentz

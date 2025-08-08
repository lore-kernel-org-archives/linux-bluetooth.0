Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C272E36E7
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664162; cv=none; b=H37CdrvXZIB3G/OKYU/S9g3NyiXZFBhMkvqhTop4IO1pkixIUxsj/N/VSMZGyhNUVUIdGKbXH50R5Sam7oToGQFpdj51rCCtOt5hJk8+aRU8B9OW2tjQ4B/kVeOel24XJmYJFiCcAI5C9RM6EaKdKRtZHiCYGJTh/zFQ6CIDtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664162; c=relaxed/simple;
	bh=Lbj3MXbYge06DnuOWc7rfackaHVoJbaCmfBJas/dpB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NBObim9u+80hx0FfQoiTiLATx3EbM96sjnlmsf2LSmFQvC3zwBpXvh9sj8L73DU7KKqmtGWOE3BsRLg+TRWvzQy++BQtRKndgUMjXEmaVbUhQWQQ/u05G5oZxHi97BTuKmpNkyDRwbZmlAqO+MDAs/jnG7e+ouLEHnkz0FeFS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B61WFfSP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B61WFfSP"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3326163941dso19132821fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Aug 2025 07:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664155; x=1755268955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxovy7/JTnBt+LHcmpGcKzG8hIY/SbkF7GJX0yuh/QE=;
        b=B61WFfSPkMJqATiGhaH4kmicYPr9TMr0cyxqsGODTbOWYFvqEbF9XzybAg10uEFQ93
         govfBSDMdiEaMhUVehsAsJNf1e4akcmZx/Wd2wz7r3SIztJCLVUqB83529E6ov+CAKym
         yEysSNyk8veyT88y7q+tReda1w42qJ3cg5Y91FStJRFyD1EztCY7aM4GwGCJaW8eftm+
         9ArRXXoDtpBF7x4m7IV/GXTUlRTqBez+5vrqy9MiXjsU8zS+nqu1z96cz+t2C80iB4CR
         LRN/joZQpyP3tAWmjTu6aVZHaYw0lsVST5BKI8IL7HBzR3f9nXEplZaS1AwZU39jcYtE
         meEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664155; x=1755268955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxovy7/JTnBt+LHcmpGcKzG8hIY/SbkF7GJX0yuh/QE=;
        b=Zi9Ksz3ApPXc3MvPqHxyQo9SSBjCB+rNQt0pR/pXW+OtMnBg0/cF6ZFvt/XaJR+usd
         PO0dn0Efk4lpKdNR1mZcKQgGSWUhtT5HpA1Jv302Yd6002qkWS7zQtsCJDYH2hBO6dyi
         lBPvZHfpAfAWnKLm5PxdL+hwMYYlyoUwg6t1dIsn9MOvEUriz6raFvgJqRDc0FXU2JjH
         knTc8wuOj0zoeizK7yI8PGE4paAOj05jaR4tQ0MOl4SPEUWl0sLqY7fwBt5RQT7vYgnj
         auoNLyR/su4ai6mf736sXJJyEQ9iApIE9aJXnBAuBLGx03vcJsry5p+BEX/payVCBDa6
         ggcw==
X-Gm-Message-State: AOJu0YwQiRf+LfWJVIgtdlnOfQ/tifoJrKdNCAjGqj6f61lzGKZ6XWo2
	7t90Bv2yAumWWyCIHLm+exhJ2LBRl2QfeXsRfWJk6xFL/4/unZagXy2fiwnalCD92iYFSDYYvBQ
	qA/JWiVTYnHbf+xvSCBt4T9tKQaTZ6Kfrj4y5
X-Gm-Gg: ASbGncvPaYxjE0H4TNi11wufEW6I+nxivY0CVSTKbBacO5VkxtiDOgLKxWnIEd8KG/Y
	eB6V043po9C7BtuaWVyAvnbkxIC/7xCRGLfBpxgC5UGWUKpLvH62PGWQMHUlkfsrAJNrZXPCx4w
	geeNsjYgUZ/rk4ucimBRKmYgprCt7EvriRJZtzXbrcAF1GHEhzluUz6RSlO7+Tg446d4mdT2x8/
	MCbUg==
X-Google-Smtp-Source: AGHT+IELBg2gOqRXvs3eHRwY8YDi803L3hk8Pnns6JFzZdaabdspbEzBnomZst5tAAe7+VItXg59fTdJ9jRwsEKGpfE=
X-Received: by 2002:a2e:bc04:0:b0:329:1550:1446 with SMTP id
 38308e7fff4ca-3338c913ff2mr21224281fa.0.1754664152965; Fri, 08 Aug 2025
 07:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807155115.1037982-1-hadess@hadess.net> <20250807155115.1037982-2-hadess@hadess.net>
In-Reply-To: <20250807155115.1037982-2-hadess@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Aug 2025 10:42:19 -0400
X-Gm-Features: Ac12FXzXYk7_I1bq7P3on4FLncxNLynDxqRk5UIPR4MaHovLxC5-dHIPlVH0K-s
Message-ID: <CABBYNZJbfk7GipDbox9KvP5SXWL-XYG2GGyojvH0UCzvbgucog@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/3] build: Move library source to lib/bluetooth
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Aug 7, 2025 at 11:51=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> This fixes the installed directory hierarchy not matching the source
> directory hierarchy.

Ok, but why do we need to do such a change? Doesn't meson handle
installing in a different directory? If it doesn't you can probably
state it or point to the documentation.

> ---
>  .gitignore                       |  1 -
>  Makefile.am                      | 25 ++++++++-----------------
>  attrib/att.c                     |  4 ++--
>  attrib/gatt.c                    |  6 +++---
>  attrib/gattrib.c                 |  4 ++--
>  attrib/gatttool.c                | 10 +++++-----
>  attrib/interactive.c             |  6 +++---
>  attrib/utils.c                   | 10 +++++-----
>  btio/btio.c                      | 10 +++++-----
>  client/assistant.c               |  4 ++--
>  client/mgmt.c                    | 14 +++++++-------
>  client/player.c                  |  6 +++---
>  emulator/b1ee.c                  |  4 ++--
>  emulator/btdev.c                 |  4 ++--
>  emulator/bthost.c                |  2 +-
>  emulator/bthost.h                |  2 +-
>  emulator/hciemu.c                |  4 ++--
>  emulator/le.c                    |  4 ++--
>  emulator/serial.c                |  4 ++--
>  emulator/server.c                |  4 ++--
>  emulator/smp.c                   |  4 ++--
>  emulator/vhci.c                  |  4 ++--
>  lib/{ =3D> bluetooth}/bluetooth.c  |  0
>  lib/{ =3D> bluetooth}/bluetooth.h  |  0
>  lib/{ =3D> bluetooth}/bnep.h       |  0
>  lib/{ =3D> bluetooth}/cmtp.h       |  0
>  lib/{ =3D> bluetooth}/hci.c        |  0
>  lib/{ =3D> bluetooth}/hci.h        |  0
>  lib/{ =3D> bluetooth}/hci_lib.h    |  0
>  lib/{ =3D> bluetooth}/hidp.h       |  0
>  lib/{ =3D> bluetooth}/iso.h        |  0
>  lib/{ =3D> bluetooth}/l2cap.h      |  0
>  lib/{ =3D> bluetooth}/mgmt.h       |  0
>  lib/{ =3D> bluetooth}/rfcomm.h     |  0
>  lib/{ =3D> bluetooth}/sco.h        |  0
>  lib/{ =3D> bluetooth}/sdp.c        |  0
>  lib/{ =3D> bluetooth}/sdp.h        |  0
>  lib/{ =3D> bluetooth}/sdp_lib.h    |  0
>  lib/{ =3D> bluetooth}/uuid.c       |  2 +-
>  lib/{ =3D> bluetooth}/uuid.h       |  0
>  mesh/main.c                      |  4 ++--
>  mesh/mesh-io-generic.c           |  4 ++--
>  mesh/mesh-io-mgmt.c              |  6 +++---
>  mesh/mesh-io.c                   |  4 ++--
>  mesh/mesh-mgmt.c                 |  4 ++--
>  monitor/a2dp.c                   |  2 +-
>  monitor/analyze.c                |  2 +-
>  monitor/att.c                    |  8 ++++----
>  monitor/avctp.c                  |  4 ++--
>  monitor/avdtp.c                  |  2 +-
>  monitor/bnep.c                   |  4 ++--
>  monitor/control.c                |  6 +++---
>  monitor/hcidump.c                |  6 +++---
>  monitor/intel.c                  |  4 ++--
>  monitor/l2cap.c                  |  4 ++--
>  monitor/msft.c                   |  4 ++--
>  monitor/packet.c                 |  8 ++++----
>  monitor/rfcomm.c                 |  4 ++--
>  monitor/sdp.c                    |  4 ++--
>  obexd/client/bluetooth.c         |  8 ++++----
>  obexd/client/map.c               |  2 +-
>  obexd/client/pbap.c              |  4 ++--
>  obexd/plugins/bluetooth.c        |  4 ++--
>  obexd/plugins/syncevolution.c    |  2 +-
>  peripheral/attach.c              |  6 +++---
>  peripheral/gap.c                 |  4 ++--
>  peripheral/gatt.c                |  6 +++---
>  plugins/admin.c                  |  4 ++--
>  plugins/autopair.c               |  4 ++--
>  plugins/hostname.c               |  4 ++--
>  plugins/neard.c                  |  6 +++---
>  plugins/policy.c                 |  8 ++++----
>  plugins/sixaxis.c                |  6 +++---
>  profiles/audio/a2dp.c            |  8 ++++----
>  profiles/audio/asha.c            |  6 +++---
>  profiles/audio/avctp.c           |  8 ++++----
>  profiles/audio/avdtp.c           |  8 ++++----
>  profiles/audio/avrcp.c           |  2 +-
>  profiles/audio/bap.c             | 10 +++++-----
>  profiles/audio/bass.c            |  6 +++---
>  profiles/audio/ccp.c             |  8 ++++----
>  profiles/audio/control.c         |  8 ++++----
>  profiles/audio/csip.c            |  8 ++++----
>  profiles/audio/mcp.c             |  8 ++++----
>  profiles/audio/media.c           |  8 ++++----
>  profiles/audio/micp.c            |  8 ++++----
>  profiles/audio/sink.c            |  4 ++--
>  profiles/audio/source.c          |  4 ++--
>  profiles/audio/transport.c       |  6 +++---
>  profiles/audio/vcp.c             |  8 ++++----
>  profiles/battery/bas.c           |  6 +++---
>  profiles/battery/battery.c       |  8 ++++----
>  profiles/cups/hcrp.c             |  8 ++++----
>  profiles/cups/main.c             |  6 +++---
>  profiles/cups/sdp.c              |  6 +++---
>  profiles/cups/spp.c              |  8 ++++----
>  profiles/deviceinfo/deviceinfo.c |  6 +++---
>  profiles/deviceinfo/dis.c        |  6 +++---
>  profiles/gap/gas.c               |  8 ++++----
>  profiles/health/hdp.c            |  6 +++---
>  profiles/health/hdp_manager.c    |  6 +++---
>  profiles/health/hdp_util.c       |  8 ++++----
>  profiles/health/mcap.c           |  2 +-
>  profiles/input/device.c          | 10 +++++-----
>  profiles/input/hog-lib.c         |  6 +++---
>  profiles/input/hog.c             |  6 +++---
>  profiles/input/manager.c         |  8 ++++----
>  profiles/input/server.c          |  6 +++---
>  profiles/midi/midi.c             |  6 +++---
>  profiles/network/bnep.c          |  8 ++++----
>  profiles/network/connection.c    |  8 ++++----
>  profiles/network/manager.c       |  8 ++++----
>  profiles/network/server.c        | 10 +++++-----
>  profiles/sap/manager.c           |  4 ++--
>  profiles/sap/server.c            |  6 +++---
>  profiles/scanparam/scan.c        |  6 +++---
>  profiles/scanparam/scpp.c        |  6 +++---
>  src/adapter.c                    |  4 ++--
>  src/adapter.h                    |  4 ++--
>  src/adv_monitor.c                |  4 ++--
>  src/advertising.c                |  6 +++---
>  src/agent.c                      |  4 ++--
>  src/battery.c                    |  2 +-
>  src/bearer.c                     |  4 ++--
>  src/device.c                     | 10 +++++-----
>  src/eir.c                        |  6 +++---
>  src/eir.h                        |  4 ++--
>  src/gatt-client.c                |  6 +++---
>  src/gatt-database.c              | 10 +++++-----
>  src/log.c                        |  4 ++--
>  src/main.c                       |  6 +++---
>  src/oui.c                        |  2 +-
>  src/plugin.c                     |  2 +-
>  src/profile.c                    |  8 ++++----
>  src/rfkill.c                     |  4 ++--
>  src/sdp-client.c                 |  6 +++---
>  src/sdp-xml.c                    |  4 ++--
>  src/sdpd-database.c              |  6 +++---
>  src/sdpd-request.c               |  8 ++++----
>  src/sdpd-server.c                |  8 ++++----
>  src/sdpd-service.c               |  6 +++---
>  src/service.c                    |  4 ++--
>  src/settings.c                   |  4 ++--
>  src/shared/ad.c                  |  4 ++--
>  src/shared/ad.h                  |  4 ++--
>  src/shared/asha.c                |  4 ++--
>  src/shared/att.c                 |  6 +++---
>  src/shared/bap.c                 |  4 ++--
>  src/shared/bass.c                |  4 ++--
>  src/shared/btp.c                 |  2 +-
>  src/shared/ccp.c                 |  6 +++---
>  src/shared/csip.c                |  4 ++--
>  src/shared/gap.c                 |  4 ++--
>  src/shared/gatt-client.c         |  4 ++--
>  src/shared/gatt-db.c             |  4 ++--
>  src/shared/gatt-helpers.c        |  4 ++--
>  src/shared/gatt-server.c         |  4 ++--
>  src/shared/log.c                 |  4 ++--
>  src/shared/mcp.c                 |  6 +++---
>  src/shared/mgmt.c                |  6 +++---
>  src/shared/micp.c                |  4 ++--
>  src/shared/tester.c              |  4 ++--
>  src/shared/util.c                |  2 +-
>  src/shared/vcp.c                 |  4 ++--
>  src/storage.c                    |  8 ++++----
>  src/uuid-helper.c                |  6 +++---
>  tools/advtest.c                  |  4 ++--
>  tools/avinfo.c                   |  8 ++++----
>  tools/avtest.c                   | 10 +++++-----
>  tools/bdaddr.c                   |  6 +++---
>  tools/bluetooth-player.c         |  4 ++--
>  tools/bnep-tester.c              |  6 +++---
>  tools/bneptest.c                 |  8 ++++----
>  tools/btattach.c                 |  6 +++---
>  tools/btgatt-client.c            | 10 +++++-----
>  tools/btgatt-server.c            | 10 +++++-----
>  tools/btiotest.c                 |  2 +-
>  tools/btmon-logger.c             |  4 ++--
>  tools/btpclient.c                |  2 +-
>  tools/btpclientctl.c             |  2 +-
>  tools/ciptool.c                  | 14 +++++++-------
>  tools/cltest.c                   |  8 ++++----
>  tools/hciattach.c                |  6 +++---
>  tools/hciattach_ath3k.c          |  6 +++---
>  tools/hciattach_bcm43xx.c        |  6 +++---
>  tools/hciattach_intel.c          |  6 +++---
>  tools/hciattach_qualcomm.c       |  6 +++---
>  tools/hciattach_st.c             |  2 +-
>  tools/hciattach_ti.c             |  6 +++---
>  tools/hciattach_tialt.c          |  6 +++---
>  tools/hciconfig.c                |  6 +++---
>  tools/hcidump.c                  |  4 ++--
>  tools/hcieventmask.c             |  6 +++---
>  tools/hcisecfilter.c             |  6 +++---
>  tools/hcitool.c                  |  6 +++---
>  tools/hwdb.c                     |  2 +-
>  tools/ioctl-tester.c             |  8 ++++----
>  tools/iso-tester.c               |  8 ++++----
>  tools/isotest.c                  | 10 +++++-----
>  tools/l2cap-tester.c             |  6 +++---
>  tools/l2ping.c                   |  8 ++++----
>  tools/l2test.c                   |  8 ++++----
>  tools/mcaptest.c                 |  8 ++++----
>  tools/mesh-gatt/gatt.c           |  4 ++--
>  tools/mesh-tester.c              | 10 +++++-----
>  tools/mesh/agent.c               |  2 +-
>  tools/meshctl.c                  |  4 ++--
>  tools/mgmt-tester.c              | 10 +++++-----
>  tools/oobtest.c                  |  4 ++--
>  tools/parser/hci.c               |  4 ++--
>  tools/parser/l2cap.c             |  2 +-
>  tools/parser/lmp.c               |  4 ++--
>  tools/parser/parser.h            |  2 +-
>  tools/rctest.c                   | 12 ++++++------
>  tools/rfcomm-tester.c            |  6 +++---
>  tools/rfcomm.c                   |  8 ++++----
>  tools/sco-tester.c               |  6 +++---
>  tools/scotest.c                  |  4 ++--
>  tools/sdptool.c                  | 10 +++++-----
>  tools/smp-tester.c               |  6 +++---
>  tools/test-runner.c              |  6 +++---
>  tools/userchan-tester.c          |  6 +++---
>  unit/avctp.c                     |  2 +-
>  unit/avdtp.c                     |  2 +-
>  unit/avrcp-lib.c                 |  2 +-
>  unit/avrcp.c                     |  6 +++---
>  unit/test-avrcp.c                |  2 +-
>  unit/test-bap.c                  |  4 ++--
>  unit/test-bass.c                 |  4 ++--
>  unit/test-eir.c                  |  6 +++---
>  unit/test-gatt.c                 |  4 ++--
>  unit/test-gattrib.c              |  4 ++--
>  unit/test-hog.c                  |  4 ++--
>  unit/test-lib.c                  |  4 ++--
>  unit/test-mgmt.c                 |  4 ++--
>  unit/test-micp.c                 |  4 ++--
>  unit/test-sdp.c                  |  6 +++---
>  unit/test-uuid.c                 |  4 ++--
>  unit/test-vcp.c                  |  4 ++--
>  239 files changed, 614 insertions(+), 624 deletions(-)
>  rename lib/{ =3D> bluetooth}/bluetooth.c (100%)
>  rename lib/{ =3D> bluetooth}/bluetooth.h (100%)
>  rename lib/{ =3D> bluetooth}/bnep.h (100%)
>  rename lib/{ =3D> bluetooth}/cmtp.h (100%)
>  rename lib/{ =3D> bluetooth}/hci.c (100%)
>  rename lib/{ =3D> bluetooth}/hci.h (100%)
>  rename lib/{ =3D> bluetooth}/hci_lib.h (100%)
>  rename lib/{ =3D> bluetooth}/hidp.h (100%)
>  rename lib/{ =3D> bluetooth}/iso.h (100%)
>  rename lib/{ =3D> bluetooth}/l2cap.h (100%)
>  rename lib/{ =3D> bluetooth}/mgmt.h (100%)
>  rename lib/{ =3D> bluetooth}/rfcomm.h (100%)
>  rename lib/{ =3D> bluetooth}/sco.h (100%)
>  rename lib/{ =3D> bluetooth}/sdp.c (100%)
>  rename lib/{ =3D> bluetooth}/sdp.h (100%)
>  rename lib/{ =3D> bluetooth}/sdp_lib.h (100%)
>  rename lib/{ =3D> bluetooth}/uuid.c (99%)
>  rename lib/{ =3D> bluetooth}/uuid.h (100%)
>
> diff --git a/.gitignore b/.gitignore
> index 155a65c5a5d5..d23a06af4b53 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -38,7 +38,6 @@ coverage
>  ell
>
>  lib/bluez.pc
> -lib/bluetooth
>  src/builtin.h
>  src/bluetoothd
>  tools/97-hid2hci.rules
> diff --git a/Makefile.am b/Makefile.am
> index fa1003a2f27d..94f625db4210 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -73,17 +73,15 @@ manual_pages =3D
>
>  plugin_LTLIBRARIES =3D
>
> -lib_sources =3D lib/bluetooth.c lib/hci.c lib/sdp.c
> -lib_headers =3D lib/bluetooth.h lib/hci.h lib/hci_lib.h \
> -               lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h \
> -               lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
> +lib_sources =3D lib/bluetooth/bluetooth.c lib/bluetooth/hci.c lib/blueto=
oth/sdp.c
> +lib_headers =3D lib/bluetooth/bluetooth.h lib/bluetooth/hci.h lib/blueto=
oth/hci_lib.h \
> +               lib/bluetooth/sco.h lib/bluetooth/l2cap.h lib/bluetooth/s=
dp.h lib/bluetooth/sdp_lib.h \
> +               lib/bluetooth/rfcomm.h lib/bluetooth/bnep.h lib/bluetooth=
/cmtp.h lib/bluetooth/hidp.h
>
> -extra_headers =3D lib/mgmt.h lib/uuid.h lib/iso.h
> -extra_sources =3D lib/uuid.c
> +extra_headers =3D lib/bluetooth/mgmt.h lib/bluetooth/uuid.h lib/bluetoot=
h/iso.h
> +extra_sources =3D lib/bluetooth/uuid.c
>
> -local_headers =3D $(foreach file,$(lib_headers), lib/bluetooth/$(notdir =
$(file)))
> -
> -BUILT_SOURCES =3D $(local_headers) $(ell_built_sources) src/builtin.h
> +BUILT_SOURCES =3D $(ell_built_sources) src/builtin.h
>
>  if LIBRARY
>  pkginclude_HEADERS +=3D $(lib_headers)
> @@ -517,7 +515,7 @@ EXTRA_DIST +=3D doc/btsnoop.txt
>
>  EXTRA_DIST +=3D tools/magic.btsnoop
>
> -AM_CPPFLAGS +=3D $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(builddir)/lib
> +AM_CPPFLAGS +=3D $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(srcdir)/lib
>
>  unit_tests +=3D unit/test-tester
>
> @@ -789,12 +787,6 @@ tools/%.rules:
>         $(AM_V_at)$(MKDIR_P) tools
>         $(AM_V_GEN)cp $(srcdir)/$(subst 97-,,$@) $@
>
> -$(lib_libbluetooth_la_OBJECTS): $(local_headers)
> -
> -lib/bluetooth/%.h: lib/%.h
> -       $(AM_V_at)$(MKDIR_P) lib/bluetooth
> -       $(AM_V_GEN)$(LN_S) -f $(abspath $<) $@
> -
>  ell/shared: Makefile
>         $(AM_V_at)$(MKDIR_P) ell
>         $(AM_V_GEN)for f in $(ell_shared) ; do \
> @@ -835,4 +827,3 @@ endif
>  clean-local: clean-coverage
>         -find $(top_builddir) -name "*.gcno" -delete
>         -find $(top_builddir) -name "*.gcda" -delete
> -       $(RM) -r lib/bluetooth
> diff --git a/attrib/att.c b/attrib/att.c
> index bf98fe2d8627..686674a9ac74 100644
> --- a/attrib/att.c
> +++ b/attrib/att.c
> @@ -19,8 +19,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "att.h"
> diff --git a/attrib/gatt.c b/attrib/gatt.c
> index 3cedae9d167a..71367c083fc4 100644
> --- a/attrib/gatt.c
> +++ b/attrib/gatt.c
> @@ -18,9 +18,9 @@
>
>  #include <glib.h>
>
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "att.h"
> diff --git a/attrib/gattrib.c b/attrib/gattrib.c
> index 1795cd3a72ff..3a988e131e94 100644
> --- a/attrib/gattrib.c
> +++ b/attrib/gattrib.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "btio/btio.h"
>  #include "src/log.h"
> diff --git a/attrib/gatttool.c b/attrib/gatttool.c
> index 4309d20b10b3..4fae9d41f44f 100644
> --- a/attrib/gatttool.c
> +++ b/attrib/gatttool.c
> @@ -19,11 +19,11 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "att.h"
> diff --git a/attrib/interactive.c b/attrib/interactive.c
> index c0262e87cd08..4329685c4f7a 100644
> --- a/attrib/interactive.c
> +++ b/attrib/interactive.c
> @@ -26,9 +26,9 @@
>  #include <readline/readline.h>
>  #include <readline/history.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "btio/btio.h"
> diff --git a/attrib/utils.c b/attrib/utils.c
> index 317331b4bacc..e48bf4ea5cd3 100644
> --- a/attrib/utils.c
> +++ b/attrib/utils.c
> @@ -16,11 +16,11 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "btio/btio.h"
>  #include "att.h"
> diff --git a/btio/btio.c b/btio/btio.c
> index 43275cb86e89..1a34927b2353 100644
> --- a/btio/btio.c
> +++ b/btio/btio.c
> @@ -25,11 +25,11 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/rfcomm.h"
> -#include "lib/sco.h"
> -#include "lib/iso.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/rfcomm.h"
> +#include "bluetooth/sco.h"
> +#include "bluetooth/iso.h"
>
>  #include "btio.h"
>
> diff --git a/client/assistant.c b/client/assistant.c
> index 88795cdd3cd3..5850b5827a7d 100644
> --- a/client/assistant.c
> +++ b/client/assistant.c
> @@ -26,8 +26,8 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/shell.h"
> diff --git a/client/mgmt.c b/client/mgmt.c
> index f1d607283da5..255155e41873 100644
> --- a/client/mgmt.c
> +++ b/client/mgmt.c
> @@ -29,15 +29,15 @@
>  #include <wordexp.h>
>  #include <ctype.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/uuid-helper.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "src/shared/mainloop.h"
>  #include "src/shared/io.h"
> diff --git a/client/player.c b/client/player.c
> index b8d7b68753b6..8e68fbcc054a 100644
> --- a/client/player.c
> +++ b/client/player.c
> @@ -32,9 +32,9 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> -#include "lib/iso.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/iso.h"
>
>  #include "profiles/audio/a2dp-codecs.h"
>  #include "src/shared/lc3.h"
> diff --git a/emulator/b1ee.c b/emulator/b1ee.c
> index 53b85f2216e3..9aeb8f2395c9 100644
> --- a/emulator/b1ee.c
> +++ b/emulator/b1ee.c
> @@ -26,8 +26,8 @@
>  #include <netdb.h>
>  #include <arpa/inet.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/mainloop.h"
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index 6833d4d51920..99e3e5cfa754 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -27,8 +27,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/timeout.h"
> diff --git a/emulator/bthost.c b/emulator/bthost.c
> index 52c5b0bede13..c85f751cc7a8 100644
> --- a/emulator/bthost.c
> +++ b/emulator/bthost.c
> @@ -22,7 +22,7 @@
>  #include <endian.h>
>  #include <stdbool.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
> diff --git a/emulator/bthost.h b/emulator/bthost.h
> index 0d8eca530190..743615838c25 100644
> --- a/emulator/bthost.h
> +++ b/emulator/bthost.h
> @@ -13,7 +13,7 @@
>  #include <stdint.h>
>  #include <sys/uio.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  typedef void (*bthost_send_func) (const struct iovec *iov, int iovlen,
>                                                         void *user_data);
> diff --git a/emulator/hciemu.c b/emulator/hciemu.c
> index a59773618823..3521e99948d7 100644
> --- a/emulator/hciemu.c
> +++ b/emulator/hciemu.c
> @@ -25,8 +25,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/vhci.h"
> diff --git a/emulator/le.c b/emulator/le.c
> index 7656a657cfc0..8ad0316118cc 100644
> --- a/emulator/le.c
> +++ b/emulator/le.c
> @@ -22,8 +22,8 @@
>  #include <sys/uio.h>
>  #include <time.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/crypto.h"
> diff --git a/emulator/serial.c b/emulator/serial.c
> index f8062ae5eac3..4f3781e405a1 100644
> --- a/emulator/serial.c
> +++ b/emulator/serial.c
> @@ -26,8 +26,8 @@
>  #include <sys/epoll.h>
>  #include <sys/uio.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/mainloop.h"
>  #include "btdev.h"
> diff --git a/emulator/server.c b/emulator/server.c
> index 84fc5956caa4..fa2bc07be4ce 100644
> --- a/emulator/server.c
> +++ b/emulator/server.c
> @@ -26,8 +26,8 @@
>  #include <netinet/in.h>
>  #include <arpa/inet.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/mainloop.h"
>  #include "btdev.h"
> diff --git a/emulator/smp.c b/emulator/smp.c
> index 2a36437a00c8..0b1733cc7e57 100644
> --- a/emulator/smp.c
> +++ b/emulator/smp.c
> @@ -22,8 +22,8 @@
>  #include <stdbool.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/crypto.h"
> diff --git a/emulator/vhci.c b/emulator/vhci.c
> index cab35354549e..22ca15796872 100644
> --- a/emulator/vhci.c
> +++ b/emulator/vhci.c
> @@ -25,8 +25,8 @@
>  #include <dirent.h>
>  #include <limits.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/io.h"
>  #include "monitor/bt.h"
> diff --git a/lib/bluetooth.c b/lib/bluetooth/bluetooth.c
> similarity index 100%
> rename from lib/bluetooth.c
> rename to lib/bluetooth/bluetooth.c
> diff --git a/lib/bluetooth.h b/lib/bluetooth/bluetooth.h
> similarity index 100%
> rename from lib/bluetooth.h
> rename to lib/bluetooth/bluetooth.h
> diff --git a/lib/bnep.h b/lib/bluetooth/bnep.h
> similarity index 100%
> rename from lib/bnep.h
> rename to lib/bluetooth/bnep.h
> diff --git a/lib/cmtp.h b/lib/bluetooth/cmtp.h
> similarity index 100%
> rename from lib/cmtp.h
> rename to lib/bluetooth/cmtp.h
> diff --git a/lib/hci.c b/lib/bluetooth/hci.c
> similarity index 100%
> rename from lib/hci.c
> rename to lib/bluetooth/hci.c
> diff --git a/lib/hci.h b/lib/bluetooth/hci.h
> similarity index 100%
> rename from lib/hci.h
> rename to lib/bluetooth/hci.h
> diff --git a/lib/hci_lib.h b/lib/bluetooth/hci_lib.h
> similarity index 100%
> rename from lib/hci_lib.h
> rename to lib/bluetooth/hci_lib.h
> diff --git a/lib/hidp.h b/lib/bluetooth/hidp.h
> similarity index 100%
> rename from lib/hidp.h
> rename to lib/bluetooth/hidp.h
> diff --git a/lib/iso.h b/lib/bluetooth/iso.h
> similarity index 100%
> rename from lib/iso.h
> rename to lib/bluetooth/iso.h
> diff --git a/lib/l2cap.h b/lib/bluetooth/l2cap.h
> similarity index 100%
> rename from lib/l2cap.h
> rename to lib/bluetooth/l2cap.h
> diff --git a/lib/mgmt.h b/lib/bluetooth/mgmt.h
> similarity index 100%
> rename from lib/mgmt.h
> rename to lib/bluetooth/mgmt.h
> diff --git a/lib/rfcomm.h b/lib/bluetooth/rfcomm.h
> similarity index 100%
> rename from lib/rfcomm.h
> rename to lib/bluetooth/rfcomm.h
> diff --git a/lib/sco.h b/lib/bluetooth/sco.h
> similarity index 100%
> rename from lib/sco.h
> rename to lib/bluetooth/sco.h
> diff --git a/lib/sdp.c b/lib/bluetooth/sdp.c
> similarity index 100%
> rename from lib/sdp.c
> rename to lib/bluetooth/sdp.c
> diff --git a/lib/sdp.h b/lib/bluetooth/sdp.h
> similarity index 100%
> rename from lib/sdp.h
> rename to lib/bluetooth/sdp.h
> diff --git a/lib/sdp_lib.h b/lib/bluetooth/sdp_lib.h
> similarity index 100%
> rename from lib/sdp_lib.h
> rename to lib/bluetooth/sdp_lib.h
> diff --git a/lib/uuid.c b/lib/bluetooth/uuid.c
> similarity index 99%
> rename from lib/uuid.c
> rename to lib/bluetooth/uuid.c
> index 9a216e7cef60..bd8d5c6b47c7 100644
> --- a/lib/uuid.c
> +++ b/lib/bluetooth/uuid.c
> @@ -17,7 +17,7 @@
>  #include <stdlib.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "uuid.h"
>
>  static uint128_t bluetooth_base_uuid =3D {
> diff --git a/lib/uuid.h b/lib/bluetooth/uuid.h
> similarity index 100%
> rename from lib/uuid.h
> rename to lib/bluetooth/uuid.h
> diff --git a/mesh/main.c b/mesh/main.c
> index 5b8af4bc7345..369daf88c656 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -24,8 +24,8 @@
>  #include <sys/stat.h>
>  #include <ell/ell.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "mesh/mesh.h"
>  #include "mesh/crypto.h"
> diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
> index f65de9d8d6de..df1450ebecc6 100644
> --- a/mesh/mesh-io-generic.c
> +++ b/mesh/mesh-io-generic.c
> @@ -22,8 +22,8 @@
>  #include "src/shared/ad.h"
>  #include "src/shared/hci.h"
>  #include "src/shared/mgmt.h"
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "mesh/mesh-defs.h"
>  #include "mesh/mesh-mgmt.h"
> diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
> index 30d3981bc14f..c1fd65421ae6 100644
> --- a/mesh/mesh-io-mgmt.c
> +++ b/mesh/mesh-io-mgmt.c
> @@ -20,9 +20,9 @@
>  #include <ell/ell.h>
>
>  #include "monitor/bt.h"
> -#include "lib/bluetooth.h"
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>  #include "src/shared/ad.h"
>  #include "src/shared/mgmt.h"
>
> diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
> index ec5feb9c2714..cbc59c36293c 100644
> --- a/mesh/mesh-io.c
> +++ b/mesh/mesh-io.c
> @@ -16,8 +16,8 @@
>
>  #include <ell/ell.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>  #include "src/shared/ad.h"
>  #include "src/shared/mgmt.h"
>
> diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
> index 87036d180fe0..5d4bb606b2ad 100644
> --- a/mesh/mesh-mgmt.c
> +++ b/mesh/mesh-mgmt.c
> @@ -16,8 +16,8 @@
>
>  #include <ell/ell.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>  #include "src/shared/mgmt.h"
>
>  #include "mesh/mesh-mgmt.h"
> diff --git a/monitor/a2dp.c b/monitor/a2dp.c
> index ae88f565ed4f..722bcb962ddf 100644
> --- a/monitor/a2dp.c
> +++ b/monitor/a2dp.c
> @@ -18,7 +18,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "src/shared/util.h"
>  #include "bt.h"
> diff --git a/monitor/analyze.c b/monitor/analyze.c
> index c466ff3ca85d..268ea10e29e6 100644
> --- a/monitor/analyze.c
> +++ b/monitor/analyze.c
> @@ -19,7 +19,7 @@
>  #include <sys/time.h>
>  #include <unistd.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/monitor/att.c b/monitor/att.c
> index 33d45e960bec..abcdf15a84af 100644
> --- a/monitor/att.c
> +++ b/monitor/att.c
> @@ -27,10 +27,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/monitor/avctp.c b/monitor/avctp.c
> index fda7ff1ffef6..874e217a7aff 100644
> --- a/monitor/avctp.c
> +++ b/monitor/avctp.c
> @@ -20,8 +20,8 @@
>  #include <ctype.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "bt.h"
> diff --git a/monitor/avdtp.c b/monitor/avdtp.c
> index 1393d1286445..d1eb15356602 100644
> --- a/monitor/avdtp.c
> +++ b/monitor/avdtp.c
> @@ -17,7 +17,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "src/shared/util.h"
>  #include "bt.h"
> diff --git a/monitor/bnep.c b/monitor/bnep.c
> index 3b8b284a921a..5cbda205dee8 100644
> --- a/monitor/bnep.c
> +++ b/monitor/bnep.c
> @@ -20,8 +20,8 @@
>  #include <ctype.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "bt.h"
> diff --git a/monitor/control.c b/monitor/control.c
> index 009cf15209f0..cb8e9fe731fb 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -30,9 +30,9 @@
>  #include <fcntl.h>
>  #include <linux/filter.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/btsnoop.h"
> diff --git a/monitor/hcidump.c b/monitor/hcidump.c
> index fac9c8a08511..a0219fec2820 100644
> --- a/monitor/hcidump.c
> +++ b/monitor/hcidump.c
> @@ -22,9 +22,9 @@
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/shared/mainloop.h"
>
> diff --git a/monitor/intel.c b/monitor/intel.c
> index a6e9cebe9daf..cd997d24b59c 100644
> --- a/monitor/intel.c
> +++ b/monitor/intel.c
> @@ -17,8 +17,8 @@
>  #include <stdio.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "display.h"
> diff --git a/monitor/l2cap.c b/monitor/l2cap.c
> index 8c47f8c89674..6380fec7ac4d 100644
> --- a/monitor/l2cap.c
> +++ b/monitor/l2cap.c
> @@ -19,8 +19,8 @@
>  #include <string.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/monitor/msft.c b/monitor/msft.c
> index 24b7bd55444c..054f34006734 100644
> --- a/monitor/msft.c
> +++ b/monitor/msft.c
> @@ -30,8 +30,8 @@
>  #include <stdio.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "display.h"
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 90a82b1af4ff..d259bf9e9a25 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -28,10 +28,10 @@
>  #include <sys/socket.h>
>  #include <limits.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/btsnoop.h"
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index a855152c69c3..b03f44fe90c9 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -20,8 +20,8 @@
>  #include <ctype.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "bt.h"
> diff --git a/monitor/sdp.c b/monitor/sdp.c
> index 5fe4f29796f3..9f97ba4bbea0 100644
> --- a/monitor/sdp.c
> +++ b/monitor/sdp.c
> @@ -19,8 +19,8 @@
>  #include <string.h>
>  #include <inttypes.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>
> diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
> index ca2c023fbbe3..96c69d856135 100644
> --- a/obexd/client/bluetooth.c
> +++ b/obexd/client/bluetooth.c
> @@ -18,10 +18,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/rfcomm.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/rfcomm.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "gdbus/gdbus.h"
>  #include "btio/btio.h"
> diff --git a/obexd/client/map.c b/obexd/client/map.c
> index ef0bff3ee0c7..955db9315e12 100644
> --- a/obexd/client/map.c
> +++ b/obexd/client/map.c
> @@ -21,7 +21,7 @@
>
>  #include <glib.h>
>
> -#include "lib/sdp.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gobex/gobex-apparam.h"
>  #include "gdbus/gdbus.h"
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 78c46bf86b12..0f575e61ed63 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gobex/gobex-apparam.h"
>  #include "gdbus/gdbus.h"
> diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> index 355921479111..3af1b504d591 100644
> --- a/obexd/plugins/bluetooth.c
> +++ b/obexd/plugins/bluetooth.c
> @@ -22,8 +22,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/obexd/plugins/syncevolution.c b/obexd/plugins/syncevolution.=
c
> index ae3dc48c4f2e..b257a3457a64 100644
> --- a/obexd/plugins/syncevolution.c
> +++ b/obexd/plugins/syncevolution.c
> @@ -21,7 +21,7 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/peripheral/attach.c b/peripheral/attach.c
> index f7dc7eceab3f..9438e4b49098 100644
> --- a/peripheral/attach.c
> +++ b/peripheral/attach.c
> @@ -17,9 +17,9 @@
>  #include <unistd.h>
>  #include <sys/ioctl.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>  #include "tools/hciattach.h"
>  #include "peripheral/attach.h"
>
> diff --git a/peripheral/gap.c b/peripheral/gap.c
> index b12e08b3d10a..28f82c5f0309 100644
> --- a/peripheral/gap.c
> +++ b/peripheral/gap.c
> @@ -15,8 +15,8 @@
>  #include <stdio.h>
>  #include <string.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>  #include "src/shared/util.h"
>  #include "src/shared/mgmt.h"
>  #include "peripheral/gatt.h"
> diff --git a/peripheral/gatt.c b/peripheral/gatt.c
> index 2c5e037b9f70..e3dd24632c12 100644
> --- a/peripheral/gatt.c
> +++ b/peripheral/gatt.c
> @@ -18,9 +18,9 @@
>  #include <string.h>
>  #include <sys/epoll.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/mainloop.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/plugins/admin.c b/plugins/admin.c
> index 16b74cfbf04d..6ab3cba56ec8 100644
> --- a/plugins/admin.c
> +++ b/plugins/admin.c
> @@ -19,8 +19,8 @@
>  #include <sys/stat.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/adapter.h"
>  #include "src/dbus-common.h"
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index 2274b5e2f897..721c86ee0c9d 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "src/plugin.h"
>  #include "src/adapter.h"
> diff --git a/plugins/hostname.c b/plugins/hostname.c
> index 51707f07dc5c..767114586bc1 100644
> --- a/plugins/hostname.c
> +++ b/plugins/hostname.c
> @@ -19,8 +19,8 @@
>  #include <fcntl.h>
>  #include <sys/utsname.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/plugins/neard.c b/plugins/neard.c
> index 99762482ce0f..c84934025cd8 100644
> --- a/plugins/neard.c
> +++ b/plugins/neard.c
> @@ -16,9 +16,9 @@
>  #include <stdlib.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/plugins/policy.c b/plugins/policy.c
> index 66f5c04ccb04..0e1ce5c9a6fc 100644
> --- a/plugins/policy.c
> +++ b/plugins/policy.c
> @@ -19,10 +19,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "src/log.h"
>  #include "src/plugin.h"
> diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
> index 1fab8ae59bcb..22dc634da0f8 100644
> --- a/plugins/sixaxis.c
> +++ b/plugins/sixaxis.c
> @@ -26,9 +26,9 @@
>  #include <glib.h>
>  #include <libudev.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/adapter.h"
>  #include "src/device.h"
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 8b0b16ff18c5..c0a53eae9a12 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -24,10 +24,10 @@
>  #include <dbus/dbus.h>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
> index a17b877d9bbe..e870ea06f03a 100644
> --- a/profiles/audio/asha.c
> +++ b/profiles/audio/asha.c
> @@ -27,9 +27,9 @@
>
>  #include "btio/btio.h"
>  #include "gdbus/gdbus.h"
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/dbus-common.h"
>  #include "src/adapter.h"
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 8ad146df106e..65eec6f6c227 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -29,10 +29,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/l2cap.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/uuid.h"
>
>  #include "btio/btio.h"
>  #include "src/adapter.h"
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index b849896a937f..30648251ff8c 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -23,10 +23,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "btio/btio.h"
>  #include "src/btd.h"
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index e2797112fcd5..5258b9aec112 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -33,7 +33,7 @@
>  #include "bluetooth/bluetooth.h"
>  #include "bluetooth/sdp.h"
>  #include "bluetooth/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 3dc4cd92e9ac..e77db5d442fd 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -30,11 +30,11 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> -#include "lib/iso.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/iso.h"
>
>  #include "src/btd.h"
>  #include "src/dbus-common.h"
> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
> index 87db130dafd1..055d51b8927e 100644
> --- a/profiles/audio/bass.c
> +++ b/profiles/audio/bass.c
> @@ -27,9 +27,9 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> -#include "lib/iso.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/iso.h"
>
>  #include "src/dbus-common.h"
>  #include "src/shared/util.h"
> diff --git a/profiles/audio/ccp.c b/profiles/audio/ccp.c
> index ae17a31f7ed3..8aa537b044e1 100644
> --- a/profiles/audio/ccp.c
> +++ b/profiles/audio/ccp.c
> @@ -28,10 +28,10 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/dbus-common.h"
>  #include "src/shared/util.h"
> diff --git a/profiles/audio/control.c b/profiles/audio/control.c
> index 619afc13d753..9847693e9084 100644
> --- a/profiles/audio/control.c
> +++ b/profiles/audio/control.c
> @@ -27,10 +27,10 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
> index a697ebdfbda0..b8f29ddf8522 100644
> --- a/profiles/audio/csip.c
> +++ b/profiles/audio/csip.c
> @@ -27,10 +27,10 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/dbus-common.h"
>  #include "src/shared/util.h"
> diff --git a/profiles/audio/mcp.c b/profiles/audio/mcp.c
> index 5fe7ef82a4e7..6651b0897e6f 100644
> --- a/profiles/audio/mcp.c
> +++ b/profiles/audio/mcp.c
> @@ -27,10 +27,10 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/dbus-common.h"
>  #include "src/shared/util.h"
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 8e62dca17070..5ad75544d643 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -31,10 +31,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/audio/micp.c b/profiles/audio/micp.c
> index 4f0bde1438ce..f1fb13389732 100644
> --- a/profiles/audio/micp.c
> +++ b/profiles/audio/micp.c
> @@ -27,10 +27,10 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/dbus-common.h"
>  #include "src/shared/util.h"
> diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
> index 7e02bcca1a01..81d5a3a6ba51 100644
> --- a/profiles/audio/sink.c
> +++ b/profiles/audio/sink.c
> @@ -20,8 +20,8 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/audio/source.c b/profiles/audio/source.c
> index b549ed114073..6be4de74e9a1 100644
> --- a/profiles/audio/source.c
> +++ b/profiles/audio/source.c
> @@ -21,8 +21,8 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 111d4b9b7ed1..2b9832a76a63 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -19,9 +19,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>  #include "btio/btio.h"
> diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
> index 423210b4af3b..8949c71858e5 100644
> --- a/profiles/audio/vcp.c
> +++ b/profiles/audio/vcp.c
> @@ -27,10 +27,10 @@
>
>  #include "gdbus/gdbus.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/dbus-common.h"
>  #include "src/shared/util.h"
> diff --git a/profiles/battery/bas.c b/profiles/battery/bas.c
> index 16ff22e1923a..ed38c3db1506 100644
> --- a/profiles/battery/bas.c
> +++ b/profiles/battery/bas.c
> @@ -19,9 +19,9 @@
>
>  #include "src/log.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
> index 2f5be48e91d7..050234a0fa03 100644
> --- a/profiles/battery/battery.c
> +++ b/profiles/battery/battery.c
> @@ -23,10 +23,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
> diff --git a/profiles/cups/hcrp.c b/profiles/cups/hcrp.c
> index 3038fe2f80ed..e243dd9f9d32 100644
> --- a/profiles/cups/hcrp.c
> +++ b/profiles/cups/hcrp.c
> @@ -20,10 +20,10 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "cups.h"
>
> diff --git a/profiles/cups/main.c b/profiles/cups/main.c
> index 144a0fd78e57..d56c942b939c 100644
> --- a/profiles/cups/main.c
> +++ b/profiles/cups/main.c
> @@ -25,9 +25,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
> index 81a26281c97d..5d83b8ea9cfb 100644
> --- a/profiles/cups/sdp.c
> +++ b/profiles/cups/sdp.c
> @@ -18,9 +18,9 @@
>  #include <signal.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "cups.h"
>
> diff --git a/profiles/cups/spp.c b/profiles/cups/spp.c
> index 6e910a722a8a..30879b95d238 100644
> --- a/profiles/cups/spp.c
> +++ b/profiles/cups/spp.c
> @@ -18,10 +18,10 @@
>  #include <signal.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/rfcomm.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/rfcomm.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "cups.h"
>
> diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/devic=
einfo.c
> index 0cdf2947e0a3..f5adb101e312 100644
> --- a/profiles/deviceinfo/deviceinfo.c
> +++ b/profiles/deviceinfo/deviceinfo.c
> @@ -17,9 +17,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/plugin.h"
>  #include "src/adapter.h"
> diff --git a/profiles/deviceinfo/dis.c b/profiles/deviceinfo/dis.c
> index f660179ed5f4..7cc722c526e1 100644
> --- a/profiles/deviceinfo/dis.c
> +++ b/profiles/deviceinfo/dis.c
> @@ -18,9 +18,9 @@
>
>  #include "src/log.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> index 26b5e1af4d07..dd45554d43eb 100644
> --- a/profiles/gap/gas.c
> +++ b/profiles/gap/gas.c
> @@ -23,10 +23,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
> diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
> index b6590cd3ac87..ac5023b067c6 100644
> --- a/profiles/health/hdp.c
> +++ b/profiles/health/hdp.c
> @@ -19,9 +19,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.=
c
> index 23c6a4926338..d1e627a3382a 100644
> --- a/profiles/health/hdp_manager.c
> +++ b/profiles/health/hdp_manager.c
> @@ -13,9 +13,9 @@
>
>  #include <stdbool.h>
>
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "btio/btio.h"
>  #include "src/adapter.h"
> diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
> index ad3702f01f45..267fdecdee59 100644
> --- a/profiles/health/hdp_util.c
> +++ b/profiles/health/hdp_util.c
> @@ -17,10 +17,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
> index 74fffa71a2d1..b7e51d15cdb5 100644
> --- a/profiles/health/mcap.c
> +++ b/profiles/health/mcap.c
> @@ -22,7 +22,7 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "bluetooth/l2cap.h"
>  #include "btio/btio.h"
>  #include "src/log.h"
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index f21a69f57529..02a9ad43d6fb 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -22,11 +22,11 @@
>  #include <sys/ioctl.h>
>  #include <sys/uio.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hidp.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hidp.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index dbf4dad96bc5..860c6e32d93b 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -27,9 +27,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/uhid.h"
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index a3c876cf9f2e..f5d24aad67e2 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -24,9 +24,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/log.h"
>  #include "src/adapter.h"
> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
> index 1c0b6122a10d..d0db13f2d3e9 100644
> --- a/profiles/input/manager.c
> +++ b/profiles/input/manager.c
> @@ -16,10 +16,10 @@
>  #include <stdbool.h>
>  #include <stdlib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/log.h"
>  #include "src/plugin.h"
> diff --git a/profiles/input/server.c b/profiles/input/server.c
> index c8be445c7306..97579152eae8 100644
> --- a/profiles/input/server.c
> +++ b/profiles/input/server.c
> @@ -19,9 +19,9 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/log.h"
>  #include "src/uuid-helper.h"
> diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
> index 2ca8fe87f2f0..90e00a5f5836 100644
> --- a/profiles/midi/midi.c
> +++ b/profiles/midi/midi.c
> @@ -15,9 +15,9 @@
>  #include <errno.h>
>  #include <alsa/asoundlib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/plugin.h"
>  #include "src/adapter.h"
> diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
> index 8d4786d4529b..6873f5378280 100644
> --- a/profiles/network/bnep.c
> +++ b/profiles/network/bnep.c
> @@ -26,10 +26,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/bnep.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/bnep.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/log.h"
>  #include "src/shared/timeout.h"
> diff --git a/profiles/network/connection.c b/profiles/network/connection.=
c
> index 74d9d894454c..81fee279f955 100644
> --- a/profiles/network/connection.c
> +++ b/profiles/network/connection.c
> @@ -21,9 +21,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/bnep.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/bnep.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> @@ -35,7 +35,7 @@
>  #include "src/profile.h"
>  #include "src/service.h"
>  #include "src/error.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/uuid.h"
>
>  #include "bnep.h"
>  #include "connection.h"
> diff --git a/profiles/network/manager.c b/profiles/network/manager.c
> index a2650d6f0b1f..51f382529df2 100644
> --- a/profiles/network/manager.c
> +++ b/profiles/network/manager.c
> @@ -17,10 +17,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/bnep.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/bnep.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/log.h"
>  #include "src/plugin.h"
> diff --git a/profiles/network/server.c b/profiles/network/server.c
> index ad2cd55bd398..03cfcb3fcfcf 100644
> --- a/profiles/network/server.c
> +++ b/profiles/network/server.c
> @@ -21,11 +21,11 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/bnep.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/bnep.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
> index 6670f397c94c..306472166c77 100644
> --- a/profiles/sap/manager.c
> +++ b/profiles/sap/manager.c
> @@ -12,8 +12,8 @@
>
>  #include <stdbool.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "src/log.h"
>  #include "src/adapter.h"
> diff --git a/profiles/sap/server.c b/profiles/sap/server.c
> index e6f3024ea666..c1f07701fcc1 100644
> --- a/profiles/sap/server.c
> +++ b/profiles/sap/server.c
> @@ -19,9 +19,9 @@
>  #include <errno.h>
>  #include <glib.h>
>
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
> index 739a9a46de1a..1c531773740c 100644
> --- a/profiles/scanparam/scan.c
> +++ b/profiles/scanparam/scan.c
> @@ -16,9 +16,9 @@
>  #include <stdbool.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/log.h"
>  #include "src/plugin.h"
> diff --git a/profiles/scanparam/scpp.c b/profiles/scanparam/scpp.c
> index 4be8b26cc505..e70d161c4dba 100644
> --- a/profiles/scanparam/scpp.c
> +++ b/profiles/scanparam/scpp.c
> @@ -20,9 +20,9 @@
>
>  #include "src/log.h"
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/src/adapter.c b/src/adapter.c
> index 5d68fa4c7dea..b771cf66ade3 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -34,8 +34,8 @@
>  #include "bluetooth/hci_lib.h"
>  #include "bluetooth/sdp.h"
>  #include "bluetooth/sdp_lib.h"
> -#include "lib/uuid.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/src/adapter.h b/src/adapter.h
> index 6b2bc28f6dad..ad81a10b1bb1 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -13,8 +13,8 @@
>  #include <dbus/dbus.h>
>  #include <glib.h>
>
> -#include <lib/bluetooth.h>
> -#include <lib/sdp.h>
> +#include <bluetooth/bluetooth.h>
> +#include <bluetooth/sdp.h>
>
>  #define ADAPTER_INTERFACE      "org.bluez.Adapter1"
>
> diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> index f24dcca1f20b..87fa824b35d8 100644
> --- a/src/adv_monitor.c
> +++ b/src/adv_monitor.c
> @@ -21,8 +21,8 @@
>  #include <dbus/dbus.h>
>  #include <gdbus/gdbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "adapter.h"
>  #include "btd.h"
> diff --git a/src/advertising.c b/src/advertising.c
> index cc30c1c85ef6..ebdefcdb0586 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -20,9 +20,9 @@
>  #include <dbus/dbus.h>
>  #include <gdbus/gdbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/sdp.h"
>
>  #include "adapter.h"
>  #include "dbus-common.h"
> diff --git a/src/agent.c b/src/agent.c
> index 7d66cf50d42d..c990dc368439 100644
> --- a/src/agent.c
> +++ b/src/agent.c
> @@ -23,8 +23,8 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/src/battery.c b/src/battery.c
> index 59e4fc570278..4c1ea79d922d 100644
> --- a/src/battery.c
> +++ b/src/battery.c
> @@ -18,7 +18,7 @@
>  #include <glib.h>
>
>  #include "gdbus/gdbus.h"
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>  #include "battery.h"
> diff --git a/src/bearer.c b/src/bearer.c
> index d4286b431583..9723b59e2e7b 100644
> --- a/src/bearer.c
> +++ b/src/bearer.c
> @@ -23,8 +23,8 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "gdbus/gdbus.h"
>  #include "src/shared/util.h"
> diff --git a/src/device.c b/src/device.c
> index 7e62112615e4..0179c3dab603 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -28,10 +28,10 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> @@ -45,7 +45,7 @@
>  #include "src/shared/ad.h"
>  #include "src/shared/timeout.h"
>  #include "btio/btio.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/mgmt.h"
>  #include "attrib/att.h"
>  #include "btd.h"
>  #include "adapter.h"
> diff --git a/src/eir.c b/src/eir.c
> index 1e1f769525c3..68ed74fe6493 100644
> --- a/src/eir.c
> +++ b/src/eir.c
> @@ -21,9 +21,9 @@
>  #include <stdbool.h>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
>
>  #include "src/shared/util.h"
>  #include "uuid-helper.h"
> diff --git a/src/eir.h b/src/eir.h
> index 2fe8cddf783d..b9f7c3874eb3 100644
> --- a/src/eir.h
> +++ b/src/eir.h
> @@ -11,8 +11,8 @@
>
>  #include <glib.h>
>
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #define EIR_FLAGS                   0x01  /* flags */
>  #define EIR_UUID16_SOME             0x02  /* 16-bit UUID, more available=
 */
> diff --git a/src/gatt-client.c b/src/gatt-client.c
> index 65308c0f7561..44ec95db06ad 100644
> --- a/src/gatt-client.c
> +++ b/src/gatt-client.c
> @@ -21,9 +21,9 @@
>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>  #include "btio/btio.h"
> diff --git a/src/gatt-database.c b/src/gatt-database.c
> index 434a4f96555e..eea3f600a8b0 100644
> --- a/src/gatt-database.c
> +++ b/src/gatt-database.c
> @@ -18,11 +18,11 @@
>  #include <unistd.h>
>  #include <limits.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/mgmt.h"
>  #include "btio/btio.h"
>  #include "gdbus/gdbus.h"
>  #include "src/shared/util.h"
> diff --git a/src/log.c b/src/log.c
> index ca8ae2d0e8fd..bf155132fb76 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -25,8 +25,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/log.h"
> diff --git a/src/main.c b/src/main.c
> index 3c51a0092425..a542d0fc50b0 100644
> --- a/src/main.c
> +++ b/src/main.c
> @@ -31,8 +31,8 @@
>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "gdbus/gdbus.h"
>  #include "btio/btio.h"
> @@ -45,7 +45,7 @@
>  #include "shared/timeout.h"
>  #include "shared/queue.h"
>  #include "shared/crypto.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/uuid.h"
>  #include "shared/util.h"
>  #include "btd.h"
>  #include "sdpd.h"
> diff --git a/src/oui.c b/src/oui.c
> index 7b3040fb07bd..e20297b938f8 100644
> --- a/src/oui.c
> +++ b/src/oui.c
> @@ -13,7 +13,7 @@
>  #endif
>
>  #define _GNU_SOURCE
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "oui.h"
>
>  #ifdef HAVE_UDEV
> diff --git a/src/plugin.c b/src/plugin.c
> index dcdb1b2dbf36..c0bb47810dad 100644
> --- a/src/plugin.c
> +++ b/src/plugin.c
> @@ -19,7 +19,7 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "btio/btio.h"
>  #include "src/plugin.h"
> diff --git a/src/profile.c b/src/profile.c
> index 8a25a97cc62b..66405d7e49e5 100644
> --- a/src/profile.c
> +++ b/src/profile.c
> @@ -21,10 +21,10 @@
>  #include <glib.h>
>  #include <dbus/dbus.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "gdbus/gdbus.h"
>
> diff --git a/src/rfkill.c b/src/rfkill.c
> index ac4a48d0a26a..04489e390522 100644
> --- a/src/rfkill.c
> +++ b/src/rfkill.c
> @@ -24,8 +24,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "log.h"
>  #include "adapter.h"
> diff --git a/src/sdp-client.c b/src/sdp-client.c
> index 71d3d9e95044..4f35cf1b7a8f 100644
> --- a/src/sdp-client.c
> +++ b/src/sdp-client.c
> @@ -16,9 +16,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "btio/btio.h"
>  #include "shared/timeout.h"
> diff --git a/src/sdp-xml.c b/src/sdp-xml.c
> index 5efa62ab8acd..30953144bdd6 100644
> --- a/src/sdp-xml.c
> +++ b/src/sdp-xml.c
> @@ -22,8 +22,8 @@
>
>  #include <glib.h>
>
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "sdp-xml.h"
>
> diff --git a/src/sdpd-database.c b/src/sdpd-database.c
> index 35617abec9d8..5f71a39eed54 100644
> --- a/src/sdpd-database.c
> +++ b/src/sdpd-database.c
> @@ -18,9 +18,9 @@
>  #include <stdlib.h>
>  #include <stdbool.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "sdpd.h"
>  #include "log.h"
> diff --git a/src/sdpd-request.c b/src/sdpd-request.c
> index c8f5a2c7271a..1fc07e97bfe0 100644
> --- a/src/sdpd-request.c
> +++ b/src/sdpd-request.c
> @@ -20,10 +20,10 @@
>  #include <limits.h>
>  #include <stdbool.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "src/shared/util.h"
>
> diff --git a/src/sdpd-server.c b/src/sdpd-server.c
> index 748cbeb6196b..31db93d6b41d 100644
> --- a/src/sdpd-server.c
> +++ b/src/sdpd-server.c
> @@ -25,10 +25,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "log.h"
>  #include "sdpd.h"
> diff --git a/src/sdpd-service.c b/src/sdpd-service.c
> index 012438558913..3f3b540186fa 100644
> --- a/src/sdpd-service.c
> +++ b/src/sdpd-service.c
> @@ -23,9 +23,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "src/shared/util.h"
>  #include "sdpd.h"
> diff --git a/src/service.c b/src/service.c
> index 7c4dc8fe0140..7690a126167d 100644
> --- a/src/service.c
> +++ b/src/service.c
> @@ -23,8 +23,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
>
>  #include "log.h"
>  #include "backtrace.h"
> diff --git a/src/settings.c b/src/settings.c
> index 37164939573f..3f92573af9e2 100644
> --- a/src/settings.c
> +++ b/src/settings.c
> @@ -16,8 +16,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "log.h"
>  #include "src/shared/queue.h"
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index 6952a0dabf6e..9e21cbf61a29 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -16,8 +16,8 @@
>
>  #include <ctype.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/ad.h"
>
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index 90cc82de9d63..7c5d94db0458 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -11,8 +11,8 @@
>  #include <inttypes.h>
>  #include <stdbool.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #define BT_AD_MAX_DATA_LEN             31
>  #define BT_EA_MAX_DATA_LEN             251
> diff --git a/src/shared/asha.c b/src/shared/asha.c
> index 69906fcc568e..79bb29bf9a0b 100644
> --- a/src/shared/asha.c
> +++ b/src/shared/asha.c
> @@ -19,8 +19,8 @@
>  #include <stdlib.h>
>  #include <string.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
> diff --git a/src/shared/att.c b/src/shared/att.c
> index c29e914c654a..77ca4aa24906 100644
> --- a/src/shared/att.c
> +++ b/src/shared/att.c
> @@ -20,9 +20,9 @@
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>  #include "src/shared/timeout.h"
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/att.h"
>  #include "src/shared/crypto.h"
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 8c186e6f1040..0af117be8295 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -16,8 +16,8 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/io.h"
>  #include "src/shared/queue.h"
> diff --git a/src/shared/bass.c b/src/shared/bass.c
> index 11ad59e3b2a6..f65e1eadca7f 100644
> --- a/src/shared/bass.c
> +++ b/src/shared/bass.c
> @@ -15,8 +15,8 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> diff --git a/src/shared/btp.c b/src/shared/btp.c
> index 04ccae9d81f1..9d1cec3adb78 100644
> --- a/src/shared/btp.c
> +++ b/src/shared/btp.c
> @@ -16,7 +16,7 @@
>
>  #include <ell/ell.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "src/shared/btp.h"
>
>  #define BTP_MTU 512
> diff --git a/src/shared/ccp.c b/src/shared/ccp.c
> index 8e1b0b58f93b..069c880b18c2 100644
> --- a/src/shared/ccp.c
> +++ b/src/shared/ccp.c
> @@ -15,9 +15,9 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> diff --git a/src/shared/csip.c b/src/shared/csip.c
> index a9c57c9bde4e..c5b77001a1aa 100644
> --- a/src/shared/csip.c
> +++ b/src/shared/csip.c
> @@ -17,8 +17,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> diff --git a/src/shared/gap.c b/src/shared/gap.c
> index 6fb1b7b6917d..98b80a1f24b6 100644
> --- a/src/shared/gap.c
> +++ b/src/shared/gap.c
> @@ -15,8 +15,8 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index 26b4d1c7cb1c..f6d5dc4b7c5e 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -13,8 +13,8 @@
>  #endif
>
>  #include "src/shared/att.h"
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/gatt-helpers.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
> index 61fac00445c7..b67bf89f9d5a 100644
> --- a/src/shared/gatt-db.c
> +++ b/src/shared/gatt-db.c
> @@ -15,8 +15,8 @@
>  #include <stdbool.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/timeout.h"
> diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
> index f1fa6300a16d..c1cbbdc91135 100644
> --- a/src/shared/gatt-helpers.c
> +++ b/src/shared/gatt-helpers.c
> @@ -15,8 +15,8 @@
>
>  #include "src/shared/queue.h"
>  #include "src/shared/att.h"
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/gatt-helpers.h"
>  #include "src/shared/util.h"
>
> diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
> index f8ed9a505bf0..27ae7e79ed3d 100644
> --- a/src/shared/gatt-server.c
> +++ b/src/shared/gatt-server.c
> @@ -17,8 +17,8 @@
>  #include <errno.h>
>
>  #include "src/shared/att.h"
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/queue.h"
>  #include "src/shared/gatt-db.h"
>  #include "src/shared/gatt-server.h"
> diff --git a/src/shared/log.c b/src/shared/log.c
> index 22b9850f6f11..8548954b07c8 100644
> --- a/src/shared/log.c
> +++ b/src/shared/log.c
> @@ -23,8 +23,8 @@
>  #include <signal.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/log.h"
> diff --git a/src/shared/mcp.c b/src/shared/mcp.c
> index 20a540a70bcc..3b03aff40918 100644
> --- a/src/shared/mcp.c
> +++ b/src/shared/mcp.c
> @@ -15,9 +15,9 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 4d7b64f2b1ab..a5335b978dcb 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -17,9 +17,9 @@
>  #include <string.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/io.h"
>  #include "src/shared/queue.h"
> diff --git a/src/shared/micp.c b/src/shared/micp.c
> index 1c34e9d0079f..98baff689fcc 100644
> --- a/src/shared/micp.c
> +++ b/src/shared/micp.c
> @@ -14,8 +14,8 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> diff --git a/src/shared/tester.c b/src/shared/tester.c
> index 62a14d0732c8..d1e872b8f3c4 100644
> --- a/src/shared/tester.c
> +++ b/src/shared/tester.c
> @@ -25,8 +25,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #ifdef HAVE_VALGRIND_MEMCHECK_H
>  #include <valgrind/memcheck.h>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index c2cf2bf72ab4..fabe4283094b 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -29,7 +29,7 @@
>  #include <sys/random.h>
>  #endif
>
> -#include <lib/bluetooth.h>
> +#include <bluetooth/bluetooth.h>
>
>  /* define MAX_INPUT for musl */
>  #ifndef MAX_INPUT
> diff --git a/src/shared/vcp.c b/src/shared/vcp.c
> index be002ad4cdac..b766faef6495 100644
> --- a/src/shared/vcp.c
> +++ b/src/shared/vcp.c
> @@ -15,8 +15,8 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> diff --git a/src/storage.c b/src/storage.c
> index 187ba156ce6c..356fa900f826 100644
> --- a/src/storage.c
> +++ b/src/storage.c
> @@ -27,10 +27,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/uuid.h"
>
>  #include "textfile.h"
>  #include "uuid-helper.h"
> diff --git a/src/uuid-helper.c b/src/uuid-helper.c
> index 640592fd2ace..598ec45ff27a 100644
> --- a/src/uuid-helper.c
> +++ b/src/uuid-helper.c
> @@ -19,9 +19,9 @@
>  #include <errno.h>
>  #include <arpa/inet.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "uuid-helper.h"
>
> diff --git a/tools/advtest.c b/tools/advtest.c
> index 9ef69ed5124a..8df6923d2f2e 100644
> --- a/tools/advtest.c
> +++ b/tools/advtest.c
> @@ -22,8 +22,8 @@
>
>  #include <getopt.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "src/shared/mainloop.h"
> diff --git a/tools/avinfo.c b/tools/avinfo.c
> index 2f68f53e76b5..1b2dca88b5b1 100644
> --- a/tools/avinfo.c
> +++ b/tools/avinfo.c
> @@ -27,10 +27,10 @@
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
>
>  #include "profiles/audio/a2dp-codecs.h"
>
> diff --git a/tools/avtest.c b/tools/avtest.c
> index c68d7b5a3e3f..04824f0f6d56 100644
> --- a/tools/avtest.c
> +++ b/tools/avtest.c
> @@ -22,11 +22,11 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/sdp.h"
>
>  #define AVDTP_PKT_TYPE_SINGLE          0x00
>  #define AVDTP_PKT_TYPE_START           0x01
> diff --git a/tools/bdaddr.c b/tools/bdaddr.c
> index de17416e9c6c..d69471e32fb2 100644
> --- a/tools/bdaddr.c
> +++ b/tools/bdaddr.c
> @@ -20,9 +20,9 @@
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/oui.h"
>
> diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
> index 63a95b878fb8..9a8abd0db5db 100644
> --- a/tools/bluetooth-player.c
> +++ b/tools/bluetooth-player.c
> @@ -26,8 +26,8 @@
>  #include <glib.h>
>
>  #include "gdbus/gdbus.h"
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/shell.h"
> diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
> index 5e4d7fb6df0f..2a9b843098f4 100644
> --- a/tools/bnep-tester.c
> +++ b/tools/bnep-tester.c
> @@ -20,9 +20,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/bnep.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/bnep.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/tools/bneptest.c b/tools/bneptest.c
> index c0c123f63614..7d82ee9edc71 100644
> --- a/tools/bneptest.c
> +++ b/tools/bneptest.c
> @@ -28,14 +28,14 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/log.h"
>  #include "src/shared/util.h"
>  #include "btio/btio.h"
> -#include "lib/bnep.h"
> +#include "bluetooth/bnep.h"
>  #include "profiles/network/bnep.h"
>
>  enum {
> diff --git a/tools/btattach.c b/tools/btattach.c
> index 4ce1be78d69c..5f7d19093698 100644
> --- a/tools/btattach.c
> +++ b/tools/btattach.c
> @@ -25,9 +25,9 @@
>  #include <sys/ioctl.h>
>  #include <poll.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>  #include "monitor/bt.h"
> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
> index f64d5bcf2d56..54a3cc8763f2 100644
> --- a/tools/btgatt-client.c
> +++ b/tools/btgatt-client.c
> @@ -21,11 +21,11 @@
>  #include <limits.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/mainloop.h"
>  #include "src/shared/util.h"
> diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
> index 9d05abd900c9..66523c1b3306 100644
> --- a/tools/btgatt-server.c
> +++ b/tools/btgatt-server.c
> @@ -21,11 +21,11 @@
>  #include <unistd.h>
>  #include <errno.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/mainloop.h"
>  #include "src/shared/util.h"
> diff --git a/tools/btiotest.c b/tools/btiotest.c
> index 75af90543950..f62248e32a8c 100644
> --- a/tools/btiotest.c
> +++ b/tools/btiotest.c
> @@ -23,7 +23,7 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "btio/btio.h"
>
> diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
> index a770ad575f0e..261d998a6664 100644
> --- a/tools/btmon-logger.c
> +++ b/tools/btmon-logger.c
> @@ -29,8 +29,8 @@
>
>  #include <linux/capability.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/mainloop.h"
> diff --git a/tools/btpclient.c b/tools/btpclient.c
> index d062e6d628eb..a140253d92a6 100644
> --- a/tools/btpclient.c
> +++ b/tools/btpclient.c
> @@ -21,7 +21,7 @@
>
>  #include <ell/ell.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "src/shared/btp.h"
>
>  #define AD_PATH "/org/bluez/advertising"
> diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
> index 1d89b51b55e9..72c54086d38b 100644
> --- a/tools/btpclientctl.c
> +++ b/tools/btpclientctl.c
> @@ -22,7 +22,7 @@
>  #include <fcntl.h>
>  #include <poll.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "src/shared/ad.h"
>  #include "src/shared/btp.h"
> diff --git a/tools/ciptool.c b/tools/ciptool.c
> index f26e3cc0b353..7ed8bba261f6 100644
> --- a/tools/ciptool.c
> +++ b/tools/ciptool.c
> @@ -24,13 +24,13 @@
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> -#include "lib/cmtp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
> +#include "bluetooth/cmtp.h"
>
>  static volatile sig_atomic_t __io_canceled =3D 0;
>
> diff --git a/tools/cltest.c b/tools/cltest.c
> index 250c93cc7a5c..35e7d82fa0e8 100644
> --- a/tools/cltest.c
> +++ b/tools/cltest.c
> @@ -23,10 +23,10 @@
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
>
>  #include "src/shared/mainloop.h"
>
> diff --git a/tools/hciattach.c b/tools/hciattach.c
> index adf79baf6ebd..8554375a3102 100644
> --- a/tools/hciattach.c
> +++ b/tools/hciattach.c
> @@ -31,9 +31,9 @@
>  #include <sys/param.h>
>  #include <sys/ioctl.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/shared/tty.h"
>
> diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
> index 5bd63582267d..0e4bbf04b193 100644
> --- a/tools/hciattach_ath3k.c
> +++ b/tools/hciattach_ath3k.c
> @@ -23,9 +23,9 @@
>  #include <sys/param.h>
>  #include <sys/ioctl.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
> index b89fc1b505f6..10af7daf41b5 100644
> --- a/tools/hciattach_bcm43xx.c
> +++ b/tools/hciattach_bcm43xx.c
> @@ -24,9 +24,9 @@
>  #include <time.h>
>  #include <limits.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciattach_intel.c b/tools/hciattach_intel.c
> index b68678991bf9..040fa56db0b8 100644
> --- a/tools/hciattach_intel.c
> +++ b/tools/hciattach_intel.c
> @@ -24,9 +24,9 @@
>  #include <sys/ioctl.h>
>  #include <time.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
> index d751f42b177e..fec0511004b0 100644
> --- a/tools/hciattach_qualcomm.c
> +++ b/tools/hciattach_qualcomm.c
> @@ -30,9 +30,9 @@
>  #include <sys/ioctl.h>
>  #include <sys/uio.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciattach_st.c b/tools/hciattach_st.c
> index def761305944..4eeee26e220d 100644
> --- a/tools/hciattach_st.c
> +++ b/tools/hciattach_st.c
> @@ -23,7 +23,7 @@
>  #include <dirent.h>
>  #include <sys/param.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
> index c0a0025ff888..e50d66c84a46 100644
> --- a/tools/hciattach_ti.c
> +++ b/tools/hciattach_ti.c
> @@ -26,9 +26,9 @@
>  #include <sys/param.h>
>  #include <sys/ioctl.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
> index bf6e84923386..ff8a3ce6a3ae 100644
> --- a/tools/hciattach_tialt.c
> +++ b/tools/hciattach_tialt.c
> @@ -29,9 +29,9 @@
>  #include <sys/ioctl.h>
>  #include <sys/uio.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "hciattach.h"
>
> diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> index a1c615bfa1f3..8653e930eabd 100644
> --- a/tools/hciconfig.c
> +++ b/tools/hciconfig.c
> @@ -27,9 +27,9 @@
>  #include <sys/socket.h>
>  #include <sys/stat.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/textfile.h"
>  #include "src/shared/util.h"
> diff --git a/tools/hcidump.c b/tools/hcidump.c
> index d517031dc6b7..db84aa384b2b 100644
> --- a/tools/hcidump.c
> +++ b/tools/hcidump.c
> @@ -30,8 +30,8 @@
>  #include "parser/parser.h"
>  #include "parser/sdp.h"
>
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #define SNAP_LEN       HCI_MAX_FRAME_SIZE
>
> diff --git a/tools/hcieventmask.c b/tools/hcieventmask.c
> index 0e7fe5fd71d4..682d4aaf81fe 100644
> --- a/tools/hcieventmask.c
> +++ b/tools/hcieventmask.c
> @@ -18,9 +18,9 @@
>  #include <getopt.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  static struct option main_options[] =3D {
>         { "device",     1, 0, 'i' },
> diff --git a/tools/hcisecfilter.c b/tools/hcisecfilter.c
> index 46cdbf381886..d4dea3d623ec 100644
> --- a/tools/hcisecfilter.c
> +++ b/tools/hcisecfilter.c
> @@ -16,9 +16,9 @@
>  #include <stdio.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  int main(int argc, char *argv[])
>  {
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index 639ee6a511fb..834f83e7a036 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -28,9 +28,9 @@
>  #include <sys/socket.h>
>  #include <signal.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "src/oui.h"
>
> diff --git a/tools/hwdb.c b/tools/hwdb.c
> index 4b37c753dd62..5d8c787eac3d 100644
> --- a/tools/hwdb.c
> +++ b/tools/hwdb.c
> @@ -14,7 +14,7 @@
>
>  #include <stdio.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  static const struct {
>         uint16_t vendor;
> diff --git a/tools/ioctl-tester.c b/tools/ioctl-tester.c
> index 098b58608500..cb283e1ec68b 100644
> --- a/tools/ioctl-tester.c
> +++ b/tools/ioctl-tester.c
> @@ -22,10 +22,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/tools/iso-tester.c b/tools/iso-tester.c
> index 7c0cfc408952..9cb963d45622 100644
> --- a/tools/iso-tester.c
> +++ b/tools/iso-tester.c
> @@ -24,10 +24,10 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/iso.h"
> -#include "lib/mgmt.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/iso.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/uuid.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/vhci.h"
> diff --git a/tools/isotest.c b/tools/isotest.c
> index 0f92b8970735..e3d2d63ce1ff 100644
> --- a/tools/isotest.c
> +++ b/tools/isotest.c
> @@ -35,11 +35,11 @@
>  #include <sys/wait.h>
>  #include <poll.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/mgmt.h"
> -#include "lib/iso.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/iso.h"
>
>  #include "src/shared/util.h"
>
> diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
> index f1eb79af1c97..c473c6cc6480 100644
> --- a/tools/l2cap-tester.c
> +++ b/tools/l2cap-tester.c
> @@ -20,9 +20,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/l2cap.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/l2cap.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/tools/l2ping.c b/tools/l2ping.c
> index c44ce872f94d..1a3f78af6642 100644
> --- a/tools/l2ping.c
> +++ b/tools/l2ping.c
> @@ -26,10 +26,10 @@
>  #include <poll.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
>
>  /* Defaults */
>  static bdaddr_t bdaddr;
> diff --git a/tools/l2test.c b/tools/l2test.c
> index 8c35d60cc818..5825314b9834 100644
> --- a/tools/l2test.c
> +++ b/tools/l2test.c
> @@ -30,10 +30,10 @@
>  #include <sys/ioctl.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/l2cap.h"
>
>  #include "src/shared/util.h"
>  #include "monitor/display.h"
> diff --git a/tools/mcaptest.c b/tools/mcaptest.c
> index dcef0b908ac8..c37d8cbb97da 100644
> --- a/tools/mcaptest.c
> +++ b/tools/mcaptest.c
> @@ -20,12 +20,12 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #include "btio/btio.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/l2cap.h"
>  #include "profiles/health/mcap.h"
>
>  enum {
> diff --git a/tools/mesh-gatt/gatt.c b/tools/mesh-gatt/gatt.c
> index ab9743cd10aa..ca49d58ec03e 100644
> --- a/tools/mesh-gatt/gatt.c
> +++ b/tools/mesh-gatt/gatt.c
> @@ -26,8 +26,8 @@
>  #include "src/shared/shell.h"
>  #include "src/shared/util.h"
>  #include "gdbus/gdbus.h"
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "tools/mesh-gatt/node.h"
>  #include "tools/mesh-gatt/util.h"
> diff --git a/tools/mesh-tester.c b/tools/mesh-tester.c
> index 848ccbe51a87..7c42dff76fb1 100644
> --- a/tools/mesh-tester.c
> +++ b/tools/mesh-tester.c
> @@ -23,11 +23,11 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/mgmt.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/l2cap.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/vhci.h"
> diff --git a/tools/mesh/agent.c b/tools/mesh/agent.c
> index ee0fade24d1d..7a62f345dac7 100644
> --- a/tools/mesh/agent.c
> +++ b/tools/mesh/agent.c
> @@ -17,7 +17,7 @@
>  #include <stdbool.h>
>  #include <inttypes.h>
>
> -#include <lib/bluetooth.h>
> +#include <bluetooth/bluetooth.h>
>
>  #include "src/shared/shell.h"
>  #include "tools/mesh/agent.h"
> diff --git a/tools/meshctl.c b/tools/meshctl.c
> index 152fc0139849..acc9ad4d72ff 100644
> --- a/tools/meshctl.c
> +++ b/tools/meshctl.c
> @@ -29,8 +29,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/shell.h"
>  #include "src/shared/util.h"
>  #include "gdbus/gdbus.h"
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index 35035827c47e..c066ad6c37b8 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -24,11 +24,11 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/mgmt.h"
> -#include "lib/l2cap.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/mgmt.h"
> +#include "bluetooth/l2cap.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/vhci.h"
> diff --git a/tools/oobtest.c b/tools/oobtest.c
> index eed765af02f8..c35b1ac41c69 100644
> --- a/tools/oobtest.c
> +++ b/tools/oobtest.c
> @@ -15,8 +15,8 @@
>
>  #include <getopt.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "src/shared/mainloop.h"
>  #include "src/shared/util.h"
> diff --git a/tools/parser/hci.c b/tools/parser/hci.c
> index 4af142c4a3bd..a2880860e116 100644
> --- a/tools/parser/hci.c
> +++ b/tools/parser/hci.c
> @@ -22,8 +22,8 @@
>  #include <string.h>
>
>  #include "parser.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  static uint16_t manufacturer =3D DEFAULT_COMPID;
>
> diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
> index abc1c77361b6..4ac0804ae6cb 100644
> --- a/tools/parser/l2cap.c
> +++ b/tools/parser/l2cap.c
> @@ -24,7 +24,7 @@
>  #include "parser.h"
>  #include "sdp.h"
>  #include "l2cap.h"
> -#include "lib/hci.h"
> +#include "bluetooth/hci.h"
>
>  typedef struct {
>         uint16_t handle;
> diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
> index 94b642896741..7707b4cb880b 100644
> --- a/tools/parser/lmp.c
> +++ b/tools/parser/lmp.c
> @@ -19,8 +19,8 @@
>  #include <sys/socket.h>
>
>  #include "parser.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>
>  #define LMP_U8(frm)  (p_get_u8(frm))
>  #define LMP_U16(frm) (btohs(htons(p_get_u16(frm))))
> diff --git a/tools/parser/parser.h b/tools/parser/parser.h
> index dcc0e9b96897..607da9c9a53c 100644
> --- a/tools/parser/parser.h
> +++ b/tools/parser/parser.h
> @@ -16,7 +16,7 @@
>  #include <sys/time.h>
>  #include <netinet/in.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "src/shared/util.h"
>
>  struct frame {
> diff --git a/tools/rctest.c b/tools/rctest.c
> index 7da2d8bebf8b..13b57a9e7c1f 100644
> --- a/tools/rctest.c
> +++ b/tools/rctest.c
> @@ -28,12 +28,12 @@
>  #include <sys/socket.h>
>  #include <sys/stat.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/rfcomm.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/rfcomm.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "src/shared/util.h"
>
> diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
> index b78b50537e4a..25b3a41e0f4f 100644
> --- a/tools/rfcomm-tester.c
> +++ b/tools/rfcomm-tester.c
> @@ -20,9 +20,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/rfcomm.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/rfcomm.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/tools/rfcomm.c b/tools/rfcomm.c
> index 0139fe69b9eb..13d24030c055 100644
> --- a/tools/rfcomm.c
> +++ b/tools/rfcomm.c
> @@ -28,10 +28,10 @@
>  #include <sys/socket.h>
>  #include <sys/wait.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/rfcomm.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/rfcomm.h"
>
>  static int rfcomm_raw_tty =3D 0;
>  static int auth =3D 0;
> diff --git a/tools/sco-tester.c b/tools/sco-tester.c
> index 2723cf1c6759..d2ab51b355ba 100644
> --- a/tools/sco-tester.c
> +++ b/tools/sco-tester.c
> @@ -19,9 +19,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sco.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sco.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/tools/scotest.c b/tools/scotest.c
> index e6a88770f624..04716d84f934 100644
> --- a/tools/scotest.c
> +++ b/tools/scotest.c
> @@ -25,8 +25,8 @@
>  #include <sys/time.h>
>  #include <sys/socket.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sco.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sco.h"
>
>  #include "src/shared/util.h"
>
> diff --git a/tools/sdptool.c b/tools/sdptool.c
> index 686d28362518..4e95a18d09bf 100644
> --- a/tools/sdptool.c
> +++ b/tools/sdptool.c
> @@ -26,11 +26,11 @@
>  #include <sys/socket.h>
>  #include <netinet/in.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "src/sdp-xml.h"
>
> diff --git a/tools/smp-tester.c b/tools/smp-tester.c
> index 16fe0dfd7aef..6c3de6451167 100644
> --- a/tools/smp-tester.c
> +++ b/tools/smp-tester.c
> @@ -20,9 +20,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index ae4e653e3502..4a63f0ec087d 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -31,9 +31,9 @@
>  #include <sys/param.h>
>  #include <sys/reboot.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/hci_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/hci_lib.h"
>  #include "tools/hciattach.h"
>
>  #ifndef WAIT_ANY
> diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
> index 095ef2689514..168b757c6ae8 100644
> --- a/tools/userchan-tester.c
> +++ b/tools/userchan-tester.c
> @@ -20,9 +20,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "monitor/bt.h"
>  #include "emulator/bthost.h"
> diff --git a/unit/avctp.c b/unit/avctp.c
> index d8104a7c2b45..8856daed989c 100644
> --- a/unit/avctp.c
> +++ b/unit/avctp.c
> @@ -30,7 +30,7 @@
>
>  #include <glib.h>
>
> -#include "lib/sdp.h"
> +#include "bluetooth/sdp.h"
>  #include "src/shared/util.h"
>  #include "src/log.h"
>  #include "avctp.h"
> diff --git a/unit/avdtp.c b/unit/avdtp.c
> index e0466853b7b5..c37764d10a2c 100644
> --- a/unit/avdtp.c
> +++ b/unit/avdtp.c
> @@ -26,7 +26,7 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>  #include "src/log.h"
>  #include "src/shared/util.h"
>  #include "src/shared/queue.h"
> diff --git a/unit/avrcp-lib.c b/unit/avrcp-lib.c
> index b342692cbbac..720775fd2603 100644
> --- a/unit/avrcp-lib.c
> +++ b/unit/avrcp-lib.c
> @@ -18,7 +18,7 @@
>  #include <errno.h>
>  #include <string.h>
>
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "src/shared/util.h"
>  #include "src/log.h"
> diff --git a/unit/avrcp.c b/unit/avrcp.c
> index fe092f02dd44..6eced0cc95d8 100644
> --- a/unit/avrcp.c
> +++ b/unit/avrcp.c
> @@ -18,9 +18,9 @@
>  #include <glib.h>
>
>  #include "btio/btio.h"
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>  #include "src/sdp-client.h"
>  #include "src/shared/util.h"
>  #include "src/log.h"
> diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
> index f18ab236e957..7bed8fbaf74a 100644
> --- a/unit/test-avrcp.c
> +++ b/unit/test-avrcp.c
> @@ -26,7 +26,7 @@
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
>  #include "src/log.h"
> -#include "lib/bluetooth.h"
> +#include "bluetooth/bluetooth.h"
>
>  #include "unit/avctp.h"
>  #include "unit/avrcp-lib.h"
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index a7a9448e7972..c15afe52dbbc 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -21,8 +21,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/io.h"
>  #include "src/shared/tester.h"
> diff --git a/unit/test-bass.c b/unit/test-bass.c
> index ace47d9edb8c..89835698e0a0 100644
> --- a/unit/test-bass.c
> +++ b/unit/test-bass.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/io.h"
>  #include "src/shared/tester.h"
> diff --git a/unit/test-eir.c b/unit/test-eir.c
> index b94a2985a07b..55967e957c82 100644
> --- a/unit/test-eir.c
> +++ b/unit/test-eir.c
> @@ -16,9 +16,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/hci.h"
> -#include "lib/sdp.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/hci.h"
> +#include "bluetooth/sdp.h"
>  #include "src/shared/tester.h"
>  #include "src/shared/util.h"
>  #include "src/shared/ad.h"
> diff --git a/unit/test-gatt.c b/unit/test-gatt.c
> index 1613fbcb5f21..535baafc6f70 100644
> --- a/unit/test-gatt.c
> +++ b/unit/test-gatt.c
> @@ -22,8 +22,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/att.h"
>  #include "src/shared/gatt-helpers.h"
> diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
> index 9c7dea09415f..81573dfde142 100644
> --- a/unit/test-gattrib.c
> +++ b/unit/test-gattrib.c
> @@ -23,8 +23,8 @@
>  #include <glib.h>
>
>  #include "src/shared/util.h"
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "attrib/att.h"
>  #include "attrib/gattrib.h"
>  #include "src/log.h"
> diff --git a/unit/test-hog.c b/unit/test-hog.c
> index a7cb5f0d3583..45ffe718e7de 100644
> --- a/unit/test-hog.c
> +++ b/unit/test-hog.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
> diff --git a/unit/test-lib.c b/unit/test-lib.c
> index 8395c2a73bfc..5cd43f82caab 100644
> --- a/unit/test-lib.c
> +++ b/unit/test-lib.c
> @@ -21,8 +21,8 @@
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
>
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  static void test_ntoh64(const void *data)
>  {
> diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
> index 1b71e562f0b9..691af79a4a2a 100644
> --- a/unit/test-mgmt.c
> +++ b/unit/test-mgmt.c
> @@ -18,8 +18,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/mgmt.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/mgmt.h"
>
>  #include "src/shared/mgmt.h"
>
> diff --git a/unit/test-micp.c b/unit/test-micp.c
> index 87fde8ed0e92..9c4f834e7164 100644
> --- a/unit/test-micp.c
> +++ b/unit/test-micp.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
>  #include "src/shared/queue.h"
> diff --git a/unit/test-sdp.c b/unit/test-sdp.c
> index 5c04a71ebfe6..4cb75289c356 100644
> --- a/unit/test-sdp.c
> +++ b/unit/test-sdp.c
> @@ -20,9 +20,9 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/sdp.h"
> -#include "lib/sdp_lib.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/sdp.h"
> +#include "bluetooth/sdp_lib.h"
>
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
> diff --git a/unit/test-uuid.c b/unit/test-uuid.c
> index 0889630cfb34..213f6d594376 100644
> --- a/unit/test-uuid.c
> +++ b/unit/test-uuid.c
> @@ -14,8 +14,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/tester.h"
>
>  struct uuid_test_data {
> diff --git a/unit/test-vcp.c b/unit/test-vcp.c
> index cd6d53c0121d..71c545656ed6 100644
> --- a/unit/test-vcp.c
> +++ b/unit/test-vcp.c
> @@ -20,8 +20,8 @@
>
>  #include <glib.h>
>
> -#include "lib/bluetooth.h"
> -#include "lib/uuid.h"
> +#include "bluetooth/bluetooth.h"
> +#include "bluetooth/uuid.h"
>  #include "src/shared/util.h"
>  #include "src/shared/tester.h"
>  #include "src/shared/queue.h"
> --
> 2.50.0
>
>


--=20
Luiz Augusto von Dentz

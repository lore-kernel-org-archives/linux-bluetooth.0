Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAC41BF23
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i70SKndx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B724C433F1;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705413639;
	bh=kh1sBC15ggrzL6V70nVyIyM9BK7L/wflKntRRL2THNU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=i70SKndxA8HWSC7kFe7RmbpnN7gDlVfJmyyN9By1vwBzLLZer57MDFLpKH2MRLQIh
	 wNQZBq7JKXev0aVBNhVjKEdhI75Rf816INwS62cE9oLGDjJRUPIHtTOaZbin3y9l20
	 3Ve/JEgquAvKEwHSjUdlm3/hpSr76bTa1RPhWOBPFsz7T+cRtinmf5NxVEpMe6Zx6y
	 6/749SJNAjCNcX5ShF8beG5PcewPhV30uiY/c3zid5zwoykiFqQ8hpsnV5Of0PQdiU
	 WRNBOmGwXuGA4mcTknZXpaZKxa1sX0GB4Se9056waHrRL3u1Y/gD1III9AhQ5/9++x
	 uanPGXWXJVIkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430B9C47DA2;
	Tue, 16 Jan 2024 14:00:39 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH BlueZ 00/20] Constify all the things
Date: Tue, 16 Jan 2024 14:00:25 +0000
Message-Id: <20240116-const-v1-0-17c87978f40b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmLpmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0Mz3eT8vOIS3aRkS8OUNFNLw1RLYyWg2oKi1LTMCrA50bG1tQClxl0
 wVwAAAA==
To: linux-bluetooth@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705413636; l=4292;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=kh1sBC15ggrzL6V70nVyIyM9BK7L/wflKntRRL2THNU=;
 b=MJhi6vOwX9bJyjH8ZmF0hzGRfofaGOHw4hdM8Zf/bMbdVfpztu8Mq5yI3Utws/NP5J4c7IHQ4
 uzzI+xIUTOZDItTxn0TpxA4cKx2b/epuNC0BuXGPbtgBt2zwOGwCwKT
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello list,

Here is series#2 of the paper cut fixes. Here we annotate a handful of
the data as constant alongside updating all the respective APIs.

There's nothing particularly existing or controversial here, despite the
size of the series. That said, I'm not 100% sure that all code-paths
have been (runtime) tested.

As always - any input will be appreciated.

Thanks
Emil

---
Emil Velikov (20):
      src: const annotate the bluetooth plugin API
      monitor: const annotate util_ltv_debugger instances and API
      monitor: const annotate cmd/handler tables
      monitor: const annotate misc arrays
      monitor: const annotate intel_version_tlv_desc::type_str and API
      monitor: const annotate type_table and related API
      profiles: annotate immutable data as const
      attrib: annotate immutable data as const
      client: annotate struct option instances as const
      emulator: const annotate rfcomm_crc_table[]
      gobex: const annotate RO arrays, use G_N_ELEMENTS
      lib: const annotate hci_map instances and related API
      lib: const annotate tupla instances and API
      mesh: const annotate misc data
      obexd: remove obex_mime_type_driver::set_io_watch
      obexd: const obex_mime_type_driver instances and API
      obexd: const obex_service_driver instances and API
      obexd: const obex_transport_driver instances and API
      obexd: const annotate misc immutable data
      obexd: const annotate obex_plugin_desc entrypoint

 attrib/gatttool.c               |  8 +++---
 attrib/interactive.c            |  2 +-
 client/mgmt.c                   | 42 ++++++++++++++++----------------
 emulator/bthost.c               |  2 +-
 gobex/gobex.c                   |  8 +++---
 lib/hci.c                       | 42 ++++++++++++++++----------------
 lib/hci_lib.h                   |  4 +--
 lib/sdp.c                       | 20 +++++++--------
 mesh/agent.c                    |  4 +--
 monitor/att.c                   | 54 ++++++++++++++++++++---------------------
 monitor/avctp.c                 |  2 +-
 monitor/intel.c                 | 28 ++++++++++-----------
 monitor/l2cap.c                 |  2 +-
 monitor/rfcomm.c                |  2 +-
 monitor/sdp.c                   | 10 ++++----
 obexd/client/manager.c          |  6 ++---
 obexd/client/map.c              |  4 +--
 obexd/client/mns.c              |  8 +++---
 obexd/plugins/bluetooth.c       |  6 ++---
 obexd/plugins/filesystem.c      |  8 +++---
 obexd/plugins/ftp.c             |  2 +-
 obexd/plugins/irmc.c            |  4 +--
 obexd/plugins/mas.c             | 18 +++++++-------
 obexd/plugins/opp.c             |  2 +-
 obexd/plugins/pbap.c            |  8 +++---
 obexd/plugins/pcsuite.c         |  4 +--
 obexd/plugins/phonebook-ebook.c |  2 +-
 obexd/plugins/syncevolution.c   |  4 +--
 obexd/src/genbuiltin            |  4 +--
 obexd/src/main.c                |  2 +-
 obexd/src/mimetype.c            | 26 +++++++-------------
 obexd/src/mimetype.h            | 12 +++++----
 obexd/src/obex-priv.h           |  4 +--
 obexd/src/obex.c                | 18 +++++++-------
 obexd/src/plugin.c              |  8 +++---
 obexd/src/plugin.h              |  4 +--
 obexd/src/server.c              | 10 ++++----
 obexd/src/server.h              |  2 +-
 obexd/src/service.c             | 20 +++++++--------
 obexd/src/service.h             |  6 ++---
 obexd/src/transport.c           | 14 +++++------
 obexd/src/transport.h           |  6 ++---
 profiles/audio/avctp.c          |  2 +-
 profiles/audio/avrcp.c          |  8 +++---
 profiles/audio/media.c          |  6 ++---
 profiles/audio/sink.c           |  2 +-
 profiles/audio/source.c         |  2 +-
 profiles/audio/transport.c      | 12 ++++-----
 profiles/health/hdp_util.c      | 15 ++++++------
 profiles/iap/main.c             |  2 +-
 src/genbuiltin                  |  4 +--
 src/log.c                       |  2 +-
 src/plugin.c                    |  6 ++---
 src/plugin.h                    |  6 ++---
 54 files changed, 251 insertions(+), 258 deletions(-)
---
base-commit: 770ad5614e7e8074133e6f563495ce4822f63fe4
change-id: 20240116-const-bc91df591e93

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>


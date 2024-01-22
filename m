Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113664C3B9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943624; cv=none; b=CLTxb6mvz7yL5fmjVW72HkAMGrAmy2/q4odjhETjSm5JqROgp6wNdqnX+aNAFNEa3Wo3L/CfEL5wVErC7oMfbPhk+mt89h6mTEyS4R7Pi8b8Km9R0XFhwerITgB0eWLgRwRjR0mFFrO1lZv+fs3kIZG5mnH1mMTlnNwaWlvs1aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943624; c=relaxed/simple;
	bh=TKbt3fdbuRyPTZUTuoN+M4xgojag5mfJsdAwoHGKgXk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JU6Dg1vFQavQKRbRxS/umYchkH7/+CJrtXR99a9MF99Hjmt745i+9+qUJ75ZvClf8x0OrKFF1sYSlFLLcTJB07ZlmDFNDDn9YwrTb+6ZGysPU00o88iYMvaQ5o6dy9tmZG9kxRskQiwTuW2CIaGyXQqcXcFKRWtkrlBU0vyPSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T6hD/Rw2; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T6hD/Rw2"
Received: from github.com (hubbernetes-node-f7c426e.ash1-iad.github.net [10.56.167.34])
	by smtp.github.com (Postfix) with ESMTPA id 0438A3412B9
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 09:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705943621;
	bh=RZIxuNkDsJc6d7KonjzNqFEjRt78hI2xrWnEN5OwY/U=;
	h=Date:From:To:Subject:From;
	b=T6hD/Rw2q9WFB5VVVEqsZrijbB5dY0ydBXFpexze8KkFzv7rLFvuJfXNUr+FojZQv
	 Bodi09DXJ+GJAZL3Fry3WCoAihlkeODwm0c4VWmbTUeK7AO7k/rWTl0ReKCm8cFbPg
	 ysGdk5Y5OTyzHHlOy11scUTmXHAf2i6YsQF41qlo=
Date: Mon, 22 Jan 2024 09:13:41 -0800
From: Emil Velikov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/2ef2f1-e0c64a@github.com>
Subject: [bluez/bluez] 00f1dd: src: const annotate the bluetooth plugin API
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
  Commit: 00f1ddfd8a16f01ba9b2ef9c7857fabe1ebd5340
      https://github.com/bluez/bluez/commit/00f1ddfd8a16f01ba9b2ef9c7857fabe1ebd5340
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M src/genbuiltin
    M src/log.c
    M src/plugin.c
    M src/plugin.h

  Log Message:
  -----------
  src: const annotate the bluetooth plugin API

The data was never mutable, so there's no API/ABI breakage here.


  Commit: 9a16b8bf7b4c19515d067485abb963447325a587
      https://github.com/bluez/bluez/commit/9a16b8bf7b4c19515d067485abb963447325a587
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: const annotate util_ltv_debugger instances and API


  Commit: 7ef54773240b901bbe8e331b74aca4312a960a62
      https://github.com/bluez/bluez/commit/7ef54773240b901bbe8e331b74aca4312a960a62
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: const annotate cmd/handler tables


  Commit: 4630f3fba0fc0f1a1c9d65271d600c9812393cbe
      https://github.com/bluez/bluez/commit/4630f3fba0fc0f1a1c9d65271d600c9812393cbe
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M monitor/att.c
    M monitor/avctp.c
    M monitor/intel.c
    M monitor/l2cap.c
    M monitor/rfcomm.c
    M monitor/sdp.c

  Log Message:
  -----------
  monitor: const annotate misc arrays


  Commit: 5380e63a80f2c0a9fa475275713287bb826c2300
      https://github.com/bluez/bluez/commit/5380e63a80f2c0a9fa475275713287bb826c2300
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M monitor/intel.c

  Log Message:
  -----------
  monitor: const annotate intel_version_tlv_desc::type_str and API


  Commit: f8e0270a7a73c46da1c35debbd97cd7dafc6a335
      https://github.com/bluez/bluez/commit/f8e0270a7a73c46da1c35debbd97cd7dafc6a335
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M monitor/sdp.c

  Log Message:
  -----------
  monitor: const annotate type_table and related API


  Commit: a078d13ab559639a45269c6c15adbe520bddaa8e
      https://github.com/bluez/bluez/commit/a078d13ab559639a45269c6c15adbe520bddaa8e
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M profiles/audio/avctp.c
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/sink.c
    M profiles/audio/source.c
    M profiles/audio/transport.c
    M profiles/health/hdp_util.c
    M profiles/iap/main.c

  Log Message:
  -----------
  profiles: annotate immutable data as const


  Commit: a8543fd2b062502a7d0c170b5286eb9fa7541cdd
      https://github.com/bluez/bluez/commit/a8543fd2b062502a7d0c170b5286eb9fa7541cdd
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M attrib/gatttool.c
    M attrib/interactive.c

  Log Message:
  -----------
  attrib: annotate immutable data as const


  Commit: 20864af937f35d5cf2b9195a080cbcc48f5a1044
      https://github.com/bluez/bluez/commit/20864af937f35d5cf2b9195a080cbcc48f5a1044
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client: annotate struct option instances as const


  Commit: 4d88fd2fabd6257869f7dc5fc2d7d1b08f879faf
      https://github.com/bluez/bluez/commit/4d88fd2fabd6257869f7dc5fc2d7d1b08f879faf
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  emulator: const annotate rfcomm_crc_table[]


  Commit: 0e5a4589773ba907bdcedc13dd959f73dc478fb9
      https://github.com/bluez/bluez/commit/0e5a4589773ba907bdcedc13dd959f73dc478fb9
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M gobex/gobex.c

  Log Message:
  -----------
  gobex: const annotate RO arrays, use G_N_ELEMENTS


  Commit: af552cd906a042a2b45c01dd898b6d8dbafa1768
      https://github.com/bluez/bluez/commit/af552cd906a042a2b45c01dd898b6d8dbafa1768
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M client/mgmt.c
    M lib/hci.c
    M lib/hci_lib.h

  Log Message:
  -----------
  lib: const annotate hci_map instances and related API


  Commit: c8b518daa928aa93c47dd24f48a5736d43c4c5fb
      https://github.com/bluez/bluez/commit/c8b518daa928aa93c47dd24f48a5736d43c4c5fb
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  lib: const annotate tupla instances and API


  Commit: a9393b2e9eec078e3eb6174c3ecde27119d15adf
      https://github.com/bluez/bluez/commit/a9393b2e9eec078e3eb6174c3ecde27119d15adf
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M mesh/agent.c

  Log Message:
  -----------
  mesh: const annotate misc data


  Commit: 8e88f8cecaa8cc8c38d9f5d2d1f2ee7fbb72235c
      https://github.com/bluez/bluez/commit/8e88f8cecaa8cc8c38d9f5d2d1f2ee7fbb72235c
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M obexd/src/mimetype.c
    M obexd/src/mimetype.h
    M obexd/src/obex.c

  Log Message:
  -----------
  obexd: remove obex_mime_type_driver::set_io_watch

All the drivers use the default function, where the register function
modifies what should be a constant vtable.

Instead let's remove the indirection, export and use the function as
applicable.

Since we have set and reset, export both functions and cleanup the
users.


  Commit: 0c3c674033a111fa3294ac735bdacccb4eb6576f
      https://github.com/bluez/bluez/commit/0c3c674033a111fa3294ac735bdacccb4eb6576f
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M obexd/client/mns.c
    M obexd/plugins/filesystem.c
    M obexd/plugins/irmc.c
    M obexd/plugins/mas.c
    M obexd/plugins/pbap.c
    M obexd/plugins/pcsuite.c
    M obexd/plugins/syncevolution.c
    M obexd/src/mimetype.c
    M obexd/src/mimetype.h
    M obexd/src/obex-priv.h

  Log Message:
  -----------
  obexd: const obex_mime_type_driver instances and API


  Commit: ae8f9c95606927283d3e16a075685908ae33d96e
      https://github.com/bluez/bluez/commit/ae8f9c95606927283d3e16a075685908ae33d96e
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M obexd/client/mns.c
    M obexd/plugins/bluetooth.c
    M obexd/plugins/ftp.c
    M obexd/plugins/irmc.c
    M obexd/plugins/mas.c
    M obexd/plugins/opp.c
    M obexd/plugins/pbap.c
    M obexd/plugins/pcsuite.c
    M obexd/plugins/syncevolution.c
    M obexd/src/obex-priv.h
    M obexd/src/server.c
    M obexd/src/service.c
    M obexd/src/service.h

  Log Message:
  -----------
  obexd: const obex_service_driver instances and API


  Commit: c968fe691d694e34c391b332a1b185bc650496bb
      https://github.com/bluez/bluez/commit/c968fe691d694e34c391b332a1b185bc650496bb
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M obexd/plugins/bluetooth.c
    M obexd/src/obex.c
    M obexd/src/server.c
    M obexd/src/server.h
    M obexd/src/transport.c
    M obexd/src/transport.h

  Log Message:
  -----------
  obexd: const obex_transport_driver instances and API


  Commit: ac1d2369b29a87bc9d033135eab817661f836cb6
      https://github.com/bluez/bluez/commit/ac1d2369b29a87bc9d033135eab817661f836cb6
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M obexd/client/manager.c
    M obexd/client/map.c
    M obexd/client/mns.c
    M obexd/plugins/phonebook-ebook.c
    M obexd/src/main.c
    M obexd/src/obex.c

  Log Message:
  -----------
  obexd: const annotate misc immutable data


  Commit: e0c64a2031e2a0b60b940aa3f2a939029e1578b2
      https://github.com/bluez/bluez/commit/e0c64a2031e2a0b60b940aa3f2a939029e1578b2
  Author: Emil Velikov <emil.velikov@collabora.com>
  Date:   2024-01-19 (Fri, 19 Jan 2024)

  Changed paths:
    M obexd/src/genbuiltin
    M obexd/src/plugin.c
    M obexd/src/plugin.h

  Log Message:
  -----------
  obexd: const annotate obex_plugin_desc entrypoint


Compare: https://github.com/bluez/bluez/compare/2ef2f122e608...e0c64a2031e2

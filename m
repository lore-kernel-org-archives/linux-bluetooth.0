Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4523BCEE
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834357; cv=none; b=KQL8jENxhl5+iwW5Rn+VyyzvuQwKKCXFz1HqBVUx5qsOB9XWQvodX2dxSfixNg6cr7reeLqksLWwjxbfzMJf35EdvrfVFX6WQTA0YAH8fc3JdjZUpCStXS+ihbGcxCRmg06KD8yEjHE5QkNJfaGIwUyQWlBqnf0iwmeRAexTYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834357; c=relaxed/simple;
	bh=d6LH4azfbQBU8OuIjPzfS8B6Hu/x7rfCcTXdsf+eZ9o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=heahNXV2B/izJsmTcmijgBt/z3cePfOVdUH1JmPhU1JXDPbGz0oZQVKo6J89uZD5mCQEtRhPqDHM9Y+ln8Mo4ixvRALvI/TR3aEAVJdt54P83wVFrGphjkaAfy/eYxT2VoTfy80KVi4wfCEgNEmx10kl5DbH54T9bUs4xhTrLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qvc7ElT+; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qvc7ElT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782834355;
	bh=rnpaNiZmzrkeHbTjlnwpsmdyxbZV4AXUarTrgEadT64=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qvc7ElT+HgQjPJzyEwugBIOPFjOBC6E21xEXU+joJuLsvCR5VIr41g/o4gMFuyonl
	 TuH3TSVdRnq1TgEtP7uW8Oe28+ePpRPqkT94oUcWcdbOFpht7Twp4O2p3J1/A0lbEG
	 Cmoe4+mtiBhbqJlGZlsvkBpTSZUCvVKsd64xqCsc=
Received: from github.com (hubbernetes-node-7579ddf.ac4-iad.github.net [10.52.169.31])
	by smtp.github.com (Postfix) with ESMTPA id 49A6478E8A2
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 08:45:55 -0700 (PDT)
Date: Tue, 30 Jun 2026 08:45:55 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1119059/000000-74a305@github.com>
Subject: [bluez/bluez] fee356: shared: remove default settings params from
 bt_rap...
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

  Branch: refs/heads/1119059
  Home:   https://github.com/bluez/bluez
  Commit: fee3563b14f36116bdc4b1dd3bb827ff5113ebc2
      https://github.com/bluez/bluez/commit/fee3563b14f36116bdc4b1dd3bb827ff5113ebc2
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: remove default settings params from bt_rap_attach_hci

role, cs_sync_ant_sel and max_tx_power were passed into bt_rap_attach_hci
but these are CS default settings that belong to the measurement session,
Callers need to set them via bt_rap_set_default_settings_params() in
start_measurement where they belong, alongside the other per-session
CS parameters


  Commit: 810a55beb6a01886ae9b80304d2778637032e677
      https://github.com/bluez/bluez/commit/810a55beb6a01886ae9b80304d2778637032e677
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: update bt_rap_attach_hci call to drop def settings

role, cs_sync_ant_sel and max_tx_power are no longer passed at attach
time. They are applied via bt_rap_set_default_settings_params() in
start_measurement where they belong, alongside the other per-session
CS parameters


  Commit: 7e04dff983faf194a6bf3cde42a73eb538d98e73
      https://github.com/bluez/bluez/commit/7e04dff983faf194a6bf3cde42a73eb538d98e73
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  rap: remove CS default settings from main.conf

role, cs_sync_ant_sel and max_tx_power were configurable in main.conf
and parsed in main.c, but these are per-measurement parameters that
callers supply via StartMeasurement


  Commit: 6a8079c039cc12db471ef2d722f345b9842d6015
      https://github.com/bluez/bluez/commit/6a8079c039cc12db471ef2d722f345b9842d6015
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: replace the wrapper API

Replace API bt_rap_attach_hci_v2 with
bt_rap_attach_hci which has less parameters
to avoid compilation error for individual patches


  Commit: 7441d315e80ffe498e61f618d7d5d5d280c2194a
      https://github.com/bluez/bluez/commit/7441d315e80ffe498e61f618d7d5d5d280c2194a
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: replace wrapper API

replace bt_rap_attach_hci_v2 with bt_rap_attach_hci API
which has less parameters to avoid compilation error
in individual patchsets


  Commit: 74a3059a93b9a31aaa08c2dc354638d54e89a8b6
      https://github.com/bluez/bluez/commit/74a3059a93b9a31aaa08c2dc354638d54e89a8b6
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: remove wrapper API

Remove bt_rap_attach_hci_v2 wrapper API
which was added to prevent compilation error
in individual patchsets


Compare: https://github.com/bluez/bluez/compare/fee3563b14f3%5E...74a3059a93b9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

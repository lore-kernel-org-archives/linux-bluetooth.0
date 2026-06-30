Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB7C2F8EA3
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819313; cv=none; b=R+kG9IQ7id4+ugsgLQzPvOe0ZJ+qfhiTILvL5cL2pvrue/PdViK983Ti0LkcgnTG+vyc3oNeyRvfwOMWfTPsJXkqK7kkcPJW1t9pBos8M7ojQe73L7gu72c/MWFjM3vDDyP5UPiV0RJiDt67TjIqB4iqBE2QzJ7hvxpgPPcqWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819313; c=relaxed/simple;
	bh=sE4NE2U8g+BEema2Ec/FnSH8mmBpGlxAbtrP7yBcZdU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IcFwdSqYHLcHfvPowortI69ARN4jz17rzcvO7yHLtnwNIQsoSjemPn4gC0gfbJBHPRDugi0B0l7xAobjNDMc04yHbk4WySYUV7+AJplYcsR6IpWtnEQF0kBebv2aQhnpl/LPWpUWcjVZYViQZLmdjhE/PAjCOhjiLnBntc3Xqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PteaLd+Z; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PteaLd+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782819310;
	bh=xUC6ojuX7X141ZxhaVBjHo+ZKZt9LFgQcLqmM9lQpAY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PteaLd+ZuarK8GkVxFKMCGrANziuVfzrJe13opVruOZtSfeNhGg9VfqHrjrRWMUTd
	 oqaK2VySACMMmfZQk14VhzpNlEUlq/q6bwgcFtTxLdBR88cUYXTR87c6LHZJH8W54L
	 A9q/bboDwPPfwnDduyAVLUG5MVnI6b/yaJMN0slQ=
Received: from github.com (hubbernetes-node-e1ae6ae.ash1-iad.github.net [10.56.164.42])
	by smtp.github.com (Postfix) with ESMTPA id AAD148494EC
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jun 2026 04:35:10 -0700 (PDT)
Date: Tue, 30 Jun 2026 04:35:10 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1118869/000000-9d4da6@github.com>
Subject: [bluez/bluez] 801a5c: shared: remove default settings params from
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

  Branch: refs/heads/1118869
  Home:   https://github.com/bluez/bluez
  Commit: 801a5c4d9c6fe13bf6e73e04a3b40c5a8fad7c8d
      https://github.com/bluez/bluez/commit/801a5c4d9c6fe13bf6e73e04a3b40c5a8fad7c8d
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


  Commit: 66fd6c144600296a291bf54be58b9baa110d9e62
      https://github.com/bluez/bluez/commit/66fd6c144600296a291bf54be58b9baa110d9e62
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-30 (Tue, 30 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: update bt_rap_attach_hci call to drop default settings args

role, cs_sync_ant_sel and max_tx_power are no longer passed at attach
time. They are applied via bt_rap_set_default_settings_params() in
start_measurement where they belong, alongside the other per-session
CS parameters


  Commit: af7b71cf565f5fcfc3c8302b6adc6c6aa215586d
      https://github.com/bluez/bluez/commit/af7b71cf565f5fcfc3c8302b6adc6c6aa215586d
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


  Commit: 15ba2adfd3d757bc88088854295242c3cea80e40
      https://github.com/bluez/bluez/commit/15ba2adfd3d757bc88088854295242c3cea80e40
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


  Commit: 88e942cc79b1fe19ec5f0ecd8325f09fdf10424d
      https://github.com/bluez/bluez/commit/88e942cc79b1fe19ec5f0ecd8325f09fdf10424d
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


  Commit: 9d4da6e27b6cc928ca041f31e514b4952fb0613b
      https://github.com/bluez/bluez/commit/9d4da6e27b6cc928ca041f31e514b4952fb0613b
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


Compare: https://github.com/bluez/bluez/compare/801a5c4d9c6f%5E...9d4da6e27b6c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

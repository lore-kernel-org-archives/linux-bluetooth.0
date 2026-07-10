Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006723B6370
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783672559; cv=none; b=axfY6vVe70lakTvg8JUFc0TaLYfuLmm6aJWlafHwogKD+/uQPqeSxHj6gBnRvPqqw7IhhslBWBtP2yKpfbTdsxZYFkxgcWT4+eTZixuE1ldqWUlSj9FotMq50zBOjJtYdrB/UZaw28XLCCHup4LEsH/ABdq+vwtNgTo8zz+V/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783672559; c=relaxed/simple;
	bh=CDXoyp6EBl6gcmR+Yk1wRWKkvJK+ggq1E+dMemJldT4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mIDjEG7HhJZWcPjXlQbl0ToaBTz4AMMhrCFL3jy7DCDQ4C3ceRiO1viKOTcAW0Jv89QTD2tn/71hD6JdBYlL0qVZeTKPhg9fMvc/+BLrAL22MvAIfEMv0bofN3J6pb56Xqxc8Dd5H1rJGPeclWqfAgBvwWzF50YGl2MJyo2lvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QB+LvUqe; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QB+LvUqe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783672557;
	bh=t1WPN+ZxDY7kiFCaAWADVPGnwb/07GMkrsLnSwwenRM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QB+LvUqeqidaETTVAlTpmKmnOUuB6c0YPEoxmKC2uTC3exlyvB1/fMPqXU+T6vThn
	 8EfGKg6GwYArCr95sjxlY3NA6PLDvuzxfYAxWZ27LZ0ObnTQ1ZRulcrg37UK7R+lCt
	 p3KK3MJ4X1Eg1pOlOacWFJVhIDneENl4NtYdPaSk=
Received: from github.com (hubbernetes-node-94d846a.ac4-iad.github.net [10.52.222.83])
	by smtp.github.com (Postfix) with ESMTPA id 2CEA1A0C86
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 01:35:57 -0700 (PDT)
Date: Fri, 10 Jul 2026 01:35:57 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125185/000000-c90ff7@github.com>
Subject: [bluez/bluez] dda6a6: rap: Add Channel Sounding parameter types and
 APIs
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

  Branch: refs/heads/1125185
  Home:   https://github.com/bluez/bluez
  Commit: dda6a66bf77cca529b8f11744370bf1b9f918515
      https://github.com/bluez/bluez/commit/dda6a66bf77cca529b8f11744370bf1b9f918515
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M Makefile.am
    A src/shared/cs-types.h
    M src/shared/rap.h

  Log Message:
  -----------
  rap: Add Channel Sounding parameter types and APIs

Add shared Channel Sounding parameter structures
(bt_rap_le_cs_config, bt_rap_le_cs_frequency and
bt_rap_le_cs_default_settings) for exchanging
CS configuration, frequency, and default settings
between the RAP DBus layer and HCI state machine.

Add getter/setter APIs for CS config, frequency
and default settings, add measurement.


  Commit: c90ff7c1ac6891fb9c027ea272875ae456d41453
      https://github.com/bluez/bluez/commit/c90ff7c1ac6891fb9c027ea272875ae456d41453
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  src: Register GATT profiles for Channel Sounding reflector

Probe and accept GATT_UUID profiles on non-initiator (reflector)
devices before gatt_client discovery checks,
ensuring RAP's org.bluez.ChannelSounding1 DBus interface is registered
even when GATT client discovery is skipped.


Compare: https://github.com/bluez/bluez/compare/dda6a66bf77c%5E...c90ff7c1ac68

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

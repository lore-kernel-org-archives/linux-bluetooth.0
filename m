Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77B52D8DB5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769167281; cv=none; b=H5CYPpW6Z/upFNBcjgGtSkJqfqop9133c64hfDG87l7Z7/b0vWmDo4KtxlN65R44E8sjXZVfEaooHu09mo5898hH2s9/NFlQ9hSKmXGgBr9p1MiN2HSlywPvJG65l98R+hZJ5Rmr8IOEPBITsbUYJK/8ufKqr4IB25sU9xTuUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769167281; c=relaxed/simple;
	bh=HFr9fb3YkuKYuwAGXK2S+DINUeHGEs528a/LrkJ5GNk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OXzm3WVS515nsxrySkRQnTts8w1+VnyUU/NFLazM2gsmGU/cTWdubqB+/QYdsFrQQku6fKI2Yd7c2+tFG4T+DBdehlMzfwj8r6/4Sflp8G4M+h/TQ5greERfk2IjQBiKn3M5XIbMBW28hHtOWvsI7j+MgxZpWYHrV6dfUFYWzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IQ5Suxy1; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IQ5Suxy1"
Received: from github.com (hubbernetes-node-1b21261.va3-iad.github.net [10.48.13.38])
	by smtp.github.com (Postfix) with ESMTPA id 2EF8C3C107A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 03:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769167279;
	bh=c65sm/7wmYsuC4OfpbrqBZ0+hWVLRmFdP2aw/EDbxPo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IQ5Suxy1yzF85zd5juNjIYA0+hDyGKNCTzTMYQuuHi+1qmB3RzMp20CtBqrCO4IFC
	 pd05jP3Ac5TMcS0Aw4GWC0mLUf9+DFh9xjdgRbZmvzTLAMZQ/XHJ+PObpeMVYSp0bH
	 f/ejiTDaLRKqRF0uScQOkXhGNuCW0Nowh6LDlhuQ=
Date: Fri, 23 Jan 2026 03:21:19 -0800
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046215/000000-cd6e34@github.com>
Subject: [bluez/bluez] cd6e34: monitor: Add support for Ranging Service (RAS)
 Imp...
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

  Branch: refs/heads/1046215
  Home:   https://github.com/bluez/bluez
  Commit: cd6e34b9c951dc1210c98ccb256fc99eef85d49e
      https://github.com/bluez/bluez/commit/cd6e34b9c951dc1210c98ccb256fc99eef85d49e
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-01-23 (Fri, 23 Jan 2026)

  Changed paths:
    M monitor/att.c
    M src/shared/util.c

  Log Message:
  -----------
  monitor: Add support for Ranging Service (RAS) Implement comprehensive decoding support for the Bluetooth Ranging Service (RAS) in the ATT monitor, including:

- RAS Features characteristic (0x2c14) with feature bitfield decoding
- Real-time and On-demand Ranging Data characteristics (0x2c15, 0x2c16)
  with segmentation header, ranging header, and subevent header parsing
- RAS Control Point (0x2c17) with command opcodes:
  * Get Ranging Data
  * ACK Ranging Data
  * Retrieve Lost Ranging Data Segments
  * Abort Operation
  * Set Filter
- RAS Ranging Data Ready (0x2c18) and Data Overwritten (0x2c19)
  notification characteristics

Also add RAS service and characteristic UUIDs to the shared UUID table.

This enables btmon to properly decode and display RAS protocol
operations for debugging and analysis of Bluetooth ranging
implementations.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

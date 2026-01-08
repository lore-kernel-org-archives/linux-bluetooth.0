Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0CE31B815
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767902069; cv=none; b=DRv2bam2zEimB5WcXv1LoD8fbMPCQSiP4nyY8muoDE0nQUENopMGjn65wXy9YJvhY2bSbMnZG8mfbto1CrQWTYtFZpY9aBjUPy0Ma6adHi38egSlJiyd72L3+KuYTHnJXv1lvi3MFkSIu9TjA2O4PO6HXTA8MPJ4WhN0ua476V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767902069; c=relaxed/simple;
	bh=UX7CIC5fxkgfKdgo8TsQP58+DW89JJQnvJiwaKUDfmI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iixoX9TvzxMAkCRuQcc0OwYDZ8pRLtTghAk16zzRrdtqd21TOSXbJY/e1TXFwmnmsFlhelejhlxsBWswGl6RVRTvKECADqhiIk2NKY9os7c84+vv0jXEPXHX7H0QEjcT+t9d7eLECBtYjogDR7Pl7LtogLexRH1StfiaIDcGZcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hEj/d5k2; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hEj/d5k2"
Received: from github.com (hubbernetes-node-a98aacb.va3-iad.github.net [10.48.209.107])
	by smtp.github.com (Postfix) with ESMTPA id 3E01E4E0E11
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767902067;
	bh=ZVN10YJMEy4x/3i0Id740+yRHLQhWpkpMC6+yOWlKPI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hEj/d5k2vGJ0Eg7dmqcfnvtEHortaP7Csbt2lbuc98VFc8wX0VfD8CRtdc3uH1tEl
	 ZrFE8iI3UVkYoc/LqYDLj32L26WQ0Y0YArDb/xVVPBCLX4MggdknACPLrLmkpqWXVe
	 mugdVDEO9boFMLD8RO0bBBEz3zXbe0KboamQ/3C4=
Date: Thu, 08 Jan 2026 11:54:27 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/561d4e-1287ac@github.com>
Subject: [bluez/bluez] 769335: transport: clean up volume set/get for A2DP and
 VCP
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
  Commit: 76933585dc4815fa7815df3903a21d9fa6431c34
      https://github.com/bluez/bluez/commit/76933585dc4815fa7815df3903a21d9fa6431c34
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M profiles/audio/avrcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h
    M profiles/audio/transport.c
    M profiles/audio/transport.h
    M profiles/audio/vcp.c
    M profiles/audio/vcp.h

  Log Message:
  -----------
  transport: clean up volume set/get for A2DP and VCP

Cleanup uuid comparisons in device transport volume set/get. These are
unnecessary because the transport->ops already do the equivalent check.

Use separate functions for set/get AVRCP volume, to avoid mixing up
AVRCP and VCP volumes.

For VCP send volume update notifications on all transports, since same
volume is listed on all.

To avoid interspersing #ifdefs for A2DP/VCP in this code, define dummy
functions in headers that behave accordingly.

Fix the bt_audio_vcp_get/set_volume to properly indicate when VCP is not
present.


  Commit: 1287ac9068b748cdb3c48260d0a4b93466f24784
      https://github.com/bluez/bluez/commit/1287ac9068b748cdb3c48260d0a4b93466f24784
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-07 (Wed, 07 Jan 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: distinguish BAP mic and playback volumes

BAP Unicast has two kinds of relevant volumes: playback and microphone.
Client Sink and Server Source generally correspond to microphone volume.
Broadcast Source and Sink do not have microphone volume.  Microphone
volumes shall use MICP, not VCP, but currently we confuse them.

Fix by distinguishing the VCP / MICP cases. The shared/micp
implementation is incomplete, so leave those volumes unimplemented also
in transport.

This fixes setting volume on microphone transport changing the playback
volume.


Compare: https://github.com/bluez/bluez/compare/561d4e815f28...1287ac9068b7

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

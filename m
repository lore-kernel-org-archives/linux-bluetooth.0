Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FE21991C9
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750593369; cv=none; b=NaWyU7T9I1kmlnvtjeyxiavTU4u/Y4SZmOh+dPy349qcmxO7SjCAgJ5pBGfJFZQ12t5ONXRv2ObPguHR/MyFV6X9dUAoP9nxrd6afIYCmxYYHK+sGLnOrr19bpXmUftPhaGF6QUR6/XdDY8egiOE/0HdaqzZylItOTftI3VNeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750593369; c=relaxed/simple;
	bh=86IwGc3sDqGbWvM/paHWMZafuxUGwJ+y0AT06J/+XA0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TrdqEr50VtBfy0+IKSOGaihNUlla58KVq/czFDHirrL3OO9P1NGLZ65+T8qDlcfZLTWrNEzXqdtxVLFVwJT/o2vw6GAQy60lPuxulzNimSCaWqpp42qNeeRpNHG4ioJrhhK5K+zJqfbeock1WGnXPUd5kbfHyE23VFZ9Q3mOLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=E4RAgyWE; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="E4RAgyWE"
Received: from github.com (hubbernetes-node-6e2ddfe.ash1-iad.github.net [10.56.166.38])
	by smtp.github.com (Postfix) with ESMTPA id DF0889203E5
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 04:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750593363;
	bh=eeF2M+MLkTk19IVz9Fo2gGLKNt2Cw119Lbu0oYfB6bk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=E4RAgyWEwJ0XIgQj1x5DFEfs3xOHLY7kMfPhGkYJtESkmvscpmuhj/Xcvd5g62AUc
	 YXAQu//6adg9+oY9kYovDt4l0nmyonLI7ugMbF6EdxbT2JBGCwq1WxdF0TspBLh6ZP
	 x7bTLVl5uT4VDk4Qg4LrSBOOSmi7yOieLmpyHwjo=
Date: Sun, 22 Jun 2025 04:56:03 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974594/000000-0ae2a2@github.com>
Subject: [bluez/bluez] 0ae2a2: shared/bap: handle inverted order of stop ready
 an...
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

  Branch: refs/heads/974594
  Home:   https://github.com/bluez/bluez
  Commit: 0ae2a2f77f007a43ec075dc13d605851df1d6e4c
      https://github.com/bluez/bluez/commit/0ae2a2f77f007a43ec075dc13d605851df1d6e4c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-22 (Sun, 22 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: handle inverted order of stop ready and disabling->qos

DISABLING->QOS transition and Receiver Stop Ready reply may arrive in
any order.  BAP v1.0.2 (Sec. 5.6.5.1): CIS may be terminated by either
side after Receiver Stop Ready has successfully completed.  However,
when we get the reply, the stream may be in either state.

Instead of client detaching the IO on stop ready reply, rely on
detaching IO on entering QOS, where Receiver Stop Ready has then
necessarily completed. On DISABLING, mark stream io as not connecting,
so that it gets detached even if CIS was not yet established.

Seen to occur with Samsung Galaxy Buds2 Pro, when it refuses Enable for
32/32kHz duplex on one of the earbuds.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

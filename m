Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C517C7CE
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823698; cv=none; b=ZvAWtGH9Vo1HsK++L1YGx+qIrPFPbmeio/aQ38PbrJ0tSmYVM9Gv0MAoavyr9Zxv9BCNIrOaoSV+ihv0IiHW4TnEAMOrr/X3uK05Ma4XcP1IaK0mgeJPrijtQIgH9Kswhpbnu61baaj81wP0EqDoQ82R04kAKg9jb6ETf69XKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823698; c=relaxed/simple;
	bh=oF2wAmW5JTTRtrRZVQH6d69NHQLbFMIICjcrJs5AVnQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PlQd7eJ6nJpjlI7MBFRVbHKv1WuhQ+JacGKbMsZJc7IlpWVcvX//MRkiRk+higxe2m8uvPrM1M0I18VDxVUtSZHqmuEfi1uj8y/bEpSSa7GV2N5vdGKGKcIHI+e0lGWx7iy0z/zbBGixonci+ORiJzircmB7nQCjgPGkUd5bcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d/v5xF1i; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d/v5xF1i"
Received: from github.com (hubbernetes-node-8f47c0c.ac4-iad.github.net [10.52.210.54])
	by smtp.github.com (Postfix) with ESMTPA id 0D99E5E0820
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Nov 2024 08:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730823696;
	bh=dq7VldMNYOKmDaqThHGcKrNyuNIcPkK5B4QSEIA3RxE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d/v5xF1ijyInhM2xhNcEv/BKJPT+B0BbKnztSXaqcyRPM7KJvWxGyW1zRMpy96D9+
	 aVFYBG++B25SrHkifcxHl5G8ynZAEp4nAE5c8ABRqygu9ObmJREGlVR3xThBl7T6wx
	 OFxe7wKy/Od889cl7auQdiCxjPzNaJ1Hzbjv/OMM=
Date: Tue, 05 Nov 2024 08:21:36 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bae6c3-002ee1@github.com>
Subject: [bluez/bluez] 002ee1: obexd: Add system bus support for obexd
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
  Commit: 002ee180b1b5c17989e197ee0b77cdcac5a5ef6e
      https://github.com/bluez/bluez/commit/002ee180b1b5c17989e197ee0b77cdcac5a5ef6e
  Author: Damodar Reddy GangiReddy <quic_dgangire@quicinc.com>
  Date:   2024-11-05 (Tue, 05 Nov 2024)

  Changed paths:
    M Makefile.am
    M obexd/client/bip.c
    M obexd/client/ftp.c
    M obexd/client/map.c
    M obexd/client/opp.c
    M obexd/client/pbap.c
    M obexd/client/session.c
    M obexd/client/sync.c
    M obexd/plugins/pcsuite.c
    M obexd/src/main.c
    M obexd/src/manager.c
    A obexd/src/obex.conf
    M obexd/src/obexd.h

  Log Message:
  -----------
  obexd: Add system bus support for obexd

Currently obexd uses session bus.
Distros  where session bus is not supported and still obex profiles
are required in that case use system bus instead of session bus
which can be configured at run time.

An Command line option has been added to achieve it.
{ "system-bus", 's', 0, G_OPTION_ARG_NONE, &option_system_bus,
"Use System bus "}

we can use option obexd -s to use system bus.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

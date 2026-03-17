Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D550D3E8C6B
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773761658; cv=none; b=i7egBFIsjos9+VXHvTraplsOvaBFxPvLwRfaKCCrqqox6aAJezkIJ41VBcJLMAaA7O/rUwkR2OoLmqD6zRVt860meH9mSVG3zzrR614YczdnN8zvtB0C9jPqhcLcNsBilDUBQeOybeJbJvERBEI3aDPIJMIGr4jgiswg3SysJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773761658; c=relaxed/simple;
	bh=lAwhF41EfuEaqz8MlMUqgAFS+sfB56UJY1fv1pcj0jQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BDkJq+rm94DJ7g5KvfYV+rN3MqLjB/FNLmrlZfeW36Ks+sUN+XhrUhV57UXxWQVTahzCWvdPWch7erbei/5QUxoeNqV5Bh/5n4GNftCrNTjJqcn46ycqv/lVNxILSccbr+y2GTqFtbzf3yGKVIrCjiSWRw8cMrX1MQvgnsJ62TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MLD0Xoet; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MLD0Xoet"
Received: from github.com (hubbernetes-node-fa21036.ac4-iad.github.net [10.55.96.40])
	by smtp.github.com (Postfix) with ESMTPA id 72465213F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 08:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773761654;
	bh=qd+astLj+daC7LI8l/JCHBugu/iWlDTnTDKt+FF+HFI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MLD0XoetyXZ92Qb4BOt/zitgdlaSuG1caHb+ffoqvpBom8obgI3b6cojrHpdX3Zax
	 ugmqq2baxcupkxNmwnjQehh7T7ftUORUtossEchGzX3IV8dUJlSV/evUGW7fEqRFks
	 RgumV/Fv8CWx8qDPo+sjoEzqDOkBbgq1RaM5nnx0=
Date: Tue, 17 Mar 2026 08:34:14 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1068070/000000-d222a9@github.com>
Subject: [bluez/bluez] d222a9: client: Add public-broadcast profile advertise
 com...
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

  Branch: refs/heads/1068070
  Home:   https://github.com/bluez/bluez
  Commit: d222a9698d7a219cceffcbaeeea94e8782a6c196
      https://github.com/bluez/bluez/commit/d222a9698d7a219cceffcbaeeea94e8782a6c196
  Author: raghava447 <raghavendra.rao@collabora.com>
  Date:   2026-03-17 (Tue, 17 Mar 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: Add public-broadcast profile advertise command

Add an advertise submenu command for BLE Audio public broadcast profile
advertising in bluetoothctl.

The new "public-broadcast" command reuses the existing staged AD
ServiceData field for UUID 0x1856.
It supports:
- public-broadcast sq
- public-broadcast hq
- public-broadcast

The sq and hq values map to the existing raw service-data payloads:
- sq -> 0x02 0x00
- hq -> 0x04 0x00

When called without arguments, the command reports the currently staged
public-broadcast state if the staged AD service UUID is 0x1856.
Else it reports that public broadcast is not set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

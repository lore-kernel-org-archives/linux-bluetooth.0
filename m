Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45B3C9429
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 08:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560529; cv=none; b=sE+McWiflU4s3gvXJ4V4t8lLPk5jiAac2HJPo5YpBS58ZFED9kIjbykt+iB/Xh4EIolgi6J+rkNCzOBH8IL8T0nG8/u+7zLYZPZjR0cnbFH7MULkTQY9lk6R9N8MpxX4/tUG7VrjmZzLsSs/uiDS0bvazCZilf2kV8VfHQ2YR6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560529; c=relaxed/simple;
	bh=CFY81kUvnc0pJCY54k7UGsFWe3sBxT16IISlVJcbul0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C0CxSD3dJ1/gU4cy5G/ob+nuNOesbWj4K5xhGkRwdGzmqUW06DYjm+ak0hZrNfOS2d8omg9KH3tdI1VjSLb0C0ys1lFWglqIXzmF1tyDPXxjHgYr09XDsluotDg+YIdEC23jHEWkNYZc3hQobgv3bl5er5pHVKtMhLK53eyTze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MASakPZI; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MASakPZI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780560527;
	bh=EOjJotcZGSCp/DER2vJ80WwKM9T7u9+FZ+F8KEd34zk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MASakPZIGbhB1iByYPCQPUZ2/SCxVTifW4uCW4wR72yWDgPc7/Z6Uxqxg+2maUv0F
	 NZj57ow+MOTkJCt7ZkasB0x7H05R92HC2egO8TOW0aJFYo+k0VjrErcvptjTvCoklj
	 wpBfyHfduV9wH8kZejs5dnSduvcwecuemH6QDI64=
Received: from github.com (hubbernetes-node-e709a15.va3-iad.github.net [10.48.207.104])
	by smtp.github.com (Postfix) with ESMTPA id 53B6E801253
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 01:08:47 -0700 (PDT)
Date: Thu, 04 Jun 2026 01:08:47 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105699/000000-f3482a@github.com>
Subject: [bluez/bluez] f3482a: shared/bap: add ASE Control Point error
 responses
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

  Branch: refs/heads/1105699
  Home:   https://github.com/bluez/bluez
  Commit: f3482a8657f0c3abd08dbaa5abcce6ae83c2e009
      https://github.com/bluez/bluez/commit/f3482a8657f0c3abd08dbaa5abcce6ae83c2e009
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-06-04 (Thu, 04 Jun 2026)

  Changed paths:
    M src/shared/bap.c
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: add ASE Control Point error responses

Add SPE unit tests.
These changes are required to Pass BAP/USR/SPE/BI-01[5]-C tests.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

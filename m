Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E093C26
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032593; cv=none; b=A+E7kcWbf3H3L8exxT1wI1zmSpmhslOC870opOd4ImabEYyWDsjbgqmvRjpHbLK5FkRsQaCdrFi5plkCz/SpUF+AG8CBPSRLIqb2z01kN4vvxRfJ7PKPNYNGVNfCjW4L7NgNmGgBJUymEBzdMHB+jhrDJkGlpIaHCk5IFtsH8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032593; c=relaxed/simple;
	bh=bSi0vLwSdBwRnHr/BA9wMTIS6Hn05URpJpkwyM8MeYs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G8wOZ5IdEnNN+IvUbcoZxYZJX/jSGonNbW2EkUEXb56/VNYfOwrjDI3z1qEdcnSM7fVhVwXu9yf5RZ0QD47VN2PpDOE+Rq/3Q9zO0QTrdOkXXJYPbo1XEBISw/f0ygozd+a47HhSs8v5M8ClhgrsCyLigPa/ILf0Q3X6kk1k/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CUlXV5qz; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CUlXV5qz"
Received: from github.com (hubbernetes-node-53b1f6b.ac4-iad.github.net [10.52.145.27])
	by smtp.github.com (Postfix) with ESMTPA id 441C264092C
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 00:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754032590;
	bh=dtFP9p1gAz/0jChhGps1ZpHNc2cpKH1B7lPd8Kw1Htk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CUlXV5qzMM3QF9mqibw7pvDzPC8zdDnR4T1YRr6897fpX0TMSpapr71cg3mbSeGjk
	 vPO5wJFirwPzOblZYmimPe1WJJcM6I6CSaSRja8JjT8BrTo6KC2ohXfME+M/810GJ8
	 hVsHjNiBMw2PfGB/9vyh5RYV6lGEHGLqw8y94aWI=
Date: Fri, 01 Aug 2025 00:16:30 -0700
From: Adrian Dudau <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/987581/000000-b54aba@github.com>
Subject: [bluez/bluez] b54aba: tools: Expose the raw advertising data
 available o...
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

  Branch: refs/heads/987581
  Home:   https://github.com/bluez/bluez
  Commit: b54aba40445202f7fe39c992f0f0c934b29bf5e1
      https://github.com/bluez/bluez/commit/b54aba40445202f7fe39c992f0f0c934b29bf5e1
  Author: Adrian Dudau <adrian-constantin.dudau@nxp.com>
  Date:   2025-08-01 (Fri, 01 Aug 2025)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools: Expose the raw advertising data available on D-bus to PTS tester

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

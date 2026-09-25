Received: from out-44.smtp.github.com (out-44.smtp.github.com [192.30.252.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C136C9CC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790347819; cv=none; b=G7CHUwdk4mOjzP+Mshg67JaRuEYyQ7CQZxQtpJWNC4HQKP3gPb60fHalQ9hY70SiVl7RP4D99HcxnEf5n9vng3OmYwvr4kZ+WATz3gh+SPxmdRQbLJHkwae4YhiMdSSzSTGJeoHUKhEeja2+A9s2gR2INA8/ewL+w36GLd301/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790347819; c=relaxed/simple;
	bh=N/qozAzdAr+YrzxK3uAyaDCeW+mmctbeXT6NIgae6Eg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rRmNSxzlvY0Ee82OlZV4mLWdRTqompiSxtgT/OAHrhRMFLQz7Dv5NmCBNy2Qx5X0PSCkxxGEupUGi600ZtWlLbY2YiQ3vgqduJWIPkkcaNaiAhk0R57AHi4UCEi4RUzudNAdYgZa6ud6vHjKXeTFxWiOzfueGzdRVNeXYqINkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=QQ1bMnkK; arc=none smtp.client-ip=192.30.252.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="QQ1bMnkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790347817;
	bh=bPXGsW/Ut5cLW8pcD8r2NCtjrZ61CWP4qnRsg4Orm+U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QQ1bMnkKiJaphHOtZQdNMWVkHvdpIn2sXD5+HmFS8sUrSuJqDdH/cLLIC+aQMpROu
	 cKd1Zg0aZDM+hlbD7qXZq10ai6IMDlURdILY2Y0WJcfA1AVqZVTYYXpFKsa5k5VqXR
	 FV8AdceF6NzZnN47h7/vYBmqPMTd+5b4nlL8QMMfBCddN6Y4/toNrmJNLXYj/+zBAK
	 E4kh8AccCwFIo3CZ+KjzeN7l8SbhVU9TSHxq9J9eooKudJoGoAKuDQid9C9SY+fj5i
	 ISd2dxP7pNjs3Pq9fv7tBfpytdoa6uLCntisF/arNTAg1/p0J1SF6R5vdAPpFyxHiq
	 fkMRpEZqzinMg==
Received: from github.com (hubbernetes-node-d2b0bf8.ash1-iad.github.net [10.56.182.38])
	by smtp.github.com (Postfix) with ESMTPA id 48CCA8412E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 07:50:17 -0700 (PDT)
Date: Fri, 25 Sep 2026 07:50:17 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1173745/000000-9d4632@github.com>
Subject: [bluez/bluez] 26b04b: doc/qualification: Add VCP PICS file
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1173745
  Home:   https://github.com/bluez/bluez
  Commit: 26b04b595b0abba0131ceb0c8f6c6dd37828a0dc
      https://github.com/bluez/bluez/commit/26b04b595b0abba0131ceb0c8f6c6=
dd37828a0dc
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/vcp-pics.rst

  Log Message:
  -----------
  doc/qualification: Add VCP PICS file


  Commit: 9d4632b221ee75ffad69854166ef643b6437d726
      https://github.com/bluez/bluez/commit/9d4632b221ee75ffad69854166ef6=
43b6437d726
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-25 (Fri, 25 Sep 2026)

  Changed paths:
    A doc/qualification/vcp-pts.rst

  Log Message:
  -----------
  doc/qualification: add VCP PTS tests documentation


Compare: https://github.com/bluez/bluez/compare/26b04b595b0a%5E...9d4632b=
221ee

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications

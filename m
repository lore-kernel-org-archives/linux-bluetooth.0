Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C44280CC1
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771012799; cv=none; b=J3wQHbpbC7NKNDgDSzaO91TT/AIfIniGOX04XUp1SbkFjw5+91gCD9QdppSxAq6ogiwN3pq9+xl3dV3RoFQCPcsfcBSxVzMQLSz3uhUQ1ZvwfY3b4bs9OnsNYWARsOmiJIIUvrq2KL+3KP9Ln+aL1UmYosv3LJWwk8JGHW6XPlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771012799; c=relaxed/simple;
	bh=jheJuIxMXYRyrw6kcoXL4tM1Iol9vneV2rFVWRypMW0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IFunpk6oTjXAJ3RpXC5+NlpsnEwiXZsoe4xmBM5HbRZkSDGpkXACwO60qKnHbmUTAVNgtxxuBL52FLZuSXhrD6PGJiP+RsXoQrnD6CBkwnOj6d85Xkg8ZLYPV5YE2Uncu19N6FFtGDiCibMpdqPMOgV2rN6sAYZFbmPRqbBfGjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YJDeCX/T; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YJDeCX/T"
Received: from github.com (hubbernetes-node-b401b44.ash1-iad.github.net [10.56.211.24])
	by smtp.github.com (Postfix) with ESMTPA id 8260414042E
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 11:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771012797;
	bh=OalBlfMrHVfMgg1wzi6qDixo1Bd3FjnVvqpF0knPLIk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YJDeCX/TGelP+B/4G5BS+/xHn1mZVIQxTuu81Dcj2zSuwjhc5w0NBu4bW6p7Yt9Jy
	 PWJm1gpAMxCYYNEQ9oSlSmPncSdw+RXxD0SVpKKacBl3eJ9Q2RcO/KjLXhnJdZxGsH
	 nfjjOln8tKUMBPkfIhTaLQ/4kUywrvTyI56IP1pk=
Date: Fri, 13 Feb 2026 11:59:57 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/fix-lenovo-keyboard-input/cc63d2-e5ff33@github.com>
Subject: [bluez/bluez] e5ff33: Add code analysis of HoG implementation and
 propos...
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

  Branch: refs/heads/copilot/fix-lenovo-keyboard-input
  Home:   https://github.com/bluez/bluez
  Commit: e5ff3314d0195cf34d2c6fecd3ced875064dedd8
      https://github.com/bluez/bluez/commit/e5ff3314d0195cf34d2c6fecd3ced875064dedd8
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-13 (Fri, 13 Feb 2026)

  Changed paths:
    M ANALYSIS.md

  Log Message:
  -----------
  Add code analysis of HoG implementation and proposed fix location

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

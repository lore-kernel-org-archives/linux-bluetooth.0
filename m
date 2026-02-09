Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E5F253B42
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 21:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672180; cv=none; b=it9s+FkVGqRXkGaXAg32BYuqTWAFids3df4gc+Qr7J7t4ML6kfi5/lQA1kC7D+zEd0H+FgXalL7u7AZKusJWpQX4QBVWP20ckDeR91fbbnPlWeHTdlZqLPd/NlMWdeqbisWaLl837FyBUf8foqVFaoPvCq68pePJuONy2dZ4GAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672180; c=relaxed/simple;
	bh=XNDQtnfg/orsvgHnuO35Be5ykb37OFPwSEDjfWqbpWY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YfAmMrg7LpxWTcG3YR3QSatOJPU7okUkEi7erCO//QZWF/txnuTU4hFTwWfbkR2hYmLqWW61C4/H1Y/BlLdwDgB6CWrYMf6aaJz9lxCidvEyEIWsBXHA79U1wvol9TbmKoPc70lRES0lf35DUa8kcHFomlLn1fS86sdcvMPuS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CF4kjjPL; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CF4kjjPL"
Received: from github.com (hubbernetes-node-25761c4.ash1-iad.github.net [10.56.145.43])
	by smtp.github.com (Postfix) with ESMTPA id 72EA0141318
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 13:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770672178;
	bh=SNeJWye1969gu2z7Vy+5N2PpNNGLkcZ/p0McB9q+oa8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CF4kjjPLWYtaUozVDjZN3TaOu2aAvgSR5Jzd+Ivm2n1K3JLz9ydPa5R3zuyUL9buo
	 QMHr55iquDqS6AJQLJ3uRwAvms85wNL0rjfScbYZh4bR6fCADTSCeA9YegEzawy17F
	 /vS/lN5DkY4neEpt2qTGoABeQMaa+nkhRy9RUEns=
Date: Mon, 09 Feb 2026 13:22:58 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/generate-release-notes/ce6a16-aaefe9@github.com>
Subject: [bluez/bluez] aaefe9: Add release notes summary document
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

  Branch: refs/heads/copilot/generate-release-notes
  Home:   https://github.com/bluez/bluez
  Commit: aaefe90892544ec86dc4bb8622ce71b3c6ca3abe
      https://github.com/bluez/bluez/commit/aaefe90892544ec86dc4bb8622ce71b3c6ca3abe
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-09 (Mon, 09 Feb 2026)

  Changed paths:
    A RELEASE_NOTES_SUMMARY.txt

  Log Message:
  -----------
  Add release notes summary document

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEF01DFDA5
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747061865; cv=none; b=TRgX8Bg6zi03LQSIuAuV6ypHr62dd86xLcHQvFgob3tJvwwIJQ9U8MT+siDMivIe0xDUyC6gOKQJylcJTEX9lDVfZllUmAePh/E3gFhdoHE3S9Tiys9N0cMJXoIIcJUaAtKf16sc5BGN6pPqm99zt0sKnbZeVR3ffkTBPKmJgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747061865; c=relaxed/simple;
	bh=74qKUk8EGObwC/LKTkYncW/2nvOb5RR8unlhqkfptIg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bVW6g7KgRHt6+uD+uMc8sb5RRRXGHSUfJmvXPmt/Dt84CTa1Fu9Rcdgx5B2LrVIuuawC78rVvMF1duRuoed3+iuA6JthF7CfEYUQCiv6bQFNA0CcZ0rAa3BzKnhErpxS3EEePtCsmfMWT4XsNjrQayWoLialPNsuX4piF5QJxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V6uWx9+1; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V6uWx9+1"
Received: from github.com (hubbernetes-node-f965103.ac4-iad.github.net [10.52.181.55])
	by smtp.github.com (Postfix) with ESMTPA id EAF7E7013E4
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 07:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747061863;
	bh=OUfGm6pKOJYbb6tKvBXZ1TkhgQqFGXpnp1xMRi+ecE4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V6uWx9+16TRKF0XlO0S0GqnTHVduU2j09a9xjljGtcmTcbWdoBObdSQR6riZSv0Dz
	 jokG2C4jcAUyU0v++tKNPRimn59ITsDK9e3XmX4WYFkvOuokAiuZc+g2mgOyepZU1P
	 /Fr4y6/YDOI5FWmdghJNr41Z5Ozoiu7iQFGS+lLs=
Date: Mon, 12 May 2025 07:57:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961953/7808aa-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/961953
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

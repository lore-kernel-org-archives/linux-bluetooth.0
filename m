Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE23845D8
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775742; cv=none; b=kWSfXY/RZTF9DgtV5OdglCP3GN1Mwkrck1CD/rSdYN3ElNIaaibKoBQBgCF5Cx7JR3nxzYYJJ7hnFl2DHrvqM2oYKrsw2a9IwT2OolcQ1j60WGvTd4WoJ47BFIS6kCsiesdGcfaZka1rWfv1zDbwgvNCLbQc7PWt4UD4n9C7MIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775742; c=relaxed/simple;
	bh=1+UjngDCgRcllMCfokGcR4FIb0T0fN1YA+i4GnaK8+I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dv+5S0qzfrJ6dUizIF4podue8/+WHT8diz1J8zMW4/IJYNwk+oKvUns+hlhV/2dqHnoadlmKu8YkvN8D3dV+w4mfpFscgOSdLYYpxlKMPlvQp5R8chSAEbvB/WR3BYEFhtSj6mZjdrVOmBCxx8URWMXXPTY0KdbzhXbBhaHxguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xi6HEUhk; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xi6HEUhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776775740;
	bh=aWUhM+pPSrEQtOkKDY7M4UpMCGMcwiStjliNm2s+BHo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xi6HEUhkxKsRZpChqxk/dwvqU4jOahlySishSXGJ9+JnsImdA6j4aSNt0r8XS6nrH
	 buv0JSStUoRy6C6+UAupeLMQBAIqt42xtA3Owddohj9q2XHXZLXPIffnRyIoDiARzf
	 y7vm/baLwbRK8fTmPJMnXQwzv82dQaIjYubS/QXU=
Received: from github.com (hubbernetes-node-6a3860c.ac4-iad.github.net [10.52.14.54])
	by smtp.github.com (Postfix) with ESMTPA id F3D45210D3
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 05:48:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 05:48:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082537/a21fe5-000000@github.com>
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

  Branch: refs/heads/1082537
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

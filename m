Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AB449B2C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593898; cv=none; b=B2rtkdas543bbJ9xbXMeNpF8q4WQskV9YImzghEQSg4jJPFvu+sKlyt9QJTgm8FbTdA1L4hAg1fq5L/EA9rgN5E1G/rEuq1AxZT+OvuHfEEhLk74llrsmmXqCFZg/+KNYdqZyt4l0nMyaxRs9Y5xeEWOHpk/8ZroBfXNnDlkqVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593898; c=relaxed/simple;
	bh=ju1Oz0+/WOV3dOndzc61c30AoZxXlOEXMzUMFDOGB8c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NpDDH+MIDddDVHtvIR6n1J+NaCTmS/3Yo3QUwd/3bR7f+I4ZvTENYMIQJvMdGc1wUZ5IXbqwjcoJpkpiYXNG7jCOiTc/glWtujTHFZAagg/KRuoMtcXcmHJ3zG4z35ySAuiooXG+sBk+xH5K+bCdfiv0Nr2R9hVULpS4aWmAaV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VlavzbCe; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VlavzbCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789593889;
	bh=n1KNFTWi6NMs2uVHziB0r09SZGIHqrwbn0FJ7YQ+8K0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VlavzbCe5qrBCYgpJ1+ixx+9JTbTzI2SLvKBrK/9L4jjHeec9fk0Ub0lBmqUUn6ig
	 XTEkroFNNk/R/Rr/Z3554OMoLEEWoAZ3ded5TWI9C6Ucpmyas9oWVEroGQ5NKxFGiX
	 tQsssxLLE6YR4P+hPKN+azIzn0N5OWAZRmTVs1GY=
Received: from github.com (hubbernetes-node-ef7288f.ac4-iad.github.net [10.52.125.66])
	by smtp.github.com (Postfix) with ESMTPA id 710D0740CAC
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 14:24:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 14:24:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1165926/f8ccd9-000000@github.com>
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

  Branch: refs/heads/1165926
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

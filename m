Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08ED2571B8
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081248; cv=none; b=kxwGy4y67t+rOv6OzNgmtnDg/IKHCfW5Falcs55hMV2OVbi8jUjfcBR9MWDCMjRGpslRPI0aqU8AuN5ZV0XufbTdogV2INsN053X+0o9p2r9ORWehY0884Yg7HbNswmI3f8rD5MVLTdJFeCvfPT44oMQwFO7WPOv8J8oDOIE/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081248; c=relaxed/simple;
	bh=ggOHoTZg/h1B9FMaDAgTa5lGRmgI+bJR5cWOcXzpNd0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G2tZTVzSyemyRk/OSl3tlHpi86DDkA0YouEpYJxXATHKuuRizdo2bTuGWVQ8NXFZI8w6wpjzCZH733MWYMsanweVfy3UaHYPIdmTGVux3WuGdS8IrfBcp2rfawTGsHQA1nvpkCFExBTHOMAxBV3dDtEAILJOY/SafXEFWwJniFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DLPVlRpo; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DLPVlRpo"
Received: from github.com (hubbernetes-node-9c7194b.va3-iad.github.net [10.48.15.13])
	by smtp.github.com (Postfix) with ESMTPA id 19F7DE082A
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771081247;
	bh=OpSqSwQcdA5YH73Ly0mYHiXumrv/p13KXGbOlpwi5s4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DLPVlRpoUhxfnFzXAQyE6tES5Cq7A2oacbpzRF+aKoZG7QXBAWT0Uq6Ms6s1U6JDn
	 kF8JitG+ERaHiwV+eIgLlPrBB1PlQSBr+RCP3W5kRzkMc+Be4BQbEuLbY4UbJ/rKRM
	 9Lku7wtBuf+053VogAicDzuQItV37zAQlwFMc5F0=
Date: Sat, 14 Feb 2026 07:00:47 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042856/1e15ef-000000@github.com>
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

  Branch: refs/heads/1042856
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

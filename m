Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED34968FE
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554137; cv=none; b=L8HeSTn0XhSHrRTOQ3jUmw7zLvpO+uc8jIP7wIYPNYG0SQdfXbFOMIqFARvyfDnB8TaGzbeMagXPTcw20WB0TsKz0idINS/ylcea0qEUHWsNBPKQYDPraVIBkfXUCCxsnt3zEhG7JJXtzElIuURYallKELbCGikSVTgy+4C5lAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554137; c=relaxed/simple;
	bh=eodyuy9l3oLgv+6T5+ipvGZtvErhpOWmH4rTd7m/jh4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PujjF/hG0a0I1IGlNwiD/JhycjRwwSDO3POjmROln1dN2PUfqNvg+fmDEd/T5Qt8t+dtLd4SrjpHaOP775IzO6pVi3ZOXpHSjdLI34ojzZeOxMde6Y/W+PN6efOXuLarCNy/4rFKTVeyxUZICQc0CEMxtU1CkF3UgxsBifh2brI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ASDwiV20; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ASDwiV20"
Received: from github.com (hubbernetes-node-d8fcb5c.ash1-iad.github.net [10.56.206.82])
	by smtp.github.com (Postfix) with ESMTPA id EBE2814AB87
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 08:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772553732;
	bh=QeZS7fnBpzpeA+H1unN10KFtlWfBpbSd8MKEp3ACRbs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ASDwiV20eafCH6kfThh/etsjn/ijQnFptYaAA2aJuOlKlu030QCoWZJ/Lh+jtigXp
	 HskpPN3p2DKbryJfIkiMBCg6OJHqp7X4V5Y/BHw1+IldIfcHDvC2tFyWqr51RETekA
	 X+161F6KnRS/ndPD5Vx3OzL8n1P5wu/4Hg74BU6Q=
Date: Tue, 03 Mar 2026 08:02:11 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1058640/63ee6a-000000@github.com>
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

  Branch: refs/heads/1058640
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

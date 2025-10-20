Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AB72CCC5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967428; cv=none; b=NdvL5tErLjbJmVpeZve4jRDn8AvEyKN1OF+e2qEiWCqvbR5fqblkjNf8Ez5KwQ3T3fJB6/5+mx4qJrMXF7eCAspWH2l4Bcii4pWLkA1c6iGRziAxlls246EU9QBpP6THSJcUSFHbOlo/NP0cexqyJPnn0giKyj42OIGBirOxreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967428; c=relaxed/simple;
	bh=psgNj51MtjuM19Jw3uG2QpJKBycW3w4YZG+HEeM21jk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hAdh71gDL4Pwi3wppTH+//cFCMup/BXj0SQRjsjYncSN1SYaVNAJE72/eAtSw6cLiYNMEV8eiGfo+Jx5mXolp0PvX6DrOY9Nl2SHDLbtDqjXWBbQlmjCeIux3isrysLmjxt2ORYxfl5w0Fg8xZf1Gn4S6UjF3c3oo/t4aZRRsOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Su+dCSuE; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Su+dCSuE"
Received: from github.com (hubbernetes-node-4fb4e18.ac4-iad.github.net [10.52.174.50])
	by smtp.github.com (Postfix) with ESMTPA id D0B7C213C0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Oct 2025 06:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760967425;
	bh=Imx+n9yJCo+k6U57TNWBDR/REPJEFZMFo79hpvlS+e8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Su+dCSuEbnJ9CJefK3ettQCE9mmuLej6Whsv35Ts45yUHbTLRNbOvGoOuiflr2IHR
	 m39fBlnpwN295UGEnjT1GXnrHfowawj4DVr2JF+D9p/VKpxs7mIY4AflyQivV1IwxQ
	 IJ/Aqb/9FRbMM6hWAkX+lqu60GNgXu6SJiXHx58Y=
Date: Mon, 20 Oct 2025 06:37:05 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1011959/42be56-000000@github.com>
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

  Branch: refs/heads/1011959
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

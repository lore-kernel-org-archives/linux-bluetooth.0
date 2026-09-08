Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BB583AB4
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897407; cv=none; b=DrXHHO75OhJBYc+XKrjOHJhYj2dv3fH1Y4X1TtGfESLgYfvvykE4s2UmpggDqJ0tM/uwT3bLeA+n5g9dj81SSG3/GRbVfob1Ba3BZQ8qs4d4ginYPDlLUDDHL4ebE74Te9AGHS7h4o7KkqZofSvK+0fZrvB+J3H5CbFTd0GzktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897407; c=relaxed/simple;
	bh=uhJmWWtaWOEhNSPd1pdJboX/NzC7MVYiymuMs9U9PtA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L7rNVrJBB6GdvotmV8ozW/pU+VI9wm4PqiiXhoOee0C+OAECEIDlJNlpBBvCXPKaNpp3zyvqI8eDQ4h1QIJNt2AJDY5DIwLLhY6J/kpqhxSz2LOk7i46lnd9a6HDXLyRIQ0SzgpDGw6PhAAaO7pLgBpsvVxoq/hr7mdNx/UJjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bMxbbCrK; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bMxbbCrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788897405;
	bh=vbE/+phaZirIjEAdr0UAJioMH3w8XZSfttL2HbySxT8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bMxbbCrK8BISQZfyCgZwnzyX91rqZSwyKHHRCZmiif1fgCOg+yPr8Q9NLAI+H6pmw
	 bxF6PkxyVojeFsL1JlbdzENnDcBHq7tulKZW5BmBJVd3+d4uy1dcFSuYijfHcyDxtz
	 gvihOPq8nrPm7diNg9tu1apjq+QI2o/Ag1JKYl60=
Received: from github.com (hubbernetes-node-9f9a133.ash1-iad.github.net [10.56.208.42])
	by smtp.github.com (Postfix) with ESMTPA id 9772E18129A
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 12:56:45 -0700 (PDT)
Date: Tue, 08 Sep 2026 12:56:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1155564/162444-000000@github.com>
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

  Branch: refs/heads/1155564
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-39.smtp.github.com (out-39.smtp.github.com [192.30.252.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66745FFB7
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788293488; cv=none; b=S6MOM+ALzNnec9Y20nUoPqOH1K7JBDsag16vuiaUPdculGYiEwPfo8NJkYI5HG6Zzi/8rNbKv4ILQXP2bA12W0aVUc1AiwTVE6px7oZ4lFBH3xQLCQbd9U0oLWr9KUWGeYtP2CjpYIxEPY0vyvqH3nWuOT9D0UjcKaNvmcen080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788293488; c=relaxed/simple;
	bh=nKT7RUoZPnd0sYA6lRjeirgMvh1PvhnfGnGgpa/ntfY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uyV6rNcmObQQHqKM7eLYEc96wDv2svvfU9HvGdNqLVt5RjWc0h7Mqw5ql+IzLFF47pUQG6aHBgSVN5DmTFAaOExb1EBpZsMUa52ahTcIaJIy7mQQCPGDwhQ8t/+T3nfC4GjD6SAXcVTvYnbNsiBt3SwH2WGQUQPdUepP5JWK3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IklTHLeZ; arc=none smtp.client-ip=192.30.252.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IklTHLeZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788293479;
	bh=Q9agA2P24CUPShAZaseCyMnAA79TBag6dlnSGENOick=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IklTHLeZkOM3snW7xd3NemtJSe36G8kMTv/b/RCYV/5D3H8+nhRuMf9chLBoRL3ut
	 Kgjqg/+3lH6KTZHAQU7hOn8FzwXBCglhdv5R8X75VwNOmGiNk9Ms4DB7CkqFNkJc+r
	 tlMrMnnRymU90bnPk9aHHSCZvYZbzj6J/FyUrQoU=
Received: from github.com (hubbernetes-node-c073347.ash1-iad.github.net [10.56.201.112])
	by smtp.github.com (Postfix) with ESMTPA id 022CA920C5C
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 13:11:19 -0700 (PDT)
Date: Tue, 01 Sep 2026 13:11:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153367/772bf5-000000@github.com>
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

  Branch: refs/heads/1153367
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

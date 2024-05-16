Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CC14A11
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898966; cv=none; b=dl761a3lZUfABKaSa7/rdY/GLlpYYAT21kA34MRjcfIwMyBZt9spB7ZPh5NBJtCB2HOUOxZH9FVTI6UCHn57i9p+o5afjfHJReAV6GLBFvMJLsD/xNQzrYrhXdtoym5zp8XXKMAP7cgGFjrCflu7nc9/Sdv7fpLHucxrUhVmvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898966; c=relaxed/simple;
	bh=PDumyCkhR9FoeZWQMTEuAM+surgdb57Kz4Pawn+Nd9Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gWLFM/K+Q+ex3BitIubBYEtYNV3f9sXgX0PzTJULb4B+aEIVIBSxCofOODWKv4DPocaNTPH+Cy5yeAe/P4XL51yE4hqowAM2w/3XAtdvEjLuVMQX30hFJiii+1rYPyN/J4q6zZx1qEPFQHYce3xuBDAZyxPb5MXDzTpCSkdaVzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mGgd0aBf; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mGgd0aBf"
Received: from github.com (hubbernetes-node-5f09548.ac4-iad.github.net [10.52.221.89])
	by smtp.github.com (Postfix) with ESMTPA id 03CCA700291
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715898964;
	bh=tvKgWPmFiLsYkVScySg+aDU2zvZ+LQC4JvNVJIxddB4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mGgd0aBf8k45l+UIETeeoeB9RdNc/x4KdOC8TudzMq7q55ICp7dz8qZy8WUOUPFNe
	 FgTl66Exfcth2o29Wh7jxN+30jDDpqW4b+DoTHuZ9k+0KaYQrMdJeZxtltMB7z7krc
	 8NkoEqTo1ewokmcHBiUTzTnTbPb0CsoDsuJWSfYc=
Date: Thu, 16 May 2024 15:36:04 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c9fe88-f6241a@github.com>
Subject: [bluez/bluez] f6241a: Release 5.76
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f6241a10e460ab14fa3e2b943460673df0ded603
      https://github.com/bluez/bluez/commit/f6241a10e460ab14fa3e2b943460673df0ded603
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.76



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

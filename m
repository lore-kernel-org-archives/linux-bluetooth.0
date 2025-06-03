Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB262C3246
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972076; cv=none; b=YQf3eLtiqugztUcKCmeVY5aIU0WIlXiFbmJMMvHH+CPoF5lrP+bsRicKQDTurzzEH9UhzOZjOn2n9jLS+u9w2jRyUlUpXckSG+wla4Ky1a6EQpJ5//SHyyJd+VBkD1uEGBkC8zvBCHVLrbgq1TfpKDyCC0tWlMM4FH66jJdCyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972076; c=relaxed/simple;
	bh=nIjN8bIrYpPpc8QAacKj9EVFVAsVr4poWFctXyTreSw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=isur7IkyxIwGRcN1uf4YfNmWhQLJngheeSATzOYfqKPj0Np7k3gN6ttmuVV0XgC6tV+RPc26KNX7tCzaDopm9QQlhyJW4u1BGx3kjOhS4cVvSMtAOUb9phqrce0S0gOPGM5Y8lCA/4hzHh6/dfiXpkNdmSvqJlNoQOvtPV5gfug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Q86toIf+; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Q86toIf+"
Received: from github.com (hubbernetes-node-6fd818d.va3-iad.github.net [10.48.222.62])
	by smtp.github.com (Postfix) with ESMTPA id 539B18C0C87
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748972074;
	bh=ISvIaE7LaYNsBsmctYOohKpc3B/nmxRWQ5RZ2sVhMdc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Q86toIf+XZ00LujRRo/N7EBAqEyWn+yeVocxaJVFG0jHsCfgrVE3G0vEyAgTxxqnQ
	 mH9ivA4Daxk4dUssEBPY4HVAPyuNvxLhLTrchSAf29g9RUIgWyqSY6b1WvTPVSlc5G
	 2GlHnoMeFMiKQK5+L93MZJFCPa7+LGuIM46aXHIw=
Date: Tue, 03 Jun 2025 10:34:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968220/1c0528-000000@github.com>
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

  Branch: refs/heads/968220
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB223AE83
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749583664; cv=none; b=kKNr7Q6u1eWJlTQAVHQXn687waWDDgkVh1Ci5ocJ5LAV/+5z4qjGZ5BWHt7q6d1K+m51rob1OeRE0yvJEuo9RXt8LTlQ0Ihw4HQ011pCtb+oNNvgJ9zeNp5f05exbsIqgZp8JYWPCCK9EIPfYD4eoaz7XFoCvUBgzBzZj/1QSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749583664; c=relaxed/simple;
	bh=4uwL0AUt+POMrw1gJRRLBpPKNsldkY5JNCm2RGsNKdg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JDX3V4Uc/VlkzkKqh6BXTKSMwu9fHgANOeHsjxeQdrty83qZu05rR09vCJecvsPZktd/Q6uF6D3N8jiURYHJlOmIdj6m11+7t2QpVMBsj3tyga8Q5OdhfPiEi++tZxXvBxSMpHlzlloy0nHo+B8SN/O6e1fho4t0maAEonxPFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F3kZiI2C; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F3kZiI2C"
Received: from github.com (hubbernetes-node-482c20b.va3-iad.github.net [10.48.183.53])
	by smtp.github.com (Postfix) with ESMTPA id B2D274E011D
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749583661;
	bh=/2qfbmscPg5vegMtURE3mpdK07qnU8tzLvJmfpx16uM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F3kZiI2CP5HmMjClh+Ee4trDiv7Ydw9CY8kITnwckkQ14z82PTyP78c2F34L95/ly
	 eqC7VPjSEng09ifXJJlQPhb6cGao5cqXJz9RDkvo84ZaBqgAf93UFs3YaE/Jo8HqA7
	 OUI4/jdiUr9vrYZaZjufABq9ITG8f38bxWnM7CmA=
Date: Tue, 10 Jun 2025 12:27:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/969870/3ba7e4-000000@github.com>
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

  Branch: refs/heads/969870
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

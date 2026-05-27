Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566AC28D8DB
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779916066; cv=none; b=fQBDIdU0eYiYRLf+lnRj98CQPZ13BW8OpEwQGK2dnFlZ5CGgfxcPwMSmIh6HTMJ/HLBaPENyMWbELjbwagBZX7TJVQw9E61SwDPUB92ZJGGGXkxuo9xJZXEjuAw7ekCuEmYPF6xLHV5tT+6efDl05b3qfV1GMyl7fguWk/05NxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779916066; c=relaxed/simple;
	bh=wx+xvXrFAvkAZtcbPjoHSCMlzvuVAclpxQbxkRKJALk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=upEDGXfJIO9BjPtuJeKxwVhAWDue3wHvEndOGzIhgn0oohMfuHleO5WF81oK5/Hp1WlMrI1gzDTzmE/FGbHsnDgi6mcyqMT3m/V4b/852Eef+Bu5uuxCVJQ+yWOMl2xjTpLe2MWuqdEQXqvnsHWXvpdB0wcPZDjYlTNVEwrrqVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U1rL6H/V; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U1rL6H/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779916064;
	bh=x+PGPoejO7cY7P5KSpXeAo0++K+4xQlomtPn72jrftg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U1rL6H/VfHRuyHcItKYaRHxu9neBN8BWYso46xYNmPhJNsw3izsxpbMH/5UYY8MrZ
	 UD89kUH6AwU1qoC3QZOfijlgHVlXIfL8HEVFZEitKJe8D53qH6MbrPZFV3Q/Lfq2iO
	 BeyeFFkwgNDrAoexa0FbSzpzITug5JrsXH7Z+g/k=
Received: from github.com (hubbernetes-node-6b7572c.ash1-iad.github.net [10.56.197.31])
	by smtp.github.com (Postfix) with ESMTPA id 996B2601159
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 14:07:44 -0700 (PDT)
Date: Wed, 27 May 2026 14:07:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086393/a388a8-000000@github.com>
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

  Branch: refs/heads/1086393
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

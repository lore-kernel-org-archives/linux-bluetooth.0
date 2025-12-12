Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FE293B5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765554083; cv=none; b=RMIHuXXJ+QH6H1adzVYhj+6zYDL8mQ/BWRnz/MBMnQJLA3AGUeFqkZCy8LtoV8euExNdM+M3YF9kR6Nv8Sfq98HTPqDX+7eQZ4sFZE+uz0gpGxRR2ic7DZJwyG2fYJdb8s7u2DUXLy3Go6yb8Qyww8OD2t8uxNPpC81Ly1XFei4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765554083; c=relaxed/simple;
	bh=hd+Wt7vVPdAeE/uJok9gsR83ZZeSfMQ1NTuEfa87kAI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FYPGNkqbJ+ILACU+VNd7Q5iTkUyABPXeRyMj+NgOm+yAOjL0daaeCrWhg+WUp9rOSwGj3rRZQJ/nM2DIMA4WJrv5bb3eD3c+sROXwMmANK8Co7JL1v665O8b4tGaBzoqajtJetUsFVhPXOcRZXWaOwIWCAqrpLYkTdCjU9PfMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Up/X4/Bt; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Up/X4/Bt"
Received: from github.com (hubbernetes-node-b5bae84.ash1-iad.github.net [10.56.167.43])
	by smtp.github.com (Postfix) with ESMTPA id E20811412F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 07:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765554080;
	bh=+5RkQ9FJaq0sd7h4vVFy8qLQBwyV2GzX+7V7je0SQ5Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Up/X4/BtUjP/lbhKes4tTNj2f1wfpYFeXJDXj4u5HGdlmRI8UihmllQ3NkyxpnU5E
	 SUNqZwlrvc0V+8hgJaRlkWGszWz5h4nzInhrxQHju6a8Y0QCq7UPyhoohmjy/9lbPC
	 Im/2TY5KaagdBqhkGzVH0N6Vr3NbtqRQG3olyP5U=
Date: Fri, 12 Dec 2025 07:41:20 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032412/f212f4-000000@github.com>
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

  Branch: refs/heads/1032412
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

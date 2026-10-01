Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617033C871B
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886920; cv=none; b=VjdO9UTkN+GXLVPVDSd/zfrHp6ymXnDz51aDzDqlB9RuAVRXdIPrSVbBuAfbHFgm9qafbeYIhygn/3ckRc7IGgoMkn6jAOqY1/JiZpV8seu9IByUQNWrQivo35QDMxvnCAOhO9Ou+xdQGTG1zszeQCS34Q1pnHu3yaBS2CZ8nws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886920; c=relaxed/simple;
	bh=RqrSGl91iXNERVz9msOf5W+QfDKRsGj1AiWDjA4L/ws=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Eg6cnYR51i4fGEhaPdkpcbcnzKRhil3WqpIcnXXbpsGt6rvKpAItppLUImBZBTgy4SswxFN5E3arkI/DGl997RMd0pPX45Fg6n9eZkNVHUu0hHb0QIv4MnzYAcNc0/W1e0Fq6lOMZx/+/3MVcqSJ5B4HRJnh9D+LogmCZ5hp9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=gFNuKEBQ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="gFNuKEBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790886918;
	bh=gTKfy+BrZinHS+4s7fwYF+vY/qRY3eS+YDXyAbZFjr4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gFNuKEBQaZweCQ0vP53gSP3X2hJwY6KyP7GoaqP8QxWFbPeXYf8mMuj9qrTi06X6D
	 yUkDGGE/aiWJzMI1VZwceP1PUqxc4a9VY/p6Wcsm82Mk90rL/87GxunHtq3MOwUZtk
	 QTruZpuPlj28GKq3yMjBdYPdE3F5kYY/mk4sQ9ZLrnjO5Xh+aBfWiUJ4bCav+3fFri
	 vsf8VA/BNyqfjB/cqSqbzUw/nuEh4RBCaUSDV4mOECFoKOaMyDCIiYhnpAXBeejBHy
	 1I6Fd/T4ckiXMW/1jHafYNjemeWja4HQvqFdUyqlVR+TL1Sa+JXA3xbEkxXOYK4wDa
	 R79a2o0bbJMIg==
Received: from github.com (hubbernetes-node-cd3d039.ac4-iad.github.net [10.52.130.21])
	by smtp.github.com (Postfix) with ESMTPA id 5CF547809D5
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:35:18 -0700 (PDT)
Date: Thu, 01 Oct 2026 13:35:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1177764/c60df5-000000@github.com>
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

  Branch: refs/heads/1177764
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCD429B229
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471061; cv=none; b=Wx5g7kGZ37by6lURDVF0q4FaG+KZcvXuNqLV77G+vAzU33aQpN76rhudPQuvJrtdeXE5QKIa8w2YJiTdaX2LlvQsZOigaFlIxnjtwwOkYAbpGXeXYF1/OBbLgTiMtbxWhkrJ1bL5pSiLuT6AOCYfXLMq7DVQ90aSbDYy41kQaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471061; c=relaxed/simple;
	bh=mZts7y6gIgxSoNkxronBmNCkr7b1phrUC7sObvtJMuU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hFbpsX8caPA6EJF9iAn0Nc/4nZNXucdFjOrTv4mt3iWF03pYgwCdBTuUmwjr83OGleguR/3aRzo8JoU+sWV/RzIaooq24/6B9oiks07bsIylA4brEe/VxJQwLTfRqrGMXe3bRKzJwjST4jcPobNdrOHlSD+S8u1w29EJKpurTA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JgitJoyT; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JgitJoyT"
Received: from github.com (hubbernetes-node-0dbac46.va3-iad.github.net [10.48.14.61])
	by smtp.github.com (Postfix) with ESMTPA id 2B8C9E0DE2
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 15:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762471059;
	bh=kX4QXO1c5Hmbs8tsHidOFNaH5Fgt5tbVYd7pR089Qe0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JgitJoyTW9idYfGnyzlL3dA/hXsJX3Cd1b82uEHrA05wNML7GUF3oTGvv1jCLVRd3
	 TfE/CWWSl0vfLvuH5v9ZhYlGjptMBXnP72g9fqnkvgaJrmTTuICiBIymseFs9yKAtO
	 jMVb8fRTe1AuWQ3dgE3rwgcNsWC+gsEVwNlaJ4yk=
Date: Thu, 06 Nov 2025 15:17:39 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020539/000000-10c5ae@github.com>
Subject: [bluez/bluez] 10c5ae: github/stale: Fix not removing stale tag when
 an i...
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

  Branch: refs/heads/1020539
  Home:   https://github.com/bluez/bluez
  Commit: 10c5aea0ad63653969c01b591dcef17b2c07c0fd
      https://github.com/bluez/bluez/commit/10c5aea0ad63653969c01b591dcef17b2c07c0fd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-06 (Thu, 06 Nov 2025)

  Changed paths:
    M .github/workflows/stale.yml

  Log Message:
  -----------
  github/stale: Fix not removing stale tag when an issue is updated

In order for stale action to automatically remove stale label from
issues it requires the following permissions:

issues: write and pull-requests: write

https://github.com/actions/stale?tab=readme-ov-file#remove-stale-when-updated



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

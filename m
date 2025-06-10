Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE902566F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581786; cv=none; b=FFppg3CiC1wSupUJq3B5wgjO5e++8j+Egd+wpib7XurILGtd4SnQXrGGAGOlfz4oNIZ5TvqHbI60ShEJGSpWrCka4ayp+tkGEqfTxlPgyGJYFpSeepFC3CvUwGIjySnNebcHCxewf6szQw+VFvPInFEL+jWQ0XLWfavMPWgcGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581786; c=relaxed/simple;
	bh=9idGfTx/12YcP4v/oIDZpnC39aRnkXq0CitB2+bCJOY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ipSHJ8BhJ2qSIhp+rYe5RaD9ao0kfGkUFYQHQ1brBHjz1RNGIthKErwrDJrh7AnufPKW+v8Vdzy3UvldgHvaWCNUWpJspvu/QPIwA4O3EjlHc4wWYQ6AGMfisg0M/dfR02niapILyzlXCoZBOLJPan+bKcgYbel4uP+TXbSOO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=REA3TCap; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="REA3TCap"
Received: from github.com (hubbernetes-node-86da431.ac4-iad.github.net [10.52.178.36])
	by smtp.github.com (Postfix) with ESMTPA id 6817770094F
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749581784;
	bh=fMYFqstNvFdcGxd5LG0vXWvBcLzFVhN3nS1TrUL44FA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=REA3TCapIxQcsR8PGjk2+q9YbT1DwLvkZNVrxBMCrL58DyDtHqOOLr/3tHJKHjUMf
	 9BhAgHVjs7ixmNQ1k8QMuIg9TkRZFxVDv8rdPs+CLz61BXUiu0DMz34zJO/ocz646F
	 TGqnvOslXf6zBmU9GEB/RgMm0Kb/Q1bjrHMYwxY0=
Date: Tue, 10 Jun 2025 11:56:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970499/000000-fccec9@github.com>
Subject: [bluez/bluez] fccec9: bap: Fix not responding to SetConfiguration
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

  Branch: refs/heads/970499
  Home:   https://github.com/bluez/bluez
  Commit: fccec9cb13c093fc55914eaf6589bdea780c6757
      https://github.com/bluez/bluez/commit/fccec9cb13c093fc55914eaf6589bdea780c6757
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not responding to SetConfiguration

For broadcast the SetConfiguration would call setup_config which were
not calling the callback so no reply was generated which brakes the
likes of client/script/broadcast-source.bt as endpoint.config would not
complete without a reply.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

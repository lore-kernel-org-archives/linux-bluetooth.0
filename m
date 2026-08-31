Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93638F934
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 20:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209190; cv=none; b=ARxMe6OVgLEY+uq9GhZqsnYBemjCjdBWyjHAkOL45HhQH2kA6PtmasUIXshXfliF0ZP8fr3P2YLNUVuCSHIanDAKdTIvnG4DnUM4QiUDREjIv5zDr/QQTjxKM8OlkGjhwEkuodFoAATlMtNNZ+3FuxmC8COowtrStD0UcLaEWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209190; c=relaxed/simple;
	bh=AuZoHj3jZAKGmAidhPh0FpCyu9HjGVVclqR/TZszL5s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ooFeAjcRWLJqjlsnDtIuA6dM+qHIWx/diGnSIA6LU3NGWtIs8bND3FTWsccBkocbdEjjAU9QleXgZ1Gu16e4KwvBFDiTUCfy/e4bBXfBZdtk68mz4qeWUouzOEBmVt3xRoESiRIj2lOuveEgMH70b0h6WD59bdvRYz+U0qpNtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F5X9jfHi; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F5X9jfHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788209187;
	bh=rl88ir/O0rLvWnEpUSjTrpKI2iAujk8eB3G4FrvTAVE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F5X9jfHimv1H6CA6d+gQBFCowpZb8vi4ODaHzwc5YJl3pqDgLHogVvbWEQulYx6AE
	 IIgsUQOPZ7/AjAM3sy1fXGzeclN6rQUlhGv+OlFG+Axr4xqo8neR40AwGx9v33lGHb
	 LZPuOL37RQvjPHqMpqLHmgW/P4okB19iTQ7xxSAs=
Received: from github.com (hubbernetes-node-46ba5bc.ac4-iad.github.net [10.52.81.28])
	by smtp.github.com (Postfix) with ESMTPA id 14F89321371
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 13:46:27 -0700 (PDT)
Date: Mon, 31 Aug 2026 13:46:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153725/80ad2f-000000@github.com>
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

  Branch: refs/heads/1153725
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

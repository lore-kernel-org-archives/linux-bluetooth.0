Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2601E22E9
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042656; cv=none; b=dwDAzYm01+WpOyRnRNPzcFElwXwX8VxCwrEHuy82cOwRJDWdt/Upk4JDFXsTEKkjy3CR5VjJdlA6WAbsgXk3zxuGENTC9USSv7bkiofnkk9MY/qEOldpv+motgtY1iKcRtvmWyOlbb9Q0LllOH37u7oL5AoccsRa3w2kPTRd3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042656; c=relaxed/simple;
	bh=wpknWUiT1qPGmb26VtGWrMOHzXIhAHBSdcI5Q1uSrNg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QwhQZKLYu7HGHkhqgO0B12EC7Aaer/feWcAgBhmDF5m4mcvhg+Hv0SHuXfxX90UYmFHje7DupXQsaJeuxSJSp25y5VSuzqLqtUU9ZzEByBmq/w/HL6d81oYAJZ7tNNFKp0EMUNO7nTrKQdWPKsFBjEiIZVwbgF0ADau7ffmcisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=d3gBpprQ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="d3gBpprQ"
Received: from github.com (hubbernetes-node-756e79c.ash1-iad.github.net [10.56.225.28])
	by smtp.github.com (Postfix) with ESMTPA id D9E4C1408F2
	for <linux-bluetooth@vger.kernel.org>; Sat, 27 Sep 2025 23:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759042653;
	bh=AwcqEcLI+hV1ekt2pM1nzVQU0/Dc7dt9ddlFdGsVbF8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=d3gBpprQfh2UZ7TtIP6Zqx4NnODlK7uB1g/ur3DqSsarulmsrJe6+FFc2aKcTbHMH
	 GdS+YKq4JPH7VlHsUL8cPWNzFPIQnJwAP0+hF6hoP3AzjlM62l6BOrZCZp3SzY8gd7
	 EnTtSFwUC3OEe7/A/+WRXaN3aqt44x612ApTnZhI=
Date: Sat, 27 Sep 2025 23:57:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/996765/dc6c9a-000000@github.com>
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

  Branch: refs/heads/996765
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

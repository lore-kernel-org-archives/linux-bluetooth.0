Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9608431BC8D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513786; cv=none; b=uOLaWblMpEs+IT0W5HiZPPuautya9wwZr9kEAajA+QnB0DTgd/Tdq48Vci2mgROwR5hF4rZTDjRpt7sPYrf6r4AZDxDeVOlaEC0kMIRRbg5Fwbp11RuqkNdwTHit9/AwCBHqEnXi+rbajOupULEwlXfYfxrCUQ1RJQf+5Ljj6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513786; c=relaxed/simple;
	bh=HMnoeATR4zKkdITEPodOBKYQHJo/F0TdK7TWiLtOGyA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pSh/cyOgTu/HmiXDy3ts8/d910D6/8/Df3vaVCnilwXPIJmLhJoOxMTdKhNi/A8+wRjwcWazn7Bc4cz0+2JhG0HMmX4UEw8iuRSiyFfqQB8f6x5pOa+6G7uDgJhokX68G+ypg8voMg3JkHulXOGCu68J8+R3ghyATBTvt1X+iZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H5R7KpNz; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H5R7KpNz"
Received: from github.com (hubbernetes-node-f60b2a7.va3-iad.github.net [10.48.206.47])
	by smtp.github.com (Postfix) with ESMTPA id CDD66E0114
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768513783;
	bh=z2QmYxYmRQdOXP33GPYXcPtHRSNmfj7hWoPlbUpL8zI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H5R7KpNzsXCkB+t+UQkETe6vnrZ0iYsuoej5twTbvsZhbHmSW8406CJuVpIZkj0sP
	 kDiYTSu8GEUdHk0hc6zFpxEtt5f/uvsyIqZ4TItQQZNxTj+E1NU+PxGWPDreJKhTyi
	 RmkBNzfiVpQev4X8ZqmAgLvjLDQLFfJXYwxFUzGo=
Date: Thu, 15 Jan 2026 13:49:43 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042858/2af9c7-000000@github.com>
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

  Branch: refs/heads/1042858
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

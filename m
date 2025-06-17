Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324E2DE1F1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170008; cv=none; b=Mfwzm+N5t7FKp9DpNYcPlhv5wcsjXuSGxVxhIHet9stLccBcjdJzPTY/FPoTUN+f7nOGCqcw7n5FduXR/jibp/Li80ljgvTzqENJ48S0MPCjX+2vmGk4jMMD6+1ClBVd11fKxu4trW4dGYFurmCg9s51/RxAprVB2x5GvlSWuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170008; c=relaxed/simple;
	bh=DzcWPGG/A0yp7NIo3N28C/9zIYjEm0+SXHMAIzqqfJw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dzu7jHU0m7lRfa0E6HxhMqhSE5jkH3vyBP6OVy/O4uUvmJbY47WrFtDqNEsMdc0GHmk1T1YQimfJR0ZvuA5FePEMLPK5FD+3wlMIdyF5Ao51f5OtECY0bwuYBk+7vDE6ZHQTyP5GI/mwwYWEWBj65TcZd9XQzemeY82tVtLH9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lC2ElErF; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lC2ElErF"
Received: from github.com (hubbernetes-node-aa10d08.ac4-iad.github.net [10.52.177.38])
	by smtp.github.com (Postfix) with ESMTPA id 9508D7014C4
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750170006;
	bh=Ag5BDBEF/XzrsXKsxfCkS25bBypLiu0/EJdLaA9nTCs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lC2ElErFpx0tC28T0YhxGhHmbDYv2SNs8n5FJ4wpUVkLh+d8DP5rYw+txTcusAKiV
	 mvTNZZRQb3sNnSBuhwz0wsw+cNooK3m+4uqnkzH81pc/YjZd7mFIL1r30CjmQz0Wl/
	 838dcn4jqbGB4++zWvxPCAv5vCFaJ2v/G65ibvpw=
Date: Tue, 17 Jun 2025 07:20:06 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dc8db3-f5fd7e@github.com>
Subject: [bluez/bluez] f5fd7e: github: Remove lint workflow
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f5fd7efee7c31cd9cad98ea273716980d2591ca0
      https://github.com/bluez/bluez/commit/f5fd7efee7c31cd9cad98ea273716980d2591ca0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-17 (Tue, 17 Jun 2025)

  Changed paths:
    R .github/workflows/lint.yml

  Log Message:
  -----------
  github: Remove lint workflow



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

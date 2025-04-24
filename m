Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D427F728
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513979; cv=none; b=ReCG7ZA6ra3ReMShdDlmL8TLhEeHtb5hfQVYqtRdBriEdwqdJNugtO7OYEQZIn5lOua1wE3zrmpszCpfLFTJfK3Bsz1TO68RC/ftbHqlCt4J9GKv/Aq6SEFIKtI7tvU3MqwacDAf2uaW8WzedNcxzE3xJ1Ri09Avb7UhQ8TyP6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513979; c=relaxed/simple;
	bh=hs/HR7Eby657mV13UgY3mnDLGMSteOB+by9+zzFOYxI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q2x3l4pd0Wrbrfm4T8m5IU2saLPvylIemOrM+tS7O7PuTP6BOjzTHg4UlIOIY779xKgRpM114EnDQJD+HKNsICiQsI/hlH+8ifqW4F/BRiBjUwGCrWEtkVsiArFrCahK9YWf3yh3HxtnqnG3NorzHRCDtMQ/6y+ftyvIS5OXsf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=B0F7P5kF; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="B0F7P5kF"
Received: from github.com (hubbernetes-node-6538989.va3-iad.github.net [10.48.143.42])
	by smtp.github.com (Postfix) with ESMTPA id AFAF6E12FB
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745513976;
	bh=dORAEN/gssfaTwNWFepX4vdKEoErsjQVTZPCh8cW+R8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=B0F7P5kFQO8i66Frg3a1IBQiwR32O832as1eIdiN0+ea9yagvshRVT+idiDjBQl4V
	 kHnGEMUvAZmH1becuKq79aW1Bvl13i3rtAY8gtVpJA42wh99t9GpsSaWMMWMl5GyXM
	 XvwpFB/xzy2jrPMAZzmw6y1QkxbKJ6swDga/LH9k=
Date: Thu, 24 Apr 2025 09:59:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/956666/72d064-000000@github.com>
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

  Branch: refs/heads/956666
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

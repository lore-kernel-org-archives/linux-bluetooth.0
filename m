Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EAF366827
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152567; cv=none; b=petgze4/JpBnxRuwjfMUstCjYfC9AxqGkTXQ2zjSQZvwkuIJ1KKGUjRZ+vQbGJB2BeaWJozYKUcMFImATumIeOJ7ytqqcxFb6Wdlw/WkxZEajys11K8cMJFmEVR7GIFFi/Lp5K9E6gFjd6Cczv9FxCBFuQm+AwvCRNmHN7Ogn38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152567; c=relaxed/simple;
	bh=ypmbjqKJE2UIoiGT24wObwCALhY7vnllBBCNUAFs+wY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CoXh4rzKjAkrEhgJj/XPUEapKg3dgxE0cyD26mTKWzwZleWG29sDt/LHVLxYTwKTts3o/qun0dIQcoUrIX293w8KZBmuWRAVNai6kpBJwoySBs25Bj+1MBMwlgRiUni0arszZ4REKYi9xuCYQm8F6CxEB5itLzbYeCR1jNAk8Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hCXw7i12; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hCXw7i12"
Received: from github.com (hubbernetes-node-b9b6490.va3-iad.github.net [10.48.15.40])
	by smtp.github.com (Postfix) with ESMTPA id 41CC54E03E1
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 23:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769152561;
	bh=KsQ5jCAZIIOzpeq3zje+f0IU8kiUcboK9TqSZheYPY0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hCXw7i12AYHo0iA0Oepvbec5Wdwzx5as9UFJG7SmWiL3SnQ5WulQoSLi2Xe7VfuOk
	 4P//XbOJQhBD3fnZb6LEIYajuO991qmW0mTxhHZTkiYF7SdvRiFV7MT2SkBIFQJNWx
	 q+ewjthTPEB+Eu7juNUeqRQwIKKF2Z7w3qif6EvA=
Date: Thu, 22 Jan 2026 23:16:01 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1036285/15a776-000000@github.com>
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

  Branch: refs/heads/1036285
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

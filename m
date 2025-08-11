Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30812DA77A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754918029; cv=none; b=pnHfSWuCLAnSWqUMCvx92t5e1q46WaR8YjXJiIFWDi74GUaV6h6UwsziF9pM859Q9lSwm/2JGNE6ttyh9F1DW2zrbBMiBDjQlkHRJ7BFO/+5bh/OLbjcxGjzxN6ANAuXFNY2fu9IMOB/L9/LwMcf9BsOE/EpipzQNr+oo2V5g+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754918029; c=relaxed/simple;
	bh=oFkEv7GP4tnokE0pjAvhG/i6ikJ1EC1XIRlq1ZtH19k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tnrJ7Xyh23W+SAkEuPfEA9r64AT7g/sixXp8Scyv+BRTEsvAaeXv0uIhkEkBzI8Xkucq34w/127h984thcRzvJcnj7Jcd9ZHjntatICASd5TRHk/tWNeHyJn6AX59ziN36pCPuKrX9lAMy8BARu1bWA9HNcYj31eGNWCDOjgtuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WquVlECC; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WquVlECC"
Received: from github.com (hubbernetes-node-858e9c1.ac4-iad.github.net [10.52.169.41])
	by smtp.github.com (Postfix) with ESMTPA id 38B157010AD
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 06:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754918026;
	bh=4sz17k2XEdRMgqNKGg2ro7O2XD5BvDECoAcObDzwC8g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WquVlECCXl6lojJpUe/T431831WVm/799A5zZW0+VbLBkvq/adu8aSWDliJdW9FI2
	 ciEokCkhoUlww/8ba/XpprM8rqW3XaZFcMOgQHZFY7VYU3JKf0FyBDmm3S8ryU2Qbe
	 OBB/VstJoCuYhNoHyGPyKzWxqc15l+CHWrv4w2DM=
Date: Mon, 11 Aug 2025 06:13:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989173/e64cc1-000000@github.com>
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

  Branch: refs/heads/989173
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

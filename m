Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66C034545
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752576280; cv=none; b=j0xylJYMofjnnJ2tQ4lP0CDscEiI9nmESnVQYPiW2VYfLSCNo4WdSUsIAl276rLhPld9CVmo93iqYxIt+nE5cG96RLHLcjUH9kOmjMmu8NCm59xBnUXUP2B0Ci3oqju/OKwdCAh8rJVP36swpA5drgG9QOhCLHVMhUxxaUq+qMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752576280; c=relaxed/simple;
	bh=PvcbcsQDS2tBeLKHDwzR53vDpLBV+jByVPamo7CozIY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Fyiq7shOrhJe/MeqtJtNP3ijNwS0Gd6nU/8qF1/NorNUy6nY5BIpVSGIdfAxVQd5uURMu+QhZlArm2yaI+YtbptztxeqsVviFbSTEg0wZnCQ6Tm9kPtYoPqx6JpsM+fvr17utQdQjPsLtp3SgorL9tVpXVzo/ehWMQbKG/e9yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kdt0AB1j; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kdt0AB1j"
Received: from github.com (hubbernetes-node-30b42e5.ac4-iad.github.net [10.52.136.18])
	by smtp.github.com (Postfix) with ESMTPA id EAE2A21269
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752576278;
	bh=aNZxPp4Pe5GF/Ldsq54eiT+KotWaRoi9SdpF0t/syzE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kdt0AB1j+2eHDoiP3kuJ/gEh7kR4iD6gtxjuZ3yEmnAlowDXo9hDkoqjbVR0Fah1Y
	 vf/PpdQYNUr3br2oR/E4VcEgFPuNiKXmGhIprtZ9Q+HtM9HDOnOYl5p7CHJiGyzPjP
	 fbP9j3hbLNeuuilATbUIlGQAdEg/S8FEYszJ2hKE=
Date: Tue, 15 Jul 2025 03:44:37 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982465/000000-e4f87a@github.com>
Subject: [bluez/bluez] e4f87a: doc: explain SCO BT_SK_PKT_STATUS socket option
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

  Branch: refs/heads/982465
  Home:   https://github.com/bluez/bluez
  Commit: e4f87a6ef9bbeae64e1586e56e99fd9feb59b250
      https://github.com/bluez/bluez/commit/e4f87a6ef9bbeae64e1586e56e99fd9feb59b250
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M doc/sco.rst

  Log Message:
  -----------
  doc: explain SCO BT_SK_PKT_STATUS socket option



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

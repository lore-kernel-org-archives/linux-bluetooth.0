Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E2386C15
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512560; cv=none; b=tUODl9Fzjb6mnBYYFOq0K1ujBgCsSEUHqE5zrVsS5Nfe7N7Pcdlofz0LVmRv1t99yM3tdqC8qNIOKSVf3a047Fyg/RGNv1fgkY3qt3wFN0n1/I8LEqpzi02QuOKqFTFM7aCYnm89GK9xW5N/n0kXquwTLuWoP8JsSx4CyasiSWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512560; c=relaxed/simple;
	bh=JpnX3OiNV7hfK2sNn2/c7Siyt2/ADVppDJSctTssSh4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BrgApkG1LC/SoxIPj35RIbut5HrYrXo8H6B84G+d+lHZZqtYSnAwVwHPsG+ux7F5nXFLTKbsrNp2TsLfsjmr+khZpO5VAb93rxJoV6UQcCSN2DXyMFo37kcD+ZNRRAHjpgUQk/VDMTn8Cg9/KqWPKHHMQAF5aVkCXzo7gQwt8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hz5v7aKV; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hz5v7aKV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783512558;
	bh=oBlfndoRES/VwF8u0F1JQoO6DGOZLw7RdQG+W00qsHc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hz5v7aKVxIZVrrV/ccMIdqlVHt3cuqYBveWtd0YxvjiL3CXMt1n2qPk8XXvRmDkV3
	 myo2Qi/2I1q1Alf4yYVCAYL9nySeabi6cadzFqf+pcn+qbMH9XJQnD+2Vwt99/dQAf
	 D3jPxvfAPEpYHoY0ITj5rnSLjp9gKOk4xG89FXAg=
Received: from github.com (hubbernetes-node-1c45f10.va3-iad.github.net [10.48.77.60])
	by smtp.github.com (Postfix) with ESMTPA id 4EB8F808EE0
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 05:09:18 -0700 (PDT)
Date: Wed, 08 Jul 2026 05:09:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107783/78a1c0-000000@github.com>
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

  Branch: refs/heads/1107783
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C521271443
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614655; cv=none; b=cFK486R1NM+QEq/W8kzpQSvpJZ/EkrQBTpt0VTQyijgzAjr66tN1MFE9IHVerDj17CVYW+Le2UCmYUjWsYtMwCRnxhHlDRWVaD9t0xrsC5iReunWq7w9D2pYJi9LaeUA1akbSp8en4xZwOpWfWyvhqcFUlqVOr/LjQsJVKCiYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614655; c=relaxed/simple;
	bh=WqxkWvXhdXoXo9zt5JiT517Ukt6UVKh4F57+dt0nDhw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uXZ7ISguZtGOWo5OCOf65gDPWGghk24VVOqRUFBEFTodiZ+y0dXaFD6T9NeofKZr7RARLLuPWtVMkMeV2E4aMTs2nDGw0Pi1rExZETzG2pbJny8/dZQgYPL7CcijTxclcryqn0tD85AnqzFRtP2iPcXE3i1IeDUobfdyGHa0bag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XJdW2fJT; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XJdW2fJT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783614652;
	bh=bv3LvlH/H/XquLlF5LSiQBcCiy0zgdKVL1sy6X2arIM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XJdW2fJTUgG9qglmiVVBcN9h868QSyb8plVXBtyBeTH1v1alwfbBIbcOs8Pyy406j
	 8P9eHWY/K/uwpU7eJCPHDgM438FPK6IfXC2AmU764aKSPnRsxBLRVSda7y17sAcibm
	 sNP9ODqds66DML6jzW9OOfiJFjBgGgquFQyPx+DU=
Received: from github.com (hubbernetes-node-4c65bc4.ac4-iad.github.net [10.52.169.44])
	by smtp.github.com (Postfix) with ESMTPA id 42A10A9C4E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:30:52 -0700 (PDT)
Date: Thu, 09 Jul 2026 09:30:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1123298/5a8416-000000@github.com>
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

  Branch: refs/heads/1123298
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

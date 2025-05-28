Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52B28A415
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448809; cv=none; b=r+/Fhf9rXTyXBpC0vLw3jZJis3/B3dP+mjw7UlTfF59QgSGk71YLs2NoNIyX5s6HN2vwa4wgO/+Z1bb7J43oWwXBwplxUnL8eGN/FHBjIdqGjwQcdRHDvyIWKCI7wG5cCvLvKhdMNRvDhnTLfbPMmt7n4/jRhBUVLYMJHaMCpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448809; c=relaxed/simple;
	bh=4gdVBB11vsrrIFLgjQmzpADreovJtLBW3AMfI4RgHKU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=alJ0MjA0dIVqMSZe3NqEtUjVMkQxwJZ8mdHWw7SiR8SGH4KRYP6fT1yjtOtq+isgngxM1SqKF0Y9GnfrUnXI6yAAJ+O2m0fW9oRcOK3Ft/sqSgXIyVJjBI2tydxdSE0tTP8WFWXMzlUWhQt8hmlv3nZWG/j+4po5R3GZLFaSVME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MSODHsFA; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MSODHsFA"
Received: from github.com (hubbernetes-node-a78c878.ac4-iad.github.net [10.52.14.47])
	by smtp.github.com (Postfix) with ESMTPA id 6BB4F6411E2
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 May 2025 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748448807;
	bh=Hsp93WJoBxptrqFoRJSIE1wKMQBCAssIKkg/07xJ1H0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MSODHsFA4d5K27w9b1v7dpF9RjopWmZh4TVEzRtnwgyhwo7/zWZPCcD8g5SwJS7Vs
	 FrqC/dlJbZXqiuYaUJsLVWfOq7cgTOQJdj7pxtVfjqqkrlET/IAp3LVYzY39I5I+i8
	 ibVjF8O/904dwIWszC1sp7G0Z38TKMWXRBbS3SgY=
Date: Wed, 28 May 2025 09:13:27 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/967039/c2e4a1-000000@github.com>
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

  Branch: refs/heads/967039
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

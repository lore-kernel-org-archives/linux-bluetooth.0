Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D351A4A04
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011650; cv=none; b=i08PLsBrO2n+N64FQ0N7n0qjmDEGXbBEteG6e8Y8ZPQ/lAKla0GPI/EG5n0tFb90N0t17mlDNnFKs7w0aeHXbdB0xUVkHrhZKUPg20XEgf/Xd5fWyvY+cADTaboNzGPD1pQwEduFPwbDmmqR+qvi09uIpqMU9SzkzZcBdxTRuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011650; c=relaxed/simple;
	bh=ID8MHpAfC3d0QNUVHLakhC1aSoIcjmEBKBVDgQ2vxqQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oJ0VcRkppJEmfwBYnc5d7hFv2W/NdLmJJP638eMCbtAn/CVmsmJ9JHQEYjqcDF0yyQ7ZffV6DxFbJoG/sCAo73aD7jPSHv7eFIweI8VS/HFTAgNLnm7l3Dl/7ggwpTLuNQC5khUDmVjeXKkkpPnLftQH3qBc2YXtM1RWo+B9M4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EJz1Park; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EJz1Park"
Received: from github.com (hubbernetes-node-4264a0d.ac4-iad.github.net [10.52.176.37])
	by smtp.github.com (Postfix) with ESMTPA id D62036401B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755011647;
	bh=6yBV7cd21o/Hj2uLw0uEYguho9Ybf/X5wSclMltTo/Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EJz1ParktsAzRXZg57rsTAOzALwgfPhF9jKW3JqmYNrVIyZ6VwRpCD7/PyTVvT4oE
	 62MnPr2y3VnWI0/OOtzDPYP1/lhWdyoXlvVmz/hez8n4lD3fPSxc1gveO9OAYi7IP6
	 PT2ENigslfGpqVN6ui/1uB1y5jzso4X3n9tf9jd8=
Date: Tue, 12 Aug 2025 08:14:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989263/90680c-000000@github.com>
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

  Branch: refs/heads/989263
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

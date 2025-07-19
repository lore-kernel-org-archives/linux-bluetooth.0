Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809581EB39
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752936997; cv=none; b=TA7RMid8OCSvxJSvF91SAIFWNAZq0Ry5jkrXv913VwE/GW8N9ifgX2rE4C2pJ1PxOGaUC3y21zpcswYbBuHai4zGycw/2K5evD1ZKDtVCHP9oUf3oV2V6vJDXOUmeMgWRjS3see8hR6+6paLDzKANTerC2iwUevDXpatz54YLOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752936997; c=relaxed/simple;
	bh=KiHs35IlsMol3m7sA6wf0nxLHIH4W6M541WCEbyXO5c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PYa0z0NuxKri3v2cWlxeqGADzN8vTQj7ejrYcwZxXflumjZHZ57Gm0EfO5L3uhxtS8+bKGB2JH+wi54uWwFu8JDSgX7XdPZT9A4CSXiyfuZEHtZ2pVfL8RNi2oZ5DoZrBJDDxnX7ISFRg4seCOBDY9NdGmTYtYAVsnCyXLDtfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=bDgvFpLI; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="bDgvFpLI"
Received: from github.com (hubbernetes-node-e042978.ac4-iad.github.net [10.52.167.38])
	by smtp.github.com (Postfix) with ESMTPA id 76EC220B30
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 07:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752936992;
	bh=f6pxwvrY6pPEMkkS1q0JxVA/gWxKuqaAAsnoqDiB7DE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=bDgvFpLIk1IXB9SlI5ESXO1INrZa+enlL3sMOe4e6lxpRD0jL0Gf8GJrSrXGSkfnu
	 U2knEViw8JG1cVLGIU296ABdMpvZ0qXMvQXWJK4+P/bGtEIXJf20/H91O4E52RbVC9
	 +hwl2DMGZWY1q60QD7ynEGofGQjlg+BmNcMlEruI=
Date: Sat, 19 Jul 2025 07:56:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/973863/acc5f9-000000@github.com>
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

  Branch: refs/heads/973863
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

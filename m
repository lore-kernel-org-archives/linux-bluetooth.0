Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F693F9D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023042; cv=none; b=htvsRzgb6H7vecm7pMUEvb4fqlvIkB5tNYAnVy3sxdsR/3fG090YSSwN9WODAuirVtnZbtFuxzE2axNXLuOLwwV8OQY8hvm0ETr8K9zQK40JmlogWWSja4D/LwRcpVPM7NkLa187itRn1zX2PDWpr/1dNAaITWm9dzcd7UswNeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023042; c=relaxed/simple;
	bh=Jot/wt8n11rT66VH81S2D7Sa07cVXiogG/RMNKgJ+UY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CwKC/jvmu0LUvuJ3dp2UcMSRorplRYLOM08PEX4Cgq26aQr3sROs86Yr7T7q3UDpagEuVBy/dKmO2qVbs5nGHz2YHn4cmzYdSWgMXLJwhoQ1+XC3W976DP2wwfSHdL0eDxXkVkbxV/jrRnTMPdm1CYudFcZYNLOKiQ3jODXfwIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MrNQyN/t; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MrNQyN/t"
Received: from github.com (hubbernetes-node-8012e95.ash1-iad.github.net [10.56.155.34])
	by smtp.github.com (Postfix) with ESMTPA id C1F31600B8D
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 11:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755023040;
	bh=sqJLZnHHpjAOmLwBXGUOyD1duJFQ47Ti5fNo1PmzSMY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MrNQyN/tv7Ysyi8aFwdxbMpQW2jrzmdmrVEayJwf04pk98252jaIAY4qLYmfufvPw
	 qLQvqOZDUoS7H3ce/ewLBkNhFSNXxzbISZ1pWz+lHhzYCsEDDJZ7JhyWsMTkpHMvXk
	 IMym/ImgrmEEGudTxyfx7eKi8UAKzT/HgUjRrdZE=
Date: Tue, 12 Aug 2025 11:24:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988599/784cb2-000000@github.com>
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

  Branch: refs/heads/988599
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

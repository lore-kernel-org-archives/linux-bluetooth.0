Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A8469D
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 04:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748841; cv=none; b=OGuFZP3cvIw9oZ2Y9w8yVgcp8Yr5d22H3apZ2TxmtybyhDNiT3NC+gCr9D4dmANqGV0dgsRGyBx/0YKPTgnBM8b0y6fONlCTm57KL38+WdGd31Jg6aFxtjw58YQBd74541xtjML2MVNCFR3ujSBvuU8pL96VmZoZ/ulPmKsmqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748841; c=relaxed/simple;
	bh=XDkKiFL22EOJ+NWB25UTF9NvfnHG51QiOUf0K7ZZVig=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AYrjkfnK4zadwaiP0VPZLMMJBPymIlC+c8zXXdA9JBPzdbeekb1sFhdPVDhQg613GAXa6mWS3gHTwbnK5JnDbgY38d1jMIIXFZHhhFMt/C/OQs7Htb/rTMLEdDgZgY80kRwgGmRPeJVZU1CtrZbktnuxj85kysmo/b4Qa31UD0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ValtW9ro; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ValtW9ro"
Received: from github.com (hubbernetes-node-86495f0.ash1-iad.github.net [10.56.184.37])
	by smtp.github.com (Postfix) with ESMTPA id C3DC86005ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Aug 2025 21:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755748837;
	bh=B5oUsKPSYXRiixoejcLq+9FOlg2OtIBD+U95dXAPTds=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ValtW9rovaX3XKlgxuHbrzWcJyaCrwZpHCX7cr+1gRUchDLLKLdvAthxywHLzTby2
	 kCzGHeLDBdB9JnkOfjXSf2a9wPOjShKEejfjUHQOtkgPvp9GFVXGn/EnKVpEoif8BB
	 c9zRPv11S9a2nhXl6UHZ8Nz/W9qSieepvqB4AJsM=
Date: Wed, 20 Aug 2025 21:00:37 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/984529/7ea4b1-000000@github.com>
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

  Branch: refs/heads/984529
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

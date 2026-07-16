Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E83446CB
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784214703; cv=none; b=ZmIps1DhcFtKwGhUPtqymj2Z15/b8XBsyleP8mbYZ2UGe3K/CHlmCe4DfWoiTUaCp3iWnUbqSPn68iq5XtEJkW1oBXonmFIQ3cOA8CvLDwBNnrZxnyVOElRPK0ck8YgP+HBxQ6ideu708p70OglN1B8OowT/cPvmLPEi6UqfWEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784214703; c=relaxed/simple;
	bh=LS9WA3FSeSEwqtdsX8JpocXHusFc5uqcjKrWQFilCrk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KjBJoE+SZ1prALpM8ZGoH2/cZ/aAfNKcQ4+gojIuf/FolmHI2o83lQFnw5hz01Y9PX/eygYKNBB+t6XpmvEy4IA2XZPxPZ2oyXMCgMsbH/01XI+jAQzn6C9qXHmZCcF4IUCAp+WMlvE+pLs+jaOlbzb/tlfIwQyYaR88mATS0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aREreaDg; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aREreaDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784214701;
	bh=j8NmuQwcQzK3tHrpgePi8QuhhBr1VeQzfvXuELhnaSs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aREreaDg99JM5f3xNDB8w66h53rFYiRo3dyFHgFGFoW3jGpNoB+PQPvMG6ApJOeOZ
	 ND3u1/pe4kVnkpmgkF/R1WcIm5lodgI/Si2gxt+Vdl9JEsL2r2BkpEdcEC9PUZDn1J
	 Od2RlAFuF+D6pCVvJvNYovlLAwFm/FadSltHTk9U=
Received: from github.com (hubbernetes-node-f285f12.va3-iad.github.net [10.48.180.57])
	by smtp.github.com (Postfix) with ESMTPA id 73E2680108D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 08:11:41 -0700 (PDT)
Date: Thu, 16 Jul 2026 08:11:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1123273/445547-000000@github.com>
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

  Branch: refs/heads/1123273
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

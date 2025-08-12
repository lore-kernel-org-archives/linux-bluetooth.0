Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE82F83A1
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023045; cv=none; b=a/mbOA90LlUEsf0SlVXSBw0ht+OQ/f05q3DnvSBRoR9vMGqpzNbaB5UespzsMm3FuyHyFhKElbILJA/sZ29xoQItwvimSFQheIicft1gt+noZQ24bbLwO+xin6vbOv6SBeXUZcME2KdBAcokzrDsM499AOGqY3GQkHthwWUuuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023045; c=relaxed/simple;
	bh=s25LMKuY1iQbinq3rCR0YY6W9CsLEdJW0RXf38ysTpI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cXvz1VSlbygN8mo4yjRO8ZrWTiDPmhCxh8ok5JcRwH+DMVarMmNKvs743bNlELPQSEuemzZu3ZYiuBt+fwDXPaKIjoTHtqnyJ6pAlifDqTWIUWucus3Fn7RcdmXM9pb90i1U+OKFWJIBcC7wpqu4YTXZZ6xFgajNfrym1hzTdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ElPliFuV; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ElPliFuV"
Received: from github.com (hubbernetes-node-f42130d.ac4-iad.github.net [10.52.177.33])
	by smtp.github.com (Postfix) with ESMTPA id 37EAF20821
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755023043;
	bh=CSO5+WdjjeAXf5NHKdWL/cBB8a9xHVpmCmVpNj2M3Lg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ElPliFuVSniqXFxHpmacb59WfGlo3UbNop2xCgxVD0HXWtM1m4kCKKVsPMbZcfiJO
	 zfsxlu9ClhZWnry5jOq2O50LeWahc+wkO1BqfVYh/4/H03LiOTnU0PmDWVcGKQklh+
	 eZBiX+oTXFRBZDhfxVeIFVyVEDnFe4W8wsvKrxRE=
Date: Tue, 12 Aug 2025 11:24:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/988417/935713-000000@github.com>
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

  Branch: refs/heads/988417
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

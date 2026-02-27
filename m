Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E12472A6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205995; cv=none; b=dvHeLsq/blwxsqPNTZp8DS2T5BcfcaxAFqMf1Mzlpj9XgLjZHeHcWylyv7lNMdmvoFb9WuWkQQPoGp69scK0DqL/6MVOO09/wduJjTc8IPUa7+E41v2IUdfymXmhVe977qPodNz0IrTlANsuqnmSXWXWhhdIjnOLYd//nwqR/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205995; c=relaxed/simple;
	bh=zma4D+DqbVpr76An8MgZE9Jbc8FKY6tRDeOfpyVfUQQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bqrmIC/qleDrbu6MXeWTtIrVK4sTbIcaQxPHv+GWRALE7FEMPdlscXmj5nWVGqVYlOeZe5jFK93Jli4kY2LcP+IIJeB0uBtoOEhuIdhu+l9W3ohBZ7xs5UpOwk6jviJQxuvi1P0c88rUnD6tMI4XtCsLaAG2bn1FPrHWhcWgKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RJ0oRdBW; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RJ0oRdBW"
Received: from github.com (hubbernetes-node-e034c63.va3-iad.github.net [10.48.13.18])
	by smtp.github.com (Postfix) with ESMTPA id 26A483C1385
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 07:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772205993;
	bh=PkNazDWTvoyXDqXhjAV/r/v9ah8f6nss5agrXcmQLcg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RJ0oRdBW3/nAi3vxaZMwee7o53LnXy9jI1uvB8OhEpPGBsMHZKhg/ksZQfqvezPmr
	 DpGz1ErTgkUl3u/CHhj4NHXSlIICSZqL5eHgyAyIQ3JHjUnbX0HBI7LdEMOcEtEo/F
	 W7fFQozSoCKDwR6nSAefoG0W9XLlAdgKsfe4psOY=
Date: Fri, 27 Feb 2026 07:26:33 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1058931/ee344c-000000@github.com>
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

  Branch: refs/heads/1058931
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

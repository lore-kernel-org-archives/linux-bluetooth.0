Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58378F29
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876586; cv=none; b=pacAT3MknwGhBOM3zrh3AkuESLPHABDtAgtZa+PMBnoIadm86q6CJI3thNxpNt0faIeo6BLZMDFmIsQMVENopliDybxRI/cYfww5ThIStNVU6gYgYNTRBS6KfDT38XjesHWV0BSQjANsa1bbMyDs91+3wDFOLquAUz1mIy00YCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876586; c=relaxed/simple;
	bh=lHR6PA8mlm9uCQ+JVi1GxYPtgnT0sO4llsPrX8znzZk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e+Nqqo2OYN0BY23mAOLO1RHzKYB3Cn8XpH1H+FlxZd6B0qg1FH3dcs4RZv7s6R2OJcwbQJqLgySs4nIWkCDtbR9dvWQPFQluIMFJzyiOECeunSoEsYlbBeOCCen2JKFlL2Hg6eST11UlN5SFC85k7RNloj8Uo79ymEgcg/WH+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QRL2WDNw; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QRL2WDNw"
Received: from github.com (hubbernetes-node-63787f9.va3-iad.github.net [10.48.132.31])
	by smtp.github.com (Postfix) with ESMTPA id 4651FE0447
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745876584;
	bh=OrfS/whl8EMBKA1vRXPDtuvnoy4KHtZ5tc63GPKSDrQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QRL2WDNwYH156Ge8zvcxYD1f5nQh8zY6TgUr4rmi9SYwWQG5UlBhO1SzPceexquZ2
	 7T3uJ8g8ZM1cezdOk0lPRViUEPgBYX6zS2pUW58hNyvT9cF7EzBLMAJmuLbhrJlW2d
	 OLeW8n054mbglg94jLkb/OHLpxVJH1zCKYBv816Y=
Date: Mon, 28 Apr 2025 14:43:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957795/eaa24c-000000@github.com>
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

  Branch: refs/heads/957795
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

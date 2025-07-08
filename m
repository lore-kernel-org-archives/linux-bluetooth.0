Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747C1DF74F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992852; cv=none; b=XT4rXzRkmGmqa7RryBTRynVxk3jAU3EaTquwE3WDFcxlaz4EeAxrtFAC03AngcVlvjiKhW6uZBgVQyOaJd73pI1kX86e2MbAHyayDKMgrhNH034cMkCln8Rc2m+AapWxhaMo5zW6E3FkVUh9zJV20HGgU48e73/4cgdI2kqnQIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992852; c=relaxed/simple;
	bh=zNNc46mR4V+3r6Iot+7QscU7NW6njLLn1RJLgMYO7V0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=O71W4pBAdm7w5k0OSRbGN0nveZclO2ns8W2w2lySS3Po9Lr0ds4mZoFphbjXcHtnKhkiW8rRzGTwHypFvwJlMqtwV137BasEfmuoDRLrCEBOeRZ8vbjcOsqtcrurD3jhzbHCaP1v8PBaZUxvGoLZ4CPv9eSMbea6I6wrn7CdYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ujwm/T7A; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ujwm/T7A"
Received: from github.com (hubbernetes-node-33e0606.va3-iad.github.net [10.48.172.19])
	by smtp.github.com (Postfix) with ESMTPA id F089A8C030F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751992850;
	bh=C+/K+ryd4xYaZYdjNnzNYQ+Dbb4TF/BpOZ5NRMjuLiA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ujwm/T7AjAeYTOMh4CZn7gFtvngb0U61au743y8Gv/3ys9DtV3x/BX/y1GRXAPpFo
	 rNv7gIjHUVbwboF2iWe1CkJsFM6kS5mbUz90MVNxPSz0k65VeAcHp+5Hv2BO7YwSzf
	 HUMAZqdzEL+MakcCORPrpUGjnn39WyQUcbTgEKKs=
Date: Tue, 08 Jul 2025 09:40:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980101/30d642-000000@github.com>
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

  Branch: refs/heads/980101
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

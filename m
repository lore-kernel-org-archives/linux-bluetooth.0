Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2B47D929
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709369; cv=none; b=cONiGC988X8U/EgxkwfIewq9n191CwO5kTnxzgE3v2MfbKMdD/l5uRzlkaiQHF0TGru4fh0RC5v8K41DvAWcM69IiM3N9jeVogBMJzuNODTQWRFC1/HMJL2XTRgHCLx20IiFfdWpDbhgHJj5lo1gdEiLe8fFzY18q15qbO0Y0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709369; c=relaxed/simple;
	bh=xydSv46rcHFYsTVeg2oj3v5V8JTJ1yDrnvAFJdgnXvM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HlytAxL+ypBaWKOZwMtIkQGxinwI70hEB4LoLz+B1Eim5NrFOE1chyEwiDvQXNrHeU/UAzyQ4D8F/nyynxegub+JO3WUCnvEDGPnGH2MQDtnYKpqRuGJERBm8RN64U0b3a2+v3wW8IBIbf90DnLYLpDjIzhP6qnjcHwgkDjwHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iA5i3AZp; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iA5i3AZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781709364;
	bh=66QFtYHTnJixf4wUMZiGyPIqCD5+BY7X+EbG6NQmAiQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iA5i3AZpR3vO5wnvok37cokJBnfHwJOyy/jRxM6tPoUL1AddmiGqWGP3HRk2oHGX7
	 oM9tqZnG/zkvbvz2aQy5XSnG9LWSD3WSMwsVdPjuzHfio3vZRSesdmUlzB37xUrCEt
	 00O2AsarVBiBHLlbIcIGXxPaMdFHP6qc2qmACkvs=
Received: from github.com (hubbernetes-node-a4af42d.ac4-iad.github.net [10.52.13.31])
	by smtp.github.com (Postfix) with ESMTPA id B780D402C4
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 08:16:04 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:16:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1112321/4f34c4-000000@github.com>
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

  Branch: refs/heads/1112321
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

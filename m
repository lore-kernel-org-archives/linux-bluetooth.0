Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6838D001
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958914; cv=none; b=MgfTKxGMQKUr8UBj4GWIsNlWZv/vmakqbhS0qATjufxcDhioTCq0+8rci6GJSmLlMr7lpdTdJSaTMZ+EzRTm2PdPLw0dyEALa89Ke8i0BSqs0jsrrXHNC3/qreHk3HQZBLGDswrCm3Z7V1WyuWuB3S5+G7WPk+wF+tJhi0GJ+sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958914; c=relaxed/simple;
	bh=FYkuixbD/ayC/jisIMj4tT4273rWmXR6fPslqRbAx30=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=a8H+XkSRuTv8tQ1ud4lqWo0upqCd4PLc0HsO2f8FykhOfkMQWd03Xu851592sL0ksaQlsOr4abVQ54rcOExoxZaM+bjCAdgDrg3A1nA0zzpamGkbakxZLJN1RtqvlNN/rE20XjdADLsC7X4x4WJ1aq+aIvIcbrKwmcBWdZ1N3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qyqsr/2r; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qyqsr/2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779958912;
	bh=fTT5cADpj0OJv1WAaD2giK4iJ+bGtF8wJjFcwswi2is=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qyqsr/2rC9fKjl8gdKXgMGsSbklQ1YfdNq1kEnIxUDSGOeGmpbgmzb6l/WxoFJNjN
	 FX8Iarrk1ffytlpQ3XNPmxNOgLRoAVH7c0XXSgngtghakj2Q8QNKlVe7AQXiIMBCMl
	 acKxTHDOD6XLGQ5+bH6bmESJmv+hlmXsARSLx8zE=
Received: from github.com (hubbernetes-node-e32d07d.ac4-iad.github.net [10.52.173.43])
	by smtp.github.com (Postfix) with ESMTPA id 571B17410E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 May 2026 02:01:52 -0700 (PDT)
Date: Thu, 28 May 2026 02:01:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086648/37e808-000000@github.com>
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

  Branch: refs/heads/1086648
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

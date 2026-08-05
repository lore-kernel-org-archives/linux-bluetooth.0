Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79D348C6F
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949028; cv=none; b=GFB4pejGfvEp3XheETuoRleCN3VeUrl8A/fJFq64NfTTiBu6LqB29M2bRpHaCfUXYncYNXhh1uhfUo8Dfnp94EiRtVDKiVaUcvW3ENrEPl7Y+RMqS4IN5NXKmZk91XV9bvESEXqgKKQFshIfU0cgCZqmn2fSRzzuNEhyb/ZEx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949028; c=relaxed/simple;
	bh=ilJq7PE791+jGzljRiZSHkjd4TZLfvDf6E4tLvJ0a6g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CgU+LFltJ9qT1Il/Db8tu7S0b103KkyiVEVgkgSqAxjw+r0af2Xa5GSmOEF1dF6c8vALnRD7u1JoWGlqWC/EfgklILdSv/WK6w7bXFtMvie4TrHeBNvhboGPreyXaluxP0eEJoq2zC2gayzXNoHDHb3at8Ce+XhBq80LTFGm1yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cUse/43/; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cUse/43/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785949026;
	bh=O71WCRYD1fOIxmFFTCLO2HSSOcs7wDLkNmzJZOdg2Hw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cUse/43/4HFMaXU80GzU+iy38GX81jNxBHogxrkbGhnbYRhI/jHCj/cctapw8WGF4
	 l7rrKqWk6oXP6dyZHMVTQTqHnGg1gYc3SwglL76C+rCLtaezD5sYNH6lwaz7VeqHJa
	 7Aaf+8HyTZZbpWeKsrhpMS3zFJ6jy7pNPvWkoLqQ=
Received: from github.com (hubbernetes-node-b40c017.ac4-iad.github.net [10.52.171.49])
	by smtp.github.com (Postfix) with ESMTPA id 52E04A0183
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 09:57:06 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:57:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1122551/0606fa-000000@github.com>
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

  Branch: refs/heads/1122551
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

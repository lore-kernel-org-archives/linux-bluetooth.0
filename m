Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875026C38C
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520631; cv=none; b=mXfkEUmQ/bPoTZeu9rgnAD+d+wuHIssiXB+sDA6SJh9zpKBXFTP//3bH0FNYvBmB3t5jgIhNZw65qszmes0FtlCSJrZGEHDdObyGlvz/rpRVpwwMeBBhXDsJfR7yWWCS+8IH4edyiLOFTsfN6qSzdZRvCIh6JWZH+jc+sISGlaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520631; c=relaxed/simple;
	bh=HHzSvu4OrL84TgJ+Xb3RpHX7QDUtqorGs2Wkvc38A9Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YY3a7KjIGA/zfyCifQYNqnYvFNLAaaoAUbsj5cdrqd+xjNwbTBmgNEZ4lEsxsItZTF4T/lu3/NgoaP6u0x5e776GoU4CtlSbvQUl5BD/5iSZTuBo2JthIemvU1jxsefg1D09oDY3DZhwBwiZQKSedYraW1z8uVGn7KzddCqgTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Oey758Al; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Oey758Al"
Received: from github.com (hubbernetes-node-6b043df.ash1-iad.github.net [10.56.148.46])
	by smtp.github.com (Postfix) with ESMTPA id C11D29211E9
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 05:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762520627;
	bh=5iDuvxXsTKtMF0GfaVx+CD/I1i3VW2Zuapo8Kb0hsEU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Oey758AljNRDR2JBCWjlQ7lancXfp/HV7fVxFaAR2aWGr603uVqhyNWH2UULHcChH
	 a/ALkN0fGwPCrAixGXBDqTOKQPZI5mT9CneAXmkCC/O+hPJn4WSYQSF8RwL42ohvhG
	 8FW3eE9usCn9k3db8c7VGjTHlWUKwtzGc/0qpwSs=
Date: Fri, 07 Nov 2025 05:03:47 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020865/000000-102f4b@github.com>
Subject: [bluez/bluez] 102f4b: The GATT.Client option is in the wrong section.
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

  Branch: refs/heads/1020865
  Home:   https://github.com/bluez/bluez
  Commit: 102f4bc5e3da84972ee92e10b85e47c49e0ca539
      https://github.com/bluez/bluez/commit/102f4bc5e3da84972ee92e10b85e47c49e0ca539
  Author: Pavel Bozhko <pvbozhko@salutedevices.com>
  Date:   2025-11-07 (Fri, 07 Nov 2025)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  The GATT.Client option is in the wrong section.

GATT.Client is currently in the CSIS section, but should
be in the GATT section. The bug is that
setting the Client option to false has no effect.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

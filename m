Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF5A256C83
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205879; cv=none; b=Ry3I0gjB+vrX70ySX+U96QrXsExG+r1YukJVIqO2oRuRbuTeU0U59W/d0mE5iZtn7wL7/9edhz5OLDeTFJhuYsYdCnKt/0Cf1oDyFRkEA4a6Bi9OrveU0S+ycq2q/Zy0d+Rhh1D1rFol4fe1at7vMVXiXqpZBIvIeWZrNfz+BMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205879; c=relaxed/simple;
	bh=QsmjLCnCY2B33bUxVXb30HzcsEy9ghOpR6Rg8t97yxM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TbEgytI1DQnluzbOOWfrBh+iA/AHxYYXMURQwKB7EBQ4WAJlVHMl7OPyzMD2Dc6bGIHdSWJsXonRwh+c3nh5XCmcawieWcH+HkAutF3ceDepQqdnquCo/gJo+QE8pvJ7CnOF2YQn9dEpgPw2XRmxS1VeqTB+1UuGL71+mqGw9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X4P0+nOf; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X4P0+nOf"
Received: from github.com (hubbernetes-node-d987fdd.ac4-iad.github.net [10.52.206.25])
	by smtp.github.com (Postfix) with ESMTPA id 9684A20957
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746205875;
	bh=oraB4CWYFmhjZU+BnYarBUj+wzhbOswE4/o4//pHf68=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X4P0+nOfZsgH1eCupJ21ubPE5S5hoWDAgcmNR8YivTHM8a9IL0JpdQ89e+a022PQU
	 vVN30JuPk2pRzXR02n/qhk+qLsx4LrqGfC7VB6WY33bWAJ9krMGGkhIgcix8Gt+9PD
	 2ewoIgkGSW+/VRLdPsEOohND5mxPufCuI0Ithjbw=
Date: Fri, 02 May 2025 10:11:15 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959160/000000-0ac9f5@github.com>
Subject: [bluez/bluez] 0ac9f5: input/device: Fix not sending virtual cable
 unplug
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

  Branch: refs/heads/959160
  Home:   https://github.com/bluez/bluez
  Commit: 0ac9f51615ebb69a5b84c91f9dd1af813ec16e00
      https://github.com/bluez/bluez/commit/0ac9f51615ebb69a5b84c91f9dd1af813ec16e00
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-02 (Fri, 02 May 2025)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Fix not sending virtual cable unplug

When using udev HIDP_CTRL_VIRTUAL_CABLE_UNPLUG must be sent directly
since it is not handled internally like when utilizing kernel hidp
module.

Fixes: https://github.com/bluez/bluez/issues/1173



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C127BF78
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509508; cv=none; b=R3DbcfyjzQWNj1+qoSHRrawtAB5iR83uCm5C1WcW7dCVBvI/aIY73kGCrQsAgoF9d9RPq0R7fSQdQoof7X+DiVUV464vxsqSAcZmE/KgUYFW83JwMzVK4aZObwfqSpIQPLlqH/HvDFRZqq8/vuJg5zXFiOJ8C9zdAwdmM0PV3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509508; c=relaxed/simple;
	bh=q9se9ZLmUFSwaBBAa5Pt/ACHsgLYsp4fWrEszkqiwKM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PLBmsVGFNfnV1UcRaCDdky3+nF6Kvgr+fAZCIU7n04gvefMNlqIfIiv0UjJ7TuIdRUw67olNi2MnxBqlY2Ikh5P5Y3EIkzW629s0v/Y886flpg3qw+Rv8BSTsRH9fbRTOItBzaFu105fPIgFayDd25UP4NRlciYIrQjT9rSTi9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BeIINsKX; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BeIINsKX"
Received: from github.com (hubbernetes-node-6261fd4.va3-iad.github.net [10.48.210.87])
	by smtp.github.com (Postfix) with ESMTPA id 30B5B4E0BC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745509506;
	bh=sDaHFDC+QsgGPPzFXFmYRiJiyXGmehze+BujnRTLeW8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BeIINsKXQYtvodI0fTiWcEGiSQ7PO0jfCFLJ8+1ZtO6WlAsz4A1gugd9JFwAGNrTU
	 WemDCDNvfEoOdL53iMdwQgJpj+lfqHBwS+mvg1W3dYBxb2C9ravvcaBp3ql7LJmyU6
	 k4mJQ739tYF8B4PvEjdeR9iiCmbLd1y4s2TV5DTI=
Date: Thu, 24 Apr 2025 08:45:06 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/949188/000000-ecb773@github.com>
Subject: [bluez/bluez] ecb773: bass: Clear the temporary flag of the BIS
 source d...
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

  Branch: refs/heads/949188
  Home:   https://github.com/bluez/bluez
  Commit: ecb77367c2c358a75c5bda91dfd27fb6c237c671
      https://github.com/bluez/bluez/commit/ecb77367c2c358a75c5bda91dfd27fb6c237c671
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2025-04-24 (Thu, 24 Apr 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Clear the temporary flag of the BIS source device

When BIG sync succeeds, remove the temporary timer. Otherwise,
the device will timeout and be removed, triggering the automatic
termination of BIG.

issue: https://github.com/bluez/bluez/issues/1144

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

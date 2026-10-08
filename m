Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EAE3AD530
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478549; cv=none; b=OJvt17z2l4HqmrlyjGZ4NTo8mHeOoIAa0OCJDdBqoIh3if4kAempVUfLK4zAO/9O8BKFo7IxSTJCx6//a1z8+94UkZW1rHHN8aFjMpUXli6JqTQkGynAIXu71cLWCfwzWoX9H6cNPam516skbXrqlB3Vc+5GIhZ161tFT1gPV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478549; c=relaxed/simple;
	bh=2aBjgr6aUBXyz7AsRAtwD/VUIQqj2Zx92JdNOU7bX2s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ALJW42kqnL00M5lodMvArY4777ttKdNqcMy8nQUP4LPyG2qjoyKRa0A+felvnPNa++3dwDf6TauQFhYyEHhBpEIj/NHX9N8Ir7EIWv0+cCSewAHFvjqCdnIgBJnfsPYZPaZbnaiROId6wF2rDnFjXioXgE4qlAIutxkLANenTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=hrwbsdKR; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="hrwbsdKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791478547;
	bh=/uzmkYV4VKJj7fSBfYSORP5R/LylkcbUNCnIyAxvi20=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hrwbsdKR/aZr9DdMbtBTBzT8YebsRYdmtPKltR40iojZmBdyRw0EA5rAtxpQ8paS9
	 2eLe7kqYixFIyeNLPH08JTmVTlm3XvkpVplsyR4M69wF4Cil2EDKusRWG0lN4L5ajN
	 kdHTC3issMLSXJ8mNA5TrIaYDpKY9qhaiIelgwgp2K3+4PBH8TKDCEuXeA2tUJuBKR
	 q0xOQ/AwxNC15H03XVX0fJE6EIvluG/RiA/h3zUSwEUVqLEtDWu3b7o0fhd9gEdTth
	 cUUX+NQn8MuxLflU5h23ix605AcPAsBEaP/wBYB3vqulauzEfOdl58BAg3vgsN/ikJ
	 Hx7psXXq+ctkA==
Received: from github.com (hubbernetes-node-b824531.ac4-iad.github.net [10.52.133.37])
	by smtp.github.com (Postfix) with ESMTPA id 42335940CCB
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 09:55:47 -0700 (PDT)
Date: Thu, 08 Oct 2026 09:55:47 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181248/e7df84-000000@github.com>
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

  Branch: refs/heads/1181248
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

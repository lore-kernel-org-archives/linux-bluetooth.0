Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054672E9EDC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069642; cv=none; b=IR9+ObBSs5c9PLt0ursLnwNdBGDdKMn/XrcqnIntjtotLzXlzEjnKG9psv9G+lqrQ8w9CVMgsPu14yaYuwYujq3xYWIrPcNxvIHZFNVyuBQSXzJyXi/+GiZxfCnvhkVGfF9CewbK1GQlXVnbbrW31Sz5OGqFqAhiU0dl/1omu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069642; c=relaxed/simple;
	bh=cWDY9p/XQ59ZTB7naxVfhaCpEgbptZgIC1LOW+qLNBw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qzmSpUsR/sOAllrML98kT1d/K2B5KfunP0nEQQ0EGCwO1WfFH7qwWS8dcPgg98IFDX3pTETdILDIX7/LgPp5/zzoopwu/pKnj6hYc0cht77qVbTcK2/0WKIUyp52BLkpaZdxEDIJCIIOb2pjOoXrt+xyOJVdElrfLaNx6SWI5V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YgX9NH2s; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YgX9NH2s"
Received: from github.com (hubbernetes-node-eb613de.ac4-iad.github.net [10.52.146.37])
	by smtp.github.com (Postfix) with ESMTPA id 082606406D8
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752069640;
	bh=db5giDdXVjSMORhVTO2b+kEcSzkbO7Ib44mEYnTYWAQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YgX9NH2swgck1mkJl+cpOcc6MeqkaU4BiMKkhYg67XVTSWknqrKLF06IbrX1Li8eH
	 9P9P9h2Mo7gE4ecSRu1TU0NXyFmUzyAvlDebU2K/8kT9/1NyT2eESPfln4gCylqgfU
	 hT+96nOgjP4O/4JPwPGcDZddbmZWALPbDTZqNwmE=
Date: Wed, 09 Jul 2025 07:00:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980500/b55a78-000000@github.com>
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

  Branch: refs/heads/980500
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

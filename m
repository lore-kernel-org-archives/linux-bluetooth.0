Received: from out-35.smtp.github.com (out-35.smtp.github.com [192.30.252.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23313B47C4
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765475; cv=none; b=SlAjjwM0UEDtoLClAjkbLfEmNAATtKp9ahQGnxLzpuPSXLDgSFOZnZkg2wzv/RjenK0+kK9t7eI69oGdBPw7kXDp+KtZRdM8mpmq/XCOqvLBYQvcN4PtY+kofsrNxKU7od+a4/9yp5mLUbHmT3bt1RJ7zDxOjEXQxYQOsjKVq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765475; c=relaxed/simple;
	bh=0VtWD3ZnL0tfZzINicozQdmnkMhUfyDVQzWgGnbIiYY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qrmM0E0pMphdL8mhBNFXzHj1YX+oHeBVhQH7Lko4pRFQxtmpsjRe2hM8QoiYIsVXSdw16MupYvLKVsl/LzzBPPTnzY9P83G8My80s3eeVX/Ud8CYeN63k1CyeqKr51ApCTsNm1y22Qft6GuiG7Nx01ydp+yDicpBrcik6Fno/HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cDbXSU8h; arc=none smtp.client-ip=192.30.252.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cDbXSU8h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783765470;
	bh=XzTESEIswjc281CXt3sQLf/fO+2xNgdx4Ee7VPTRB1M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cDbXSU8hjnn1JJrg7feL96hp7dZRqtzmnsQZUrQwqamcM2uWQ8E1jHIJp5neHfEVG
	 Hvib52ozBERv3EnsapzWaD+QDEpYeIW1bteRsQ0vJY9AysQfwVhz73sQBMhLnGlfeE
	 0g2LgX5MUm5O7GOsTglR/EEGq3tDsiknuYr3ppAk=
Received: from github.com (hubbernetes-node-35e9fb4.ac4-iad.github.net [10.52.175.32])
	by smtp.github.com (Postfix) with ESMTPA id 8B1E8740458
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Jul 2026 03:24:30 -0700 (PDT)
Date: Sat, 11 Jul 2026 03:24:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1125549/00500a-000000@github.com>
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

  Branch: refs/heads/1125549
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8CF2D0C9A
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351156; cv=none; b=n4b5jZBvL7UlstqYUc5cPr0OcjOjk2UzyVnsEOKdtb98WzH5swEiVLDYXaDMNTVxwzHd6lNk2XPjLj68s1U9A1d3ejV3LFunHAXqftf3VAjKhTkEM0QlKd3w0FTnq5bWqerE3TRCJfJ6YPGksK+/GM7aCrAX1gBO5ziOgbvMASE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351156; c=relaxed/simple;
	bh=3aqQoay8h6GuYbEQaFmEWrolarcTjJR5Uqg+pM07WEQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=snWibIRruFaHd5xOdEGZdKyyjqlWQFP+rY6/DyllT1BGOiWH2CUxA/NQneWibko9enrjXNc0ju7TWOUDrkmDanpniQawHzOLkyTOgUVcDQUaWv6H4aUugcK0XWgZElwFqeiIhqycaceSAkLeusQJomo0uaaYXKjtA4HD4irPAWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ODsuSJhX; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ODsuSJhX"
Received: from github.com (hubbernetes-node-ac3b3c7.ac4-iad.github.net [10.52.178.44])
	by smtp.github.com (Postfix) with ESMTPA id D63FD6412E8
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Nov 2025 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762351153;
	bh=pJl8RFPDcbgqTNO7th3qPLSRML3jOmFbtBVn79DaKNg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ODsuSJhXgUAMFMwCzZlx1lkNRNwD5ohPlf92qLHI+WQgl4hTQ0FjtGRYv6ELKhxHa
	 CnZI/aUhOQ76s9ZlAGROCSKMpLiD4T3Sqp90wKdWucHnuy5z0aws0uUy33uvIVd3aA
	 At7q7rhbYIssCPVltjVNMVYm1L4Y8gt669BwlpcY=
Date: Wed, 05 Nov 2025 05:59:13 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019829/18e86b-000000@github.com>
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

  Branch: refs/heads/1019829
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

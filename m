Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420C28DB74
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929472; cv=none; b=Ynkddtz0m+ugmQskHpKb2Y9Oy5AY2zsWCDEq/+NMooyPIN4cGJAIg/Bi1TLJcmrwdiHqqJM2Sux5Df4tAzpL474TL/nQA+4vxDzCyyDyysE1dTEQq2olSZZvTIVHp1pxBnBi9XeYzy/SHVrQyADR8VB4/P9X0g+WtQsY4HnWu9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929472; c=relaxed/simple;
	bh=ug4Omo1FqaVOtfJMYdATdXVF+j4kXYZnb4X9TEtp/OY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R5V4x9bvN4DpQyOFLu6Jp20ER3W0hd/cdrtgOKU3caN57NBCjLxDh3W1i6mK+JCmuKGZkT24xXZNkhhIziWpRb7ixuILwCnUruyWlUlDTy9xf9pTTA8fYb3cBn42RO98Gw2svC6XRwBHqBvgtUmW3zZi/f02A1RH/t+exWc6t60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YUM5w4Mk; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YUM5w4Mk"
Received: from github.com (hubbernetes-node-2bbc117.ac4-iad.github.net [10.52.132.21])
	by smtp.github.com (Postfix) with ESMTPA id 79867205F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 08:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747929470;
	bh=QDM5WGYEtjZlE6TYJYoYHN3UW27EgVwt1afff7T418o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YUM5w4MkzNBbNAv3X6Q28lgngqjLSz03hWSI6mnOvXf3h6Kt1WJ+7XjbDZhXvlRn+
	 3SghUU4fD6UaKwg+K70lFSFPJVFEYRhcoKgqgjngqNKTPnqlFNN/sWsMglY/Pvkg7z
	 DxU5DFxWMbafDm8uOOfE80Qu+9wg8vB3JjrGI+Dk=
Date: Thu, 22 May 2025 08:57:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964653/74a9bb-000000@github.com>
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

  Branch: refs/heads/964653
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

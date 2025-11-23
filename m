Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1612FF69
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763892055; cv=none; b=tzV28lhJbn017UmCuTLmIQ6LfStXszHyOKk3iXvFZO3CM/OpGYi8KwDMyKZ7zv3mjxA0O37MVOwdM7sTCvIw03bk5DrcEyVc9BueYO2wYodXYAssVeJk3c/adyHcBevwlUA/7rNzkyXLlLLUzA/9SwcQnpIPQA3f5U5u/rJvf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763892055; c=relaxed/simple;
	bh=si+nU08tgY6Xy5LCEo+6nCs1v+tJJ9XcgsCawaY3A2Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oHR3fReKNhp+Hm2q6kdbSQfDdq7LN0VR9zdUoyZdQCIoomzUpdfLMbtA+/hGD1upO/AJ7U3jQv32xHPR4KnsF1nSW+n3IYV6DmqjHvAUOzlXXhPa8VX0WIK9Clq3oF+1T9vBzS1lT/TDUsFp+buI2fDRuIMoO/eoUb1hiB+oRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WwBmvpab; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WwBmvpab"
Received: from github.com (hubbernetes-node-4c3612b.va3-iad.github.net [10.48.146.31])
	by smtp.github.com (Postfix) with ESMTPA id A55D6E0669
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763892053;
	bh=Js7EHbVgCPe1H+fD8mUxf/fDxttaM9LUcOLBbBSrC/E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WwBmvpab/vEML8+0Ug+eptZyyiHgycKvcwitETXp8aznC+6YWUur07j1DDDslAJj0
	 +yZRfYEERSlnlEStCh011ep/95YwdDmHR5vFZ9hAsUp/rYPA8i1drgpjX5Z/jnDtOa
	 0HVRX0ZD+eO8JkxeP4XrG0tqS/FB/5w//FLuw8qc=
Date: Sun, 23 Nov 2025 02:00:53 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1015404/3c062e-000000@github.com>
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

  Branch: refs/heads/1015404
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

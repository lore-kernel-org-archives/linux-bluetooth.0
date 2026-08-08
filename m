Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5764C392C28
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 05:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786166645; cv=none; b=ImX1Gsv/2eRFRE94zXf0dYtCGwfoHqKkJppxYSIjWcFXTN/YQqudMEnzsRmo4xafa2O7Oc29OdtBOJzbUV9cGqLubROqTnAcOFGpbRuoedB7MdQ96GO6cmCTV68acKDcVBhZKnxACVeE5cgWr3bEyiUJKWQ9mX99o70rpwX5TJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786166645; c=relaxed/simple;
	bh=9GHRa2E5Nexuwltvqu+eE7seODBZbOz27Vm+4j+I9YU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EKbVotiHsw71OJYC7YqFia2jeUE8Ovqcq9IoEIP+QhLhZEL5BraTST2fB7DoBs6XKFoAGNv7dShe8g/B4dVP9nGbRfyjnYmxbvJ2OpWOmp4yVx5NFvMADJfYjmfUx46OJGXr0+OMFei1eU2b5Kn3BPrrEpJHpxd0vS0FdsKSIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GhDcA11R; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GhDcA11R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786166643;
	bh=u8A5hoHQitPxa7TaEQds7bCzDbLCOnWK5Y6bKN0mkn0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GhDcA11Rw8aGUseLiCgFd4FywSGpwpaxvc4D3oC2XKeFk4HHYanrrlw++tBoybiAO
	 EaItbdrxA49y+a6UXbcaMDr75RzyXLeD73dgfdRvbghzmfK/IZX2OqvHVJqykFVK++
	 fifTyCM0ZTAdzOXLOyoINyRgd5lImag7B+N9XZk8=
Received: from github.com (hubbernetes-node-c2165aa.ac4-iad.github.net [10.52.205.82])
	by smtp.github.com (Postfix) with ESMTPA id 7A3FA780406
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 22:24:03 -0700 (PDT)
Date: Fri, 07 Aug 2026 22:24:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142517/574d52-000000@github.com>
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

  Branch: refs/heads/1142517
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

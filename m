Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB26312803
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876992; cv=none; b=uOc6ku9aYGQHZEbIijonFQ/poKKzYKFMk20wO9cHEnhUiyHoPAem4VFHOtddRz74t6VH9zMoWo4KYkVuzB+s7VcTL+9YQ382Zr0MLA7vHGLZOfaDIWZ3DY+izies/KqjFHR2gMxxL8yQFjYxGVrumryFySjFTi/y/dXQZI3BugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876992; c=relaxed/simple;
	bh=kABa3ytikqXvSwxrAxyjzBNxF9FJoQCcEZfVwjM9Ijo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=P3Upt4PSTAvqXrWhf1gxz4ASAmGb1VNalHzz641K8A2lRLQFt6nZZUEDgZD2INkqaxzZiS/h83fimPSZmyMi2EwDuIsraCdFKBLEHm/jQsGjIB/KOoZXt1CaVl1EwGBKoBLGcYIXDLGD6qcx4hixOIOWlGfKRqZjGzdKgX1dtjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aTXEp0Ae; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aTXEp0Ae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787876990;
	bh=YUShci/RTUs0Y4Of2O4G+6maK05t22zWnOW45Im2keI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aTXEp0Aeub48OpJMDhKyKiI5+3dLF82dedAEZ40xeUynKqNAOFXKgtlzKJFPFYrJD
	 2h5PQXJ+5oFy/sQs0yqGmvJgbdqewuuiNBvJx5CwY8+DxqCoNmu03IfQt5rLku5bIg
	 rLKbuEEsJetpzJdvtJ/cf9oR8gDr7vz0UmT6x2vI=
Received: from github.com (hubbernetes-node-03567d5.va3-iad.github.net [10.48.75.63])
	by smtp.github.com (Postfix) with ESMTPA id 9B96B280C81
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:29:50 -0700 (PDT)
Date: Thu, 27 Aug 2026 17:29:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152525/a0f261-000000@github.com>
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

  Branch: refs/heads/1152525
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

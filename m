Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453D33F8CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779725403; cv=none; b=ITeo70YdcrxMk1wouX9I/qDqX4tiF5Lb2r7WcyAvFrQoE73PL9v3CDffLaExsQTF1XJWmSoSx9/Jff59MC0w2NjgIEfIeNOvUXCseyGG4EBJRqasQ1bDH0vLeDSd7SSafuw7ofrVBJ7x/V2qvGDuAXHdgGMphii/bnm2/nRQyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779725403; c=relaxed/simple;
	bh=I0tLNd04xKhlsuiT2/CofCurbWd+nY02ltH9wwKTj18=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lDOfsSAQy/T4eLk2dQVvbDnjUfXevEc5SPS9BdLtmGiEYczGoD6rPbFasXZSGJzJGvtgaizmlrMyJ3vB0Ulr2wBhzoJ80VrWwARyMMw5A36kxYvVX0TWllSQQfKuftXiiqDDf6MOh/5wc3gAXgFwRnO8F3Lnxk7A/gjLy2G5VxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W+Ty9SNt; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W+Ty9SNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779725401;
	bh=NM59ZzGLrS+H7KSTkXKWLLqZ4NVne2Uw91lAjXO1e8k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W+Ty9SNtHWg1qqcJjm+aiP9udGKlW7Xk5Je43lSFSwrwkfGQsgm1EwcYYYB3euDeX
	 C0W1E65IiDEGY+ln5dMo0aOcXE3ZTArrTpO6lLEITaYvWKVQeuEjq2cZtWseqsmfdy
	 iMW2aKnqjlh59tuPh5thm83ZNcdNWyb9OqwYyx1o=
Received: from github.com (hubbernetes-node-b977292.ash1-iad.github.net [10.56.202.56])
	by smtp.github.com (Postfix) with ESMTPA id BBC5036107D
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 May 2026 09:10:01 -0700 (PDT)
Date: Mon, 25 May 2026 09:10:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1100433/360693-000000@github.com>
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

  Branch: refs/heads/1100433
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

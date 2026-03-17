Received: from out-36.smtp.github.com (out-36.smtp.github.com [192.30.252.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE9322B83
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752925; cv=none; b=ocF5hAeQxbZD2UXVkrVgzuBxjZUAhvwGIz+B+lsqr7FSwSzabUA+cvIpuoRfbgFd3dX/aY3fGw+D/2eRXtZAx2ra7FkfScigrSuKflbTotf+njTIL/HDvN5WKPl7y34Ry48qGAmKFJO0CcQYBUhPgCHtoXqW4Lr6l7l19HdW6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752925; c=relaxed/simple;
	bh=g7PYDyzqZfRgy6qxIE4DVOJY2dYYYitZ6AddosxautQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sGvo9RCnGbQi07y1QbNlWF+RlzlWD9wxoIC3hskfVeRWyN3fbTEmX0/P5ypRFGyFMAZUb/fF/+pBlaXdkPYS4q4uJwrgPhg0oCKGxy04mgHsvDDEsmontfg/GwdXpN1OOUcNw4y2I2gthyVSpX+33dGKKri8ng9pu7yknewjvQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J3BkrJF8; arc=none smtp.client-ip=192.30.252.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J3BkrJF8"
Received: from github.com (hubbernetes-node-362f921.ac4-iad.github.net [10.52.152.35])
	by smtp.github.com (Postfix) with ESMTPA id C92447010FC
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 06:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773752923;
	bh=4Y+OasQgJ713ySiXuIBMr4SPUlrQSMXkJOvk6E3OMQ0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J3BkrJF8i7OvsNE/5FGbMO4eehdV1obmNEI/AxJPd9wO4P98+nvgm5r3vi92ssBLk
	 S5ulr+vxyMVyzE41r24a6rxKkjt5hR2K6OjPMhwdNUvXt3DvIYeS0R82LAqaXXiM4+
	 S3Tp9oq8ahNEtxbRNIhrqkTP4tRWc+oYLR1fxzY8=
Date: Tue, 17 Mar 2026 06:08:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1054282/93c85f-000000@github.com>
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

  Branch: refs/heads/1054282
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

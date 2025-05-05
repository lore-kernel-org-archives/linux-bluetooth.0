Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0A1B808
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450031; cv=none; b=T58YHo2NBkQj5F8tn2b9xCSqR1oQ493V/yvw4+46D179bEESzrgxEZLfXda5XGilsH3t4PO7C+0AqNIXNT0zX40QkllMVhf82OiMZQWMx4e66PfWRHK+r2ZmsmgYaW3ENs6pjK7XeMZavLSk+XyM5egSUawLx+f9Q85ZXpyMMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450031; c=relaxed/simple;
	bh=Y+Wh9CUtd5RFC3dJviBI/XlkLfZs9uhIJO+QYNyCY8w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uoEuwE2JIBQHr/K0qYg+bsETnzPnFm909iwmj+P6tAe8uFnwiPf8q037YEDklwjqjZaqirhNRETweKHk6E+UkBZlEu0m3wESP8X71h5DCxBS0VfelhF1MI6xN6d5ExSd8hGwHOXZOh7LBASSRqMDtZb1OIFe+h3BErPP5fxRBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lStIutwU; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lStIutwU"
Received: from github.com (hubbernetes-node-1ba4af3.va3-iad.github.net [10.48.135.33])
	by smtp.github.com (Postfix) with ESMTPA id CD3328C07E2
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746450028;
	bh=MPZGcpIIlaPycZ8FSFXQyWeyV0U5zOKeaCnQu6oesAs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lStIutwU1IMPVxrjKgoA0fhs8z5humekWglQASOc3bc4A5Gknhbveh3EkeBFOPaVI
	 xTtRPfiYCrG6dQGjH4aFz6bdjg4vnMq9KYwyz0+TxV9hkwjhmHed2kjkAkTr3xlfcY
	 dfAXINocYE+hIC2+4xzglftX7jM6mycKAqK78294=
Date: Mon, 05 May 2025 06:00:28 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959620/000000-2ccdf4@github.com>
Subject: [bluez/bluez] 2ccdf4: mesh: agent: add hash calculation of URI
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

  Branch: refs/heads/959620
  Home:   https://github.com/bluez/bluez
  Commit: 2ccdf429a03b179a5298c6e1bb12b70637ec4363
      https://github.com/bluez/bluez/commit/2ccdf429a03b179a5298c6e1bb12b70637ec4363
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M mesh/agent.c

  Log Message:
  -----------
  mesh: agent: add hash calculation of URI

Mesh profile spec, 3.9.2 Unprovisioned Device beacon:
Along with the Unprovisioned Device beacon, the device may also
advertise a separate non-connectable advertising packet with a Uniform
Resource Identifier (URI) data type ...

The remaining implementation of this feature does already exist.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

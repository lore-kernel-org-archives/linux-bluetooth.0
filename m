Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAB663CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999231; cv=none; b=gw215rWMb1PUWLNgPQm/lrPn2Emie8PxJYZVPITH/R4gsBxbV0vNRg/YSt+SQbgC2N2E3ACo+5CXoJCnSdVrE8whZbKqRPs6/47BvWqSCsCxUiLCM9LqPvv7GOpde7JyZxAHXQZZAXdNfJW6yh+htF19O6IRul328UMjN1McW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999231; c=relaxed/simple;
	bh=wo8VJ/G9i6qOUepAHooXSg8xDkZXoXWLcwqWxzJNohk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cbzO6Xy/3+yH2bWA9w2CNbfih1ulxaA4O/cIDVLoL6HmbscZ3FXb7nen2wkuEOmJPGqaNXZ5AMCoe/y91qRS0jw1k2dbjQK9JzuyN/INsVpwO4+kjfrla2cfPNvYYr24viNkP8GaJyR5nfBH/plom6VpHL0cW+JSl996E7kynCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=dC9O8X1U; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="dC9O8X1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791999229;
	bh=+bl+87OxQcz5WkICf7NOuipj2njw10NXkAZJXl4iCr4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dC9O8X1UqVNb1NG8+PX7ZR/ECxfTs64Xrd3ilta+Cw6krA3jrlRTvdafNSF2jmpio
	 OvKcz1mTTg8UYDkN8ZSwERsr/pb2JwXu9gE0cglnWmJ9AeW3uGtrJxjZPOFOb7XoN4
	 Tw6LvUG02OOnX3fFeIchDRl6NoqKPTYujH6dJVNaCGZVFDv51+Zf1pqIRYz3TgoeWo
	 fDwhpKJcvwVzJ69oy15S8K8WoixMioIUOhk8Q4Q62FAI/aFnKqgYdSUDGynPLTLrl2
	 qNURYHwdH17jrjQ8Q6PgwWVKj46lptnH6ztzwzk5pdCqqAYavT+eF8G6DsuA2lyIGE
	 tP0kZFq75YBIg==
Received: from github.com (hubbernetes-node-e439bde.ac4-iad.github.net [10.52.139.31])
	by smtp.github.com (Postfix) with ESMTPA id 19EF99404CB
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 10:33:49 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:33:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184865/6d647f-000000@github.com>
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

  Branch: refs/heads/1184865
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3A9393DC7
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057736; cv=none; b=S4ck1OQWh7DhUanuMK6MqtmHKvNHbQt/FNoq70QjFzsQTGGPKRIN0A948Ge6zX/cJvUZqkE9ECjYSdQItwBPqoFnqBbRfu0apE0kZ5mc5GyQ63XbB0TsNhw2qRA6vI3Ar5xF4XAkoqjbs/xO6xg4r7mbH5/IRMYv8+JTBY5o/dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057736; c=relaxed/simple;
	bh=rHnwF+LZ9lJOfP9SZnvUNPkZ50m6CM1ElGV5YO5m/nQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T8thrFhjUvDH22XmG8lDfJ6DFqasKMRtqZF7CEQB+hb0picDBlcn8efgWrDk5E3NKUP9UKE/5rzJ7jh2Fs0YBFJs553UbM+1U3+vP4AFYgLTAjk2yLNM3CHklMmwu4bx5NqnGk1Kuv4i+JAcSbZTogNDoXvtIGJ9NSfKteGC9gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NIPW7L7Y; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NIPW7L7Y"
Received: from github.com (hubbernetes-node-e3a8c57.ac4-iad.github.net [10.52.178.31])
	by smtp.github.com (Postfix) with ESMTPA id 5E4D4401233
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773057734;
	bh=7Ll8dBRLpttFCZXPTNTWK9I2iV+S9qsspDob2LjUJxc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NIPW7L7YsqppuPNKbGqTlcPamuj/BP8NDn8EviVClISPAsSWLVUcQkkiigiWu+aX1
	 SjTzwW0EX9DoWTKuRbLEcdMm9bzASpEvye/WDGEftAunDFSjQoGVFS4+iYr1O054cO
	 d/cWy4DWPwC+7ku5ajPn03Q1GRS0ESrINJD1Skiw=
Date: Mon, 09 Mar 2026 05:02:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1061791/9a6959-000000@github.com>
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

  Branch: refs/heads/1061791
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

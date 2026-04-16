Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E421FECAB
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776358851; cv=none; b=nP9mLO0RLkXqCXikKBzRm/cp71j7CUvwtQACovhKUBpQeqoNqQJ0Wxo0uM7NhNzihQc4YRVORONBcGWwqZ9LQIgW8TywNWMGPaumSjRTJIzAq17xanOcqjZVbrX6u+v/eICEkAHZXq9Q1EoNt8lhCVI8GlynB+sY6TvUXHO3KSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776358851; c=relaxed/simple;
	bh=EH8cTpgPHFEBzC0m+YZaiGIfo/JsIUCnIKYyQd12x34=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WRHiUFMEdGaF90EQmk8N4XFZ53XpnZs7+hFdghHnm5UZE8KuKMKPEz+s1xuPP6LTO8aMx2CetMJTjtjTx5Gqnifxqz18GN9c2KUciRt/F5FRqJpp0v6FUcnNVeD28Y3fqExJ+K5l6fRzZsqrKuVhJaLs8o2HJNvatOf6A4BB+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fidktx+M; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fidktx+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776358850;
	bh=okokdwwC9y+1xrkEsUPR8R0+dfcGMiVaU5SCJ0jNGSQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fidktx+MRmHDyKeOZ2GenBOTJwyS9nebBc1D3FLJOHmMwGxTxaUrDTB5Gdwwcz4Eo
	 p0w/UuX4Zp4O1mk7G0ycPk+lKANWGvS29L/Az1sGdNEV4uCgd8Gx+z0qPVLNgt81OE
	 xRUv4Y//JHEvtsAUqbIhZkJggMsosyllNXXBfy4o=
Received: from github.com (hubbernetes-node-b017e4a.ash1-iad.github.net [10.56.76.24])
	by smtp.github.com (Postfix) with ESMTPA id E87F65611BC
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 10:00:49 -0700 (PDT)
Date: Thu, 16 Apr 2026 10:00:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077051/c5e55b-000000@github.com>
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

  Branch: refs/heads/1077051
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

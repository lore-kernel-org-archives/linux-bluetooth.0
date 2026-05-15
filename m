Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474B418DB35
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867705; cv=none; b=T0dqYWUdD5K0cHqqu950uXYWImVyQwuhFUSsjG8qqcAI5y00CCfRp0yM1Dj4N173yFV0vOhBEkQ/Ipxpa3WKdmtwA3i6Lj6cutDmeCC4g08gy9Z6knR02/FMyIx94J/g+1pVfp89cnPw9ELJrbAu7mMr0JUqDTG95LSzyLOAvkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867705; c=relaxed/simple;
	bh=7Om1CoeKNqYgbcJ5wfDG+csrN2Xs5wqlNV4lUlsU2AY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=D+mjHLDu00/CnsPatka/eWk7dlgw8KLDup2IcwyOEnmBoIzeHcer9SuXvP6PDqn8EcS2s2gh78+l82slWTzqnibxlQcmkZwNArnwA7+DxtHHH3RLM1c0fkC3VD9M9JhS+S8eb7et0VdYTW50+EL4U7dTNqwN6xX5VZdD7qazunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RhXhmaog; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RhXhmaog"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778867703;
	bh=2VoSPGQRVT13Fnftj8zzwe7GPLHhYWGMAJCM1BeyGxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RhXhmaogP9G08+JrsE+BfhP3bmww3GKUWNqFzQR/O9EFj2u7LunkC8JhQz9aexqnp
	 iijfijnIFq43LbpQvv9xi7StI3bTpPGixBviE0nZtf5HRNefP8a+6UalKMyAFJ2R8V
	 ZmtTHkQGS6kZKalluZoOR9ApQPF1ccaz/qf0C2l4=
Received: from github.com (hubbernetes-node-e2d5420.va3-iad.github.net [10.48.178.38])
	by smtp.github.com (Postfix) with ESMTPA id 6F454280456
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 10:55:03 -0700 (PDT)
Date: Fri, 15 May 2026 10:55:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081668/fc2f64-000000@github.com>
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

  Branch: refs/heads/1081668
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

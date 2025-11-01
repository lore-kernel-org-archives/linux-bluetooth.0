Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558F2F3614
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000045; cv=none; b=Tu9zsG/V6XDFOvN+1VhdUA27Ll2Z/lHcP5fCHJ4vvI/aJZZEsPb81I7LLdlDlyW13ji5pDAjUcK++xAJq9ZBbkkPjcPi0aqjYjNjTBHJV3GOvWQpmZAXu4bQc7LM5pZR/fc0sQwpt7xPBryEqQT4CwJyI2qLhpkzvZngNPi9j9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000045; c=relaxed/simple;
	bh=Wc7QSIo+5cjUB2DnCjRZaskxKX7OCK+e2T5FHCey7Mg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OtweJ/I82WdX0cx/FkM4hvVkdWEukrF5vK3hDSGynYLUfPmLkprU5EctJtzKuGNHHgJlBgDp7VnyC0+LC8UqCzzGJa8qW+pR6K1THxLJQ5nO9i4U08QT7EBLEBjDlhI7WaFBy80b/wl0q9xKRWRZjKxn7XNqwFTv14ptDKBJ5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UXd6Ffcv; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UXd6Ffcv"
Received: from github.com (hubbernetes-node-d648dfb.ac4-iad.github.net [10.52.210.43])
	by smtp.github.com (Postfix) with ESMTPA id B2131400A1E
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 05:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762000042;
	bh=JP81kp2y+2Jm2F7ubstXM7bmb8TBq3pt8W5YkeFuuPA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UXd6FfcvAOjGHsthqjWFdUi/Fq2EHxcJHT+W6yF16y82meNRciLERXPRHq0+EdVaE
	 dhVG9DDt59nX0VjUAsNRUFDJ7KPlaC55L6AJ9rFvBjGQ2NjA+Bb04kW+r2xhpq925p
	 c2JNFW/dH8ahwumxcYZikXsi+3tRpfGe9tBr1oTI=
Date: Sat, 01 Nov 2025 05:27:22 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1018491/000000-5d2fa5@github.com>
Subject: [bluez/bluez] 8bf503: 6lowpan-tester: add test for header compression
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

  Branch: refs/heads/1018491
  Home:   https://github.com/bluez/bluez
  Commit: 8bf5032a5fcab675f1a13d6f166dc5b8b2e91270
      https://github.com/bluez/bluez/commit/8bf5032a5fcab675f1a13d6f166dc5b8b2e91270
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-01 (Sat, 01 Nov 2025)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  6lowpan-tester: add test for header compression

Add smoke test for IPV6 header compression:

Client Recv IPHC Dgram - Success
Client Recv IPHC Raw - Success


  Commit: 5d2fa518afa551de2e6a034ab62aaf3c5c6008e3
      https://github.com/bluez/bluez/commit/5d2fa518afa551de2e6a034ab62aaf3c5c6008e3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-11-01 (Sat, 01 Nov 2025)

  Changed paths:
    M tools/6lowpan-tester.c

  Log Message:
  -----------
  6lowpan-tester: re-enable previously crashing test

Enable test that previously crashed kernel, since there's a patch now:

Client Recv Raw - Success


Compare: https://github.com/bluez/bluez/compare/8bf5032a5fca%5E...5d2fa518afa5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

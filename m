Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911538B7DF
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495087; cv=none; b=p+yIUzHF5HorM4w8GyR1GgVj17LlOIqYKN8PBJKqWivBiKknG0MN1jcBqCvvpiQKCKXtwDnnZPhM8ySYwD50CawY8R850AUU8s5trtAK0ZcxmXUP65wE5Jewd1Zip5aMzfGTF+2P/iiwpVhmbaCUAapJrpWu2Lm8nkNYWjdegTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495087; c=relaxed/simple;
	bh=vvG0vBhBTowiQVGnFuL21Jl0C+UbMHTlM6PvoPepoqg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gcydov4DWgRL48tDwrtCGcC12gvzin7xle8x8qDeWENmSTk7aYpw/Y52HEFdrvsEFPd0LyA5uH14Wl/rah7uMYkNI+dL9a2q9/tDhaIsJa50hddQDBY9n7jOyJX8ucWjdoxBNFQrR7BHZQJfPwJLwIdFYMGt3zCVT5T5Ij/IZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Iba0PMmY; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Iba0PMmY"
Received: from github.com (hubbernetes-node-38a4462.va3-iad.github.net [10.48.177.44])
	by smtp.github.com (Postfix) with ESMTPA id 42902900C38
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775495084;
	bh=nOD6DDp9EJtNwMDoarD7nqwihD/GFAlFeKKwb2tBscw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Iba0PMmYxcWON84DgxBF6Un3A4HRnyRV16RNbhfM+yIFYYLrHpQ949Vzg5Ngfc5hS
	 bDBj1es4JCQV7lJaHTlRj+9GzXqLBqJJLisGx/ltmg8vbho5MTwy2w8rv83SckoOPB
	 dpi86kmmtwEbJeSRhoMPGYo3ce17Ik4EQOTeBnZA=
Date: Mon, 06 Apr 2026 10:04:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077654/6a643e-000000@github.com>
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

  Branch: refs/heads/1077654
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

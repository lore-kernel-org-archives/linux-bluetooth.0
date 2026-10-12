Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A853B4EB2
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849120; cv=none; b=tU/WbMVpTS7zbG8+b/JGzdWTMK9qeI54hoxIaAHljrp+yvgnqhz3+Mo5XxNE7PpC8HX2heTPS5iW0b5IeCaOBQUpEUXz2HSK5MglFVGrerl8GtSWkv42p9PwCclR7LiLg6TQBL+TWRE+E87/HZaaophsOEHvCKBfpYJSZcj0Yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849120; c=relaxed/simple;
	bh=lAYdj1fDop08tsMIXj7VJWQXRDla49jCby3/vwKCU7o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W/PwO4XXGjigXUZS5w5kN5ero5WvmkAhuFI40WybuR8E0Y7Io5GItGfOTtrqty2Xp80GLtbMIqBBgl6Btpdya4a8LhzGZbfJkKOTMdOwjw7zCB2JyqG5Q5xlxH66jSzLaTCA6PEXhBs+3jn10ACFj+5eD7jek0SgoNfx3v9/NWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=VbGfXN52; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="VbGfXN52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791849118;
	bh=hAOIfZQkkB+vgo56Bhw2pohkLxOkVA/6HdFaK38FT9o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VbGfXN52Sc9WkwOqipdFZ+ztUK2+22DqrpJXwaAgGLmqo8AIhlA9Q8wEG9frSr7jK
	 YbxcPM2jBeoECOzmNRRTBve8S3xmAC4pduCitRcS8Db4i6zEZgH/MrVE7OrCWP/Rf1
	 xgRLzrwFjZYxeedU5r3C4ifLp5UrKguD2jOxyHvnxohfd80nH9j237MOk8nNnZFpXr
	 /2KwpPYKIDUFhN9E+MWaTMz3EeEx9J802fgCOo3u5XxMnS3MN3g/CbX3IwErOw64uc
	 vv3FLtopo/5OjW/O0SlFYx9RMnZsVVQIhhiN+2MaHyryRAMNHVWx6Pb2WzyH0XDeRe
	 Tp441EZWOehUg==
Received: from github.com (hubbernetes-node-2b011d5.ash1-iad.github.net [10.56.176.16])
	by smtp.github.com (Postfix) with ESMTPA id C7F771803B1
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 16:51:58 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:51:58 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182788/17c1dd-000000@github.com>
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

  Branch: refs/heads/1182788
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

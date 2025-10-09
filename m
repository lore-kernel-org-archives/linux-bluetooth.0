Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB022156B
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760027333; cv=none; b=BT+gKeYgTJHqFMcqyWY9SFZVye6ZtJcXkECCUOBsbdsEiKw3Y2uL0Sb9YZNV+BkvaUsGLoctn84Y7/yJwfegaCn/HW9dm5X4ciQMTJPWJ85Trb6yUuwU8QHLkw79Fqx3HuhzjF15rpTzqNZLtkBwQvB8RBKOZbGyHnH+pLwMNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760027333; c=relaxed/simple;
	bh=JOsjGwlvUYMk7/exrCxkgLCRjpxszMgXhik32iYJvEI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=L7gbbQBOBgyv4O5gXWfGxXdT0LIbmjLghsj+ai1YE+4KFOFqz850/KylJ+VjV63WNx7D9D/4ToPMz5EaWNwBVVbr+dNuZno9U4EnzM2K71RUdFy+AMriKI+XFEpgYoXHfkxSn2+T+dPWXntgPS25qL/u3OmJ41LLxDCOhfQEARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lAKALkRg; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lAKALkRg"
Received: from github.com (hubbernetes-node-70ae9a2.ash1-iad.github.net [10.56.200.58])
	by smtp.github.com (Postfix) with ESMTPA id 00CB31447ED
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 09:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760027280;
	bh=ak6hI2+iplmlfGnFslMbn61Wi5+bPAPxH9ZSqaFJbHo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lAKALkRgcwQ10iqkUPI6Cu+g7WQjQ26XPR45s8r3PvYWKvjxg61bCCKxYB3R+/bOE
	 FlR3w5+cy40Nxmc2LGvGShwYw9iXwDvomkH5LOZS3gNdh3qQC0dJmuNBu2xioBEmJq
	 qdGfkdyJy5/rapuGku92+aaYTEO3wCdpfhu12dQo=
Date: Thu, 09 Oct 2025 09:27:59 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009812/000000-029fc1@github.com>
Subject: [bluez/bluez] adc2be: monitor: Fix instance where BN is printed as
 PTO
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

  Branch: refs/heads/1009812
  Home:   https://github.com/bluez/bluez
  Commit: adc2be31f31a735232763297e70d880cf3371daa
      https://github.com/bluez/bluez/commit/adc2be31f31a735232763297e70d880cf3371daa
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix instance where BN is printed as PTO

This fixes 2 instance where BN is printed as PTO.


  Commit: 7f54f99209f817dcf9ebf7b1300708dc07009c16
      https://github.com/bluez/bluez/commit/7f54f99209f817dcf9ebf7b1300708dc07009c16
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix prompting for bcode when one is already set

If bcode is non-zeroed it means it already has been set so there is no
reason to ask the user to overwrite it, also fixes the assumption that
only strings could be entered as bcode rather than a byte array.


  Commit: 029fc1f8e6e9717fc1e9286eb11514dd8183a47e
      https://github.com/bluez/bluez/commit/029fc1f8e6e9717fc1e9286eb11514dd8183a47e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-09 (Thu, 09 Oct 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Fix restricting the BIS indexes to 1 as assistant

MediaAssistant are created per BIS which creates a problem since
MediaAssistant.Push could only push one index at the time, so instead
of always using the index use 0xFFFFFF (no preference) and leave it up
to the delegator to decide.


Compare: https://github.com/bluez/bluez/compare/adc2be31f31a%5E...029fc1f8e6e9

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

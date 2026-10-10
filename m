Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578773B1EC6
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791623261; cv=none; b=JEpkIx3xbGktE3OhRKJoDzFVSIOxTp1xP9XP4Yu9LGPqZHLIjYe4606JUe37n2bFu3O6S7vixi8plruGPV50z0Gwhxu49MMjGpLMhqerC//OLC/DtdE0myHW/lDtgInPw0Ueudmud9kHqbRA8amf4UsADadMT/bI5ZYpHXcjlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791623261; c=relaxed/simple;
	bh=TZgDJOS8JWMBdhydUnxhUa8nt5qr3395De6PgOEOVSU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hVJoAOlFygimE4+56TpCNu4HPRr5tcKWQcpg0G2teI3TGHXU7TPN9TLQy5NlwHmHuxjAXMjylI1iHHPriGT4eodE7dt6aUVT3CunOwuGNF3XpbY9x4YVUMsncuRUoOk3LhttS5sTUXIkTrm+GRavT68TRREJKttPiR6fkITC3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=ehuuqDqW; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="ehuuqDqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791623259;
	bh=H25HjthXl+DOWK/PW3dwwc07wiUfR7W2XI6nrOLU88U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ehuuqDqWa002KiK36WAGeLZtq5ZliPp5acUa2jo+RJFSws9YHMY8OVWYaOwoAaNGy
	 QJFpxQFIwSIlb73Tl8yCO16HQTbZqWL6mOtc4hyScZxkG/rpo1rAN19JHwHpo2YQCN
	 sOEfLuVbFWRetKrLcGokVW+00F5r35UEAzSdubzgWiXgUHg+vm+hPyo//v4izX1RGH
	 mjoLhknPBg9C4W2qLPOsUpeDfJwAGGNZpSxKlTb2bAJD94bKdmWFnr7Md+MY+b/p2K
	 Bff1m/JJrZFW+r6VMlNJnIQiFNr4IMTaw6TzdH8oQwRQTU/al9kBxqEa3/OxfBFvV3
	 kfICqI3TlNDHg==
Received: from github.com (hubbernetes-node-ffd6c00.ash1-iad.github.net [10.56.196.47])
	by smtp.github.com (Postfix) with ESMTPA id 7CA1C180711
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 02:07:39 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:07:39 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182833/000000-b20d70@github.com>
Subject: [bluez/bluez] b20d70: device: fix loss BREDR info when merge
 duplicate d...
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

  Branch: refs/heads/1182833
  Home:   https://github.com/bluez/bluez
  Commit: b20d70c19997479424bf8d65810d440cc75dd270
      https://github.com/bluez/bluez/commit/b20d70c19997479424bf8d65810d440cc75dd270
  Author: Ye He <ye.he@amlogic.com>
  Date:   2026-10-10 (Sat, 10 Oct 2026)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix loss BREDR info when merge duplicate device

Two device objects for the same device in case it has
first been discovered over BREDR and has a private
address when discovered over LE for the next time.
The merge logic doesn't create a new BREDR bearer.
Makes the application loss connection info of BREDR.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

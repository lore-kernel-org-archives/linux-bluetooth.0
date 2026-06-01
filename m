Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95462342510
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 18:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337989; cv=none; b=DtZRQXCFC1b/dIELmU+1Ysbv+PnnVl0ElgplUrG9NZRW+7vavxujTjpKAyI0Sfq6ZqSKWtHlIGO28ph+dApnTn45JbeTfGqWb59JGM0fAYX+NrF8+8ydAkF4/BeBYR43Cv6QuDtV/lQpQ40HO1kZpdLS0h26Q/8sRLm7XKa7NIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337989; c=relaxed/simple;
	bh=5dM7GNJ1KCfsgbTAq0ABEvdfAeItjIVCyJMHC7EQ9pY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fq4Fs1L0+lKqP9Vsk4OqmjPRMpkf9mPG7ZJFrXz8JYosNGRFz0QTPQsMdqG3TPwbtqCYL9RonFcUwXy+dDhdeFqTbZlWejtNJPbgKedWQLi4190jqgjF9Ir4oy0JDPCp5uSRie+8uoQ8pmfOH3QdYphMu8IZBFgby8DZyK0R4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DHkecUp7; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DHkecUp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780337987;
	bh=hnyxOD41oGNeDsbadS7XZRD7yFEqfySCpfcT054cNGM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DHkecUp7GF3BfuffmR9BB2KyIrS5JjA0UwPcvJFSNTdGAUBYyfVcI1WPVB00haR3S
	 Wi3JsWS1rUohBxOfxKxr02MUVmWu5UxADE6A6R9bsXlkZTMR3hQpzIR4TbKYfX9bG+
	 g6eN0k9lJi5GVihdaPOcD5TdwE2u37j2JVS7jrHY=
Received: from github.com (hubbernetes-node-e87e602.va3-iad.github.net [10.48.136.31])
	by smtp.github.com (Postfix) with ESMTPA id CA6E2500189
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 11:19:47 -0700 (PDT)
Date: Mon, 01 Jun 2026 11:19:47 -0700
From: mdzik-sue <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/17fbb4-e2874d@github.com>
Subject: [bluez/bluez] b55c05: advertising: add property with advertisement
 Instance
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: b55c0559bda8cc16efc63892adb56f278c19993d
      https://github.com/bluez/bluez/commit/b55c0559bda8cc16efc63892adb56f278c19993d
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-06-01 (Mon, 01 Jun 2026)

  Changed paths:
    M doc/org.bluez.LEAdvertisement.rst
    M src/advertising.c

  Log Message:
  -----------
  advertising: add property with advertisement Instance

Instance is an internal value, but it must be exposed to client app if
client app wants to use a advertisement in BAP broadcast.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: e2874db00a40a1379172f3939ea670063b7e918d
      https://github.com/bluez/bluez/commit/e2874db00a40a1379172f3939ea670063b7e918d
  Author: Michal Dzik <michal.dzik@streamunlimited.com>
  Date:   2026-06-01 (Mon, 01 Jun 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add advertisement instance support

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Compare: https://github.com/bluez/bluez/compare/17fbb48d8f7c...e2874db00a40

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

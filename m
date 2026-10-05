Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A840803B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227642; cv=none; b=IMdadWBtjcQWXi70Iluj7cz33KIbkjw3I6ucvZRjqnftNviTMnitBS+Qo9+ihTQcYkr3ZLllPV81hYxCh1PQPG+QTOhCS0Kgxk5AmTIlRSo5oz7Zx8wvU+sQU7j4jq6C2ZqAfpQNa5tfFbkjvXzw45OMqaHiRh1ZPie+VRK0k+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227642; c=relaxed/simple;
	bh=PL5vDYU9XiT5DB7H1NBbqyzwl1b7hTq14itSNbPMS8A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PuW2BJ90SQLWvY0RrQZqlwiRjDM3qoo7W5KEke7WgRgZX9haolRqc5ZHnonQ023+ysCe07AXe5+e+cqZeYtm+3fQ6VO+FVGSDkwDYvi+KuTafosp1cNOTRB24q8cz/R5PIg8/Bfi/t1knoVPQ5NphaH5Eug+ym7y2XAP8t3A+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=UROJu7sV; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="UROJu7sV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791227639;
	bh=OMwoR1WSHtVxQJPuzLleEa4C9LUl9gT5knCpE2ay8Q0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UROJu7sVTN7LKd/EtNyNEgaVmfLkjxIePBUX+3zYl9wHW0NSshvNcTWFLNensfwa+
	 nhz7QcaNDl0wXmMuARmBfNJehysbOfLdiEM/USj/QpE3hS+qloisT1Il8etyIZIDuH
	 FO73R3jvqYWjlxgKfTx9dv6F5art6PK5YwxV1uUYDEwE308COw3XKFHVsdco4AlKTv
	 P5j+U7Br79ZhiPMxBSKYI08L7v+YACE+DyNPksSweUBZcqp/LgdAv4y4iL+3kB7jnv
	 /xcy0ngaK/c/O+AVJZK6KOYPiApgPApV4CYMsOJuGoZtm0c3x8Ih0+aylkSCCC90X5
	 jTm7+3ffSAg/A==
Received: from github.com (hubbernetes-node-953895e.va3-iad.github.net [10.48.76.66])
	by smtp.github.com (Postfix) with ESMTPA id DF3E27803FF
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 12:13:59 -0700 (PDT)
Date: Mon, 05 Oct 2026 12:13:59 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1179727/000000-9c0205@github.com>
Subject: [bluez/bluez] 15ea8a: doc/mgmt: Document Advertising setting as
 Global A...
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

  Branch: refs/heads/1179727
  Home:   https://github.com/bluez/bluez
  Commit: 15ea8a4bdefcde62ea917c30f8fd6b216e00697d
      https://github.com/bluez/bluez/commit/15ea8a4bdefcde62ea917c30f8fd6b216e00697d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M doc/mgmt-protocol.rst

  Log Message:
  -----------
  doc/mgmt: Document Advertising setting as Global Advertising

The Advertising setting always uses instance 0, and with extended
advertising it has a dedicated advertising set, so only instances
sharing that set are overridden by it; the others are advertised
concurrently and removing instances never disables it.

Assisted-by: OpenCode:claude-opus-5.5


  Commit: 9c02053880a4ae7b9f5df125edcbc97105f49ca5
      https://github.com/bluez/bluez/commit/9c02053880a4ae7b9f5df125edcbc97105f49ca5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-05 (Mon, 05 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add Global Advertising tests for extended advertising

With extended advertising, instances are advertised concurrently with
Global Advertising, so update "Set Adv off override" to expect only
the set of instance 0 to be disabled, and add tests checking that
adding an instance enables it and that removing the last instance does
not disable Global Advertising.

Assisted-by: OpenCode:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/15ea8a4bdefc%5E...9c02053880a4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

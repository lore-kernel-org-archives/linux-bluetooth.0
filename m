Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F4F42DA3D
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434007; cv=none; b=b+Ljfsao+9wKzdtpBSOLZ8ek6+6FJZCAf2yoQNC5Ia+xddR/RkECHzXqau2mC+7kmAjs29ufndMcbuFlaJpQCGhK4o3QNMR5i0ehDZJjAm0SrhRejUcE/umdJinw09dKtbVs7q4xWAiXuPZyYncbceHw8Fuc2vytTZmKpvTsAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434007; c=relaxed/simple;
	bh=XEPT74bZx6DpjCkGteOm5Zn8d3IrPIR0Q6jRXkkIYzU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CjuBY4nWZMrq0Ibbyq3xcIZaqIUf9IUGrNwc3ioEXEExqQF7+5sAMX/w/4NCIx4qYrSCLNAS+dHqGkhoaXslNxVdUrpgutIiD/2iSRVfKnWYYfLmo2zw7ZH0QkkLhx8me4bbad0tV3cq1d08j5gjAuGWFirOBlbdZsD4akeLo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SCi0NxvA; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SCi0NxvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788434004;
	bh=xF+deAX1pj/BANLAglKyjXIML2t3t5wqPwU1IUsoCAA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SCi0NxvAR//g3H3hELK6xA52H6znBYCERE2jVhIIixO3rqT4+kJICYzTycCyUe2se
	 49UnB96vxM6ai64y682bucdPIfufR2MKaFKqYMsSh7O8h+qDO0iDnO9UaPDY9UfxP+
	 q6aeV1tYoJqD3efak0AqmgHCMk29YDqTcQqQZKKQ=
Received: from github.com (hubbernetes-node-8538db7.va3-iad.github.net [10.48.64.56])
	by smtp.github.com (Postfix) with ESMTPA id 65C19501371
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 04:13:24 -0700 (PDT)
Date: Thu, 03 Sep 2026 04:13:24 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1156962/000000-017011@github.com>
Subject: [bluez/bluez] f50d29: client: avoid registering ranging objects as
 direc...
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

  Branch: refs/heads/1156962
  Home:   https://github.com/bluez/bluez
  Commit: f50d29a37ce1978ecbab9b3c0358c8507b41cca9
      https://github.com/bluez/bluez/commit/f50d29a37ce1978ecbab9b3c0358c8507b41cca9
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M client/cs.c

  Log Message:
  -----------
  client: avoid registering ranging objects as direct children of "/"

With the default provider path "/", cs_ranging_obj_create() exported
each device's RangingProvider1 object as a direct child of root. That
triggers a NULL-dereference bug in gdbus/object.c's
invalidate_parent_data(), crashing bluetoothctl with SIGSEGV on the
first ChannelSounding1.ProcedureData signal.

Fix by nesting under RANGING_PROVIDER_PATH that is
never independently registered, so the leaf's immediate parent isn't
root. src/ranging.c's provider watch matches any descendant of the
registered root, so discovery is unaffected.


  Commit: 017011766f798aa7c4ea01c50ac0f10e7924afcd
      https://github.com/bluez/bluez/commit/017011766f798aa7c4ea01c50ac0f10e7924afcd
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-09-03 (Thu, 03 Sep 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst

  Log Message:
  -----------
  doc: note RangingProvider1 objects are nested in bluetoothctl-cs

register_provider's exported RangingProvider1 objects live under
/org/example/ranging rather than directly under "/", to avoid a
gdbus/object.c bug when linking new top-level children of a path
that already has an ObjectManager attached. Document that alongside
the existing default-path note.


Compare: https://github.com/bluez/bluez/compare/f50d29a37ce1%5E...017011766f79

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

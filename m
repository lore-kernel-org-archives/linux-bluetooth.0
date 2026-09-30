Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F52DCBEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790753425; cv=none; b=Aim7lgaetc4BwhmS0Rhgc198hhsHrJ5IWjFKnIOds2/1SEk/Wtd4JeFU80xe7uUnyRRA7OLyr/oRCAWgQFqIAcDerUfncKbze/rTvYOqA5FidetgeWbHmbfsOR+YgztI39byUwzLAe5JoZgQxhN/nodrEVEfmpqeJjjSQz8LfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790753425; c=relaxed/simple;
	bh=7n7DhpkNTbERf+pPIGGAFwpf4w2Uq9OmtY97RH0v/lU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tqMmXhIoqvTr/HZ2DJkc6lsyepUJ8gdXPQXI/PShKVHoCffkvsU2aSWIUR53WTQqHS1HuehVNlLtI1RQXrGcxFO9cXulKj2tKAxzVllX6wzylpUsPc57KBy+MwIwjxU9++VIrhCfHP9otj/yNZgl5y4y/hfyBWlVO8FH7oU82E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=JAyHIhEW; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="JAyHIhEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790753423;
	bh=DGUOWZYrJ4benTXuHn31ge92UE43varR0ASuuAg6aC0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JAyHIhEW0Y7ZhPy1Xrf9amRUh1ZmYR5vGevM6llG2vsKx38hIM4/E5QdacAxmKeCv
	 KwkonCHw/pOxHA2HQRSHI9KEf2qPqoIXVngl/CAMEaVkJ0OGDbf7RCneC1Wk5lyj/C
	 JgurUbHagBgQLR4fnZu9SK9Zxwm9qogGjYSjz/HAiAxMNnUoDYeKCrEbcO6oUmzE97
	 RVH7Rkdd38nAQs9RwFnN8890Il6SWMjID+oaPHTIgO5YhE1rttDMRS/u2NKMG7kcFP
	 R3oXKJSw+JzoSpTLqUBz3K11zZFtroNrP6uRSeab0AmFsQ3mqzEs/5ik+ZjjJTSbgm
	 vimBF9pl5XtJw==
Received: from github.com (hubbernetes-node-5b74dcc.ash1-iad.github.net [10.56.203.126])
	by smtp.github.com (Postfix) with ESMTPA id 54BFA363483
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 00:30:23 -0700 (PDT)
Date: Wed, 30 Sep 2026 00:30:23 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1176540/000000-952b53@github.com>
Subject: [bluez/bluez] 952b53: ranging: Route CS subevent results by
 connection a...
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

  Branch: refs/heads/1176540
  Home:   https://github.com/bluez/bluez
  Commit: 952b535b9f935612cf5b091767b28f944c6a1e66
      https://github.com/bluez/bluez/commit/952b535b9f935612cf5b091767b28f944c6a1e66
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-09-30 (Wed, 30 Sep 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c
    M src/shared/rap.c

  Log Message:
  -----------
  ranging: Route CS subevent results by connection and configuration

bt_rap_attach_hci() allocates a state machine per device and registers the
CS subevent handlers of each one on the shared bt_hci. LE Meta subevents
are dispatched with queue_foreach() over every registered handler, so each
CS Subevent Result is delivered to all of them, not only to the device the
event belongs to.

The Subevent Result and Subevent Result Continue handlers then passed their
own sm->rap on without checking which connection reported the event, unlike
every other handler in rap_hci.c, which resolves it with
find_mapping_by_handle() and returns when the connection is not its own.
The Connection_Handle was parsed into the event and never read again, in
rap_hci.c or in shared/rap.c.

With two CS connections up, one set of ranging data was therefore consumed
by both sessions and sent out over both peers' RAS characteristics. Resolve
the mapping and drop the subevent when the connection is not tracked.

handle_local_subevent_result() and parse_cs_local_initiator_data() also
took a config_id they never checked against the tracked one, so subevents
belonging to a second CS configuration on the same connection were
appended to the procedure of the first. Ignore a subevent whose config_id
does not match the tracker, once the tracker has one.

Assisted-by: Claude:claude-opus-4.8



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

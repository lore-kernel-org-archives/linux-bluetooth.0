Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7DD1632DD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704283; cv=none; b=d3YcRX7rkAEJiSZE1YiVUecs1SJ6X/0N3rwyMXgePwz/cRRszKsq5d/UAJ7DOKUU/aDHo7UVwnD8xb+T3VwBwptrAelCXSlfr3RcuWKJJ1ZaiA32S6d2aKH4Vfow4Lp/IoG3Xvcx91iXbGVqPKG7MHP9UPGO9bBnbJvmXcdAe7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704283; c=relaxed/simple;
	bh=sTNsAx0yFvGRjQFLd5lPoaNUE5oWq8CHWgq7lrNXrLU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=k9tEa2xBR8McbocRgPXMa+bQHVyu50lVLW1V6VZ5WbcmhOgHsJ6Trn6zUN7e++bCIV2ph4tlkLGtfjMQ6GJacPOLzmle8LnL6z2SHl+QkG+BRO6ng4KxJtO18dI6fn0AK+Axh+qNKdY6LZMtMzD6babFr53xczP9/vslUtLqxyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cWm4mxUK; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cWm4mxUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783704281;
	bh=nh1ghisrcYh5KBqDTqeT20jQboCUr1etxMn68qprOuY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cWm4mxUKcF8IdYCkEwjtLSKZmMWcAIXEIYg1MRNwG6f/6QE2Kp+F7zYxV9G6EfJ2j
	 /dEdKVBYZk6tlUR2JBosUog/MecsoWciwVTAGp8TvNYRHQnZC9j9a2lm+R2no4EN12
	 Av7WfeRKMEQ8nvwTpg5xZKTtYEVLCod0ZMOggWBo=
Received: from github.com (hubbernetes-node-a590f92.va3-iad.github.net [10.48.173.54])
	by smtp.github.com (Postfix) with ESMTPA id 41413281566
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 10:24:41 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:24:41 -0700
From: Mikhail <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/82af2b-b7d71e@github.com>
Subject: [bluez/bluez] b7d71e: a2dp: Fix loading of remote SEP from cache
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
  Commit: b7d71e5067856b0daf2f1f73b3fc95483236610e
      https://github.com/bluez/bluez/commit/b7d71e5067856b0daf2f1f73b3fc95483236610e
  Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
  Date:   2026-07-10 (Fri, 10 Jul 2026)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix loading of remote SEP from cache

Commit 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
added an 'i >= 2' condition to the loop that parses the stored codec
capabilities. Since i starts at 0 the loop body never runs, i stays 0,
and the subsequent 'if (i != size)' check discards every endpoint found
in the cache:

  load_remote_sep() Unable to load LastUsed: rseid 6 not found

With no remote SEP loaded, avdtp_discover() can no longer take the
cached path and issues AVDTP Discover/Get All Capabilities on every
reconnect, and a2dp_setup_remote_path() returns NULL so the transport
ends up at /org/bluez/hciX/dev_YY/fd0 instead of .../sepN/fd0.

The condition was presumably meant to bound the writes into data[128],
which the original commit did not actually fix: caps is read with
'%512s' so size / 2 can be up to 256. Validate size up front instead.

Fixes: https://github.com/bluez/bluez/issues/2285



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

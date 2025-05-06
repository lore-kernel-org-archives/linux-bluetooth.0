Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93DB2857F2
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746551526; cv=none; b=ZlkN7HIW2tMz6WeQ5qduzvysLwWWatvv4jXqZJPZf0hX+vPaJ9yzH39WUoQTKKGFlwMaRWq7Xd3ShVuQd/S+xa18cAcT5HBhlSa7oFrHvV6KSNVgjxJW8S4Zb7IrB2OzipIEiiN/86HUr42CsNPbcsYcKMNxQbzup0Z7nLcD6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746551526; c=relaxed/simple;
	bh=eAk36u2Hd4964JqFGS7nfXYCwQdsAUxEEjnXHfz9zAg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Kza6wMk1HVai8uOIIOk26osiZI6Yfxz3a/xR6GUihMLd/RWKPXmg/06gcBttGyE5ALT+M/Mrw/V85Wcti3SRzwFaHEenp108CIqOvWAcwA2w+MFN6QZohBHrmw9EnVw6BbiltomXje6J2rNdOtzvBicTtVduvz0+Ysjq38ZAat8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SkvmHxvb; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SkvmHxvb"
Received: from github.com (hubbernetes-node-8a28120.ash1-iad.github.net [10.56.147.43])
	by smtp.github.com (Postfix) with ESMTPA id A63E692014C
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746551523;
	bh=p+E6OQc6ZdnSAQJN0jft1NfgGGTACmAhRm1wRsjCYZM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SkvmHxvb4ANSSGWoA/YCjTapMusgpbsCcrQOAnhDoQjpTBUJiiN2qcwM0CrBJBuBy
	 ADRWQOXs14waVQvtp/4c4uBaFx7pnrkmtsb/o6JdC/ujfyvropygZx4imCzSt7uKUt
	 EH8v6YELF2LyaObr5UwwdGo5ojWFWZuLjD4FQI4Q=
Date: Tue, 06 May 2025 10:12:03 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/313de9-62f0b9@github.com>
Subject: [bluez/bluez] 63b07d: org.bluez.MediaEndpoint: removing BAP streams
 with...
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
  Commit: 63b07d1cb639e9f6d3d87c7ab71a3317f065fe1e
      https://github.com/bluez/bluez/commit/63b07d1cb639e9f6d3d87c7ab71a3317f065fe1e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-06 (Tue, 06 May 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration

Allow user to remove specific streams by calling
ClearConfiguration(transport_path) on the endpoint.  If the path is the
endpoint path instead, clear all streams associated with the endpoint.


  Commit: 8d0f178974f8828c55adba58b01bbc70b0f9f7cd
      https://github.com/bluez/bluez/commit/8d0f178974f8828c55adba58b01bbc70b0f9f7cd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-06 (Tue, 06 May 2025)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  org.bluez.MediaEndpoint: add client role Reconfigure

Add a simple way for the sound server to reconfigure a BAP unicast
endpoint, by calling org.bluez.MediaEndpoint.Reconfigure().

This shall destroy all streams of the endpoint, and restart the
SelectProperties() configuration flow from the beginning.

Since it may be necessary to reconfigure multiple endpoints at once to
correctly make bidirectional CIS, add Defer argument to just mark eps
for configuration.

In future, org.bluez.MediaEndpoint.SetConfiguration() could be changed
to handle unicast in the same way as broadcast: only create streams.
This allows sound server to have full control over stream configuration
itself, and not rely on bt_bap_select().


  Commit: 62f0b9b539bc4ab53936149f74a39ed88da69ee1
      https://github.com/bluez/bluez/commit/62f0b9b539bc4ab53936149f74a39ed88da69ee1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-06 (Tue, 06 May 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: bap_abort_stream_req() should cancel also current req

After bap_abort_stream_req() no req callbacks for stream shall be
called, so it has to fail also the currently in-flight request.


Compare: https://github.com/bluez/bluez/compare/313de9af36cb...62f0b9b539bc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

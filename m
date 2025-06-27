Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027E3C01
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012178; cv=none; b=iCVN/E7e0BN8UtE7Rh9Cqp8fhDw81HZ2t0QRceunZoH62nqVYmUKj6HG4ViM1GM0uX6Hb1ey+JLAmHGZcobrT+zXFQMUIynmMZ6C6sJzkskPk5BIJcgw+/ptfDR1esi/cGEIXyzCZ0XbIgoRg9+eAGCN8QV8Zohs7aEDIlTDLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012178; c=relaxed/simple;
	bh=dpRYA0/inR6vueRU/MAA653q8/VMFJBuny+4ANIk/WM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hhnWsBIRy5jeRe+mplwQkCjoo1RePeWq+3+zI+wBwp3sMuzeIgvFzR4VY73uCQEciaFcohQaBFTm4DRGsTEHGj9ONkieYVzXlkNgJxUtlOEZQKbfqPyPdU5Q2hBcaKbByLbxZbdhm+lOW078ClLdxp6hMpZoyDdr3AyOmkMNs8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FDJ72kRJ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FDJ72kRJ"
Received: from github.com (hubbernetes-node-9fa3970.va3-iad.github.net [10.48.175.16])
	by smtp.github.com (Postfix) with ESMTPA id 3B08E8C06AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751012176;
	bh=UxdboL9Tu5tMz4owVhbQLVKuPYjvQdaEGWgN6EKYGPc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FDJ72kRJdxhPEWRkqQaj9Fyua8zIsCdJGhblJWDJovEEkRB7DgL53G+iCxif13w+4
	 xZ145/cb9yUPGvD2rqFGp6PieaW62W+vH4csvzhspJfMEf/EaQFpGcXkcY3rFDvAmr
	 vbn8L1Z6XxaN1QDZhHIikCVRC5RBRR4478wO8b0M=
Date: Fri, 27 Jun 2025 01:16:16 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/976513/000000-277563@github.com>
Subject: [bluez/bluez] 5ceb4f: doc: mesh-api: minor copy&paste fix
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

  Branch: refs/heads/976513
  Home:   https://github.com/bluez/bluez
  Commit: 5ceb4f9567e0dbc60c25ef568bdb989e66f06593
      https://github.com/bluez/bluez/commit/5ceb4f9567e0dbc60c25ef568bdb989e66f06593
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M doc/mesh-api.txt

  Log Message:
  -----------
  doc: mesh-api: minor copy&paste fix


  Commit: e6e1a2645f6d9bfacc627f060a8c79160316b199
      https://github.com/bluez/bluez/commit/e6e1a2645f6d9bfacc627f060a8c79160316b199
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/keyring.c
    M mesh/keyring.h

  Log Message:
  -----------
  mesh: keyring: constify


  Commit: 9a760fc9d6ecfe12aecc3774686c4acd1b05a08a
      https://github.com/bluez/bluez/commit/9a760fc9d6ecfe12aecc3774686c4acd1b05a08a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/mesh-config-json.c
    M mesh/mesh-config.h

  Log Message:
  -----------
  mesh: mesh-config: constify

removing 2 prototypes where an implementation never existed


  Commit: e35f2ad5f60a74edb5ef7a17d9cdeb4776bcccbe
      https://github.com/bluez/bluez/commit/e35f2ad5f60a74edb5ef7a17d9cdeb4776bcccbe
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/util.c
    M mesh/util.h

  Log Message:
  -----------
  mesh: util: constify


  Commit: 277563ccd73ee773bd14f5317e7be78a734e3628
      https://github.com/bluez/bluez/commit/277563ccd73ee773bd14f5317e7be78a734e3628
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: mesh_net_transport_send: simplify

No need for internal copy of 'seq'.


Compare: https://github.com/bluez/bluez/compare/5ceb4f9567e0%5E...277563ccd73e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

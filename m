Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2633CCF
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419499; cv=none; b=kOboI5GjkRDg4LCXZvzz5FwBTPav4HgkVAiXtV+ycxhzlJow/uYYAdFaKDJr6MEq8OFOcowP87Sc4Hyj/2oPbEwS+K4s1CUEzshm+Yh6IrHP4mno5C+XNCVju57IEPPaJ+6/l/vws41Srv/jMMeV0RUj2Sdo1zE+Q+UIKVWq1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419499; c=relaxed/simple;
	bh=oFW6PJlgvuXjKlx57tgjim+K9ZvcWBDuoXq7sitBzXg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PjNwsuge8z3eWpj+5+d2X1jIyyE4RjYzac+SkmE672Twr3TSUfHTIkI6ZjcFwxDTsfZR4D8Y4p/loNmtpzGJtcWzRgjRyFyFS7m62HHQbDPTFPaOCXc7JV5Spap0cZxBbK4GCsCpnxF5+pH1QQ/SfVq4Nr518mDm3iWnfgCq+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YVXmwJRj; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YVXmwJRj"
Received: from github.com (hubbernetes-node-b113fab.va3-iad.github.net [10.48.155.30])
	by smtp.github.com (Postfix) with ESMTPA id 64991E1267
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Feb 2024 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1707419497;
	bh=i0EU6ea/mA5HKej1GrKG8IawYqsuEEsRFkcRScv4kPA=;
	h=Date:From:To:Subject:From;
	b=YVXmwJRjWQiapQVc12MPNKC0x+t2k+8NP2XSySFjtEh/7rgfmmu0HYxfKh3nnVFvH
	 Q1qsVqDln6ddJ3pMNmiZKA6DKWamhIh/ycPSg373fMYLfdLzY7aFMv6gGaaYsuLXnR
	 Ke3CrVW1IYK9LKp5AxZuNb+hAAg71qP8nxs7DpiA=
Date: Thu, 08 Feb 2024 11:11:37 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/513561-c18519@github.com>
Subject: [bluez/bluez] 747092: shared/bap: Rework stream procedures
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
  Commit: 74709286b6b4e3252668d80a0219b438cb4b0e08
      https://github.com/bluez/bluez/commit/74709286b6b4e3252668d80a0219b438cb4b0e08
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-08 (Thu, 08 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Rework stream procedures

This rework stream procedures to avoid having to check stream types
everytime the procedure is invoked, instead this creates a operation
abstraction which is assign at stream creation.


  Commit: 8e76c9140de1211588a72bf080cc45299256ce83
      https://github.com/bluez/bluez/commit/8e76c9140de1211588a72bf080cc45299256ce83
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-08 (Thu, 08 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add .set_state to bt_bap_stream_ops

This enables different code paths for each stream type e.g unicast vs
broadcast.


  Commit: 6dafe901a2bae49048968872e0854cc47cfec45b
      https://github.com/bluez/bluez/commit/6dafe901a2bae49048968872e0854cc47cfec45b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-08 (Thu, 08 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Make bt_bap_ref_safe check if the instance is attached

This makes bt_bap_ref_safe check that bap instance is part of sessions
list which means it is attached/valid.


  Commit: c1851987ca2c6e41d1e0e166e959b754e369c254
      https://github.com/bluez/bluez/commit/c1851987ca2c6e41d1e0e166e959b754e369c254
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-02-08 (Thu, 08 Feb 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix crash due to selecting ucast ops for bcast stream

The stream ops is based on PAC type not the stream type.


Compare: https://github.com/bluez/bluez/compare/5135613ce057...c1851987ca2c

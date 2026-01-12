Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82232936E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768201428; cv=none; b=tfDcFeOnOU+WZ680oAFshCKlWQYSF/DptnX2rCFSBB5YvwpnTtkQ1Z3+A+6jBiVZ9jWKkTWfwgooUvLPbBad22YU0afDBZks9yKaEcvu1TAV4pXSq3+5VjgxGMtFxByzjFS7xRZIFnlfX/Wt3SQWlxD+J+OcWWQxKnqjL6djx1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768201428; c=relaxed/simple;
	bh=bjtAiXiZ9vVLHBz0XIRXcFm5g0Ur+9qUnIlX+iTjZFA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VUx+1G3Wb4c3rwVAYku+ZHz2toju8J2pjGrEd+hnxh0dB7p/7PGEi9YIt5M4aQxGGaZbICs5QaIfrnTdBIEjsYReW3zgI3kcV9bAoBNopmFd1g4iKh9sUj3ra3+uquHGyS6hUIWOczwiz1tmx8vFb7epZxXjCK2se4StPJwKmBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jpWBsv0j; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jpWBsv0j"
Received: from github.com (hubbernetes-node-1a4ae3d.ac4-iad.github.net [10.52.125.82])
	by smtp.github.com (Postfix) with ESMTPA id C1BCD640969
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jan 2026 23:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768201426;
	bh=vL/+My2/nrRiBl/DM4qpBcq/cpgljbS3MXIIQkR9dzg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jpWBsv0jVZVE2YY9SVol0yP/TIAZKEUzzEPZ9XCOomg+zdnEYmW+KDIiiOWuhMMSg
	 dd11aGFoiW7tq7/AFXbetaI4ORXPlzcgBL7/dOviazVvTVRrSZJAd1WMhMWGcU7BUr
	 55gjnxi8BGLf0ha1kDRT1FwPiWb5tWFeF0ZuI4EM=
Date: Sun, 11 Jan 2026 23:03:46 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1041012/000000-8a4a6a@github.com>
Subject: [bluez/bluez] 8a4a6a: bap: reduce ISO sync timeout to 2s
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

  Branch: refs/heads/1041012
  Home:   https://github.com/bluez/bluez
  Commit: 8a4a6a9c56b4fa00c9b1f0d2987c33e0d1b597c9
      https://github.com/bluez/bluez/commit/8a4a6a9c56b4fa00c9b1f0d2987c33e0d1b597c9
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-01-12 (Mon, 12 Jan 2026)

  Changed paths:
    M lib/bluetooth/bluetooth.h

  Log Message:
  -----------
  bap: reduce ISO sync timeout to 2s

The ISO sync timeout was previously set to 20 seconds,
which is too long for PA sync. This could leave the userspace
flow pending for an extended period of time.

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

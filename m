Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CE16E881
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 15:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763134; cv=none; b=lir4NL4rpDo3oktSLwDGRJ7YKWdqyQs6ni2jhjciMd2O3A1pZpZvxi2XxyC4wiPTCw380HYqTNAYqXFOxyoi20znq4qivgE+EszXnrlnE7X82LsMEP6HC10H4JVZ9bSZCuM+AcbOcGVnmh0V1IXIIf22pWPKjFjjzj/FH5lkkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763134; c=relaxed/simple;
	bh=07KacDf1WvmwdrJ16qdMf9HkulWT+Xu6agotCnbQM9Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EnpOW+xnfmjsTdLl2rWpxj5LN7Lu9nX+jD42DqY+Cgn4NS7CnjXz/QwLHOebiSOMGbaFnulGy4d5JeFi4mYKE9Al90RERP/SvVKpI//rN/JnF4Gfi4GBW0YNpoRCWpoQ2RDE9WK9EO5PxsJ+fD6m7In+FMNN8ZPjgzKu3Y9cbT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Eyxar4Jc; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Eyxar4Jc"
Received: from github.com (hubbernetes-node-15cc446.va3-iad.github.net [10.48.139.39])
	by smtp.github.com (Postfix) with ESMTPA id 638F74E0C62
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712763132;
	bh=fM/0cll7p64H1sgClFKZK6nKMazcvD/eF/TGkH070Pw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Eyxar4JcSSnBfKRavstwUuu/ovA3r301s+rJjBTT37LCn7JH9XKAlUqLQ5CkoSP7F
	 /3/jJgavaXBKgBLPrGSGr/C44UeP5gFTpE7iJxprpZKbm18FYZS3X1iJZHLvdyPv5f
	 v2xMGjypV7PrxvUb6E2VCuSuAzESSjwc3TA0Ed4A=
Date: Wed, 10 Apr 2024 08:32:12 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7604a5-b163e2@github.com>
Subject: [bluez/bluez] 991ec8: shared/uhid: Add support for bt_uhid_replay
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
  Commit: 991ec8e2e088dbfeb954b6fe003e4188d516ba5a
      https://github.com/bluez/bluez/commit/991ec8e2e088dbfeb954b6fe003e4188d516ba5a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M src/shared/uhid.c
    M src/shared/uhid.h

  Log Message:
  -----------
  shared/uhid: Add support for bt_uhid_replay

This adds support for bt_uhid_replay which enablind replaying
GET/SET_REPORT messages stored during the first time a device is
created.


  Commit: a78c839b5d8546e660c4a382ab1c5c1d3a2a16a6
      https://github.com/bluez/bluez/commit/a78c839b5d8546e660c4a382ab1c5c1d3a2a16a6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Make use of bt_uhid_replay

This makes use of bt_uhid_replay to replay the GET/SET_REPORT messages
recorded during the first time the device is created.


  Commit: 528f5a8c7d76a77ba6aa95b425986315cbecf3b3
      https://github.com/bluez/bluez/commit/528f5a8c7d76a77ba6aa95b425986315cbecf3b3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M profiles/input/device.c
    M src/shared/uhid.c

  Log Message:
  -----------
  input/device: Make use of bt_uhid_replay

This makes use of bt_uhid_replay to replay the GET/SET_REPORT messages
recorded as it offer the same functionality as hidp_replay.


  Commit: b163e2bd03034cfbdbf449f85144917497bb1799
      https://github.com/bluez/bluez/commit/b163e2bd03034cfbdbf449f85144917497bb1799
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-10 (Wed, 10 Apr 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Destroy uHID device if there is traffic while disconnected

This attempts to destroy input device if there is an attempt to
communicate with it while disconnected.


Compare: https://github.com/bluez/bluez/compare/7604a577c9d7...b163e2bd0303

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications

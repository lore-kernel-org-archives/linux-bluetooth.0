Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1090A2232F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="a1yve4P4"
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4280CD6E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 11:37:56 -0800 (PST)
Received: from github.com (hubbernetes-node-6541e0d.va3-iad.github.net [10.48.12.65])
	by smtp.github.com (Postfix) with ESMTPA id 9D44F8C0B30
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 11:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1699904275;
	bh=q1yIWB1DizBzIhqK8Oztqy66bgd11ss3qrfcehxri7o=;
	h=Date:From:To:Subject:From;
	b=a1yve4P4ZWhTBFvcr8XJOKI3EHichSig/AJNzt9YzCLQ818JPd8n/ckLAa03hZMdG
	 iBd4hr1KNaFH05Y2xUvwCVKF2cXzTOKqGxrnrVufFzGW0jMfH30tvzr2fG2vxvjlKR
	 +7cCL8iQkSeBXFitPvfkmmxtUj1P16UuQ/7VE1AI=
Date: Mon, 13 Nov 2023 11:37:55 -0800
From: =?UTF-8?B?Sm9uYXMgRHJlw59sZXI=?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/b978f9-7ef406@github.com>
Subject: [bluez/bluez] 7ef406: client: Invalidate scan filter on "scan"
 command
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7ef40617a049f083b3b5d318bcecbc60c4673c13
      https://github.com/bluez/bluez/commit/7ef40617a049f083b3b5d318bcecb=
c60c4673c13
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Invalidate scan filter on "scan" command

The "scan bredr" and "scan le" commands are broken right now because the
transport filter gets set, but not actually invalidated.

Invalidate the filter with `filter.set =3D false` so that it actually get=
s
updated when set_discovery_filter() is called afterwards.



Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E722EEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FljXSaGo"
Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B3171F
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 11:13:32 -0800 (PST)
Received: from github.com (hubbernetes-node-478e32e.ash1-iad.github.net [10.56.157.31])
	by smtp.github.com (Postfix) with ESMTPA id 5AB60340820
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 11:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1699902812;
	bh=YbC+e26rsz2AoNEXypPpZPxbLjO7tFKkUZzuyT70ZfQ=;
	h=Date:From:To:Subject:From;
	b=FljXSaGo7/WbiIV8Gce95wFM8r7e0DE10jk17Z266Dqc/PrCO9UcbhlVDep2Li42L
	 3o4P5U7ZvmWPVY0KGhpLfmsVGIab4BGiLcmhwL4GaKWY6gB2jM/FogCiD7lUtz/3z3
	 C5rqpe27byGz+Kv2P6DHjKtExNY6N9FO5/gBnmeE=
Date: Mon, 13 Nov 2023 11:13:32 -0800
From: =?UTF-8?B?Sm9uYXMgRHJlw59sZXI=?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/303925-b978f9@github.com>
Subject: [bluez/bluez] fdb5ba: lib/sdp: Allocate strings in sdp_data_t with
 NULL ...
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
  Commit: fdb5ba2cbff3e8f1411ab188fa84b58879b92b83
      https://github.com/bluez/bluez/commit/fdb5ba2cbff3e8f1411ab188fa84b=
58879b92b83
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  lib/sdp: Allocate strings in sdp_data_t with NULL termination

In extract_str() we create sdp_data_t with strings and allocate
sdp_data_t->val.str an extra 0-byte as NULL termination. In
sdp_data_alloc_with_length() we're missing this, and strlen() in
sdp_get_string_attr() ends up overrunning the sdpdata->val.str buffer
looking for the NULL termination.

Allocate the extra 0-byte for sdp_data_t->val.str to ensure this
overrun can't happen.

Co-developed-by: Zander Brown <zbrown@gnome.org>


  Commit: cfcc6346a96a9a4c3123ddc5bb395e079efe5205
      https://github.com/bluez/bluez/commit/cfcc6346a96a9a4c3123ddc5bb395=
e079efe5205
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  lib/sdp: Don't assume uint8_t has size 1

Assuming the size of of uint8_t is bad practice, we use
sizeof(uint8_t) everywhere else and the use of sizeof makes it clear
we're accounting for the descriptor here rather than just randomly
subtracting 1, so change that.

Co-developed-by: Zander Brown <zbrown@gnome.org>


  Commit: 5afa25c95e6aadd431941b410b4d5fdd44b7458a
      https://github.com/bluez/bluez/commit/5afa25c95e6aadd431941b410b4d5=
fdd44b7458a
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M lib/sdp.c

  Log Message:
  -----------
  lib/sdp: Use correct string length in sdp_copy_seq()

sdp_data_t->unitSize for strings in the SDP record is
`sizeof(uint8_t) + strlen(str)`.

The "length" argument of sdp_data_alloc_with_length() is expected to be
only the length of the string (so `sdp_data_t->unitSize - sizeof(uint8_t)=
`).

Since the last commit, in sdp_copy_seq() we're allocating one byte too mu=
ch
for strings now, because the `sizeof(uint8_t)` is not subtracted from uni=
tSize
there.

Fix this by making use of the length returned by sdp_data_value() and pas=
s
that on to sdp_data_alloc_with_length().

Co-developed-by: Zander Brown <zbrown@gnome.org>


  Commit: b978f979678d237f406f3209cf2d5f2da8e5b74e
      https://github.com/bluez/bluez/commit/b978f979678d237f406f3209cf2d5=
f2da8e5b74e
  Author: Jonas Dre=C3=9Fler <verdre@v0yd.nl>
  Date:   2023-11-13 (Mon, 13 Nov 2023)

  Changed paths:
    M lib/sdp.c
    M lib/sdp_lib.h

  Log Message:
  -----------
  lib/sdp: Pass size_t to sdp_get_string_attr()

We're currently type-casting the output of strlen(sdpdata->val.str) into
an int, which is somewhat problematic given that strlen() can return
values larger than sizeof(int).

We can do better here and use size_t instead, so let's do that.

While at it, also add a comment explaining why the check here is "smaller=

than" instead of "smaller than or equal".

Co-developed-by: Zander Brown <zbrown@gnome.org>


Compare: https://github.com/bluez/bluez/compare/303925b28110...b978f97967=
8d

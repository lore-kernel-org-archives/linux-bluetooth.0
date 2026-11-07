Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794016614;
	b=paXcR9MEYr/baY6XWjVHPh12/tUw/IdWM8qL51UznEjJXC59ufxHKtHBCaNBPaBTdXQH
	 KYzQO+pRNgU96H6C6LP2QhqfxtDgDwwXwi0T85wn0rNuvTMZqv+bheFMlq2o1s4XJGv1N
	 khquolHXY0ZdmxBxIw3O9FpeD0EEFMToaU/ntLD3gMI1pVV9UF0/WXDEd0CwrBIu5+jWg
	 sCVdby+VwvUfkM3lnCxhTUa27EO++UVS5s/5SPraW8yIL37NtbzvTw/7te6Ef+yXH8FER
	 hfYElSDaDJisX3lsnIDqthdjk3PQFlzzoKAZ3S7kVTyEjQy3/j0TySI+ZzejfyT7j0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794016614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=RtWAahkiJQf+KQQeeOZAQ52FxTvlKO8W/nA8X7WBVdY=;
	b=1tseGxTMJjjC+1bPeloIgf+JBSr01sNFUKOI7hmflZyGVOQ0l6Ekr/nlTet+tid+rsWJ
	 fn0UNNtOS+jL6jXKN0HI4gFj+KhtEfZELsjgNNXkQyrCAnEXzI97mlaAD4QQD2F3kEjog
	 mO9DkUl5+zMKctDZivvqgnwmd3JFQuyC3W+S11q0xv7bbn2Fk8564fIMGey01ARrMqxWf
	 ivopZxXFTxXJUY3/6D/IuAqDBstbrfroBb1keHBrj+5ylQRkib/yLKyIq07WgkHhm/h3K
	 RNTU24kJQQ0+4BPHWMf5yySzuLoxsEvFlNvFRwC2hKpgqpve3cdzHXQWBkuZ+Hx9trA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simpleble.org;
	spf=pass smtp.mailfrom=californiaopensource.com;
	dkim=pass header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=yNHGD3Gj;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F0606A32E
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 01:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D7F0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simpleble.org header.i=@simpleble.org header.a=rsa-sha256 header.s=google header.b=yNHGD3Gj
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37000e7234bso1579013eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 17:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1794016613; x=1794621413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RtWAahkiJQf+KQQeeOZAQ52FxTvlKO8W/nA8X7WBVdY=;
        b=yNHGD3GjZyH4S1v9h9new/3X4/tLRMCgcJhMrd5OPfV8V7q2RSpeelhQNMe4OzaTV6
         keHCmusuEYHM/wT8dOVMlPZ0PzJeaE04XullKADb4YF63spM324oQRe5DnN45nBtF6Fi
         fKdBnAhyarA9fwrwzJKerW24OJSDwDdu1mQPcAuJ4jrsaKR1O8WpgVb+mLt2tYGMIZuH
         VrgFX6p21VsS3zkaV+iTe/+I9HaZ4jqvirc17ZytSV+9L03tOK6Vj3R0L6K7sfg+90CJ
         Jw8vxKB+KIHk7cBrXqWAvRJf5C3HD34hf7SNXu6KLUQaiem/QZpc3yyfZrzyVzweNlUl
         UHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794016613; x=1794621413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RtWAahkiJQf+KQQeeOZAQ52FxTvlKO8W/nA8X7WBVdY=;
        b=qb0wquPuBDBUBthMzznrQ5AKIwOd780FcX3eS/9fiuAUc5a+i/sQhacg9t7Fgp67m7
         QnmiVTIceKUZm+Y4AFauUh6jT9Rc7szBQHFNXCPwR+xWnxjx8xZxdFwjWpWjz+HbUIhK
         5jGWvEXkx3ILiE+dTmaot9nGuY1UlnZi0QOuXHYVdLqwDyXoc4aFeQuLhrwmERfOLJGZ
         Ob2uMjEgMUwhje0/tMyEmXEyShfjkKXcgwJ0fk1++jMaWYwm3/6DJCV9Pfy6mbDmgrQj
         iKNDu5equBD7TgFdJRufkWaBrQUHAQ6aGfxfsfizmBgAvNuZe3MZNZJkB77MXdSuwkSc
         mTDg==
X-Gm-Message-State: APuU4Z962yP3I5dWiFzCtrIZoQG0IoJ3g8bosRhRhviGi/tb6yYcJMEb
	xs1R+f51rEFSCzXjSul5Ob24YPa9yWA0csU50jsRGxqrN0I5O+gMVRrkCTwkrpeFd14+Vs0MTTl
	c/6Iy/vo=
X-Gm-Gg: AYBFou1wM2T6yjBPb8Q+/pwndBRNYHQCVSzM1KuNght1MXmPisThQa9f+p8cQ/+cvif
	2iGS3PCSO5sfxTwmsLVpWArpaTg3aXzWvGNRXkb8yIBHC2gDyqv0yPcoRYsGj41JiZ+5BObE7Ja
	/UCWHvoiBHftH0Gt2QsiiNDh2Xi52yf0BYkSJEq1kqpB0QQYngwUscF0NB0JRM/r32sDwTVRotJ
	/CsZgKwqRErDFp7DPlKZMGRBQ1lDzBNFLKjOvYM426conyB/ENmZ4ha9zyG7H3k5jW4IJJZ5hq2
	33exM7lKE+Dk7/aMGIOTLGJb7z4TltZQWgoailZPdxJg5yj+bbBfIf0Wys2xXDSf0tkZ3Njtqfs
	4xUqSpraHlZM/j0Lt8pduyvumQX4QDqyNNNXbXXdT69kkKehlZ+I1QI9h1YLlj1zT+gxou1XJmH
	EZLNq31JA3ceIQ7Tzf9wtS77b3oTLaHgWi0EATnwvsQRkQtOETv80zAylvnwdrdII+w9A5XCqja
	6YodTyekomfsoofV2WLKduqV+Ib90SHAqBwwXks7AAGWDPAxW1tuB813ojdv2kNs9OxZkB+7mI6
	AFdGINo/gQt2sgwPApgWD/dICJksZH+WkX8BOnhClzOiYxdcpKesWxd7rRbXybmU7G9y9mla6Wk
	P3pQ53xufIBZGj2A7XXOPzwuC/NT6cCC2NS17UTl9/7KnPSv3ytXFBCJH2uryVirxQkV3qwk=
X-Received: by 2002:a05:7300:ce92:b0:351:6409:25c9 with SMTP id 5a478bee46e88-36f7700ab0fmr5559247eec.35.1794016612889;
        Fri, 06 Nov 2026 17:56:52 -0800 (PST)
Received: from localhost.localdomain ([147.185.47.151])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651e6b1sm22977994eec.3.2026.11.06.17.56.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 17:56:52 -0800 (PST)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ 0/2] bearer: Fix auto-connect handling of LE Connect and Disconnect
Date: Fri,  6 Nov 2026 17:56:47 -0800
Message-ID: <20261107015649.84892-1-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

org.bluez.Bearer.LE1.Disconnect is documented, like
org.bluez.Device1.Disconnect, to disable incoming connections of a
device that is not trusted until Connect is called again. Device1 does
this by taking the device out of the auto-connect list, but the LE
bearer does not: a paired HID device that is not trusted and keeps
advertising is connected back right after Bearer.LE1.Disconnect.

Bearer.LE1.Connect does not put a device back in the list either,
unlike Device1.Connect, so a device taken out of it by
Device1.Disconnect is not reconnected after it loses the connection.

The first patch moves what Device1 does into two functions, and the
second one calls them from the LE bearer. The BR/EDR bearer is left as
it is, as auto-connect is only done over LE.

I reproduced this with a functional test using the HID device of
test_hog.py, on master and bluetooth-next 3f425f95ba39:

  Disconnect, untrusted   master              with the series
  Device1.Disconnect      stays disconnected  stays disconnected
  Bearer.LE1.Disconnect   connected back      stays disconnected

  Connect, then the HID device drops the link
  Device1.Connect         reconnected         reconnected
  Bearer.LE1.Connect      not reconnected     reconnected

A trusted device is connected back after Device1.Disconnect in both, as
expected. make check and the functional tests using the bearers, HoG,
btmgmt, bluetoothctl or the agent pass as before.

I have the test as two test cases for test_bearer.py, documented in
doc/functional-bearer.rst, and can send them as a third patch if you
want them.

Kevin Dewald (2):
  device: Add functions to pause and resume auto-connect
  bearer: Fix LE Connect and Disconnect ignoring auto-connect

 src/bearer.c |  5 +++++
 src/device.c | 42 +++++++++++++++++++++++++-----------------
 src/device.h |  2 ++
 3 files changed, 32 insertions(+), 17 deletions(-)


base-commit: a8067198717b38391ca183ed7f41a69ec4b81b6e
-- 
2.54.0 (Apple Git-157)


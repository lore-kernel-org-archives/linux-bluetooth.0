Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507281;
	b=DBqoRfatqqdFjiSXey2eA0pidnvWxox218xwqbtC/hsl60Nr7UqmlrLZsYT3VeA9XSoT
	 zxLjCsAX6qLgbpyF7NYtTySjsuJmRz0XZ3SJOIFxIhMpxVxWjugoywbA0jyOMH/wog89w
	 r8Xn6KZSVEGBr2Tmz8MHjeoGLRYGWGaUHexdLTq+qkmd0lByySi7+g2M/CL42B+7jjgw3
	 LrwhWGH8XS3xu0cGD6ejlVLBWJqhs0P7WGaxfzCL/MW23nrHfeJFf1rSAG/Q17+ku7i/t
	 sd3/E1KVMQCXq1NssrGeNN3A7BgA1lSLTcvX2r9pf9djxmWTB5OgTnieajOFXIJ4wwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
	b=rYxchJw7e+SFjlYA84ZvSRm9bAkoWceuGPCn75zUKScLW9F+nP3ot0oFguRSaOW//i35
	 koeCj2+ORgjVRHEZDpCtBXttej65629+XA/4v4c+nKCQXjjSX9BndECcEve822FSkzILJ
	 4+Gz6cadeikmzWf5jfPDUM7NlajXqPnYlRdO8oLI+ikC8j5V3pKWahQVvWscCZ6JfpwKQ
	 x9ce8C1Xi66eAzLk8GZiUI1uwR172r0ZDGmeOqd6eDvg/QbzXm6b+b1lDZj8EUG+Js8rW
	 bFY5NwesX0XTMRy0Yx2qc9a4EmxvZF+wKDA3TrCXzgubSAG9PZPlBECxnXoMCVFNw0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rvNenU5Q;
	arc=none smtp.remote-ip=209.85.222.51
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD3606A33D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 18:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FDD3606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rvNenU5Q
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-9905d61449cso59124241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 10:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794507280; x=1795112080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=rvNenU5Qquy6EkXq7XUeOX14iskRgWaLdDOTWLO2NqreBK+F3aSs0J/0IdH4rIROLD
         QQFuOJqwz7I9PE9AOgYElVqtoVZlefIVnjO8Cx/1HuANIpjxr7rLZ4dMeNMGEIEdRegl
         FBucUyoGb71YJv0OFewcNEeE6MBgiuKNSgU1HuWXBooBX+TWluvp78TVd9kkcW5xl9uP
         gA8GFLJWosd9Jt3Wn9LS8oOw56yjVxoH/iXtP2V3wi27GH3jrqoZYDK+YlZoQiFrSY12
         JGk6bgKO9zdu28smb5BJastzoEz3GDZsMOiMlPJ0lNG1m8xF2WGXamUuh9z01E8qvdwD
         RKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794507280; x=1795112080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrimsWcRErevb6TPGaO2i6wHiMYEkLTaXUBRzUU9L8Y=;
        b=stQCd2uoiXPvEqt03WgycMZpG115vdXfSrHtG+lCxvxjbPf2zJ0v8Eng5rA24Gz0Oh
         7OHk63AKWuqo8ch57lydxiu7PTmdOLObX864RPm8BsBESDR41dMnJyL58yO/g5GzmlRZ
         Erak4Jk3nS+U1hlI+cdF32739/+C73nxkA4q6JHniynL/HnDZDQ7Byqe7p5+gjrPOgqY
         a/9MxJaGgKfkKFP/9TWhefFrZJQADkqCtmiID45cSaJsEv9YUKSA5uDx+IkurPXviXSw
         KgiGHe7dPWExJtmWReRbfPG6ereVWRY9FMdFKGPApnWm+WLLMddRVDWOObynygeXkT4v
         eyqg==
X-Gm-Message-State: APuU4Z/XcTPpjS7859UR1lMHO+GD+lDD/q0qc5MjM7Q/UMBXUEgcaSaJ
	fr6N0qdr2HumfT9ey6aw/UZA8Y9LeO/Fcy7CfwoqkFM4Hs1tI1bgzc2P5lcNyQ==
X-Gm-Gg: AYBFou1tYhrbEJd8wbU1XSjodvI8qie4ZTmBUEp4Ik0yALLUhP2ShEYiov6Y2O6bj29
	plnvnzy129RTGI0RVqTUwOGgi0F3QN3VQem0Tul4Fd6pgIgLaNtIIFPASh6avumim0ZrdpkiUse
	uoTNkv/fgkDtttDIW7DpzriaKDb++2c44uIYOzD0m4SSJcx3BFNHDjD7qWpgcSd9RwxOnIvORsX
	H4UcT8yIUSaIev/zsy5Hq8lXdYKjAXhIbEOEaAKrCFQn0uryNaB4wYCefbz54ChGwnMrrw5oZP6
	V0dtf0Z/AMe3MZKPQk67i2ssyDZaOty1f2mhWh5/u1MqeM0JJV6r/8e/JAoCicxbxREtwcRx4wp
	Vjovyo05PccwPYOeWzCrStqf+cfo3DSX3U/WXklZtVvlvx06pf5doFV4Y6kGbXIDxxdEeNoazIn
	jpm3xeadNqQeN95oGhPKYEZdp9O1AyuayBnQQN7NllaOZV0sRcnhedvHL0pWoQiLLMr5+ggcfTc
	8ruUq8mPyUizorkMj40M5KwXdQcLPuvBXdgNbuApdSX5d1gvAyANcBb3uenlGdaw0FXQ5mS4FNE
	YWWCBVmKcZ06UV4xX383S3faKReuF5cUc/G+7oolgYxhEPGEmopT0+15ZiBpMoCsQI8G/nd+Xt9
	yB2d2NiP7bYPFeJFgXk7nJ1Yu6JLyZ5wqIGvCkHRdMCFX4m/lKbLzmPuoQGyFNSo1GyPRi0jC8T
	VL6Vk=
X-Received: by 2002:a05:6102:c46:b0:7d2:da5c:6f73 with SMTP id ada2fe7eead31-7d64d81ec2cmr2052137.26.1794507280376;
        Thu, 12 Nov 2026 10:14:40 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c1b33eesm178749137.2.2026.11.12.10.14.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:14:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] test: functional: Cover clearing a cached configuration
Date: Thu, 12 Nov 2026 13:14:31 -0500
Message-ID: <8fb4008b3362a9586ef013b0f5d5571ded3af477.1794504552.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794504552.git.luiz.von.dentz@intel.com>
References: <cover.1794504552.git.luiz.von.dentz@intel.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Have the initiator clear its remote PAC Source endpoint twice, and
check that the acceptor removes the transport of the Source ASE once
released again from Codec Configured, leaving the Sink ASE alone.

Assisted-by: Claude:claude-opus-5-5
---
 test/functional/test_bap.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 324304204caf..02f203b68667 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -698,6 +698,29 @@ def test_bap_unicast_desync(duplex_hosts):
     expect_all(initiator, [ACQUIRED, f"Transport {to_sink} State: active"])
 
 
+@duplex_host_config
+def test_bap_unicast_clear_cached(duplex_hosts):
+    initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
+
+    # Releasing the Source ASE removes the transport of the initiator,
+    # while the acceptor may cache the codec configuration of the ASE
+    remote = from_source.rsplit("/", 1)[0]
+    initiator.send(f"endpoint.clear {remote}\n")
+    expect_all(
+        initiator, [rf"DEL[^\]]*\] Transport {from_source}", "Configuration cleared"]
+    )
+
+    # Clearing it again releases the ASE from Codec Configured, so the
+    # acceptor does not keep it configured
+    initiator.send(f"endpoint.clear {remote}\n")
+    expect_all(initiator, ["Configuration cleared"])
+    expect_all(acceptor, [rf"DEL[^\]]*\] Transport {source}"])
+
+    # The other direction is left alone
+    assert show_state(acceptor, sink) == "idle"
+    assert show_state(initiator, to_sink) == "idle"
+
+
 @duplex_host_config
 def test_bap_unicast_duplex_enable_one(duplex_hosts):
     initiator, acceptor, to_sink, from_source, sink, source = duplex_hosts
-- 
2.56.0


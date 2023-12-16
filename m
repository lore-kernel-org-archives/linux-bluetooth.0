Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698AD15E94
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 Dec 2023 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rjp.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjp.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rjp.ie header.i=@rjp.ie header.b="mn9Y9CoI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
	t=1702686658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1tq4LZQMP2/9wCtMopsRRNH3slzI1TMbtqu4DH2GTQ=;
	b=mn9Y9CoI+0bPuqJTcZM/2SKaOmjzdm22l1OVepjgC+s4/41HrOyB16P5AevD4KNv6X5j3D
	yOzPioyVwdhX60bfZKGiT+38xBEX3ajVrYT5OTb31A5epi3XYGVVlMrX78Us6E9NmSizAg
	g7SpzllXqDIbxdbkZpziuvohrnj8cMY=
From: Ronan Pigott <ronan@rjp.ie>
To: silviu.barbulescu@nxp.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH v3 1/2] transport: Update transport release flow for bcast src
Date: Fri, 15 Dec 2023 17:29:15 -0700
Message-ID: <20231216002918.55577-1-ronan@rjp.ie>
In-Reply-To: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
References: <20231004075646.4277-2-silviu.barbulescu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Silviu,

I encountered a use-after-free in the 5.71 release of Bluez which I
bisected to this patch. The backtrace is below:

#0  0x000055e93dbc8785 in a2dp_suspend_complete (session=<optimized out>, err=0, user_data=0x55e93e432520) at profiles/audio/transport.c:431
#1  0x000055e93dbb97ea in finalize_suspend (data=data@entry=0x55e93e435880) at profiles/audio/a2dp.c:376
#2  0x000055e93dbb98c0 in suspend_cfm (session=0x55e93e4317b0, sep=<optimized out>, stream=<optimized out>, err=0x0, user_data=0x55e93e41e850) at profiles/audio/a2dp.c:1276
#3  0x000055e93dbbfa4b in avdtp_suspend_resp (data=0x55e93e431823, size=<optimized out>, stream=0x55e93e433e60, session=0x55e93e4317b0) at profiles/audio/avdtp.c:2900
#4  avdtp_parse_resp (transaction=<optimized out>, size=<optimized out>, buf=0x55e93e431823, signal_id=<optimized out>, stream=0x55e93e433e60, session=0x55e93e4317b0) at profiles/audio/avdtp.c:2985
#5  session_cb (chan=<optimized out>, cond=<optimized out>, data=0x55e93e4317b0) at profiles/audio/avdtp.c:2286
#6  0x00007f5e225b9f69 in g_main_dispatch (context=0x55e93e3c6800) at ../glib/glib/gmain.c:3476
[...]

Originally reported in [1]

[1] https://gitlab.archlinux.org/archlinux/packaging/packages/bluez/-/issues/3

Cheers,

Ronan

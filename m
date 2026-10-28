Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.6.128.109
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197715;
	b=vLijLY0Y+rE3PMNuifiWlCfOa9EMK0fJhc+uUxMx62RjqNYcHS7a0bZU9jH+fgqxBtU0
	 tTi7do6SRm2KUJVfBDSS4EQ8rMUF6YDH6Hxk8D9eWjVO/rLP5VaRcTRBL9aOgvkN3BjPt
	 wVYhIyRUUBoBUkjdoMGC00TFMIyYXO5aHN+TFrWEegeAl5B8RqeAR+UGyOepMRjvDUzlu
	 2IwyHkuN3leBwiExqYpOrEPoFzaqkPp6vO0KENGuxTWpWl5Qfj4sIYMN0RHf3k650Czx7
	 opgEFmVoh/DCublwTpd14hHDuOz3M+WgPEfNY3w0iYEEKw4GuA4HDF6viK7k6F9XfKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197715;
	h=DMARC-Filter:DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1LfB+84NBGbm/GyoDpQVgJytlLPdkNE/ohvQ66bC1kM=;
	b=PskiycH7+Khxw03aUeFJa+kxm2UXVDeIQ4riybGgeXRaCR/W34Wy0lB2SmcQ82YkDm08
	 dVLE7TLCdVBXKcd2bpv5G6ZdYGu3fdPr4Qk/vrursffqor/4HLbh0ngEcDjICdEIWOwRL
	 ioWyOIvSyPVjqtYVv23nhnqx823wxmODfUl2ywQmbMA44zBIs06d4mpeF8Sa9gJ/37v0v
	 Gn8hRiHlwOC9Y4JIK9eiQ9sqkIQf3FUE3+ZJjAZ3e3RaPVfLi96hBqiOIc4DElJMcx3IZ
	 ZosMPEpLs4MdL73TwqiRxPt/vWFQSCaxKoYPsBPi8rMvwcpkRdlVK6rFML1kfmPv1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yahoo.com;
	spf=pass smtp.mailfrom=yahoo.com;
	dkim=pass header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=HbPqVtvG;
	arc=none smtp.remote-ip=74.6.128.109
Received: from sonic312-47.consmr.mail.bf2.yahoo.com (sonic312-47.consmr.mail.bf2.yahoo.com [74.6.128.109])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85803606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85803606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yahoo.com header.i=@yahoo.com header.a=rsa-sha256 header.s=s2048 header.b=HbPqVtvG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793197713; bh=1LfB+84NBGbm/GyoDpQVgJytlLPdkNE/ohvQ66bC1kM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=HbPqVtvGoO1gl53/6aFLehhsEVliagQQiW3ewtJbAQrzJkZ4pkv8tDrufKz2aEtqEuLXhKSNieoNW+9H9mQUf1C2Y7KWnuE0hCeyMISuYWNOWT+inSoqCKSxlF1uuVPvECGXMgku6gVHgWdyickHaaxnFrPCerdDdQTlckvGAMGgDMl7MM2dm1cp2iI3NugqY3qF1Tppf6Ac91MycM7PZ/KeH1xKJYZOnwTA/vXGJF2cCCOlZajD+g2sRxAfdwh05onlLPWcjzBxH+yIFU8eVTp5yNkUZp4frhFYBLjZEHGU9gzDcMcuWzOq5749/mkyMSNzGNVKQxETOdiTnjglyQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1793197713; bh=DMBwoR2TjpGAuDPVOYump4wGLcmcQZPs67xXu2C0vX1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PAAcdbratc+sAfFqs6FzUi4mjhF0Ui0uYA39V0PmeP6jj3ufqQlTVi9btxNU9bOjQ307+qpJELP3GM/m1BLz9gtx7fP2OL6eKUWOEBuwfj21RTeM4z0LXbcllTyd5/y/XV7fCvlKxdb3ewKyasSY0/f3MUBEm8AG9ln9MyQ3DToIRl8pneDR6GNaRax944quE/ida4sZ4rRS8HifkLNPTtbKXj2GKo1Rg2apH0/oh1qAJNNHWXTdZD3fSOKAUm2SbW30Y2jF28GhT1sDRlp1UQAe5RgeCB9clxiXkcP3l1HH5c3N+Ni1e2txuf6XjBxDRFcZZqQ8zFR+HeSnBZStUA==
X-YMail-OSG: 5a_M3EYVM1nCRMNprSS4IH7bhzRv2fHGTSGjY8G3ZK525hdGhq6CcuiAol2Xv_U
 .jLRy.h.5cBeZr_u0P_GBGngZP0lNS7ZW.FZf2zXBOUhs06ZjtILjN7Lsz9qA2t.f1VNOG0floOi
 5C3fJBxzOi_syBL0U9K2wLB0NvHWs5rsBBfgLjqsPfVK9ALnmFvpu4FgJW8Haa12hyQb2UqQzbnA
 r5bJIKpWdKCSx466OdXRPciQAsFiuQm2AE1rpnu6TI9Z3gI8s_cu3It0ZRmJ9_KdaNnDxNUlVnZL
 _wfVufgeeX6trHvg4WENM0GL9WnOCg0N7.yYhYLHS28LizTUIm65i7PEoiRqsJcSzH7.GZIYr7ni
 0q9GshvqtBtW0HBwBdQAaMOaJ.sHqssUgaXrsMB9jockyffaDoVIkJQOjo9rYS0zS92MHdEo0esc
 wyzbbS3wXLliCe6xzuV2dJ_jJE68BcaCukG4.NibLMBLT3jMhizovgwtPaob9M09LfuSH9EvLoDb
 cOASglw4a_t0rMRVzSmjKBOuy4NupmWRqNkmhdRvOXS5v_TuZIW4opONr6E1XOhG5sOKQoqx6mZZ
 V1kqffv1di6V2izg_g3LYyy9qw6ZzPLE5gd9DZs9XT60NyBW.UKAoViCbg_.uXu10CVdc8t_TGEp
 c6o9mUJysguw0uRaj7liNoxRzlqNLWQp11lyosMIndRmKuH492pxtTmoNY59YhSDtsfd1o4Nms7x
 FNVcWVHfFNCgNXA2eX4nJ1YO9VjNuY2k6g5xTgTrLDlwapNLUbJs_AcOPVkgZ9HHogups8eFx2eF
 o4ZODZ43R3odanX7KdBFWYIb9Ty4ELk7LjJkB0EKxg5QKfMtlVGwOVNw56TTqLanRS3.0X2KnteV
 IOn93Oi.r9DUhzOEo2uHVKba3m3SMfLJ5iYF.4k5BeZYMTyJ3LNHKkc_JpSuj6YjhbFsSM5xUjMR
 qHQJ66QxJOJW20oyMpRpdZmjabO6NYFVIwYc5DSeKkF0ogf0eaIkVyQyitiJlkeGPROCPD9E3soL
 .PqEpKoufty_hL6dhRomEXUcqQ7vHsIlJjWx996SK1Ckq1_u_XaEjVbLvHsAQDUds.Rh3SQz7Xfj
 B26IWfM1hn6oHNL0_t54DMlgLBKNQQfNhbzIlUiRDLm235Uvm7c4CgjxF.3.yC4JfWsogSZfIz1H
 LUlSiXrWX9Y00jXiyKBvhW28HLacrbe9f2fKnS5VpkvVDiT60Wc5tNCXENKF9PnJpoWRjpcKrGFE
 NkkZVhJ6n8FIg9Qij4SxWDe56Y02KDAaGUeA8G72HLvwWIdJL31806_hTouvyIKhskuA9SsYw__R
 Fajsw3tq0.I8vD6OAuoiWNrvmKYjEgGVGij_1bsmuQwd1Mc7vhU04so2tqIsm.mheIW5Xl1dKC6B
 SG3ry0.2e.m4oZHG10y4qBJAsW5zFlyoxlXUXROnY6IfYNOaOnktGlQKNIw9UP3UsgDf7ENzY22n
 7JJfIVPfUyqVIKEIK.DlYRXQY0C62HXtYEF9VnIUOMzPOUE6JUDOViPyUfPDc5naQTaRx5WAW9s9
 aIU8.Tyl.BOhudXkO9dJtGY0g5yoqZZFGvyUoD7rob.4G5GfX.dfPr1A3OP5NsCF.FdLZAhW9XcW
 Rmo9xnvm4Yo49b62L8Kk2jhQLYvcYsnmBf9on9w5E5v.a4FcBwGgcS0xhrZAiwJL2dtt9qIj9ti2
 rGv83E7GoswAAQosl7KUnGmBjZydT5jXrU6Y9L4yar205JWl2hmvwLv0Pyymu.7gcqSnGaFxRC3m
 y6CGrWN7uA3dBvwA6AmKM7feYsRONZU0HWeWW0CrEfwa03_htUIQ1bIfBQjLKAQJJg.Iv8CZ8zs2
 a2leyOf54w4c7FNOMRg0c2PHuuqOYwbnVelD5jVdu41QxS2XxllhRN64e1jrAoO4XZX1mLQS4Zmn
 TF3xBU43c4dZMMPy3rNQ4pLgJuZZWDCb0V9hUBBruerXQh4ZbQNhXI8BxdAOPtVPdzCmBqJfye_R
 jxHma9uzQ3lcyp7mc9RvpgoZjPUmH3FjuEemSy2jSpSwN8S.y3kSc4.ISKCRWzWXIyJtSbJudQzT
 a8OdA00AoMWQeGCBc_1Rs9A5ZYu6GpWFSah9IhOf_v1S9U7_uwpxawqviLAJnZAJInzclb988X9y
 aoPDfK3.XY9kjPuuqduXDqtuyd9DIKQKs8hO7bJ9n74DFcK.08SjBelG1v6Loo6fyMPHK0DsSi3t
 _2FjJ1.FeQYHDctKpLul5puVrW9wAKNrif7snErmX9U3ZjLWxYMtxcmnxYtJUoKomDZHjk7k4qP.
 Em6MbRIHb4RHVjgGuzBl1lM1OlGARU2JAaTgiX.c-
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 1c6ed766-fa46-49e1-9571-1b07cdf4f0e8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 28 Oct 2026 14:28:33 +0000
Received: by hermes--production-bf1-6d6877594b-nssjx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0632395d668a8bca3a8d4cf7829ba41e;
          Wed, 28 Oct 2026 14:26:32 +0000 (UTC)
From: Jeremy Dean Clifton <deaner92@yahoo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Heitor Alves de Siqueira <halves@igalia.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hillf Danton <hdanton@sina.com>,
	syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com
Subject: Re: [PATCH] Bluetooth: hci_core: Fix queuing disc_work while workqueue is drained
Date: Wed, 28 Oct 2026 14:26:31 +0000
Message-ID: <20261028142631.128802-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020145320.115333-1-deaner92@yahoo.com>
References: <20261020145320.115333-1-deaner92@yahoo.com>
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

Hi Luiz,
 
Sashiko replied with two points and they are valid:
 
1. A disc_work timer armed before close sets the flag can still fire
   during drain_workqueue() and hit the same warning.

   hci_dev_close_sync(), after setting the flag and
   synchronize_rcu(), we could cancel each connection's pending delayed works
   (disc_work, idle_work, auto_accept_work, le_conn_timeout) before
   drain_workqueue(). 
 
2. Skipping disc_work can leak a connection created after
   hci_conn_hash_flush(). This one is more severe.
   Suggested fix: re-check HCI_UP after hci_dev_lock() on the connect
   path, so no connection can be created once close has cleared
   HCI_UP.

   Are these additional changes reasonable? Any feedback is welcome.


Jeremy

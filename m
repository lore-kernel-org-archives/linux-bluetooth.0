Received: from outbound.pv.icloud.com (pv-2004c-snip4-11.eps.apple.com [57.103.65.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C373F1676
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 22:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559713; cv=none; b=PIZoS6yZDsWHdf1vL8RCkNTakqeIRyRxeCfIjIdyMvSOBXeN4VND5MV9AHTAXc1SUNGuIoNs3hCsGJfeNoUIoDjXDqtQeI2/a/HQ9PL7nnibpJxy2W033rZkR+lZlNEe0JWD0GbjnF3uP7D1lMGNoAWRcZY9/wGPc6DkB6RVCZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559713; c=relaxed/simple;
	bh=s5fkFjsx/yBaGR35CDqfsv+VemrC+/lhG0oTEzbJGJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DD2O3O80RLpyemrvgTBf55e2Kzp137k9x3Ltpa92ufMhcJPU9SWom7UYt0iOh5aR//m2XjL7JfFYT7ppNKnpYIUDfgghdpzfaL7MWgIjd11qz2xTvz2pN7bLCXp0x8Z4PtDIOw1E2gTHUYaa5T3Os3VL73F03PK7XdslC/pzQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev; spf=pass smtp.mailfrom=proxy-alt.dev; dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b=uM9KwpVZ; arc=none smtp.client-ip=57.103.65.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxy-alt.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proxy-alt.dev header.i=@proxy-alt.dev header.b="uM9KwpVZ"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPS id B85141800624;
	Fri, 04 Sep 2026 22:08:23 +0000 (UTC)
X-ICL-RepId: 01a06e77-3e84-7759-a56d-be9bc62ae424
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ5JHV8DXRxCCkodXAFbEhVdRUMfWBNLXVgURy1HGV0IQFVSAUNFVhVPWFUJChtAH0EBHgxbHxwUXA4TH1RWAFBRHV8CCgRHBFsXRgNTRUIGFxFQAVgeVl5aF15NRx9ATWJJAVoZWxxAF0puTVMPDwBLF0sUGgpeBBccVhsXBlsUBEQBXQVdAkkJTAFfB1MAQRdOCloAXR9BFAhBAk8SHxFVDHMdRQRKCRQZXxkZD1cGB1hHFEcODxNMC0cCWjRWH1QZWgM=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proxy-alt.dev; s=sig1; t=1788559705; x=1791151705; bh=s5fkFjsx/yBaGR35CDqfsv+VemrC+/lhG0oTEzbJGJg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=uM9KwpVZCHqGWhsE27dDLApS4ygYIhM/JV09UGzz6Ru84G+wBjt4wdkVMHXO6Hoks0o6Cd4QzNXXEEcerm4ISYBMqOlYtXWqC8J+GHTOR+PA68uH+lJy/HRGFVXJjY/hgUYvsrF1jz9Ri3NlhYd9+z9ByBrGhvR4uMSRuLs1THzzqW3G0dLikSIOCfemM5rZiBFSsKBsmL+3RffAigq0XXODIjj+Ohtdz+v1ogBfzTaShqiwC3G0mKmigpQRreJDBGN3J36KSmS3LrRrq/Gpz12RW6fqN4tC63FjNfySwg8t2QfFsDTn1Fm76lsP+9cQk+PvbdoydXwXyEz3MUWbIQ==
mail-alias-created-date: 1786144344056
Received: from localhost.localdomain (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-100-percent-1 (Postfix) with ESMTPSA id C7A5C1800629;
	Fri, 04 Sep 2026 22:08:22 +0000 (UTC)
From: Proxy alt <proxy-alt@proxy-alt.dev>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Subject: Re: [PATCH v2] shared/gatt-client: discover the CCC descriptor instead of assuming it
Date: Fri,  4 Sep 2026 18:08:21 -0400
Message-ID: <20260904220821.69776-1-proxy-alt@proxy-alt.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808044531.71229-1-proxy-alt@proxy-alt.dev>
References: <20260808044531.71229-1-proxy-alt@proxy-alt.dev>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jbQxZnbo9Jv_UFWYTtBrkGMIhIaBCyFh
X-Proofpoint-ORIG-GUID: jbQxZnbo9Jv_UFWYTtBrkGMIhIaBCyFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwNSBTYWx0ZWRfX87bx7Ix1/Bs/
 ngt79QlVF+DAgUPkR3shWZM0mYUZED+VvFjWKATriSgpfcwc8WCadLCsCsFQc6K2UxACN8C1s0S
 b+wVmWcSJyt+QwivRvHUMpNeSRlRqrBmEsHyd+A95t1Ihj7bZav00xk5ObjPA5ka25sA0DEksF0
 ZsCSG5RqXTXbbjNrRMHlZg1xx8EJ4p4pa+fFwiWSOwZ8xXJpHP8oY0eZgUw//jUcctBSaalEESe
 9q9d27/Vr6Db07JSHTViz3SFDG8CDBuYIhdmIzjTBdxYUG62ybs/jLkyWmX9I/fpWhlTZ0ODyQh
 uqQ2DfFPnHTGNRHx1yCfQJRIg8oW6Cz7G0tM5ebQIfpPKNwpI0EXMrnNbFkj3g=
X-Authority-Info-Out: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=6a9b4157
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=2Zd7BX03t5W7MK7BooYA:9
X-JNJ: AAAAAAABsawbLbBlFSNQW/dQNR172BGpa8h+Fw899DTGAKVeLXhDOoOuTc8+lx/iPjeAbhepgYmiZInCgfqd/dHb9QhxjEieAUMd9Q4BNKtQUYmcoPtQSspODrNIvNeOqw30JXNf4/+Pvhbg5xO+Vi3Ez0JsqopgP9cG2U96dC9sMWUeO+wjYRNUytwDK6o5y+DxoxWi9T6hdNqydOwlj8DC1hFK8lSZw48Cs6RkvVaThdtNtTL40Nol/TbmZiZ1xmZBG2MjR+Fvkd68+4K9cDR6Kbp7QbMHSqJSeTyZWhmIRUZ8SCMsVJ1n5dhylUGwfaaRH/ZKUavS58/1t4ZFuJg7gYx6RvlalbgHBNRlurcWDfnbluHbADtpj8mCQ24ZMM3zdDy9jk4IdKl1foiTMg7XHK+GDzZz4l8iVxuFaErgrfPQJWbt+FTKmLHzr/RnwMcTJHa0srmrHwff2GR7Z7mzKhMuIPt3x47FEor9pRqbS9OqxaORb5fcdgRRCai9l2PrLkIsDUfyG0YeA8LbsOgimz6esIbN3QC8yIkIQMPw2VBpu632Ro8L8cJbFMZvHvC5D13z85FJuapuI6PWVcHl2NnJrAqAflPuRxMEMMIivnORU8OtSmLoeok+RagqXelfjGfTEvkl4GsnmslqCWvzHniCcJf0D8neGf2KF4VaynuS9A/e/lMh0FGfvWhvG/85+jRHWE9G2VaBNi6w7NxvBl+V8edDks1NTJpOmilzm7eg8MDcVK3NX+cILtW22F3ysvJR+XcXqZ2NOYzR3whjXqRMIWc9Uk0f4QZL/GHxyb0cIkIEcTJQsdQszAHUqe4CHaTYEHxNnYgsgFp0Hx0oj+4wE7RKSfs52VkOfuPc5yn4Jba+EqNsoaJrPbMwsyRxGg6kd7d1dlH5mmFumpSw+SL1SxhF5T4JEMxopClPqeMW4jm5l4vD0f1t+nz+cHgWIQJKMDMM/tn6Fl5FeHpvyKf9y/n
 F2CCXsZ+x6vNdpAs0jEdvAqXQnqXrCA1I+DrJdK8fVK9594De6BdZMovGhLFu/0p+KST6QSy3XwIJl6BLzx53vBYKKtV6ZIwjGldBo/g9dkW2/zmSypLMMKj9oZm+GYG9LU0rQmfTwnu8CdoujQEb6zhZDxyAyRl8Wuo3a1oWCkLIW37SBw4LXypnem5SkwBRFMIU

This approach is superseded by a different fix to the same issue
(https://github.com/bluez/bluez/issues/2383): instead of always
discovering the CCC descriptor unconditionally (a round trip on every
notify/indicate characteristic), the newer patch keeps the synthesis
but confirms it with the peer lazily, only for handles that were
actually synthesized, right before register_notify() would write to
one. Currently at v3:

https://github.com/bluez/bluez/pull/2493

Please disregard this one - I should have sent that as a fresh thread
instead of leaving both open. Apologies for the noise.

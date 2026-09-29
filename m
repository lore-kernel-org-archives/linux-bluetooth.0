Received: from outbound.st.icloud.com (st-2001i-snip4-2.eps.apple.com [57.103.76.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02837AA64
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649996; cv=none; b=Fx0/b9vT+XnwyvCaPucuwlpdWGiBp2GaJ4xHkHn/xIwt4f/yyIvgdU0hOs68xeiQzk/KERdfj1Lnl+e9/iiyikL8jgRlMT9FWA0YXX1OJwFdonqsedwnl0aV7pkOlAeiW3x9rMLhYMzXrN6CKqeXjg/sQk3yuIabmJYBjevE1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649996; c=relaxed/simple;
	bh=haXVpvpgoBo6reyNmEps6fOh0I07izO0IEWO26GwuUQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVOucgEZCDWTibj5cUXmF/pMdsqDNTdFOqbViwmy8ZZI9DtiaBl7tVkAHjYvQjPM7/cnGqq/XI0/DZXtkTL/R+4TFImnaJzuyjq6T3m4oBtDPHPNOzIuaywHnBI0NK36rjs5+nXw0JTyqFOI68sCigzITI2TVO25D4KJH/7QxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=Cp6MLYeO; arc=none smtp.client-ip=57.103.76.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="Cp6MLYeO"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id 5E0C0180015A
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:46:33 +0000 (UTC)
X-ICL-RepId: 01a0eb0e-888c-7887-bc6b-883c5d84591e
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhPBkMFWgNeAUgdVQRLVxQEEl4eWgwDMFQdHQ5YBhIWXUVeCBkIXR0ZClBQBktaFVUXDgJCH1AfTBZXQ0QfHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgZXXloXXk1aAlZNBUoDXwFbC0IASAFZAVkHXgpBBFUDWANdCFVZAEQGVUF5FVZDVARfThkMSh1SVlsTVRdGCQ==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790649994; x=1793241994; bh=haXVpvpgoBo6reyNmEps6fOh0I07izO0IEWO26GwuUQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Cp6MLYeO1OThjfhbujF9qXzTTufQntNsadLA/VArCCmeLQn8L+X1h6P35hEKLYyeJk6BnBrnJPNL4Z9kdJ+CZbqU7ndopfWtbWZyZGWvuC3OJgFhHH5ceqXoJZLMSJAtAwJ6RlLa/hlQdW3KjcjE7YBwa7ykVf/5LMl/mp/QUAinVaabjf0DOfc4SB1tcPUA0PdAdCvigDMu2ifLrzX3jc9p4UUjRkoJoCCfAiGPrrpMCZjPHKd9jpQijWsuMlym+H2dEKqe4LesBZCSg8FGGaj5/rvoPKazTFxPFav3xwuUFeW1dsInyMIDSQdNFmyeLGXBbRng/GoeaNZM4/BxXA==
Received: from seonggoc (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id 72ED218002B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 02:46:32 +0000 (UTC)
From: Seonggon Cho <jmsmg1@me.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] mpris-proxy: Line-buffer stdout
Date: Tue, 29 Sep 2026 02:46:25 +0000
Message-ID: <20260929024625.3978431-1-jmsmg1@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929024302.3977246-1-jmsmg1@me.com>
References: <20260929024302.3977246-1-jmsmg1@me.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=fKE0HJae c=1 sm=1 tr=0 ts=6abb2689
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=f7IdgyKtn90A:10
 a=x7bEGLp0ZPQA:10 a=_XrXW31pRgsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HHGDD-5mAAAA:8 a=KupEsQc1amn5UGEYq6sA:9 a=UzISIztuOb4A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMCBTYWx0ZWRfX+AcnO6MZu1j7
 kVGVPmK4KdSWwzaC1VmXEJnjW2gy+i54VmEDGuccZzZz/vfoBgEApJN1sgex2ApJ/dVEIbzwN9x
 sa9uDETz9q/fiTWkFbhBHLczVmP3KCB4LAC7F4xvmZWRYjHUB/uLN3EzfF9EoFJC5jdSqxrOp8U
 4R+ykGw6SDATECSCIgj/ZoUzCAdrnEQ8VfvpYtFAsh/N/JSZDr/2CUmT5qXZseoJu/1yJ/JHh9J
 LmEZEZEV5O727tVPvDezHl2ZrYUSyDB8KWPtFAFGft4FceE87MTDwZDTEJxFhySqYtMRUpRT6g8
 xhwADV+YM4CGyjJlv/M53glN2M7GSPBEUzucIUbyK2raqoIfy4qytCJ85uRoyk=
X-Proofpoint-GUID: kcsKzLTenFBclaSeSzC6jZs3Lrb6TopD
X-Proofpoint-ORIG-GUID: kcsKzLTenFBclaSeSzC6jZs3Lrb6TopD
X-JNJ: AAAAAAABROaMqiNGmf/lStDNmw3C4EyydmsKVxgD647U1Cp9IlHUBpbXGqmOkMmJEuDXOUxYrga+dOMHVPIn3RSpkRDUU87YJ77WxO4sarSSPX1CWQAYXDMjZ46nP8R2C+oNCd8eAR1FyseNyY4yJVTCtnhzZscYbnCtUSoXDUIM3iwZvvzoP2bIHoo2+95F7GhTj/z95H5BkSQtFoDyQW/JThwNL/uvgg0A9cxyqNZaCiZt5teI2JLz/3qzTyDkT5Qnr07m369kseavJGE6KYWxwBRM1R4JyAs4lrMagkFhoskacpxV/OM2edITuwXUeSbJkV8dlVIh+gJ8+o+psTSg3hxKaw84QbajNV9FlJV6c5L2Rd4ec7l/WVEljmnIXNTSDAvQL6AB6AlSx5oOzNGntb8ybHyx3warixrRdrBp+wRg6jfMUrBByMZcYAKtO53vSDu0caHoAwXtlA85eNF4a8G6ibjnrus+N+U0eIAlgMvYxXkikUe4WbZtV0IjVzhmi9OcuZ1/SzHOP2CxS2imsnnc+K3dk9nAFBbv2RaW7RT/8ffN8Jk49mAo/HZjHbXn3FfTzlnqSJaBdgye9faC+l7KM7YYYBEHj1qUZBjdKmnfsvn7Em3pA7GTT9GJBpnigpWCmSpk6YjhDFIIGfagNqXgNVhCMnQmFGWzSlC8L8JR/q4P6XSxW7yPYXMd5DU3ngmb71Nc2qzduxAJyfoQ7ApabeLH93UTAYABi9wlTea2RaC+H8l1yMIYovfthhZQiMBLI1kP16lc45OM5pmZzwXKVWdvaBigntrIkNgCCZKWojmUnKIQQmj4/MvzY4m8BwofDqNra+/lqrriwYri0jWqjHqYSkX/I7tGuD7TH26MsCBC6BdeM6iKWktcn2rCk+1d/J3+YyRPTb02o3XSzFmkVELghyEorCCnRfXiCM8GoqZs9Crai+isxzxIXwMfiA0yf90npIToU32o2VrQG6TfT1J
 1J2u++BjB9u1RDA77IxAyF10dGewMpPFbu08oFhV886xTwJm6dMJe0inayS6CoqaHQrLonzmqb6dVFYClPKc8BU8tESrkpIIniT5fHRaBPqkpAiFjyr9fZwFhZL9qCltEPOC7aGcjYfyYjS3fwWYCVcs64vIFqXInECL5pWEtMgBUNPKcHOHkNOFuay/Watr507beOvhV6QKB6Hzl1VR1bojLKA==

This is an accidental duplicate of
https://lore.kernel.org/linux-bluetooth/20260929003432.3937487-1-jmsmg1@me.com/
(re-ran the wrong command). Please ignore this copy; v2 with the
checkpatch fix is in the original thread.

Received: from sonic316-11.consmr.mail.bf2.yahoo.com (sonic316-11.consmr.mail.bf2.yahoo.com [74.6.130.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF012C544
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jan 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738155876; cv=none; b=hbVWyJle+BlzGx637xPlDLLmJLW3QN4QL3tzWmlt34+U81ffsOn2ed7aFoVK83ZWQN2y3Z6bn94UmfOj5W7ms9F3YPkLuhnSIk0j/qDz7rl8xE2eSPv5g4wyM8DoJqEuSW6izErNJHg5BhuBxn1Gq6ZmMVNJX02qyhq7BwQNtZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738155876; c=relaxed/simple;
	bh=lH4+jVdG3J/TvNlDhLSumLAN+1+gYVv1lLUzzFdpaLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHEAo/rs+hb1c4q7hjcq5l2P4CCr5QMmUDnbONDHiaXIBTh7/r6lDfusIpybOQQa8U/M2tbHa4R+kZnC93IwsnLRv1GdbtbwpuTE79qNBrxPVESp8UrPHhvcArYQ55+g1rb4TQmvHaWnTY2qN9SPS3SCdESxow9dV0GBHmxvddY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ijT4I2db; arc=none smtp.client-ip=74.6.130.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ijT4I2db"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738155874; bh=XSotvj1zScg4CH6FnZxoiIIZOR7Emy9X3dXHuQF00Ng=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject:Reply-To; b=ijT4I2dbKJ/YhL/+tJCs8QDW6nTPCwt6OSMVBviJnc8WrOLUXCyCe0ZeHkt7Ct/9eVTgZUuAkSlPsg/PKnt4xTtiFmzqn890fsnNYhyaZVvOLRWXU9R9pDA/OnWDNRVhU/bvlrS2afi4t4NlSXw3uwYD2yQVOWXokRyVIjlXdgNDNs4mrxRgyiLtnjDYIL5Ag0XiaVmClVf5Qm1shDAzd00JRrz7de/mtN8gVz16lSiQf2mHIvE4jHP5mnAYuafCpFYImELQ+bKAsstIeDgVE+vRTnO+BMz9LMOIYid/a3KmB4L9mihO9ah2I9ogHnBZlH0U9ALpxSej2PrTbUXojA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1738155874; bh=s2TLE5T5eODyUxeQRY3hTT0DsTuU2IZN5m3N9OL2pXp=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=tHf60IJqUbDoDcZlNiTQWzMQPEn7TOeJp8V7BWBT1Mrkcszx8h81hN2e6cZfTdodylktghhM/1jwhjn89Nuysm758cP8hU5FDzEMmyVvshQdfJteVWe+9XP1BV5zWy8q6JlTbMq1ejdCnX/oEYqQWFRXYRDFGJQOs0E1PzX+95LkRCR1RPsdPQHKaDeW9zsCrgE8q6kzGljyb5vSeDRMxK39cMpFp+7JzZWKRh9XPDMwT5yp6yTjpj/bgYtFgD6XwZnzgvYFxu/OK7kDnv2Qu7u7WCjruTT9SCvS8v217XYn334UTWabWDNiM2vTo3JnWe7M7WGYe9kirgiUnEl4zw==
X-YMail-OSG: CGZP4A8VM1nYgyGPPEMjtlHUf0x3JTyy9YGkjWUGSHfLmXt6fNHGp_jnTIL.Yre
 .NUN2Bli_jqUZPTxkEQNslPW91vU8BPPEZ.SwGlewmXKQ3yoy_V5sQSdCLyYTOz1DSxIcws4EJJi
 s0pnRGDrPpuT6.j9M3h4YlTVRVNUIHW1XvBSgHUAW4A65eOUknxRv0YOJFeLM_hvChXYIPs4GWuB
 .BGa5O84HGuNsI611sD7IItT_t4o46vYbsh_8VQe.IZbg3BvOKureMTIAEpZUxBZQG5vjp0ZoV7s
 FvnmTdjCidnxdoIWjilevhsqPhd9KkSdOe98iFOqGFIwYCGIU4l.CytQ7TebgZZKKWvRLkZe.8i0
 MSm3Ka2Z3yCKA3BWn9Y_Ei.IJFdTrqNAs9cIEtDtgAQAXaZsvgvKuwsHc_3d9DCXkD3lxqjRvqPv
 6emb3zBPbA2HoaoZsBTUdk1SuyrI88wuHXu0Zycs_ABUXLkA9ZLyDzzZKa1tJL_hzRgMVY_wNFt9
 ZSrSLWwR9q81qvSn7_4R9KNfDRB72S_ckb7TwtYPFOTs0YSsqLsqoIGVecwfP.ZUTvDS9ZHHy6CL
 lsyLJ.Jv8.lv.xcY38nasI_5BX1dcDkX0sOxD4adqitIWcGYz3c4tzKjpDgFlA9lsR7qatzsxFHv
 wFsBtLnWgJvaaK6coEVtqeAg9sR_sDr.hxaJ.xOeXscZ_f7b_Som6Op53o7js7fY2njbkjveAevy
 QiSe9ETwL2ICoDTW0oV_8oDFjsZER_dXZ.zKnQ3vkTHgwLDFcjbBq79TRUNgechlwjxCNRufDS3t
 RkuvtwkzZqCbch4X.8WQZ_1.tE9yJGept9ZCt6qGBLtfXJpfk.n_cExOiNfT5IyPETNRoP_DavJ4
 hFW_UuIHD5JsGHixJO1.4a5l2TEAIaDFlO09HcVlYvEljw4lpMarfMtj4xwOdJtiG7YnA3ZZyrCh
 bCTo0IdLsCP8oR5HpkNbIBQYamNlxw9e4VkfCXQaXS6F7khsQ_Aa51MY4qazWtQPINLfMBCU1BOX
 vGzxI12xYr.dyKFGYXdeyunMGHJB1rpsbG6H_6ARCB4d.WEhg2HkszaMXyL1t06RNuOxlrNcSlC0
 YyhB9cr34oHrxRj6G0BhjjzGyNjqTYqsyDZ8CyL5QDeNAcYiSuC3MO2OoGWF8Hz3yDYBFWiDUd49
 rxj6ZULEJmga183QUVXKNLW97SZap3Liew2OObGK4qJkckFnFoTnhTXV.Fk3buGbQZXP.yZgBCo6
 hWD6lSr5BVeueeSWwlNpunrN5I9k9HLQsCEXeXi4iIC10eHa9Fx1H71KuoKk7NgnJhE7vU8X5zHn
 yaUX0Lf1BP2iYQV358KD4ZHnkenA.DTP9m1wr1nuqlCFDSAwajXZYor8s7SOl758OxU0_jfC1oAG
 xlWoToMcyQhvERl3ILlBzrl2ge3xhWmJcXhyemaYVNDVVZSAz14WU6wDkw4qGyybmzZ9z8fLHTbw
 CCg65GIK2NjF2Q1eq4OrSgN5VYmt03M4JeXbjA5hFNmpu36GTG1ZEWfCHtwsF66LQ8TNxuIU547n
 rjVkp3dZqaDKr30g6LW1wCKM1Ufe5f6BWp9ldRpOYusOXUL7NsU_o8YUWbYyy7I_eLQxmDKs240X
 5aeXNGeLX_QjKad9.1yR8iR2RtABezy9cEEP5hCw91p9phVJswSkVD5HaEUazX9asZ1A1hki0AO8
 ijofEaaFK8_w7tHUwsQS6ptwgvqetHJF.4tb3OFYBcoW3FmdFc0zKjWvxYlvz1IBkbL4zTM64YY7
 ZdNkSkRDfA07igVeBSgiVa6TCMZB.6jV7l7Ep_NnM4HihoLXswBniztesaVAaWfNhz2ymAlnMSJr
 bIP3KxnnhdvZl.cjdgacmVcD3dX5me2d489Y4nmau26ygwn5vmtYhu2Zm8ZCnDjubumERFO3oFav
 tEuyRKZ1glRYbKGxmeTAgyznoxGjRR2ZwuGwJ70BD08sR4kNFu_BNlJv0vLLpB5byeKuCb_uSIzl
 Rz6yW72P.zaV3ZKN.uS4b.YMgMjxgryyGrnj_c.jhmnoDrOpEkr7Op1W9pI5a9PWFSI.OWcouD_m
 tXcL6ZmkieYRQ5pzIJxo7GkZhdgQkjKU6JV2Io.caEgzlNuTpPfFmEw1okuJFEMejzhX3CW9MXm9
 vH6ZvgSRFIRhh3Qj9QNQYsw.r3gL3MIl6DndmSbNLK4gun5iEF_0aWslpgRSF1tK8ZVAW_6bWVtG
 exRiZ.NCDALO1F0ZTsLrD8qMexs8O9_XCrxRKlw1I1HokGQ3stWC_FA--
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 24a26418-57b7-4fe0-8e80-694eb12aabab
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Wed, 29 Jan 2025 13:04:34 +0000
Received: by hermes--production-ir2-c694d79d9-zzg9t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e15772b1802016b15aee7008b24d2d9a;
          Wed, 29 Jan 2025 12:54:19 +0000 (UTC)
Date: Wed, 29 Jan 2025 13:54:17 +0100
From: Jeremy Dean <deaner92@yahoo.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, marukus.elfring@web.de
Subject: Re: [PATCH] Bluetooth: Fix code style warning
Message-ID: <Z5ok-bN5Sb8SZnD6@vmi2410184.contaboserver.net>
References: <20250129123330.391567-2-deaner92.ref@yahoo.com>
 <20250129123330.391567-2-deaner92@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129123330.391567-2-deaner92@yahoo.com>
X-Mailer: WebService/1.1.23187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I just realized I did not include a v2 in the title. Should I
resubmit the patch with a v2 or a v3? 

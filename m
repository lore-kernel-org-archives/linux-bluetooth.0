Received: from sonic309-13.consmr.mail.bf2.yahoo.com (sonic309-13.consmr.mail.bf2.yahoo.com [74.6.129.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF03223328
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Aug 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.129.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661972; cv=none; b=hqEFgzPXDEOhtPirzyRl8z9CdRw+4+54EJsxeMEqqZx/WFBidDe6YV2suG0TBHTI6FfOYM7Y5tMoJ6EekCVw/EybDt1woG0C5HKYVnNz6uY76tBRfRf7BNqWrzi+QpQhIhZjuvsUg7FNwjH+jLlqiluVpicsOLkabIcRs7oPlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661972; c=relaxed/simple;
	bh=l0sC6xfcv150w64sw7GFwTJHaQBAfSP2urmh5RHyABo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX6cSv9gPM1YliUAPXW816jSZQGJWR3z82JHiyapBg7IhnGUkICQf+DqGblf+FAKMI58SnEkoCz+/i3BCLPVLgJFAjcZ+lR8sW2+Q8v4bI44R28WsPeksAqMvCOncyYv9MMI1F8Xaqz+nmeZRSSbczVhozUYy/cp33m+0yAE5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Uxh6xrJn; arc=none smtp.client-ip=74.6.129.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Uxh6xrJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787661969; bh=l0sC6xfcv150w64sw7GFwTJHaQBAfSP2urmh5RHyABo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Uxh6xrJnvpOI9D4FHmXo+bMGPJROBo3FcZiJYSj1rSvhc2sB/89OWnREAxIR2athpa3UWKyAtpTm3/JHVFt6eD1WQX5ktj3X4LSjGuZCml5vsl5JoPZQmZ1YvyrEvKmLADZHvXt4gFILG7M+xy2wuF6VTJsKIW+HO0eXKEg0g5LCWZ9aLPGxpOktNUljUmeUR0x8IjYjCJcsQRpkfFJtJclxjlvTiTtxe7tlEbRimOisuuEodKGNy+t+3qij3/rguAxnjqLObvhf0D3pDOzy8PJCTlCvz0emHUy0lR9ovamesE/atO1YTWYdETKYDz1kClFlvp6DD2i8OgVau5+nkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787661969; bh=/yt14ZJZ1kyvJ2cfbPwUm6ZUcNrwDZ7FN/hgcze4EPo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SsWgfySDQmCSvlrod19ipMI3BywNzgUTObCJ4dOseINZQRuLUapVyU3U90YXunrFZaOvvHkwCbxjMxCAKYKFPGex3zBW/6ijg7NkybYPE71VYos5U6ODbOz2O1HBL0uEt4te+c8edQ4Vx/PRxHhI9vPZfPP5j1f68o20sZWcVL9HZ9OMcfuMHuEgfTwaCfm6fB5T1GygR4ZCNoeLM3qJ2ETIN4/DS7gzrdmGjIt85Eu2Bvba/9hhHXoF/jHcAZ6NV7n8WBOKKXs89CFcDVSo26CKybxF1Abvq6mYeoIOWY5+uReLQOGk756SeXemmeMago3qpx+VtG6IVuBbWO5V2g==
X-YMail-OSG: kEPyH1AVM1niAQWyD.UAJVlWnVbnfGi8t6bJ5OWkmW.okThULURiqQTws_Oi8JJ
 amUdg4UwQ.w8QGwc9IDFbikkK99OhLWAQtB.hnjR.3Cw1qHi0uQRAWkTRC53nlP1eZTx2ThKayyb
 nMQh8GRJ883pCMnEvI6VUJ_DJtuFwhSJr1jL73RloeZeHhEP.645wy9cmlgZPCjS6v1woMsOtDWR
 r3J_rhZeNw52pprRbwYXvF97O2nBSTx52OHVPY6pPArfQiihMpixkjKNtzEyfSSJO61zKQQk1XQj
 gxCHgMH1UW5bDRK4vFQXcZZc9dEIQUQPPutN79rDCpP8NiXWbpxRR5ARJxJcqaM4T1kw_CxYVUs7
 Y9av1eM2.I1Q9G0kYnlG0gKo6zZb7eyxrWl.qtDZ1R9GtG0Fy.O7Qs5mXFOVagZj6Q0Nzb6bmvN0
 Ntr6w9jXSRMfTls8zYosgommOTmgZxoaHScHBC5IloOqj7ex.w21.z5YzIJJ4LtnhtG6lmLlpXWY
 IyOe6ofhBzpXhZuqlizjOo_ax3g9aIgTypcYAFtx8x2jfRdMC8QjfztIfZh8uHzWgpOGlPyw6UHV
 sx6UiUOOQn4Sntsank8U5SEvBn3e0M5M8D6zha4eOLulH0jEm_KdmruUrJ_O3e.1nT3XBYokXT4k
 6B5wDuX4MSt8HfDVIlo1Gj9iCVI_OP4MQlH_od04oKLP0MJOhfAoouHE_D0ipLcAMTZ6Jg.N6R96
 J.FS6Fhg4FrZ30RHEYC1B.p6tQnxKE1YgTKPe_Lixl5hr1vxXUjMALeo9.qZne3bCbkHySHSqQRQ
 EhnzJPBHHaEOc9DvhM5hSBXBia3gcSTXRpFRJEsbE1f6bIAqRfFss3VKUKGJ9LZSam9ox47YzfQr
 EMe6bkVQQKsNddr1iY9gAMe_PZR6gPS5kuWsfJdKvVTlkYxnzT7J7I3.jDYKR0imN9zcxPpwZBGv
 Cn0VtE.jbuPvY.y24chOVGdtsjvN4J9_92qi7b5..6whAEHx0b0juBS3_qy9cGmk2d_9t9k_9cJR
 InRl7tBKMB1KnOHKQIyVfOJBzap7xvR.oP1BM9qOqzMcf5T5rfO0AM5EaW8aAFPSInbBnsPKd6Nt
 jpLsJThMse8J7JLgjJmgGUgUJGxpcEg4DgrDap.KVHCVPTUmpAq2DEsPEBl_qsDVLlIItpj7uFAQ
 QgWC4nY_EwSpmYstTr6EDczP4GWPWZlxgY.rDh4ejQkrKhJ1HFbMY8wXQ6Fktcpj2YR5lTvJYjAa
 oNTUpD0bqEYkENFM0zTE3eFd4e0kdrV5EEdE23YAyEp1hYM2IeyZNt0JgeaviNWC6J7._qGkAQPV
 PGeL49K5XZXSI.t95pR7ixUMBulAHOCWhUggSpI9Do_BuuHGxVMux_gRwFk875vErxC2o1dN09cG
 Wh8k7LLj1BcO_0ee0joqiQ6pUWRLyOhw7O4uWB9dLS.SUIbmkXuAgKmgTI8p6SuiqYMco8kGYCax
 BQPeaJuJ6u2y6H5kr7kuE5YXWBy0i0ooCPGu3z3GUSZq3.RImkiqf2lETzD8kXRuOvqYSpSxoXcK
 KXaGb2wdihGy1WyBCNDfeHEQL6zbfWW7hfL33yVkhxlbeijPm1HBSNG_3wjqfFHyBHxtTgQlE700
 ZkUdY4SQm5bOJqfAQKbzqkJYAF1kCQzZBFvrHyxlgRgv3RJw4fBwj2vYUia1vQQFAa0aYehNOQ9Z
 _kYu6CHe6Dc8WD8YHjkR0l3BROYH4UU1J8IFdA5nR8R9ia6zx6aa6A0XdRgG1UPABzrVqLkWoPOG
 9K2ohfXuvyVrpHHvosTzIwkP0AsmEeug8eYAsG_uGqt.sdWjqdlXEn3ZPy4v5mnLDQIGOb9A6wHB
 xY897pj0aKzAgUvzQwMtwntlmgYXGONCByJX.noTv2D.U8iydpdai6uduW8qOfbaTmPXRqJM50Kx
 4pGDYMVd.pEBWE0y85Wyn.T3QwyslBTzapGVo.rHwxFq31fuJbKV7XORN6sD4ZTlrJz5WLjQXtlm
 5wM.864Wulfa9fyBLhlmcGRO_osCLjbhQMDUlTy.emTXZZQEnGlogOWzSJuQhwuDpkEVgT9.o64E
 UaD.amPYbJJE00gPG.x1CqCbPfSKzN8hNAe8jBIpKpFRy2nujqn.rxZNnJ50.MWAAma.TF43lM4K
 LTVvFbMQst.9DQfqHQ6gx3.g9BjFKqAGle0v99NwmR4fhkYfRgJolwxs33IHGGpqtEnt_v3yEcpZ
 cgyPChMp9e3bR6p7vTb7w38OLhI1R_smRaMhS
X-Sonic-MF: <deaner92@yahoo.com>
X-Sonic-ID: 457a8683-59e8-4119-b00e-8c883d222714
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 25 Aug 2026 12:46:09 +0000
Received: by hermes--production-bf1-54b5569bdc-bhmhz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 586ef78cfdeefd5bd45817c59e6a7b27;
          Tue, 25 Aug 2026 12:46:05 +0000 (UTC)
From: Jeremy Dean <deaner92@yahoo.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove unnecessary braces
Date: Tue, 25 Aug 2026 12:46:00 +0000
Message-ID: <20260825124600.101932-1-deaner92@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823095527.57473-1-triet.hoang.dev@gmail.com>
References: <20260823095527.57473-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Triet,

I think multiple lines are not to be submitted. If the patch can be broken down into separate patches, it should be.

Thanks,
Jeremy Dean

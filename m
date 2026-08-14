Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07870409277;
	Fri, 14 Aug 2026 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694162; cv=pass; b=tNExT/jTLV7UM6FwshLDvQ9LQfG2d4CWDrwbq0RuwuoNNU6cTbNw9cPeNUnFfP9LNlMPUlN0Kq4JD5fByQ8ttFuDkJ6WTny5f0QGhZwkYvvMN45dCB1CN+4Hqsyw65blEnn7lZfppCHW/55igUOVl5njoyhAlXNwct93iQQ8Vfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694162; c=relaxed/simple;
	bh=aNq1kmMDQePvJb3CciPBaqafuZjtZCCC2yfOHs9fI4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vj5K5ki2Hz4iLrExXh26/IsLBK8GzgIury1uALwPSJCKHNWUyxwypTuSyorzrbj23WqISzr+Vn7pdiCLMlbMcWN26wLjUwsP67EXJcKZgrgl/e49nGUbJNA7TP1IOf2mHDA7T/fxBwn9voFG3RQpTmXI5kTPCINmQBOdAaRv21I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=qmQCFAC+; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="qmQCFAC+"
ARC-Seal: i=1; a=rsa-sha256; t=1786694143; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=f5W8xWaAr4u6iQ5+O6RD0Qq256aWgweZIXYMNSrEGctcDXfJvscO3mZS5eXHbR0opJupfQpybbWo6PfF/l8sj3WiLCbNPzDeZSrjlxikUuUaerkpxS5vmpuG6J+/rmGBrUaHNm9ZQBu+bBRDp7q4lcBIXvPcPwACtLcv/RRE114=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1786694143; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OmDnZYm3QR1Q3L5Ya4jk3wRW+7IPCT+TvdPOSqRmX2s=; 
	b=HUM8YOWrhZy1fKHtLpK0OD84GUzRxW1woXQZq55jxSVViKWooXOeKU2fmxVggGCOOLtqcR7d9xjKUtwta/h/PiJohbX20++xcx5bmslAggIkYtzTT4inDvwwvJj4VB8PbFQZTxem0fVwswkiw/AsotyEWpKSt27IVJhGSDdJW3g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786694143;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OmDnZYm3QR1Q3L5Ya4jk3wRW+7IPCT+TvdPOSqRmX2s=;
	b=qmQCFAC+NshT/Pl301/RJR0Mlj23OnCck94dY1PdOIWEe9EvA0FsJcCsnvOb/Ht3
	dhlUGCsqD1ihuyxVDtKRQ4cWhlxJ7o+o1GkMw1inerCutZmNSDaQPYcgWtL1DRXKiFo
	QZrIAZngWbf5vSKKAngOhvnWHwei82Ji/xFV2Wss=
Received: by mx.zoho.eu with SMTPS id 1786694140705320.41969479608827;
	Fri, 14 Aug 2026 09:55:40 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel: validate version TLV value lengths
Date: Fri, 14 Aug 2026 07:55:26 +0000
Message-ID: <20260814075528.900773-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171434.82729-1-acharyalaxman8848@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

On Wed, Aug 12, 2026 at 10:59:34PM +0545, Laxman Acharya Padhya wrote:
> btintel_parse_version_tlv() verifies that a complete TLV is present in
> the response, but it does not ensure that the value is long enough for
> the specific TLV type.

The analysis and the fix look correct to me. I also reproduced the issue
in userspace by lifting the parse loop as-is and running it under ASan,
with the skb data backed by a heap allocation sized exactly to the
received event.

A few malformed inputs trigger out-of-bounds reads with the current
code:

CNVI_TOP len=0 -> 4-byte read past the event
DEV_REV_ID len=1 -> 2-byte read past the event
BUILD_NUM len=1 -> 4-byte read past the event
OTP_BDADDR len=2 -> 6-byte read past the event
FW_ID without a NUL terminator -> scan past the TLV value

With the patch applied, the fixed-size cases return -EINVAL and FW_ID is
bounded by tlv->len. Well-formed input behaves the same as before.

I think the Fixes tag should be split, though, since these two issues
were introduced by different commits.

The FW_ID "%s" -> "%.*s" change fixes code added by

164c62f958f8 ("Bluetooth: btintel: Add firmware ID to firmware name")

which landed in v6.11. INTEL_TLV_FW_ID is not present in v5.15, v6.1, or
v6.6, so using a single

Fixes: ca5425e15881

would cause stable to try applying that hunk to trees where the code
does not exist.

The missing per-type length checks go back further. They were already
missing in

57375beef71a ("Bluetooth: btintel: Add infrastructure to read controller information")

which landed in v5.10. ca5425e15881 later added the outer TLV framing
checks, but not the per-type minimum length validation.

So I would split this into two patches:

1/2 add per-type minimum length validation
Fixes: 57375beef71a ("Bluetooth: btintel: Add infrastructure to read controller information")

2/2 bound FW_ID conversion to tlv->len
Fixes: 164c62f958f8 ("Bluetooth: btintel: Add firmware ID to firmware name")

One other thing about this hunk:

> -	btintel_parse_version_tlv(hdev, version, skb);
> +	err = btintel_parse_version_tlv(hdev, version, skb);
>
>  	kfree_skb(skb);
> -	return 0;
> +	return err;

This changes behaviour beyond fixing the out-of-bounds access. A
malformed TLV is currently ignored, while after this change it makes
setup fail.

That may well be the right behaviour, but I would consider putting it in
a separate patch. That way, if some existing controller turns out to
send malformed data, the setup failure can be reverted independently
without reverting the validation itself.

With the Fixes tags split, feel free to add:

Reviewed-by: Ali Ahmet Memis <ali@iusegentoo.com>

Thanks,
Ali

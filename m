Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45004262FFC;
	Wed,  8 Apr 2026 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636192; cv=none; b=cQk5smCHwVsySQVoZuQoGicfDmp82PfN33qRpTIeh2jrf/o1kAwglpZJEOdBU02p1HNwrKcoiIjFJrJLeoTCqTEdKQKcr16DK2AqgrUCSa80oflniHji51QrwvXo3ikATetB02C1j/JPnJbUVbB5FRqirbP3sufUznX+HcgITWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636192; c=relaxed/simple;
	bh=ZI055LOS6sC8ME80eI9EWyVuobhIQxIl9qkB9bc+LfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7AMdQQp/qCU5PO3/M+R4Ok5TXmJpHRanmgseuaaMMjzsfgZc11wb1mbd8bcvWp9ezC4mAxymXrABDBX1mCLH3FSs3OYuUEzYOVHJ3EcmlCPS5szNcLhs+nQd1IegJOwddo05p5hWku3k11yAM0FDglECzCPYn/CJwaG3BXG4io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=jG9Mkllp; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="jG9Mkllp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=0UnhfYmOBpW+mWKmzX5LyitAGG8y9p+0G2EJ5+jpgLw=; b=jG9Mkllpx5u5slWhUwp3FI/Vhw
	FVMBsTQ7ngvpbjvE8WmuqBoHqAgrmoZj6lEWtAjNlMM64BqLMTaJagWI7SCZgbGQWsjw8ITUgviEo
	tVMIfzTCcxGll7sKZI2n7ewqjPzRViT1f1OIFqNvYWyJT2DWmhSNUbudwr372HnWI+wwYIi7NVFU7
	RWET751cfXHgMdKGkLqj5gBEvNOdZynVp2yaLCBev4IyDjUcDIcuVfisB9CupymfkY3V67wZfhRWC
	eH9G+JGdeqCU9ZG6RDTWZ/3Mv40AFk96JFacyhLZTqT82rlbX6NGZrycUI3sG6rVhuF4QSFGyUprz
	WnZ2x2R2H0WAAZFe2+VpX60BPCua7+XpPGNYZzGr5AkAJFU7NMHiZ0OdGDwsVarhUkJ7HGQfYdzZQ
	FwR+rIde0Mb6C2H6+Hdq6UAUBjF/Z05MhZbsmv1xijur4AKIxSIrNrpz+uYdUlXDZLZudBtTeeldc
	yXCQ39g8hA/e0d6rR3F+mUNB;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wAO5M-00000007m3U-1rYK;
	Wed, 08 Apr 2026 08:16:28 +0000
Message-ID: <69dce63c-f5e9-4e21-9665-be0889fe6334@samba.org>
Date: Wed, 8 Apr 2026 10:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: SCO: check for codecs->num_codecs == 1 before
 assigning to sco_pi(sk)->codec
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Michal Luczaj <mhal@rbox.co>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Marcel Holtmann <marcel@holtmann.org>, David Wei <dw@davidwei.uk>,
 linux-kernel@vger.kernel.org
References: <20260407151345.126999-1-metze@samba.org>
 <CABBYNZ+H7qnZFSz=Tx-S2Rdet9a1vEbb_kGbzv_VjC1ZGS5t_Q@mail.gmail.com>
 <4e4c1f7f-9ae9-4043-9ebc-e061e24868c8@samba.org>
 <CABBYNZJMY-MH+1H0kFoXPxuKbjjWaPDzzaxX=-C9uwYtdxWo4Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CABBYNZJMY-MH+1H0kFoXPxuKbjjWaPDzzaxX=-C9uwYtdxWo4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luiz,

>>> I guess this is odd because there was no need for this code to exist,
>>> BT_CODEC should have used struct bt_codec rather than struct bt_codecs
>>> since we can only set exactly one codec, that said I don't think we
>>> can change this now thus why we need to perform these checks, anyway
>>> back to your changes why don't we have both checks for num_codecs != 1
>>> && optlen < struct_size(codecs, codecs, codecs->num_codecs)) since the
>>> handling is the same?
>>
>> Should I submit a v2 using this:
>> if (codecs->num_codecs != 1 || optlen < struct_size(codecs, codecs, codecs->num_codecs))
>>
>> Or can you to take it from here?
>> As I don't really care and the patch is not strictly needed.
> 
> I can fix it myself, no problem.

Great! Thanks!
metze

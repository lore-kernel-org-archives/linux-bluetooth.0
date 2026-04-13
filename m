Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100DD366569
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092203; cv=none; b=WRuzyPknwjwOdJepaAmkZaTcvOf28okmO4QFlowq2D7FUymmd7orZiaPL0Nb+HNrAU6tfgyVVzDqPdbMP+fQtA1EAwWrvWLNh3f7ARev6kLrDDiJ4+MGri1N1HBJyvmmcgaDSLZkqpaRzdGN0u0NXq2Vzr3oK+NMl8YLj3h2p9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092203; c=relaxed/simple;
	bh=pbpXMs7VXRZdtUynBjml+ZtskO/P0GLq4ZmlxeGlfkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdwrzSiBOx7Tv4P3AvwUHz7tx0/Tj1YMabevycfmDSrGg6b+kv5E6iz/tNBxYdN12vf6X0bTFaK17nwWbpWYLzWDS+JjXD4S/eISw1Xl1NyZdM/uRdO5eN10/1/xJvl7p1gsOd4zXXYiC4w4UuMUCUXtQylttN4IctcnSdsKjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePI04JW+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpcwSdvv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePI04JW+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpcwSdvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776092201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kwNT9fe7fcVC+o/T4ujiYHM4r77SOsKtqnw72f+HZsM=;
	b=ePI04JW+0zulv0kLGF5ef7/OnrqDs+5FvWb08GPvNvA1cVYEMVfKoe09kp506ZWaokyd6P
	SMre4A0TjnWQOF8EpwLhv8yNzDIuJYl0L/uL3FwIcLRYuZA45Mg1+jlC5zI5/MtICUfLkS
	1kxe/luQdFKtTwg+KpASMycal5CKCVg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-s5DZQRtGOYyLYX7ZdDLa5A-1; Mon, 13 Apr 2026 10:56:37 -0400
X-MC-Unique: s5DZQRtGOYyLYX7ZdDLa5A-1
X-Mimecast-MFC-AGG-ID: s5DZQRtGOYyLYX7ZdDLa5A_1776092196
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9deeec7fafso49431366b.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776092196; x=1776696996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kwNT9fe7fcVC+o/T4ujiYHM4r77SOsKtqnw72f+HZsM=;
        b=PpcwSdvvcYdYcweFnLihPUMjvHV+dZzYnSmGYLtYm5GXCh+Q9dk2cLExty2TDIX5vw
         1ESaeQLkuX8vJKGhPGOcExqYAzulKzLaLnyVGSK6FKSYCQgSb1Qh1rrNxxVGFe/Y5Tx7
         +kiwn3XNtbcn5RpwLnD1+JZFqTSiII0u9SKuoIBPGtx4jEUr03WCZWKg4wnxfMeWMLwL
         hZRqQsLhjdMlyudBohLKOY6KYdy1za1coBxmyPVW1rYReMdN6zZUbr2PxzogzcOr30Aj
         zGsvQjL+BuQBLB9uVi8VOOvEbacx59IoeWWVLfbT2SxIgSbjN52EuB/eBr0k13eS2665
         tmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776092196; x=1776696996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwNT9fe7fcVC+o/T4ujiYHM4r77SOsKtqnw72f+HZsM=;
        b=rUQL8NNlXtz7YF8isigx9mVKt+kLvrvUl/HGGL5XG8rg4TMDtRF8tgw5iorNt6Qpac
         Z95BTWy0eUiHKWrLfSjld1I33Ydmk4f+hb8vbtCQ6se+lkmdeLxUzb+d3Z3VGywe0GS5
         efVzTwOvqqI2PHZKcmwAGKAIUPkf8K4yvxUtKuMD720vblmgT1sQt1JNOPZVOJdtvq2P
         kh3KIm/L/uDYilKOPSLLZecO8LMHkuP+s9xLNEzMnjMirui1A3TpoPBtDdqIZTwY0wkN
         Ubm6pd3JdHZGtesLwd0Ns93Is/fUwaYMvm8VEFq84wxvX7aoAg2ysWFssD5f8Dgorb7O
         ndmg==
X-Forwarded-Encrypted: i=1; AFNElJ8VXswzOifOkXWhPWrgt22UGYkHnawePv4Jvm5gtF3VNRiFbVCXsX2gK7TdSJRRVe0JowExI9nekaCkmQmtCXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWebixSCMsHgfaL7K/xaSybudtLGZL+5WJMSM8TpMQeTQrSHiU
	uqOydlVWOI1QxHydzZG6xq4zbU9rY6t5vF4phhZaT4BW/+dAEz1puw+X1xKgqObfy80oT/lS5u9
	BPX8h5GXLxYD6YVW58lIfF+zBP/0yuRuyLmpHlvt0YuxN3/Dk5uSPtZuWXexGrdsEJ+jrLeKu17
	m8uQ==
X-Gm-Gg: AeBDieu2Jloxndinx5i6heWSAOW22ItwCMThfsnUfAYsErknD6TM9sn2rdLVUhOEBTz
	knfZQAebaFRDcW2aijvaH+VtMzcmWaz3KShu+NbyTyUhHYX5VpBiRQ16xbKhrvTL2T4IRBOtUyC
	90d8odXrtUhKf/UQeJ6skVSkqaoVdZuNtmRE6lDvnw5zrPEF/hb8YzWoLhn5fl3A3fE77s5Z2Rm
	R/bssZcNuWDB/k1rQ+JaZwdzLxPgNGjV/r368vPV4gKcgVR68HkgT0EEO9IdOwRnenlav5ONPqA
	S9Z8jk2s1MpcQ9pyYuTv78Q7bdvU2eBB7NFCCsB8fwt07Ncw1/zkFKcVefqCBbLSKvKudUo5WSE
	Mm2KKSQeahPQh3x/H3j58jVHfit5d3l3LhzOGiP0FScd+9jpxeWfteSwH
X-Received: by 2002:a17:907:96ac:b0:b97:b9d5:4ae4 with SMTP id a640c23a62f3a-b9d724b225emr771975366b.20.1776092195951;
        Mon, 13 Apr 2026 07:56:35 -0700 (PDT)
X-Received: by 2002:a17:907:96ac:b0:b97:b9d5:4ae4 with SMTP id a640c23a62f3a-b9d724b225emr771973066b.20.1776092195339;
        Mon, 13 Apr 2026 07:56:35 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e5c583asm311542966b.36.2026.04.13.07.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:56:34 -0700 (PDT)
Message-ID: <0f1690ed-d449-4b7a-b172-85af40e709f8@redhat.com>
Date: Mon, 13 Apr 2026 16:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth-next 2026-04-13
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260413132247.320961-1-luiz.dentz@gmail.com>
 <580f7972-56d5-4968-9dcc-32adc31e0673@redhat.com>
 <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
 <CABBYNZ+7zr1jQ7a-2p88zNqMdvn6MAB5NAZ7b4OW=P56DcMT5g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZ+7zr1jQ7a-2p88zNqMdvn6MAB5NAZ7b4OW=P56DcMT5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/13/26 4:17 PM, Luiz Augusto von Dentz wrote:
> On Mon, Apr 13, 2026 at 10:11 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> On Mon, Apr 13, 2026 at 9:41 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
>>>> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
>>>>
>>>>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
>>>>
>>>> for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:
>>>>
>>>>   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)
>>>>
>>>> ----------------------------------------------------------------
>>>> bluetooth-next pull request for net-next:
>>>
>>> Net-next is closed for the merge window. I guess Jakub could still
>>> consider merging this, but unless you want it very, very badly, I hope
>>> it can just be postponed, as the PW queue is already long.
>>
>> This update includes quite a few new hardware supports. This is a
>> resend because the last one was dropped due to an invalid 'Fixes' tag.
>>
>>  Btw, I don't know why the entire PR needs to be dropped if only a few
>> items have invalid tags? Can't we just dropped those?
> 
> Maybe Im doing something wrong in my side, the issue with the Fixes
> that is that sometimes they become invalid once I rebase on top of
> net-next, which, afaik, is necessary to detect already applied
> patches. Or is rebasing is not really necessary and should only be
> done once when rc1 is tagged?

AFAICT, rebasing is needed if you have local patches not present in the
tree that you are pulling from.

If you e.g. send a PR to net-next, including all the patches present in
your devel tree ATM, you could avoid the later rebase not applying any
patch in your tree until you merge net-next back.

Would that doable for you?

Thanks,

Paolo


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE3DEFFE
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090879; cv=none; b=iTBVSo7sY+pjjgSFabPN+/V6G+QGkAGqkzDOUwMuPxd6l1SuXP4vYL44beHWoLtzFUI0v7HCdIbinGrJc98LUOXhtDp1CZgwXXeG1vFHc/DWZikEL6vaA/mGyLLrOppWYAuy/J111dhYl+uEh18lw8G0sZcSIJf4kFpTukFsmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090879; c=relaxed/simple;
	bh=x1ifNN1rcjcfnsQCTrP/kpfGUY+peyLroDHGkro91+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OssGKVawfCFQ/kVuCWjQ7oJHZOTpz9wPTkQPw/DNnTSJ2+EEc/AH7Xx3zt8uzg7Z7HwyTKD5MRhPoMguMXClgkchxzhpoH1S2VdhCy3CRqzBev6NNGgvf7QEJtlkMIxfNMO6ThUDuKE0jdfdfiI0aiz7cL14ChpEAC982ImUK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eja4weqo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mU890H6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eja4weqo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mU890H6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776090876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vgI4zgdDV6NmMPo5aAmiFT+6Ssq8rA+mnVDfSWSrmkU=;
	b=eja4weqoykALVWEncwH0reBQI26cFz7+ViXDpKggDyp5miUk3sErWJPhuFma+y2Oj9rWbH
	C7PAIsVKHrGlbaVMgJV9X4Lsx849IWOO3UOvhlPZFsnBiC2XXlwW2Guk1pNFd6ao0FBCuV
	Yte6q56SAqq24N7LusOZZ0il1Mno0Nk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-oifSizCoOQ2Lz7GSIBkTHQ-1; Mon, 13 Apr 2026 10:34:35 -0400
X-MC-Unique: oifSizCoOQ2Lz7GSIBkTHQ-1
X-Mimecast-MFC-AGG-ID: oifSizCoOQ2Lz7GSIBkTHQ_1776090874
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43d7d03e1e7so402000f8f.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 07:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776090874; x=1776695674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgI4zgdDV6NmMPo5aAmiFT+6Ssq8rA+mnVDfSWSrmkU=;
        b=mU890H6Bv43ALbYBcZlWJUDdlsBBb5zgCyY2S8h+oPIkN6SaQYZGxp3tNXFELfjOw8
         i9gnW7WJuOm8+4fpZlJXmPodjNyGb586AV0fX/8wLUUGG4XYHHhikgeXRuJutRXyDJoB
         YxgDnfnbHB78+eDjZbx1XJ56lPjF3X7RI79MPLGnzk62IvRnKrK9gGY51fUc4AKscfmV
         HjxaikWKdSwj4jzgq3zFe4SXC6bc9bIgQ/1HYA8kYUvpFxq1GyFp2oPq7fflY9lDFIWU
         EhGLB1oXg0P+uuMCMZ9GP2ElkovlD7GTiG3vvgD5M064NBIQ+vq/Cc+Ii+Cm6Q2O5HP2
         Erow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776090874; x=1776695674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgI4zgdDV6NmMPo5aAmiFT+6Ssq8rA+mnVDfSWSrmkU=;
        b=p2Z1noxi72xwEONjl+++bzYdEPFiX9ncmQ8TQhUE2vPC099bbb7XTdOGvBNwvXP6l4
         Ce6bRDtuhl5wRIEnXz9YEucl6tKHgJqyqrPWeWja1raIuyqmVB5L89pv3tzid20I5Y02
         +khnAEFy6+rqJhiX4zEwOzPpRoF7OVj7YHbRc5YsPx8+V1hw6OBl79koQfQ46FMuQ/2U
         SfI+HPk+3cmYZ8u2XfOyvEYLVTApNylA5Po36FLux1ehgBbu/807HLzaqn89Y0mxaMhX
         vd+We7jw5gkLAPQi5JGaF58uWL7ygOVncDumFXtFR2IgNoZUWKIgUb8a5tJr2lvYNa3m
         fqgg==
X-Forwarded-Encrypted: i=1; AFNElJ+FB+ZBAze9+bsAqrMUkyzZDyTSRbEbyTHIDO6aUxROBZnIkySAnnZpjBSWM4y6Frwz0gqw5qRjQfpkeBb8yoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrf1H7PL8G4kzMluEEgll23hMRdxiDLXGHnTzLqpAH3J3R22Hc
	33X6iqWkLXRzpiwctBhpsC/i2iN1oRJl2NHkKWw4hdjxV4yDXLz3yLu/Ig2QnvwY/66sTkqr05X
	t/Tf7P88vfZuL6/eQGtXbX/chcoAz0PinzQ5DFtyczS67nw9yYCwmQ88nr/F7h7LY/r3l2Q==
X-Gm-Gg: AeBDiesW6Qs0uFdSwWtr9wAPgMeECbdfUR+1AxJtvGJakjknmlvFFHqpRZqo8W23dms
	Ql1zobIJjcLUtzYRNNdycjS9IqUKRF3ZnqZ2KDZoRuxCGTKxAVgXkC/79FDhV4CHU9hJvUbVIzg
	esQS4fvj639E8W53IQcAZyQ5GmkrFUp5bdvO0Ave/yEw8TVm3cOGgU2SR+ftYCu7b0cXY2d9c3r
	Jv5uF7FThG9D9HqYEDwrlzMWPdAIitnLwpqLWPNZZJXpIPJChwLCMd+DU/Tlm2w1SD6hO/oOXQJ
	0NDD/deXwcWhEg6W5/Cni5gakkJeex0spzQWVP1jLpayS3rMZGQ6Lwedt3YAZgDVQOt4eAgw23L
	P5Yy1bJiWPdczEoz8zjlO6pmJrmUKFP5j9IjRkIgI+XE/SgrHYqy+4hWx
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr19361066f8f.23.1776090874205;
        Mon, 13 Apr 2026 07:34:34 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr19361017f8f.23.1776090873609;
        Mon, 13 Apr 2026 07:34:33 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d7cf533b7sm4165626f8f.18.2026.04.13.07.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 07:34:33 -0700 (PDT)
Message-ID: <8cba369d-0e63-45cf-9727-d505828afcab@redhat.com>
Date: Mon, 13 Apr 2026 16:34:31 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZK5mMbuzvjAquy49vSk0pLRnk_s8oqEut1se4DToURn9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/13/26 4:11 PM, Luiz Augusto von Dentz wrote:
> On Mon, Apr 13, 2026 at 9:41 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 4/13/26 3:22 PM, Luiz Augusto von Dentz wrote:
>>> The following changes since commit 42f9b4c6ef19e71d2c7d9bfd3c5037d4fe434ad7:
>>>
>>>   tools: ynl: tests: fix leading space on Makefile target (2026-04-09 20:41:40 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2026-04-13
>>>
>>> for you to fetch changes up to c347ca17d62a32c25564fee0ca3a2a7bc2d5fd6f:
>>>
>>>   Bluetooth: hci_qca: Fix missing wakeup during SSR memdump handling (2026-04-13 09:19:42 -0400)
>>>
>>> ----------------------------------------------------------------
>>> bluetooth-next pull request for net-next:
>>
>> Net-next is closed for the merge window. I guess Jakub could still
>> consider merging this, but unless you want it very, very badly, I hope
>> it can just be postponed, as the PW queue is already long.
> 
> This update includes quite a few new hardware supports. This is a
> resend because the last one was dropped due to an invalid 'Fixes' tag.
> 
>  Btw, I don't know why the entire PR needs to be dropped if only a few
> items have invalid tags? Can't we just dropped those?

That's the problem with PR: AFAIK we can just pull whatever the
submitter published. To do any edit, including dropping patches, we must
not do a git pull, and instead applying the patches individually
(meaning they will get the net maintainer SoB, too, which in turn will
make little sense).

/P


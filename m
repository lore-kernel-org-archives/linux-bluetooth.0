Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45417CA1B
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Mar 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978499; cv=pass; b=PgmakkIUaAlsBHlW3xkpE7v/VdCYUgItAlzpbWLw6mLdHIh5R1YPx0X+dbNotGgewimRsPXO+UqCa+XjeameF1a86fkVtaQBCjdcZeYxmK07wSL0SlZOg2WUzPyHbuR9OXjdfj0KeTk58gagBib0okDV+yZPQxyQyACXNveQOJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978499; c=relaxed/simple;
	bh=sFqNCDKqejwYHFIfc260tr+i0LS8mMpcmbVIvd8neFU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UqQAAXUgOpttbgq10wBAdS1Py3aB+12Xz5sHG9QO4yO7tksYF0pGMz+v4MkIoi8L7mPdaukbA0BqmIgiGEBWINg0Gae9nL3behZNjXtCsg22pW6mNa7o3J41nweAsD8zXhYq1S0XkFk/wIdJ18STxFJQ8rjZxbuMVGBAAXjuH8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=Q1uuyNYb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="Q1uuyNYb"
ARC-Seal: i=1; a=rsa-sha256; t=1742978495; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MXP1/6nxiWOT6p3UBtifp6VbpjYtkDBY4YZcHCReoZ/oECwcapr6F+WMGgg05vJosWtcU1HVYg9HDVBgKxZ3zudcpkJYmzs23/zErWavxtWoPhn7sP/7vW+IM7p4UeGQ7HC2TYQkmNJNkD0ElrwzBDQSmOm1/zdACDh7Eb2AC5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742978495; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=+VzLQiV1kyCZD5ShiD3fp71H2kJ26Ov1h6BiRaCt3nI=; 
	b=ENsvED+T1UVtUNNxeezgFa5Yz1JgV2sUFR+URoUsZOCT5HP4bZaF7Bmb9gDxy5CHcazm/sYfiyL5x96mHmAraPmhXnFNC8HdkSwLiUA6XGBkhUyoGYFZi859gNR9GYmDbNfOyhxxn8bl/m2aq8KRywH6VPduFQDewbIAKjRjqmI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742978495;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=+VzLQiV1kyCZD5ShiD3fp71H2kJ26Ov1h6BiRaCt3nI=;
	b=Q1uuyNYb4BzQNHSoViHGO6gsBa/Vt85gGpxZJgOVqAw90vjBLGgw/HlnmatpQIl2
	ABAGnps4Uvo8pQfvYt//DgVP8W1k9jdlL9tQy2cT5P7kbICSqN3aOl4I52jV9n5yObB
	hOC3uxviLMZ6B2LIPrwUzAWpyqICKifz7MuNRJP4=
Received: by mx.zohomail.com with SMTPS id 1742978493183435.6989088255201;
	Wed, 26 Mar 2025 01:41:33 -0700 (PDT)
Message-ID: <83bf2a91-580d-45d8-8891-93c265909efa@collabora.com>
Date: Wed, 26 Mar 2025 09:41:31 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v3] obex: MAP MCE Publish supported features during
 connect
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
References: <20250324110429.65866-1-frederic.danis@collabora.com>
Content-Language: en-US
In-Reply-To: <20250324110429.65866-1-frederic.danis@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

On 24/03/2025 12:04, Frédéric Danis wrote:
> This is required for passing MAP/MCE/MFB/BV-06-C PTS test case:
> Verify that the MCE sends its MapSupportedFeatures in the OBEX
> Connect request if the MSE declares support for the feature
> MapSupportedFeatures in Connect Request in its SDP record.
> ---
Please forget this patch, I just found there's already one pending: 
https://lore.kernel.org/all/20250320123126.216903-1-quic_amisjain@quicinc.com/

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718


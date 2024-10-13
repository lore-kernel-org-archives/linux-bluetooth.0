Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948912C54B
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728847641; cv=none; b=RBJneKsuguBVCYrhxf1GpA2dgO1KclztZEc9vidHjyzIYXru7Gg02jizDfz05rsBZzGHlGcuHydfgyL0DU4Tkds7hLjoxnynurv5ba5MTeTatL6nMnDsew4pIJEOoAWi+9F5pkDQS0pF04wCUBl6/DSUgjsCd7FF8ZR1oaJkivk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728847641; c=relaxed/simple;
	bh=gwTHUNzKPFqhVSJh6MkECQS7LwDRonipHdDNck7OJS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UBtQwKVqAzsaX4t6vNVYQN4pttMTHwLznDVBhOnDgnN1/6Pf0UL5WBi0xa0H2xIrAqM93viymvjg4Drn1dUUpmH1TALdEORk9Hb+9r2JZChMZJ08vZl4SBDg3ZthRurt5k53GC+LWCXqgoQSIPR9aIr0d71GAtEb3TVzrRhqDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE6x5/Cb; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE6x5/Cb"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e31af47681so931891a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728847639; x=1729452439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTYfXIOPxpGSQ1U9BLbigkK6xZ9C+Jk4uJzMJaFv0LQ=;
        b=HE6x5/Cbew2dk1mNqxD+WBugHHQOb8djNf6hwCAxuyStc7qGwJ9XJSspfddwB8MvU0
         CAcQDkA6BReKWVU2svave3KEfEnpbaLj9NGJgF3t8fZzBkRyD6ASTLsIo18BGiHcZka9
         6ZIMMjuFvaNe+LB87SwDwb/foZ4jS+gMvn6mKdiY8Kt7hss4NWNs30lD8xvnW2wfhMsV
         n8gQ7C0rPNvUHf815cIP3YIYo4n199DdK+ay7V+vWmYZBXMFRlqz2ulTasVhCi2/xGwc
         3Ugh1/M/qsSxR1E5j1Fdd+v6M3Ac5TNNVJ2tGmiDIlUh7kqqbYEIuOtXHUrHalz6n4Or
         CPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728847639; x=1729452439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTYfXIOPxpGSQ1U9BLbigkK6xZ9C+Jk4uJzMJaFv0LQ=;
        b=ApMcf7GQHdm1dM1lLak8p93xvwdSUoh8wcMc6XSTO91vN7xrtsqSsxQtwmgWlf62RE
         pwXOSNlUI2vpqJIZal9IPa3q6abBrv9LVELc7ojtBKBjiCcY7cJlPzcbJwSgYpSaRsdr
         zNZSOZ7ao6NflEPBF25jCCs/gwAoxKYPvt/xZVB9TCow0ACsDynV3w4NyG1uQmrKUMiP
         Icga8xvwWpFhIE/lLPlMpd6n1XtEbMaLQJd8KB0YftlblVpuoZx0ltyaKqrkXFvtgmpb
         dEX20iB9t3QSISEdyr1nYkTBTOeoy27ytRpKfsWPD5jLW7X2Sp7FS/6AGYqRzlrmtbws
         hMtw==
X-Forwarded-Encrypted: i=1; AJvYcCXSLv9RmMiVw7A1GdMCtr1DTLUcupJ2fK+QpYEOX6kmOTER64eXeLxqdAYtoHZnf4sM57BZ9sUhUab96J4tBjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+nbF+nfyqoGh0Zl3DFKXcPeQkLc2HcY70ZQ/s8OwOn2zgszu
	KH/wvZVsbSC/HqMLRAiQfMZ9qURhiNQjSgrDg9VJVuPzzG0i4tPvHndTfdyp
X-Google-Smtp-Source: AGHT+IECJ+sTCFhIjx8GQG85CuAevgC1+MH0rpUE7k9MAwkuhbFsavq4MnkWsvhCoU7/UF+o7gGpJA==
X-Received: by 2002:a17:90a:f3c9:b0:2e2:b6ef:1611 with SMTP id 98e67ed59e1d1-2e2f0b00201mr11159211a91.18.1728847639430;
        Sun, 13 Oct 2024 12:27:19 -0700 (PDT)
Received: from [192.168.7.229] (97-126-102-147.tukw.qwest.net. [97.126.102.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d177b8dasm7151465a91.45.2024.10.13.12.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 12:27:18 -0700 (PDT)
Message-ID: <b34b48bb-bf86-4a50-90fb-b0ff147c1be8@gmail.com>
Date: Sun, 13 Oct 2024 12:27:18 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/4] mesh: Implement lower transport layer for
 segmentation and reassembly
To: Junho Lee <tot0roprog@gmail.com>, linux-bluetooth@vger.kernel.org
References: <66ff99e5.630a0220.2b5d14.8e61@mx.google.com>
Content-Language: en-US
From: Brian Gix <bggixx@gmail.com>
In-Reply-To: <66ff99e5.630a0220.2b5d14.8e61@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junho,

There are some check-patch failures on your patchset.

Can you fix these (and any others you find with check-patch) and resubmit?
The ones below are only from patch 1 of 4...  patch 3 applied cleanly, 
but 2 and 4 also could not be applied until patch 1 is fixed.

Thanks,
Brian

On 10/4/24 12:31 AM, Junho Lee wrote:
> -			send_net_ack(net, sar_in, expected);
> +		if (sar->flags == expected) {
> +			/*
> +			 * According to MshPRTv1.1: 3.5.3.4, if the destination
> +			 * is a unicast address and a segment is received for a
> +			 * completed message, it sends one acknowledgment within
> +			 * a period of:
> +			 *	[acknowledgment delay increment * segment reception interval]
WARNING:LONG_LINE_COMMENT: line over 80 characters
#774: FILE: mesh/net.c:2207:
+             *    [acknowledgment delay increment * segment reception 
interval]


>   	/* Msg length only definitive on last segment */
>   	if (segO == segN)
> -		sar_in->len = segN * MAX_SEG_LEN + size;
> +		sar->len = segN * MAX_SEG_LEN + size;
> +
> +	/* Send ACK only if DST is unicast address. */
> +	if(IS_UNICAST(dst)) {
ERROR:SPACING: space required before the open parenthesis '('
#875: FILE: mesh/net.c:2283:
+    if(IS_UNICAST(dst)) {

> +	 * segmented. Flush if it is not segmented or if the transmission
> +	 * failed.
> +	 */
> +	if (result && segmented) {
> +		struct mesh_sar_tx *sar_tx = mesh_sar_tx_new();
> +		bool is_unicast = IS_UNICAST(dst);
> +		sar_tx->ack_received = false;
WARNING:LINE_SPACING: Missing a blank line after declarations
#1010: FILE: mesh/net.c:3565:
+        bool is_unicast = IS_UNICAST(dst);
+        sar_tx->ack_received = false;



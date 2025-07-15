Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14091CF96
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 04:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552688; cv=none; b=t3ZkpulRyy4kR/mPzT0+ubZ26fBZRjLtCNlL7JsZHJCTz6RiGQZKwEL9GbX1BqQ9bn6C+sUfveCq5WS0TG+IIlVT/w3ZefirPa65mysTnZxTYKDQ/kngtziL9yQ28WhHLmG97hTlsxeNR9cRc97+i43OL33Rhlaog6CUkt8wg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552688; c=relaxed/simple;
	bh=TSTsIwjTjjEHb3+mWjNo7F/Gg7/h7lTmxEIWVkcoka0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHjksVh9SbUxWu28EWFZ1SxISzY0UFVX3G/Igew7Tq/dZm/PA506mEZA8Ufe103PXBI3Y4LOU+ImiHQFCUgKNqQWIj6haP97mO2rI42KYoRZF7rhGLJU3oiyC18ubUXga4VxEuutjUDeRe+sqaTIuX6y7VqQKfqETXHcPlURG58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOJugynk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOJugynk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-75001b1bd76so1732052b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 21:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752552686; x=1753157486; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YgpNyN77mpcZWUaffhsKzqRyEWb/8lL7LXQ8l7xylSc=;
        b=QOJugynkoGn/+J5o3AALjaBmNP3A7IWKAAjSqCdyDbFHgMEDzU4FGkYLi5Z8XTcS0T
         Pk1G6+zygCmSAOKLqhwYR18/fgDzQOTIQ2IE61dntBt7oQY3+uppcEkWq14BFeypAOb3
         cIYme8J7Lh1ugosET+VJxUBrIq3CLWp/7eCOeWbqHfAq9xsp1iWOhpuJWEBPrfybdMUX
         6aeOhAqKiz/F4na5lTp3aieIaYzhuR4VtGXlmLNpSuyeGFY1yFN393ULhspLaG9VN5lz
         Bv2x1q7mnWiYIIa9GMxri7bMgny2KdY8luhRbjkUYnF2cMrTUU8YOpIQGKqJ0T5agZc9
         wQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752552686; x=1753157486;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgpNyN77mpcZWUaffhsKzqRyEWb/8lL7LXQ8l7xylSc=;
        b=JQvJMYlKAiqtcKkJNrv5na+bhMkrrP7RBy5zFvl5TLQrrk5Nk0OZZeg3qrQOXpjao/
         JGUwp69x0zrPyYzsSXihY1MVu5FQGzcXg0pYPSl8b4eyWX1CdUeGD2MaG/IAymK3RA91
         w6QHfTOLBeBzGQTVbhrrWaEnR0Q+7Q4wHOEgQbho/IxtuMWmtpwmtT5gklAMZFMCI7K0
         7Z07jPwXFkcVE6llrWKPb0xZPmPDaipZU37dsYb2gkMqyK2++Nb08jvGIGWTSIBavVZk
         OqQKi0CydB5po+c9k/9tqT3LbxlhuZGdXcRrsDaj0YS2T8K3NLLeveDOMkHDiKyvFos5
         DidA==
X-Forwarded-Encrypted: i=1; AJvYcCViSSXCz0V/y+Xx3wg4KrWXk5QgpJuxvFqXHMrBGRwn0a+tHwP+SkIrw4zJ39OWs/QWK6rC7cAMCugp70rzTAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf+j7qJ8j+Ikf7sRJSQc08ufUYTh5NBIx0ZikNeIXyA6woFMEI
	wtINSJzDgX8VUrL1oi/Bbt42GhGYT2S6S+6BLQI1zPXomTgMRsAJM/gnEW0xIw==
X-Gm-Gg: ASbGnctnDG8fi1VP+Jvz2+K8R0XTXFJrt+UadMsFuv7o8y4mv+MMgal652fGPxJ4zYQ
	uifwWBdS0UTTT+TO3LeLoLLluzInhT1psUv7isfzKoj6r5Lo0Q8OG7lTCYaEddPXVP7Or887HzI
	iC757TGZgah+F1XSsXjB0PipzApWu1o2a2jqUa92+8tGw2bhSKywVlJ9C3Ryx4KHrRYjxqZSrm3
	5Q6brxmyJERiDXQjP+rZlCFN4WpYZZ7UZw2Mv0HEpWlD/qx0u9AMMiFNvM0w+n9O8nP88T6hmNb
	OR4eB46XExMz34QvnA9HWXYZshEDytLNV6tbiCQ1b3ppqGihQL+/Q0OWgge2cMSR621XGcrSuXN
	pdzleg83XzPsXYVatjHIvrwCw3tj1QS3gpLxcs505gkixafYO
X-Google-Smtp-Source: AGHT+IGCgz+uMa3HRbnLLghwozb58CwshU8NwTd4XlzPqPCtW1uK+a2SF1B5wxBkiQAFlvg36JuBFw==
X-Received: by 2002:a05:6a00:3999:b0:736:3979:369e with SMTP id d2e1a72fcca58-74ee07b4c2fmr21369732b3a.9.1752552685875;
        Mon, 14 Jul 2025 21:11:25 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:a681:d77c:431c:4815])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f210f1sm11350439b3a.88.2025.07.14.21.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 21:11:25 -0700 (PDT)
Date: Tue, 15 Jul 2025 00:11:23 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc: ceggers@arri.de
Subject: Re: [PATCH v1] Bluetooth: hci_ll: Fix compilation issue
Message-ID: <bvbhdxatxi4flaybmt73lncrvqmhxru5eshweclt7ivyfarkj7@x5vkfbr67a4r>
References: <20250715030318.1007009-1-kiran.k@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250715030318.1007009-1-kiran.k@intel.com>

On Tue, Jul 15, 2025 at 08:33:18AM GMT, Kiran K wrote:
> hci_ll.c: In function ‘ll_setup’:
> hci_ll.c:656:68: error: ‘struct hci_dev’ has no member
>                  named ‘quirks’
> 	set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> 
> Fixes: be736f5f89d5 ("Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bitmap")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/hci_ll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index e19e9bd49555..7044c86325ce 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -649,11 +649,11 @@ static int ll_setup(struct hci_uart *hu)
>  		/* This means that there was an error getting the BD address
>  		 * during probe, so mark the device as having a bad address.
>  		 */
> -		set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> +		hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
>  	} else if (bacmp(&lldev->bdaddr, BDADDR_ANY)) {
>  		err = ll_set_bdaddr(hu->hdev, &lldev->bdaddr);
>  		if (err)
> -			set_bit(HCI_QUIRK_INVALID_BDADDR, &hu->hdev->quirks);
> +			hci_set_quirk(hu->hdev, HCI_QUIRK_INVALID_BDADDR);
>  	}
>  
>  	/* Operational speed if any */
> -- 
> 2.43.0
>

Tested-by: Ivan Pravdin <ipravdin.official@gmail.com>

	Ivan Pravdin

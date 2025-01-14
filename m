Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C635979
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862810; cv=none; b=pbNeruwyEPLStZXFGfkNkENbKE1dsWaM+tJGDFCOCr27wEUpOl9elW6sX7vukwx6pH38cBxe+za6TpJcsmZvb3r6vyVLn6Tr+p7N0VA+lj0Asd7LYFqQ5RulT7E8JqdqWXibAAWz3yW72bYLnre+3esTZWHRNlBL1J3vmk+e3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862810; c=relaxed/simple;
	bh=hJkX5+o+uJNtJT90xi4kgUIBJmunFB2qz5pb5sKqQRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owrNLxPPNE7XOxeO/i8lxE0po+K+jS4lT5V9as39dZ+nt1yMO08MN52aRAfqZiZF0h1oYqZoB3AT5M0i4017jqhLFWPC6xwZxfNb+gwoojwWe16k0qIeOFhrIT45MI5D0J2ES5Ddy2SQ9eXuc5stWy6Sa0fUap6hBhzWGIacz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=remarkable.no; spf=pass smtp.mailfrom=remarkable.no; dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b=VVdqWxN7; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=remarkable.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remarkable.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b="VVdqWxN7"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3778bffdso5776476e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google; t=1736862806; x=1737467606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJkX5+o+uJNtJT90xi4kgUIBJmunFB2qz5pb5sKqQRw=;
        b=VVdqWxN7Vfzjw6FtzWsF4xevt1EdWtHXTEBSVLHsSq8XRaQlgAng2e4TuSCPlE6Cip
         rpTQKmhgmUAQBRS89ty52/x5fKWI1TVpb8U5Vc0gSpx/tE1ONep4eHWmDCpGkBWVmEoE
         qVfgcjRh5fw61UrLS3UakTJO8yj05+Wdzy8Vzwodqcn15hZVxsOPShcLgvqpkUGqNufQ
         PlOF0WQVDkwaJ4Vmco/zM+EQgUyHgeRQ6igj5pQ7CqgbSU0U/+nsJbspLAA4R4LzIbQ+
         M+NqlL7DClkTUG4gzx+mM4/WcrPLD1w7j8q/3WQwTMkHwVqLI+kjwsW3fzSQAp18h3NU
         HImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736862806; x=1737467606;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJkX5+o+uJNtJT90xi4kgUIBJmunFB2qz5pb5sKqQRw=;
        b=au/gqX2dq4e+d1RqfzPCY1/FFccfbJ1ie03sCLejGSR9xQiKjFwRxhgQeTrqpM96Vs
         SRZyBdOTpMwkY2if1F5/ADenBW3HbOWQPC2r7OZxKRNcL1cECqN6wOpk9/tZYOOalZj1
         PVfpkDk3AL1SF2oy6/8LPQZIuqtuAAFbf9ikonziGIZYuQIL91THg/XMzPaZGiIv7dT6
         HD+IUUOn10v6PBwjfRoli5FGDchvsv56HKzAQ4NJWMsb9cP1DLrSDXDoKFSX1xiLCeBS
         LuuGRKS6SgKW4zm95ZV6bDJ+95LL/c/t6n9q5DCmlmG5DJMsAWkpGp/DOTNkmojv+MGm
         Fvog==
X-Gm-Message-State: AOJu0YxHqeAq3dZZPXmZGLwJ1iq2HNvl14L9zUlNUBtgKzVOnh1Z20Si
	/FTvrU5Yg9ZMVuLTLPCw54m6G48jgYxrJFQHeSnd8Rdb2mxmuiGXt4HCiIV6bg==
X-Gm-Gg: ASbGncs7+GpTgjqC0tnwtQpeZm/ImP7kyDzJBtVllu3YPt3GqeuYYI3rvT8iOs3ZvKT
	BENkayIKxMxLYaZ5AhLxvUaBw3KPN7xAsDOJl6LmG9E+JvEUm7+Jcpi12EBtA//eL3OlgOtObve
	KqHR4OiOYwjEvA85R0onKrNBt6nqQhXizLzlmc9C3Z4XLGRo3jjbNpgUgxX6Ck93N33PguppaQj
	Dlq5FdXfkS/vmGGecqwlOoaBInmm+mTEqRWmfNdTDVlV6qlg1z4HVzVQkK8aF7oQO0/8rPC2zKj
	WJIWp3kNk+koOQt682+6EDJzOXPy/vk=
X-Google-Smtp-Source: AGHT+IH1UnEjelCgHrf8XrW9PCaVmULOAto7W+p38OG4x2aB45dMf3YdxSc5kdK3NURqwyo4D6jMqA==
X-Received: by 2002:a05:6512:3049:b0:542:2137:3a2c with SMTP id 2adb3069b0e04-542845469e1mr8691546e87.24.1736862805901;
        Tue, 14 Jan 2025 05:53:25 -0800 (PST)
Received: from ?IPV6:2001:4643:2b9c:0:742e:f778:f9f1:b089? ([2001:4643:2b9c:0:742e:f778:f9f1:b089])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428beaaa95sm1686191e87.174.2025.01.14.05.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 05:53:25 -0800 (PST)
Message-ID: <43beb3f3-071d-4f58-b356-6dc6b9de947a@remarkable.no>
Date: Tue, 14 Jan 2025 14:53:24 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, marcel@holtmann.org,
 luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, amitkumar.karwar@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, kristian.krohn@remarkable.no, manjeet.gupta@nxp.com
References: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
 <20250114133548.2362038-2-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Johan Korsnes <johan.korsnes@remarkable.no>
In-Reply-To: <20250114133548.2362038-2-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 2:35 PM, Neeraj Sanjay Kale wrote:
> This adds support for setting BD address during hci registration. NXP
> FW does not allow vendor commands unless it receives a reset command
> after FW download and initialization done.
> As a workaround, the .set_bdaddr callback function will first send the
> HCI reset command, followed by the actual vendor command to set BD
> address.
>

Hi Neeraj,

If NXP firmware does not allow vendor commands prior to this reset, would
it not be better to perform this reset during probe/init?

Kind regards,
Johan

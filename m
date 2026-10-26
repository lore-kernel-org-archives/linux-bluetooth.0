Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035422;
	b=VGkg1lzWMVCJK7aC5ABWFGqcw+EU26s2Lrc86DrjORpfVSQUqgDCBZxhwEJCSO7diqjn
	 otkk7xpS6bQLQm/TKXwV/1yVTb1E8r32eB4FJYEwdHcNQsdg/ohoLOWE1rQQO7+CgcC1z
	 G4eVMoxD+DpfqpHP2VBkZwFVkD4YJpjGQnIJSbecHfdrXl8Lpr2/tJ3ADqpoeE/SA2m6c
	 eYxBudK7IXmT3bYaZsZ3ISWnX2+z1I7W+71rQOI6roYmWwAiteN4enQ9Bs36haplXJEpH
	 BzZ2i44rtE9SLmWzIhBlo9hDg6hLZnfnk0kZxqansnZG+OJH5mhEmQ1rL/fAioIxTfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lK1c6nVQsiRu4kbUCyKRokp5xqtThWlCvn5n4+ykzAY=;
	b=RLD9/U3amURA0MNfdqUSgqf9al4e1wOFpiE72blfF2VhDJcTaaigmVwPoeKYEWbOh/nr
	 IC6bDnSaPnCZNT7UvDwFvAcPIYuav5jz8kPjyYQBN6/Oz0wMY0vSgB3a+6w+xu0Ig9Lsl
	 87F/x5zuP04N8SgxgUaRC8Rex3iKZjlu3F+ZWkPsIteQQL4J1sXqF51RqSEp9J1MIDfXg
	 E0cpWMb50kC892tLU1yL4M4mm+ZjVIfFIS9yWDiliqn2God0Ohssii1svf6y5AtAQYvjf
	 9p2gOfqrD2Ma83sjpd/nvVdfzF7tNhsAsa4pGw94W4x2jYyX6jl7wwwvNGsdnRVzLQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BeJ2JG7s;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4129A606A323
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 17:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4129A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BeJ2JG7s
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b10ac6ab7bso30452477b3.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793035421; x=1793640221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lK1c6nVQsiRu4kbUCyKRokp5xqtThWlCvn5n4+ykzAY=;
        b=BeJ2JG7sb/T2DNnkUJTMm8rgAN/rA8XUvs/qb1zHksV8AEioDLenI/MFN+z7mF4H15
         2VnpV/zHPVEf6OR4cK2me9m/Vev06livmw+mM9OcRzsnv4jhPuWJszeBGVv9wa2l6mqx
         xZHzEdn6dPvM37xEWNrR9X6c7h2QdJ27l1pg4/+5kGFk806NlnHeCKfZgGQh5I03Iq8o
         fPn7tSAgE6v29kXQZJP/d5QBfvLqHzHN5ALGoj3PFI67sPnqYpeETW94zhakRQw6GgFq
         0KEtFxcwWeSWjZgA8X+cRBHo3+0yo5pq1qD3z1l0Dc4NXVZfG82nBPpAuT4PJow1v49z
         pfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793035421; x=1793640221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lK1c6nVQsiRu4kbUCyKRokp5xqtThWlCvn5n4+ykzAY=;
        b=Zi/ysa+aiaN84dm1slNvwMRDGdIrTegNJR23f9dHzGJKptTlPDCRYW4ZwckgNU9G1h
         6Xihaz5apJMpLwuejRXX3WbF2r+d2dpaM8VreeSs7nHiq3PZI1hzRIKHDM7cej2uxEM7
         17z8Dt8TZLxCOVN1ExdYo1mktGk3oOz6ZFy81BPSUunbfzW/81GtUk3+cB6zzWRI9hf7
         cXawgSG9eWlScdu0rObkWRe513eVIHXk+IrWO4QPWSykWj+9y8tz/792c34CI1ui4qZw
         +bDyKkGH0nGf7ZFjOAb5In7KhY/z3j6S1XzkqIbXh0//PTj6IEYtHZ0tjNPacLGeo/5g
         c8kw==
X-Gm-Message-State: AFq9FYK8nPAoa0M66USnTkteTUgdMqDxwXkZyP5yb79Kg594p4wsyVoM
	lJavaR7m0EkIEGqs/FXyYR1cmzvYq9DCQ+V/A9nvB3k9YrnUjzp+W1Pq/IplDTihpRk=
X-Gm-Gg: AYBFou0AudWF8eNxbP31HzhjQjcF0A1E8ClQ/4x+0WZC7DPjlMe4zrAVnO5JtxM+4Ve
	inZqjP9/ZtNQuBLwCiuFMjxBom5+Nh70+RfhnO5o6QBYjPftlXdqpZQyPVWMZaabQ/78WpTrupO
	OyQFI2Vc5NWGy7sshkJhAXyI8m1hRajdhYuMhozQz9CVeEhsXJlsRJJahGzRZ9a9kk/eEFNG+MY
	1gJ3bKLdM3hxgA7A5Kyx1eddVMJ+gHDdOTq9r5eva0XyNMnQvYNMOL8KIR4hABMiXx0ZCFguupN
	Fi+IBRDVTqW7t2QFVxqvUiyuKazmpmy54OUcoOla7fHIfCww9irQyPaAoRqxB23UM8DTPp7midv
	sxvBvAh2byR1Nv9bQAl7bNhIMJCi2msA1o5izJAlrc7FFk438QBYOFdm3hSugecK175+QTBmOoN
	7wrkpFvQMNJgRT1Tz1AAdd9DbzwaWErco2eI8t5DO/aSZryXRtsN/d/z9JGWvUpwS6EsdyJHG4i
	LUy4Ji8ZYXt6pMmn9zrNms0PVo6hT3+qH2D9hynSQx9zE0=
X-Received: by 2002:a05:690c:ec4:b0:8b0:f1c0:60b8 with SMTP id 00721157ae682-8b166c94d08mr45612127b3.64.1793035420928;
        Mon, 26 Oct 2026 10:23:40 -0700 (PDT)
Received: from WillzDenali.lan ([2600:1702:7a80:3c5e::46d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166e9fc27sm35090107b3.34.2026.10.26.10.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:23:40 -0700 (PDT)
From: Brandon Williams <turbine.bmw@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Brandon Williams <turbine.bmw@gmail.com>
Subject: Re: [PATCH BlueZ 1/2] smp-tester: Expect the identity key in Pairing Requests
Date: Mon, 26 Oct 2026 13:23:28 -0400
Message-ID: <20261026172331.33873-2-turbine.bmw@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024112527.249473-1-turbine.bmw@gmail.com>
References: <20261024112527.249473-1-turbine.bmw@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Withdrawn along with the kernel series it tests, please drop.

Thanks,
Brandon

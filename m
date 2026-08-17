Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA3248F64
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968096; cv=none; b=FHONLJrxK9es9FEuCMhQq4ZSOEJU81ff7qaqXtKUIr7VydwAa2ar+5F8MOQUYsL//YeQoOvzGf2UiPTalEzXhSRrG9HqVZETgjwFR2/ATZiipP5ILA4Y67tEBcJqpUkekz5asKUwUZmBo9eBbU88VaJsy+GrUoDWdU7lys8O0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968096; c=relaxed/simple;
	bh=kiCNSahX10ogj7tvQDxkFZJc2UiSZzyU0s19hmcy5Io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zbq2dLVKQVkYm0OXDCCcnLSsRijtw54SZRTcjc192lZedCIVc8B1hZ8eiZL7Ec5swhBzVf83BW03prsv0XEgUWmJysaF4K5KKktOBo32tYtf4qryxeOG1LyLlYGW2kmcPUKf5xTx+s3OkaBIAPSYqASHbNGywOuzckM+M+ieics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhxAW4X2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhxAW4X2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC841F00A3A
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968092;
	bh=kiCNSahX10ogj7tvQDxkFZJc2UiSZzyU0s19hmcy5Io=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fhxAW4X2kN/kcD2szQYRgQt07r6yMN1xPsjlcGCUHcsrPJb5LkzQl+TQ79Sh6L6+x
	 BhyOItNxrFyXy24CLpgd4f8qv7eunpPmvDp7JU+Dgb/hj6GN8VjQpa7RlGsktQbyBG
	 HXvmCh9oH4CHX0glkhuw+u8X35EuE4kCw1ZZUwNYBbZLH4LVvaGHbD4PFxEdMkLljV
	 YRnYmgsTDNxFODXUTv3bxo/XB15N5Hbj8dF/NvIFFNe2BTwqWsLC+8RWzEJQdalXBz
	 MfYQI+d9dA9CBJ0tKpPbx5/3QjEvhPFpbwquLtzxhFtIA814CdSOOZhO9/cHR0EUWb
	 zGHD2CzY/oUVg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39ca300db70so27174281fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 05:01:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YyA+ELtpxA0qIrlJcBr4eeY2Taj6/MekojwNRfZBghJqjisBLY8
	OOnRYSuvPhYKYhDznD5CF/lGAlCWtskLtHH95fBA18Hp8ccBb5xYaTAWdBC5AcwqpqO/82YkvQc
	I7kmFMZxKqUJJihlPdAxcsW0pE1xaels=
X-Received: by 2002:a05:6512:838c:b0:5b2:9f9c:4634 with SMTP id
 2adb3069b0e04-5b45918b0f1mr2419311e87.45.1786968091724; Mon, 17 Aug 2026
 05:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817095550.648774-1-kaihsin.chung@synaptics.com> <20260817095550.648774-2-kaihsin.chung@synaptics.com>
In-Reply-To: <20260817095550.648774-2-kaihsin.chung@synaptics.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:01:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLn3c_V8H3NT04hJ_dEDddxy5te-AS7-acB8eXAxQv1GhQ@mail.gmail.com>
X-Gm-Features: AcwNN1VCUlD1i3f52xESvOX9gadxo4dLl83G13CJB-whl8pDS0VTVS9yXjw0lnE
Message-ID: <CAD++jLn3c_V8H3NT04hJ_dEDddxy5te-AS7-acB8eXAxQv1GhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: add BCM4384
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 11:55=E2=80=AFAM Kaihsin Chung
<kaihsin.chung@synaptics.corp-partner.google.com> wrote:

> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.
>
> Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

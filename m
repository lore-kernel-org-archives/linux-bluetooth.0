Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792504674;
	b=xEVDNNsPxfdgTBGLra5LLFovtVA1EszSROBfOG7WShg/gcK7sNkOax5CXTSAjS5XG4Ox
	 720bPUxy4KpFyYBf+5xG2sP/Lip54QjzIhKtgLWgTvhZ9dkIUHd5npvnRHZecJl3rek6Y
	 d1uISXpZPW/z/uM9rqwFwfRTugITasSd44v+Yf34opwZvzRgWhV5oPXUm7TNMFICETwEF
	 gZuyEC4xs2WzjCab5DvW9k9R99f6LVWwucDLl21VJ4CLmUANiUQvC+ELlZuiBiIjjUSS2
	 1bv+Dg1XZNK8MoJMMfdqSZ4rKkllVgAmvaYHc1Bg/3n/u+9qw+ALhshJ7pfv7DWJB4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504674;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=0bBUx2eE/ZkBTMkp0dS9VbqTbGpxHTgvOCLFluNS2rk=;
	b=HU3CMCJfFdK7E/2GzHJmIzsoepZz5cG3FFVzvsZCK51Mau7QPHG5kleenjyqHkdwXzbz
	 6sNH7BpCV3e1Zx7lHnwKpU8faxIXA+3KLG2X9/ZMmUQ4muj1TIiD71CrYMTBcp1cWyqKE
	 uOsX2U79SGw/IiD6qDa1hddPaltup0K4QGMZ8G9U/1ygSLWOEBtg/RNKzSVOClbF0Qa0r
	 Rpu8unV6qOgr5fWb3pG77rYH+qP5mzZJdwIRVFD2xqK6C2KyOLfVBp9Th3LLpA2g0hnQQ
	 tDJy1A+iErTwFzqhYlrAJ5VCrPffffOQmXyqfCeoZgnDoe5RA8Iz534/IGk+gZylBbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kgKb78CX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495ED606A322
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 13:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 495ED606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kgKb78CX
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67a000ac7efso568943d50.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 06:57:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792504673; cv=none;
        d=google.com; s=arc-20260327;
        b=GZ/2//kevUeb4mjtUwtmgvxk+925WE/ZgtRXJaVjgcoO3hPe2J984HZoSKpAf+6DAO
         u/Vszk/g8NGzccCH6Aw2c3xqaGCeH5BUrP7z6fm0glUi/4bBEOibkDcn3JMcy/Ch3B9o
         ZdANZyYqaikXYL44d0qQtbS4iM5/1c35DRUyPrQeTlMv7zom3NVucDuzNfcBBus4Ifhz
         UjyXnzF3+IRIsHZW4m2O0yDJuLXiCumUDIVGrNsWNwNimXbsoP8qSffHL4+2TjdryAKk
         d6JwPxebnpLoENmpUMZALQCX0DMkhdfnlVnBzsq8iUU2Y18qMT7FdpMpLRYgvyvaNNXy
         OVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0bBUx2eE/ZkBTMkp0dS9VbqTbGpxHTgvOCLFluNS2rk=;
        fh=r2/m4wYGyqkyR6RxAWv7O3n5xNNRFG2ggCMOs0AlOdE=;
        b=e7VWCRDnPYFYrpStCQxxtbv2bic8OgE5Gdlr0EL63wGmQxGiN/IEdx7UHK8G2ULfTM
         mab3E9EoL4zTX7VhVdpv/4s3gVgSVD+kL0Vx9NFrlBW1jpiw9LxeN8/7o6ZOl7ltiJjC
         GFFAQk2j/7u9tmkLP94wy8IIyPkiAOmiYvuCVHNyi2XL9y8BSMmc1cDCdXsw6PVIGC52
         EuMdsN87t9vgqS9ow1jEj2uZqLamd3chlZyAfZ7gAX4mA1b5M863cT86zXJFI4vvIikL
         D1NP1b/6tf1S8v5jzImegw9ryjwDEStibdLY2qMP1uBqAaxU6qUYo7whv4BDdKj5G11f
         Sc3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504673; x=1793109473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0bBUx2eE/ZkBTMkp0dS9VbqTbGpxHTgvOCLFluNS2rk=;
        b=kgKb78CXwLR/wUFx/aEzJRnqK97WBTvv8rgpG0XWQkpCh9hdSaES3sZy/rTICXJq5Q
         etLfUoEnM3LaIm+pJWXJq3nuiySRLBNdGKW9MSPL7KTALXENNxkD+mS0HHHpay7fEN9a
         3DAsFeTwV8ERO0ZtR/SPwyRZOxaW5bv/KWaDMQ0EWTbxNaf4R35bSmLm3M7TxFaRd701
         iL1iq8edixbvWRLucjpQqPKsro3/VU7Zp654frm9VRr0w0MMXpGB73iSE44CGWkUgv/D
         hey24mbZfyhZ+CJ40hnHF6H3kXZKNFLbYCJ5Qb9sQ7dmo5y0+6TQBbYD5bkXDnnCLsss
         qnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504673; x=1793109473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0bBUx2eE/ZkBTMkp0dS9VbqTbGpxHTgvOCLFluNS2rk=;
        b=cckgCPjBFD+E3Jdr/TgOYS1m60DoTQ67mej+VuwGRr1kV2dd3EIBEPEDBZU7aNleZn
         ynjPCMv2h3xYRG20lF5qNBsWeht02llrzBEI78WuBWPMqpz3Pqx1wjFoBmgjVm+mDW+Y
         9yFa2i85ILY53QG0ZdnuCEiS//naCH6/WAvkn3KU1nvRYbkJZObjtuiJgyy5Tb9EQn9a
         wcJ45twl7em5g1HS59uEjK3cCdLq/5CnE5cN0VOasLST7nFSjrNO2Oq0eWlbyCJtbuLS
         XqYyHUCQwt4843A/zA7k5I1eMa7uozgW3Ii0fO6YwCK4ttuI2s8crsHfYIO5Xe5SZdDT
         UnXQ==
X-Gm-Message-State: AFq9FYIBpIhbrOVSL3OEuJz+pbwrZ416Zu/kin6aPRGs+stHvqunh2wF
	32Du2sMpIW1XIHw23MkeS6Ao6rqFF9k+rRQwCFSuXDmk+/I1MXhfjjaYAYpKWdv24GPdvBd85GK
	GXdueJ1uRA9xQ4BR1dZyOYZV0XyfEgC2CuQ==
X-Gm-Gg: AYBFou3LCzum1lRp/UNZmDZM0pTZfXpJh2x8ETsiM8NLcd9aQDM9yV3DS1qlCsQVeNd
	hcYk2vmG1rm+TL1ZKccD4p3KUsUiM0Qh5V36Na6AGUqTDCXb+0ADlx53oy8JIDu9GqYkE3Kr8sb
	WSUypTW6TflZlm0PQ0rsEZu5FERXC0OhCDmVaOVPIdNgewg1oFcMFb1/39aEEezDNRW132qwDDq
	7SyhlmnxckDx4e8Dkl+Imxtdync0/rS73TIt36v//YkkgakAVGbJGpGrZyS97JuhSF8d6yfb1LX
	I9TAIStu8/f5csDGC2oxole5B0McZagaj47JK/Wz5llaBAFwL8G/2P9WPhesPA+jgp6GCU7iay2
	F/p9UcHnLdhtRZToZlMl2aDVhYCGDVDHwT74Fvj4=
X-Received: by 2002:a05:690e:b8c:b0:679:bfcf:a10a with SMTP id
 956f58d0204a3-679ca8b6767mr3389469d50.100.1792504673062; Tue, 20 Oct 2026
 06:57:53 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <BR2PR01MB9652538FB65DC582F4A6C4DE80BA672@BR2PR01MB965253.eurprd01.prod.exchangelabs.com>
In-Reply-To: <BR2PR01MB9652538FB65DC582F4A6C4DE80BA672@BR2PR01MB965253.eurprd01.prod.exchangelabs.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Oct 2026 09:57:41 -0400
X-Gm-Features: AclHuK96ReI591QV3Nutj29CVAJs9ut-vTQkd22zo93tooHQ7s0nxSey9tq31bE
Message-ID: <CABBYNZ+_sEVNwpyQ+b0rQyB-Bq=-yF2Q+u_HrKG1CqCx-Y8XOQ@mail.gmail.com>
Subject: Re: Plans for Periodic Advertising with Responses (PAwR) in kernel/BlueZ?
To: Schober Roland <Roland.Schober@hoffmann-group.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Schober,

On Tue, Oct 20, 2026 at 5:33=E2=80=AFAM Schober Roland
<Roland.Schober@hoffmann-group.com> wrote:
>
> Hi,
>
> I am building an embedded Linux gateway (NXP i.MX93, kernel 6.6,
> BlueZ 5.72) that should act as a Bluetooth 5.4 PAwR advertiser,
> similar to an ESL access point, serving a few hundred battery-powered
> BLE displays (nRF54L15, Zephyr). The gateway would run the periodic
> advertising train with subevents, collect the displays' responses,
> and hand new displays their sync via PAST after a short connection
> for pairing.
>
> As far as I can see, neither the kernel (no PAwR HCI commands/events
> in hci.h up to current master, no mgmt interface for periodic
> advertising outside the ISO broadcast path) nor BlueZ (no periodic
> advertising in LEAdvertisement1, no btmon decoding) support PAwR yet,
> and I could not find patches on the list.
>
> Is PAwR support planned or being worked on by anyone? If not, is it
> something you would want to see, and in which shape? That would help
> me decide whether to run the PAwR advertiser on Linux or on a
> co-processor.

I guess nobody is working on it, PAwR is sort of not used by profiles
directly it seems like PA is by LE Audio Broadcast, I guess we would
need to start with adding PA and PAwR to MGMT and then to D-Bus APIs,
adding emulator support so they can be test automated.

--=20
Luiz Augusto von Dentz

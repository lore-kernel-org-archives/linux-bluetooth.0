Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09A328CA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXyM8sFN"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2cd0c151cdcso23296791fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jan 2024 09:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704477191; x=1705081991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW13Zw4J9W9OeqrPJ8AckcQ6ezLq9wD7x+boYSGavxs=;
        b=BXyM8sFN5d6Nys6hx2C2ZPMIRKIzc5HgCPf9osWYgEHSOG+SpwBzx/ivuyX6GmC8Lp
         JPyJUBGQsElv4pvl+1xs5+j/W0mlZ5259l8f+DTUkFVTWyCa5iv+iM9otlC8++DdaALu
         rjgcgzSDmJVCIqOU2mKPtyyo/tSum4+l2mIby2jG7zTLh41Q+7D0uVBvVl+4KqNzY+4g
         CA08xbMn7wPsczE5G0lHOjtu49qmrkW6gMAD0Wv8vgFSIMa5WWG6qiaYcaG/rve/gOXn
         K6pnhiCHwNFv7rsuTFqyGdG5lZ7vvAegX+FXW5k+jXxpEQSeJa2WUhunUHbJwlCDurwy
         mDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704477191; x=1705081991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW13Zw4J9W9OeqrPJ8AckcQ6ezLq9wD7x+boYSGavxs=;
        b=Zer2zdX3POLav4bhOdR3TwUMm0tmLrC7xbcMFg3AZ/9Cqz6tr6xM+IsmsGg40AEJZQ
         Dlu+1uoapCgna8AN2ADOdASJDrJo4VhrOwnEJ8WeVA2g/H2sHvsL+qZIYH8a6pYjLzIc
         YLe7OuUH1KoDOakfYcpqmMudRv0lzdQ/7M8WCe/7vE64w+qyiGUxhBnQTNkgbA2pfLyk
         bTHmFR9uDBc1raRxd6kWxgjsuqWDEPVqgV0OcwGyW565s6gUIaQX2SrNjeCqLkq5m1KT
         lUdoEauSoQa3B340PFwn+LqIvyn59qSBVZjffWFHBt7r6qR8L0RHKlV90AFkkhKbkGSa
         jXAQ==
X-Gm-Message-State: AOJu0YyM4dzEQA0uY4gJyxo1M19A6prRlzU8WPefbihnODjfAhLEjxkp
	HuWuX0GlF/hpKkQZmJyV23fVp0CJrcWNM+wYkKq5FB/1
X-Google-Smtp-Source: AGHT+IEUhqmBe713l59kcl/DW8/tEIT+QnA++kjqL42AT30cNynbxahQrYoqvG9DqEtC0+tIezGwkdJX5PWVM9bC688=
X-Received: by 2002:a05:651c:b0f:b0:2cd:23a7:a346 with SMTP id
 b15-20020a05651c0b0f00b002cd23a7a346mr1526402ljr.83.1704477190593; Fri, 05
 Jan 2024 09:53:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85bf602dac47b63cfc5ec772fddcedbce29c13df.camel@interlinx.bc.ca>
 <548cbe00abc60f0506dbc47802bddd276c192205.camel@interlinx.bc.ca>
 <CABBYNZKS0BZGRZ8NMjue91i_P3mtQSL=ctLDcHDiZ+BBcXL2Aw@mail.gmail.com> <30fb108034be78c04ff195dba6708aa9d881bf75.camel@interlinx.bc.ca>
In-Reply-To: <30fb108034be78c04ff195dba6708aa9d881bf75.camel@interlinx.bc.ca>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jan 2024 12:52:56 -0500
Message-ID: <CABBYNZ+b0bqDtSutPrYh+EWkMkg3T9xdO-Lv11SsOmFQupUpUg@mail.gmail.com>
Subject: Re: Unable to connect BT mouse after it drops: Failed to connect:
 org.bluez.Error.Failed br-connection-create-socket
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Brian,

On Thu, Jan 4, 2024 at 8:14=E2=80=AFAM Brian J. Murrell <brian@interlinx.bc=
.ca> wrote:
>
> On Wed, 2024-01-03 at 11:08 -0500, Luiz Augusto von Dentz wrote:
> > Hi Brian,
> >
> > This usually means the device cannot be found, we receive a page
> > timeout, so Im not really sure why replugging would have fixed it,
> > could you please collect the HCI trace using btmon when that happens
> > so we can inspect the error it is returning.
>
> As far as the terminal's scrollback buffer goes, here's what btmon
> reported:
>
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.808029
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.808030
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.808075
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.808076
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.808119
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.808120
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.808173
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.808174
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.809737
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.809741
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.809795
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.809797
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.809846
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.809850
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.809897
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.809898
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.809943
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.809944
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.809990
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.809991
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810036
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810037
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810082
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810083
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810128
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810130
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810176
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810176
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810220
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810221
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810264
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810266
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810309
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810310
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810361
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810362
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810410
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810412
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810457
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810458
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810504
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810505
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810551
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810551
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810595
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810597
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810640
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810641
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810684
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.810686
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810774
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810863
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810906
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.810995
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811040
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811128
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811217
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811262
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811351
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811416
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811463
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811508
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811551
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811596
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811640
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811685
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811730
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811774
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811818
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811863
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811908
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.811953
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.811955
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812000
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812001
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812044
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812045
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812088
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812089
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812132
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812133
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812177
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812178
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812222
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812223
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812267
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812268
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812311
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812312
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812362
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812363
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812409
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812410
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812454
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812455
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812499
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812499
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812542
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812543
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812586
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812587
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812630
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812631
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812674
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812675
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812718
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812719
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812763
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812764
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812807
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812808
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812852
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812853
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812896
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812898
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812942
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812943
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.812987
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.812988
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813040
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.813041
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813087
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.813088
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813132
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.813133
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813176
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813220
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.813221
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813264
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.813266
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813311
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.813312
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.813360
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.815652
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.815655
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.815731
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.815732
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.815782
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.815784
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.815866
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.815867
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.815935
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.815937
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.815985
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.815988
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816035
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816036
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816082
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816084
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816130
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816130
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816177
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816178
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816222
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816223
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816268
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816269
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816314
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816315
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816374
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816375
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816424
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816425
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816471
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816472
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816517
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816518
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816563
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816564
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816608
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816609
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816653
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816654
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816698
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816698
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816743
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816744
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816789
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816790
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816835
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816836
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816881
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.816882
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.816927
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.824293
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.824337
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.824338
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.824481
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.824482
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.824537
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.824539
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.825229
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.826344
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.826348
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.826419
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.826422
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.826576
>         Powered: Disabled (0x00)
> @ MGMT Event: Command Status (0x0002) plen 3                             =
                                                          {0x0002} [hci0] 8=
2229.826578
>       Set Powered (0x0005)
>         Status: Permission Denied (0x14)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.826722
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1               =
                                                          {0x0002} [hci0] 8=
2229.826986
>         Powered: Disabled (0x00)
> hass[1670495]: @ MGMT Close: hass                                        =
                                                                 {0x0002} 8=
2229.827779

What is going on here, do you have some script trying to power down
the adapter for some reason?

> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2234.836190
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367466 [hci0] 8=
2234.836314
>         Address: 08:41:1D:9D:AF:7D (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367467 [hci0] 8=
2234.837461
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367468 [hci0] 8=
2234.837520
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367469 [hci0] 8=
2234.838462
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367470 [hci0] 8=
2234.838629
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367471 [hci0] 8=
2234.839460
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2234.839510
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2234.839520
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2245.539431
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2245.539633
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367472 [hci0] 8=
2245.539715
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367473 [hci0] 8=
2245.541515
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367474 [hci0] 8=
2245.541697
>         Address: 3C:E9:D3:2A:B0:E1 (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367475 [hci0] 8=
2245.542480
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367476 [hci0] 8=
2245.542626
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367477 [hci0] 8=
2245.543473
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367478 [hci0] 8=
2245.543535
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367479 [hci0] 8=
2245.544474
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2245.544528
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2245.544544
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2256.291425
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2256.291542
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367480 [hci0] 8=
2256.291585
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367481 [hci0] 8=
2256.292478
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367482 [hci0] 8=
2256.292508
>         Address: 20:71:E0:59:A4:B6 (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367483 [hci0] 8=
2256.293479
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367484 [hci0] 8=
2256.293506
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367485 [hci0] 8=
2256.294480
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367486 [hci0] 8=
2256.294508
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367487 [hci0] 8=
2256.295481
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2256.295510
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2256.295516
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2267.043402
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367488 [hci0] 8=
2267.043429
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2267.043648
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367489 [hci0] 8=
2267.044496
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367490 [hci0] 8=
2267.044538
>         Address: 2C:79:E8:CD:31:39 (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367491 [hci0] 8=
2267.045494
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367492 [hci0] 8=
2267.045589
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367493 [hci0] 8=
2267.046492
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367494 [hci0] 8=
2267.046520
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367495 [hci0] 8=
2267.047491
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2267.047511
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2267.047518
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2277.795520
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367496 [hci0] 8=
2277.795582
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2277.795836
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367497 [hci0] 8=
2277.796539
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367498 [hci0] 8=
2277.796616
>         Address: 3E:BB:14:E4:83:A6 (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367499 [hci0] 8=
2277.797521
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367500 [hci0] 8=
2277.797594
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367501 [hci0] 8=
2277.798513
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367502 [hci0] 8=
2277.798567
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367503 [hci0] 8=
2277.799514
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2277.799564
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2277.799578
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2288.548526
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367504 [hci0] 8=
2288.548716
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2288.548895
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367505 [hci0] 8=
2288.550525
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367506 [hci0] 8=
2288.550570
>         Address: 09:DC:C1:82:DB:1D (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367507 [hci0] 8=
2288.551527
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367508 [hci0] 8=
2288.551589
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367509 [hci0] 8=
2288.552531
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367510 [hci0] 8=
2288.552564
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367511 [hci0] 8=
2288.553525
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2288.553556
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2288.553565
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2299.299414
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367512 [hci0] 8=
2299.299480
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2299.300458
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367513 [hci0] 8=
2299.300544
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367514 [hci0] 8=
2299.300875
>         Address: 2E:DA:B6:D0:18:E3 (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367515 [hci0] 8=
2299.301537
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367516 [hci0] 8=
2299.301605
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367517 [hci0] 8=
2299.302538
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367518 [hci0] 8=
2299.302663
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367519 [hci0] 8=
2299.303537
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2299.303594
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2299.303609
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
>
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2310.051380
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2310.051492
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367520 [hci0] 8=
2310.051566
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367521 [hci0] 8=
2310.052547
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367522 [hci0] 8=
2310.052583
>         Address: 38:E4:B1:E7:A0:E0 (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367523 [hci0] 8=
2310.053547
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367524 [hci0] 8=
2310.053577
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367525 [hci0] 8=
2310.054549
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367526 [hci0] 8=
2310.054581
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367527 [hci0] 8=
2310.055548
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2310.055580
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2310.055587
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2320.803388
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Disabled (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367528 [hci0] 8=
2320.803419
>         Extended scan: Disabled (0x00)
>         Filter duplicates: Disabled (0x00)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen=
 4                                                        {0x0001} [hci0] 8=
2320.803699
>         Address type: 0x06
>           LE Public
>           LE Random
>         RSSI: invalid (0x7f)
>         UUIDs: 0
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367529 [hci0] 8=
2320.804567
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6                =
                                                           #367530 [hci0] 8=
2320.804615
>         Address: 18:89:DE:25:B6:1E (Non-Resolvable)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367531 [hci0] 8=
2320.805565
>       LE Set Random Address (0x08|0x0005) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13     =
                                                           #367532 [hci0] 8=
2320.805609
>         Own address type: Random (0x01)
>         Filter policy: Accept all advertisement (0x00)
>         PHYs: 0x05
>         Entry 0: LE 1M
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
>         Entry 1: LE Coded
>           Type: Active (0x01)
>           Interval: 11.250 msec (0x0012)
>           Window: 11.250 msec (0x0012)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367533 [hci0] 8=
2320.806562
>       LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6          =
                                                           #367534 [hci0] 8=
2320.806613
>         Extended scan: Enabled (0x01)
>         Filter duplicates: Enabled (0x01)
>         Duration: 0 msec (0x0000)
>         Period: 0.00 sec (0x0000)
> > HCI Event: Command Complete (0x0e) plen 4                              =
                                                           #367535 [hci0] 8=
2320.807563
>       LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
>         Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4                           =
                                                          {0x0001} [hci0] 8=
2320.807593
>       Start Service Discovery (0x003a) plen 1
>         Status: Success (0x00)
>         Address type: 0x06
>           LE Public
>           LE Random
> @ MGMT Event: Discovering (0x0013) plen 2                                =
                                                          {0x0001} [hci0] 8=
2320.807603
>         Address type: 0x06
>           LE Public
>           LE Random
>         Discovery: Enabled (0x01)
>
> I suspect that's not far enough back though.  :-(
>
> The adapter is still in that broken state.  I will leave it that way as
> long as I can in case there is something you want me to do while it's
> in that broken state.

Hmm, weird it seems there is a discovery session that is only scanning
on LE, but I don't see any connection attempt on BR/EDR, perhaps this
is the same entity that was trying to power off the adapter?

> Cheers,
> b.
>
>


--=20
Luiz Augusto von Dentz

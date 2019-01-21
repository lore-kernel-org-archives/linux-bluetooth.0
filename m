Return-Path: <SRS0=Rr1U=P5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C022AC2F42E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 15:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DC02085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Jan 2019 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548084487;
	bh=pumlwjHeONPZYwnT8yHJdNMGhAVMKleR0ah1BSGOpPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IDZsoCk+2HYdADBxzEQpKmOrUneb+/fZyXBPZf/kF3TPW6xYlk7uM4ibaaLhexQJ/
	 ztQcfT/mhYIbJ6QeA9mVCKcRIKaPfRN4CiDJE6Za5tXqdd5tb5I7V2z/0Lrr9+bzCn
	 dxUWoWbDBo6Ffdam+2yFBl9L6Z5ZPohWvNGIQcbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfAUP2G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:28:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45192 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbfAUP2G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jan 2019 10:28:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so20798109ota.12;
        Mon, 21 Jan 2019 07:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LD0x+D07Ca9umwMLvZQpX8W5PrCtVl9RQoj0nOFoaII=;
        b=L4knGbiLOTIzI4Igvq9/pT+Vl/WjCv9mgn3yhW1aHTCU8naxn64yrZg10sMV0J5PDV
         ShnGM/OOCyM51O25jC3KE0dErSPVVgNCaeEYAhKWtYxTm+Ph7DvsgM6xax0R0bjOLdbw
         9KYKfnwyLQX/wX3xOj8huSbtG628xsArfLuxLuR0p3AAgtrvtbbc7tow5LemChspJCJd
         SXqy/pQy8iy2W5G7d+qn3T5kxllT9meWu0BEODitipA9yxal+nGwpDZhYdCWKodYg/Ym
         D08tsYf5RY7Xuff2DQ6LZVJlnsPbAEX/sKSSLHCvCSFvY6pSsTKOyMxTLJOdVgDqNesl
         cN4w==
X-Gm-Message-State: AJcUukfePgAW7SMtHlChQKRbCjg73233tDBZ0plJPlwxmTUK/JQhakhu
        YdqpC6U5eiwR/9PrVv7ONw==
X-Google-Smtp-Source: ALg8bN42LqHQ6uVcllSg5d0KjkTm/GFEbR91Jf8zFpCbSTlFUzxzPUX/BhoOV73H2x0xHeYMLHSc2g==
X-Received: by 2002:a9d:641:: with SMTP id 59mr18228294otn.215.1548084485447;
        Mon, 21 Jan 2019 07:28:05 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w62sm5742913oiw.34.2019.01.21.07.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:28:04 -0800 (PST)
Date:   Mon, 21 Jan 2019 09:28:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     mark.rutland@arm.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Bluetooth: dt-bindings: Realtek serial bluetooth
Message-ID: <20190121152804.GA29172@bogus>
References: <20190120124046.6715-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120124046.6715-1-beagleboard@davidjohnsummers.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sun, Jan 20, 2019 at 12:40:45PM +0000, David Summers wrote:
> Since v2, the compatible binding names have been changed to end in
> -bt, as requested by robh.

Now you have the same subject for 2 different patches. Again, use 
'git log --oneline drivers/bluetooth/hci_h5.c' and follow the subject 
pattern.

> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  drivers/bluetooth/hci_h5.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..056ab2decccc 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -925,6 +925,22 @@ static struct h5_vnd rtl_vnd = {
>  };
>  #endif
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id h5_of_match[] = {
> +#ifdef CONFIG_BT_HCIUART_RTL
> +       { .compatible = "realtek,rtl8723as-bt"},
> +       { .compatible = "realtek,rtl8723bs-bt"},
> +       { .compatible = "realtek,rtl8723ds-bt"},
> +       { .compatible = "realtek,rtl8761atv"},
> +       { .compatible = "realtek,rtl8821as-bt"},
> +       { .compatible = "realtek,rtl8821cs-bt"},
> +       { .compatible = "realtek,rtl8822bs-bt"},
> +#endif
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, h5_of_match);
> +#endif
> +
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id h5_acpi_match[] = {
>  #ifdef CONFIG_BT_HCIUART_RTL
> -- 
> beagleboard@davidjohnsummers.uk
> 

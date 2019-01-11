Return-Path: <SRS0=CXZ/=PT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748C9C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 16:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9C52183F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jan 2019 16:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547224463;
	bh=iWvqVvq9lTTCdFw6p+56JtkHtQrv0+npdrbhHHv8Hgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GopY/rTsq+OkKI/g6oC005ym9ZdIBmOQkApsiO7Ek0SILfbOxOdMghjbe+jROVoNa
	 48G7n7215PhIcRdiESWv9fvfhIL5oVZNw9vBRuR2rnOCrVlt8J0IkzE2dnuG4oC+ZL
	 C9Q1S5cG6gMLzt4+qfbj6gdd9uQ6eErAGnap+Czg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbfAKQeW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jan 2019 11:34:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33936 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbfAKQeW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jan 2019 11:34:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id r62so12695946oie.1;
        Fri, 11 Jan 2019 08:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SmbBsFaE2AnxI/LZ9i7weYqy+canQ8pDIZE+UU080nw=;
        b=GKSjmnzAlQkPB6cvt5iFPRTRP+5ZwsDNhlvV8yqB65IVROhCzTyxxQCbcjTWpinf++
         lAt+6sUGT/xpDg6+WEXTZVdUsKFbZ6jOFxT1jIBJVr0Ff0OWaNU5brM2+dwuIpkoGi1I
         NtlJipuHxgxWpdQQ6K7nipHbyWIrSdgNzmfEuqGbjQaEIpQzkCQ6wtleLB4Ti25oiG0i
         TL3D1fGMLufZXmugS5ZxLC1zn+nzqAZS8oz7yMXdYtG7NBeRCmf7fYD7Ip638IHZCymX
         SfxMYXoX7JL5UpqfaLgYy3BaVyEsx6nEsEVl61xFmk1rhHsRXP3Ivuto6lML3bZwcyD1
         A9Ww==
X-Gm-Message-State: AJcUukcOeHDu+ct/X1KEHEvY/h0L9VcUQcLvkB0eUz92wKvdrA2GszdW
        KZdWAMBzKwtnvdXKbNlMuQ==
X-Google-Smtp-Source: ALg8bN7KdwgagvyEhnL6IBeiIpshjibXkfCtmAhpW1RlXZZ7D9Gr/cs8b211hHistqfaeW7HGKUTBQ==
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr9265226oie.32.1547224461065;
        Fri, 11 Jan 2019 08:34:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 127sm36540155oid.36.2019.01.11.08.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 08:34:20 -0800 (PST)
Date:   Fri, 11 Jan 2019 10:34:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Summers <beagleboard@davidjohnsummers.uk>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mark.rutland@arm.com,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv2] Description of the realtek bluetooth device tree hooks
Message-ID: <20190111163420.GA20311@bogus>
References: <20181229115513.31153-1-beagleboard@davidjohnsummers.uk>
 <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103163538.6575-1-beagleboard@davidjohnsummers.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jan 03, 2019 at 04:35:37PM +0000, David Summers wrote:
> This adds the desrciption file that describes the hooks for the
> realtek bluetooth serial devices, as needed to refer to the interface
> in the device tree.

Please follow conventions for patch subjects. 'git log --oneline 
--no-merges -- path/to/file' usually gives a good clue. In this case, 
something like:

dt-bindings: net: Add Realtek serial bluetooth binding

> 
> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
> ---
>  .../bindings/net/realtek-bluetooth-serial.txt | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> new file mode 100644
> index 000000000000..0aabca1fc002
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/realtek-bluetooth-serial.txt
> @@ -0,0 +1,28 @@
> +Realtek bluetooth devices connected via a UART
> +
> +- compatible: should be "realtek,<name>-bluetooth"
> +  except for "realtek,trl8761atv" - which only has a serial bluetooth connection
> +       "realtek,rtl8723as-bluetooth"
> +       "realtek,rtl8723bs-bluetooth"
> +       "realtek,rtl8723ds-bluetooth"
> +       "realtek,rtl8761atv"
> +       "realtek,rtl8821as-bluetooth"
> +       "realtek,rtl8821cs-bluetooth"
> +       "realtek,rtl8822bs-bluetooth"

Arguably, '-bluetooth' is not necessary as nothing else is attached to 
the serial port. At least shorten it to '-bt'.

> +- These device are bluetooth devices, that connect via a uart

s/device/devices/

> +- all devices (except for rtl8761atv) are also wifi devices, this is connected
> +  seperatly via sdio - and is not covered by this compatible node

Really, this should be up above the property list in a description of 
the device(s).

> +- ideally these will be referenced in a device tree serial node via serdev

Not ideally, but it is only valid for this to be a child of a UART.

serdev is a kernel thing, and shouldn't be part of the binding doc.

> + http://events17.linuxfoundation.org/sites/events/files/slides/serdev-elce-2017-2.pdf

Useful, but again, not part of this binding.

There's no interrupts, GPIO control lines, power supplies, etc. for 
these chips? The binding should be complete even if your platform 
doesn't need these.

> +
> +Example:
> +
> +&uart0 {
> +	status = "okay";

Don't show status in examples.

> +       	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>;
> +       	bluetooth {
> +               	  compatible = "realtek,rtl8723bs-bluetooth";
> +       	};

Mixed tabs and spaces. Use tabs.

> +};
> +
> +this ensures that the bluetooth device is tied to the correct uart
> -- 
> beagleboard@davidjohnsummers.uk
> 

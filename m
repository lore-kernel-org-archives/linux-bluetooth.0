Return-Path: <SRS0=tqgc=MH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877AC43382
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 23:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B5B20843
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Sep 2018 23:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fewHYY+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B5B20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbeIZGAs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Sep 2018 02:00:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34050 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeIZGAo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Sep 2018 02:00:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so12726650pgv.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Sep 2018 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pEupypS0Swd7HrPPPlVvTZZOaRzgMD5elzeZZtca8qQ=;
        b=fewHYY+JLIcAAI6piWFekHwlDWPmN2C/elNWFXnwjYHgQRPQ++yU17KJPpD2DjXnyI
         QMO2s8mktcNY/3XIFN9gr8lRK3j68JZkfk3hILGFUHDqGsMyZ+GfRrggc8BQnUj4LtCq
         mHVP1xB7u05rV7VEVnjQnofQ+PdUTSG0MaemI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEupypS0Swd7HrPPPlVvTZZOaRzgMD5elzeZZtca8qQ=;
        b=FtYIzL379WHS81aAgb8XSIONuVlGLfOwD5yVb7XPS2JDJL2rFYpuBhGyqZ7SZzgOof
         qd70efnTSmC7fzyc/POEuUs8FAo9kfyLDgciucjpGp9h33oJfuugIpWnZJc75s4gnDXT
         p0VBRd95HGCMjB57+0IH2e+7qoIts7gNlLEtki/c8s5TutNfPlpdFSYuaAPG5K22Qeq3
         jjIPcmI2e7JdNTIE6fJ/p/uHyHsBmmLHUucTNGwQDoiadjzR8BdOmFyuud8+JQOXJ+Kp
         gh0fSy9rNQoY8osC5wz0hYO9OnFSWHeprgdlwkG+FvQTnsvbXVgktR8OZ++zme7VL6XB
         B8Yg==
X-Gm-Message-State: ABuFfogzW4V5r2NRoYYRAz61UM8ZRN0Crqqd/os5J+BRBTb0aHH0AuOS
        2p+vf5/B3lG630BKPExH/O3r9A==
X-Google-Smtp-Source: ACcGV60US9BK2wIJtfcT/SgCxoDIjolcvbjs3ddDG1xkXNzIIwrRwemiZSmSuHQRb+7XixdUdEYmnA==
X-Received: by 2002:a63:1148:: with SMTP id 8-v6mr3205951pgr.172.1537919443125;
        Tue, 25 Sep 2018 16:50:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v8-v6sm4260583pfl.6.2018.09.25.16.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 16:50:42 -0700 (PDT)
Date:   Tue, 25 Sep 2018 16:50:41 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3.1 1/2] device property: Add device_get_bd_address()
 and fwnode_get_bd_address()
Message-ID: <20180925235041.GC22824@google.com>
References: <20180925191014.85573-1-mka@chromium.org>
 <20180925191014.85573-2-mka@chromium.org>
 <20180925213321.buotrpzlvokem24n@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180925213321.buotrpzlvokem24n@kekkonen.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sakari,

thanks for the reviews

On Wed, Sep 26, 2018 at 12:33:22AM +0300, Sakari Ailus wrote:
> Hi Matthias,
> 
> On Tue, Sep 25, 2018 at 12:10:13PM -0700, Matthias Kaehlcke wrote:
> > Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> > address (BD_ADDR) for a device. If the device node has a property
> > 'local-bd-address' the BD address is read from this property.
> > 
> > The definition of bdaddr_t is moved to types.h to make it visible in
> > property.h without having to include (the mostly unrelated) bluetooth.h
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> > Changes in v3:
> > - move definition of bdaddr_t to types.h to avoid include of
> >   bluetooth.h from property.h
> > - add stubs for the new functions
> > 
> > Changes in v2:
> > - use bdaddr_t instead of byte pointer + len
> > - use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
> > - put new functions inside #if IS_ENABLED(CONFIG_BT)
> > - some new line juggling in property.h
> > - added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
> > ---
> >  drivers/base/property.c           | 46 +++++++++++++++++++++++++++++++
> >  include/linux/property.h          | 18 ++++++++++++
> >  include/linux/types.h             |  5 ++++
> >  include/net/bluetooth/bluetooth.h |  5 ----
> >  4 files changed, 69 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 240ab5230ff6..afe412133188 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1315,6 +1315,52 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
> >  
> > +#if IS_ENABLED(CONFIG_BT)
> > +
> > +/**
> > + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> > + *                         firmware node
> > + * @fwnode:	Pointer to the firmware node
> > + * @bd_addr:	Pointer to struct to store the BD address in
> > + *
> > + * Search the firmware node for 'local-bd-address'.
> > + *
> > + * All-zero BD addresses are rejected, because those could be properties
> > + * that exist in the firmware tables, but were not updated by the firmware. For
> > + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> > + */
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr)
> > +{
> > +	bdaddr_t ba;
> > +	int ret;
> > +
> > +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > +					    (u8 *)&ba, sizeof(bdaddr_t));
> 
> sizeof(ba)
> 
> > +	if (ret < 0)
> > +		return ret;
> > +	if (is_zero_ether_addr((u8 *)&ba))
> > +		return -ENODATA;
> > +
> > +	memcpy(bd_addr, &ba, sizeof(bdaddr_t));
> 
> How about simply:
> 
> 	*bd_addr = ba;
> 
> Either way,
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks I'll address your comments in v4. I'll wait a day or two before
re-spinning for if others have additional feedback.

Cheers

Matthias

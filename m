Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F1C04E87
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFEE2170B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 17:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TYuOZUl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFEE2170B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbeI0XYE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:24:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38215 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbeI0XYD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 19:24:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id r77-v6so2412071pgr.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Sep 2018 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qN9BvOweZ4As+HmR3/VRETB+ylu6PZcK+ZKJMv27rtI=;
        b=TYuOZUl83vSjwxI7Ww3wdOCpT4Iti6ytK/+ekVKpjiNVJ0zgeYO3bCuUJk3ERWeESq
         7FcgMk9tjQiuE4TGXgS1BbmTL/8H2KaPk0TzQOMX+6ZGXiUN/ADG1CZ6AQcsi5ijlWt5
         VwZvwuM6QlXjnKiHVvg+A+iScBYwd106Gpgg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qN9BvOweZ4As+HmR3/VRETB+ylu6PZcK+ZKJMv27rtI=;
        b=R5E3ffbGmXaK3zvugI3M1RzJ1nY6x81uGQ9E08oQHY39oA29WTSnhvst6nrGavYzOB
         I0KC3z6bLBtQTxyyTeRGFYJkW7JUjpLDx2tzKhl6nh1fktIry1YzcD6fOHOGOYz1dEwv
         Tgh1P7SiO9FKqe/017IHuSfL/nWWRiSvdD4Uvz2pF5NV+xnmV4AoMeNSiGSbJurN/in8
         F+VYVZGM/FIF5e6GWiwAAznG+K+HZbyLfg/PLA/xca2lG+hJmzs8HKmVK1nrLI6TsRgy
         pFgZXa3U/XlQWeidx7Dc/QmaE1N0SSD2Uv5jMi5t6bO1Es9nNIkoWOL4uhGTjks5u7Ew
         7OEA==
X-Gm-Message-State: ABuFfohPMOSH3Nv5OsliqUEbsgj3NIC6KhDsSjP+SCImxGlXxguODhKU
        1bSIM2qCirEwoFmUmS5MIz04CQ==
X-Google-Smtp-Source: ACcGV6095/wV83dn/WUb+fczRLLA4BHpScxwEw2NugippvFROdX6+NGbwMoMVEmdp7lV+MplwpDunw==
X-Received: by 2002:a65:42c2:: with SMTP id l2-v6mr5989453pgp.139.1538067890497;
        Thu, 27 Sep 2018 10:04:50 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id d12-v6sm3709191pfn.118.2018.09.27.10.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 10:04:49 -0700 (PDT)
Date:   Thu, 27 Sep 2018 10:04:49 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
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
Message-ID: <20180927170449.GF22824@google.com>
References: <20180925191014.85573-1-mka@chromium.org>
 <20180925191014.85573-2-mka@chromium.org>
 <20180926113625.GM11965@kuha.fi.intel.com>
 <DCD95AC8-D216-4CCE-B305-605A25B6B23A@holtmann.org>
 <20180927113829.GQ11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927113829.GQ11965@kuha.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Sep 27, 2018 at 02:38:29PM +0300, Heikki Krogerus wrote:
> Hi Marcel,
> 
> On Thu, Sep 27, 2018 at 12:24:33PM +0200, Marcel Holtmann wrote:
> > > Let's not fill property.c with framework specific helper functions any
> > > more!
> > > 
> > > Those functions are completely bluetooth specific, so they do not
> > > belong here. The fact that some other framework already managed to
> > > slip their helpers in does not justify others to do the same.
> > 
> > so? The firmware guys decided to put MAC addresses and BD addresses into the
> > firmware. So you have to deal with that.
> 
> I think you have misunderstood the point.
> 
> > Moving this into the Bluetooth subsystem is as pointless. I rather keep the
> > accessor function to firmware specific data in one place and not spread around
> > the whole tree. Especially once this is also provided via ACPI or some other
> > means. I assumed that is what the whole device_get part was suppose to
> > abstract.
> 
> Unified device property API defines a _generic_ API that can be used
> by any type of device to access the device properties regardless of
> the way the hardware is described.
> 
> Any device can use device_property_read_u8/u16/u32/u64/string()
> functions, but only bluetooth devices can use device_get_bd_address().
> Therefore that function does not belong to drivers/base/properties.c.

Initially property.[ch] seemed the correct place to me since the
device_get_bd_address() is the equivalent to
device_get_mac_address(), which lives there. However I doubted to use
bdaddr_t in the interface when I noticed that the other functions only
use generic data types. Not a red flag but a first hint that it's
probably not the right place for Bluetooth specific functions. I
agree with Heikki that the Bluetooth subsystem seems a better home for
this API.

Cheers

Matthias

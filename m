Return-Path: <SRS0=erFC=OG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524BCC43441
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 11:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3652086B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Nov 2018 11:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMiTPTfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3652086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbeK0WsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:48:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41817 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbeK0WsB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Nov 2018 17:48:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so19806292otk.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Nov 2018 03:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTJi70ab2SDWmDb5obJWlqjg0rWVeSPCjZFkzPvKifA=;
        b=EMiTPTfBaUpDyxBiLAWmUdiczjVRFFCU//haovkvDv5NJd2j4JPoiVXWHHgiVdfBEx
         JBc2nBSMPPDYtxBwQJTvbJ//T8IgXoRaH5AR+ZoEqDh2PicMoSfMt0pkTNlwbEbeGozG
         Y1N2DjLslG9p1X9mgIPjGUowfl55DnRj7uAtAX8bCqoW9xL5sFNSNpu7vo6zSStpadmd
         hNJvyU3v9/FmDXtKBzzhYOkdJGTuEZZwbIRpVx2CQUQXzBshqbt5nMC+drrmPWSPMV+d
         5Tb4Zvrdw+sUAxwW2VPtYAOt4UJ47tx6jR6b9/R9gTQQaQCwfik9gA7MJLHKbosR5HEc
         zetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTJi70ab2SDWmDb5obJWlqjg0rWVeSPCjZFkzPvKifA=;
        b=lYD8CHSH4/jNJ2XpTXDQXLDkUr9Nl5lH4wp7xjhByNMOraG3W/UWVtUti4LwQatZiZ
         Cn3hLxHMVHnXXR4/g8nsUKtoioNqicZONu6lDReGa1L2pxhwVr5h6FxvQ0EZyy9AAYkM
         1ufS8C6gsueyYgERhG8V6OT6T5AJxviQcGIWOwcNwqNDixAKmszCYTiLjrpSdngcbBwa
         L4NYaRYgukh4E0XVwow5Ie3SY9BiIWatawqbbTOZndqT6oMOxYASRfVASRMtmcFTy5Vi
         Hepx2CJFiGIEXKBBKVLtVyyvtRk2f4P6aJ+EuGEuOLDDySldQVNfdE07I/w7WskpFXnL
         5g9g==
X-Gm-Message-State: AA+aEWZTB+OHmdKX+ASSmScHzkntcja0SqEesgh4RkSJRcoqdSjjGckf
        8GsuU6ET8V6Ldu0JDgB8+ZapzLDUVCB5T9Rg88A=
X-Google-Smtp-Source: AFSGD/X2ld191XlnB1EVLulOR1bz/I9Ewyasso5WpaUbqX1ZW36Xt3gLnhYZmxhq1eEwVAf/piE2LftSa6oVrVhEiEM=
X-Received: by 2002:a9d:3213:: with SMTP id t19mr19451578otc.71.1543319422057;
 Tue, 27 Nov 2018 03:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20181126164907.15659-1-zimmermach@gmail.com>
In-Reply-To: <20181126164907.15659-1-zimmermach@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 27 Nov 2018 13:50:09 +0200
Message-ID: <CABBYNZJ72pzUOG2ukReBVNhwiwLFW7Zzts96HvF+WHHdKWfBEQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] Added config conversion for Bluez4 as shell
 script during install
To:     zimmermach@gmail.com
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Christian,
On Mon, Nov 26, 2018 at 6:53 PM Christian Zimmermann
<zimmermach@gmail.com> wrote:
>
> ---
>  Makefile.am                                |  8 +++
>  tools/bluez4_conversion/convert_config.sh  | 89 ++++++++++++++++++++++++++++++
>  tools/bluez4_conversion/convert_devices.sh |  3 +
>  3 files changed, 100 insertions(+)
>  create mode 100755 tools/bluez4_conversion/convert_config.sh
>  create mode 100644 tools/bluez4_conversion/convert_devices.sh

The permission of the convert_config.sh look incorrect, besides that
we normally avoid having extra directories so I would put them under
tools, or better yet scripts since these are not written in C. Id also
don't want to make them specific to a version so they might carry over
other all the legacy formats and always convert to the latest, for
that reason perhaps we should have unit test for the conversion tools.

> diff --git a/Makefile.am b/Makefile.am
> index 0b26ccc3e..6dc5711d9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -477,6 +477,8 @@ endif
>
>  EXTRA_DIST += $(manual_pages:.1=.txt)
>
> +EXTRA_DIST += tools/bluez4_conversion/convert_config.sh tools/bluez4_conversion/convert_devices.sh
> +
>  DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
>                                                 --enable-health \
>                                                 --enable-midi \
> @@ -535,3 +537,9 @@ clean-local:
>         -find $(top_builddir) -name "*.gcda" -delete
>         $(RM) -r lib/bluetooth
>  endif
> +
> +BLUEZ4_CONFIG_CONVERSION = $(srcdir)/tools/bluez4_conversion/convert_config.sh
> +BLUEZ4_DEVICE_CONVERSION = $(srcdir)/tools/bluez4_conversion/convert_devices.sh
> +install-exec-hook:
> +       $(BLUEZ4_CONFIG_CONVERSION)
> +       $(BLUEZ4_DEVICE_CONVERION)
> \ No newline at end of file
> diff --git a/tools/bluez4_conversion/convert_config.sh b/tools/bluez4_conversion/convert_config.sh
> new file mode 100755
> index 000000000..477e18fae
> --- /dev/null
> +++ b/tools/bluez4_conversion/convert_config.sh
> @@ -0,0 +1,89 @@
> +!/bin/sh
> +
> +CONFIG_DIR="/var/lib/bluetooth"
> +
> +convert_on_mode()
> +{
> +    config_file=$1
> +    #Read on_mode from config file
> +    on_mode=$( cat $config_file | grep -Po 'mode \K(.*)')
> +    if [ ! -z "$on_mode" ]
> +    then
> +        if [ $on_mode == "discoverable" ]
> +        then
> +            #Write on mode to new INI file
> +            echo -e "Discoverable=true" >> settings
> +        else
> +            #Write on mode to new INI file
> +            echo -e "Discoverable=false" >> settings
> +        fi
> +    else
> +        echo "On mode not found"
> +    fi
> +}
> +
> +convert_discoverable_timeout()
> +{
> +    config_file=$1
> +    #Read discoverable timeout from config file
> +    discoverable_timeout=$( cat $config_file | grep -Po 'discovto \K([0-9]+)')
> +    if [ ! -z "$discoverable_timeout" ]
> +    then
> +        #Write discoverable timeout to new INI file
> +        echo -e "DiscoverableTimeout=$discoverable_timeout" >> settings
> +    else
> +        echo "Discoverable Timeout not found"
> +    fi
> +}
> +
> +convert_pairable_timeout()
> +{
> +    config_file=$1
> +    #Read pairable timeout from config file
> +    pairable_timeout=$( cat $config_file | grep -Po 'pairto \K([0-9]+)')
> +    if [ ! -z "$pairable_timeout" ]
> +    then
> +        #Write discoverable timeout to new INI file
> +        echo -e "PairableTimeout=$pairable_timeout" >> settings
> +    else
> +        echo "Pairable Timeout not found"
> +    fi
> +}
> +
> +convert_local_name()
> +{
> +    config_file=$1
> +    #Read local name from config file
> +    local_name=$( cat $config_file | grep -Po 'name \K(.*)')
> +    if [ ! -z "$local_name" ]
> +    then
> +        #Write local_name to new INI file
> +        echo -e "Alias=$local_name" >> settings
> +    else
> +        echo "Local name not found"
> +    fi
> +}
> +
> +###
> +# Main script body
> +###
> +for entry in `ls $CONFIG_DIR`; do
> +    cd $CONFIG_DIR
> +    cd $entry
> +    if [ -f "config" ]
> +    then
> +        if [ ! -f "settings" ]
> +        then
> +            #Create new settings INI file
> +            touch settings
> +            echo -e "[General]" >> settings
> +            convert_pairable_timeout config
> +            convert_discoverable_timeout config
> +            convert_on_mode config
> +            convert_local_name config
> +            rm config
> +        else
> +            echo "Settings already available"
> +        fi
> +    fi
> +done
> diff --git a/tools/bluez4_conversion/convert_devices.sh b/tools/bluez4_conversion/convert_devices.sh
> new file mode 100644
> index 000000000..a8a013b06
> --- /dev/null
> +++ b/tools/bluez4_conversion/convert_devices.sh
> @@ -0,0 +1,3 @@
> +# TODO
> +# This file is intended for replacing the conversion of Bluez4 device datas when upgrading to Bluez5 INI format
> +# This is currently checked at every bluetoothd startup in src/adapter.c
> \ No newline at end of file
> --
> 2.11.0
>


-- 
Luiz Augusto von Dentz

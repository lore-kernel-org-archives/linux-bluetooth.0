Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 17 Jan 2017 09:51:42 +0100
From: Maxime CHEVALLIER <maxime.chevallier@smile.fr>
To: Mallikarjun Phulari <p.mallikarjun@globaledgesoft.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive
 command
In-Reply-To: <947643683.19966188.1484636706688.JavaMail.zimbra@globaledgesoft.com>
References: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr>
 <947643683.19966188.1484636706688.JavaMail.zimbra@globaledgesoft.com>
Message-ID: <590a5c2e5fc345566b6966a71a94cc76@smile.fr>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> Hi i am running heart-rate service using gatt-server.
> And i am using gatttool as client.
> gatt-server with default security level "low" is working fine.
> But when try different security levels "medium" and "high" with -s
> option, it is not connecting with the gatttool.
> 
> What might be the problem??

The patch you linked applies to the btgatt-client tool, you seem to be 
using gatttool.
When using gatttool, the option '-l' must be used to specify the 
security level.

Note that gatttool will soon be marked as deprecated, you might want to 
use btgatt-client instead.

> Thanks & Regards
> Mallikarjun Phulari

Regards,

Maxime

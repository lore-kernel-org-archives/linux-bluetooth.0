Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 31 Jan 2017 16:00:39 +0530 (IST)
From: Mallikarjun Phulari <p.mallikarjun@globaledgesoft.com>
To: Maxime CHEVALLIER <maxime.chevallier@smile.fr>
Cc: linux-bluetooth@vger.kernel.org
Message-ID: <306265495.518366.1485858639832.JavaMail.zimbra@globaledgesoft.com>
In-Reply-To: <1666158258.518353.1485858630674.JavaMail.zimbra@globaledgesoft.com>
References: <1482402965-9462-1-git-send-email-maxime.chevallier@smile.fr> <947643683.19966188.1484636706688.JavaMail.zimbra@globaledgesoft.com> <590a5c2e5fc345566b6966a71a94cc76@smile.fr>
Subject: Re: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive
 command
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thats fine..
I am facing the problem with btgatt-server security options.
btgatt-server is not connecting to any clients even with btgatt-client when the security level of btgatt-server is set to "medium" or "high".

btagatt-server is working fine with the security level "low"


Regards
Mallikarjun Phulari

----- Original Message -----
From: "Maxime CHEVALLIER" <maxime.chevallier@smile.fr>
To: "Mallikarjun Phulari" <p.mallikarjun@globaledgesoft.com>
Cc: linux-bluetooth@vger.kernel.org
Sent: Tuesday, January 17, 2017 2:21:42 PM
Subject: Re: [PATCH 1/2] tools/btgatt-client: Fix set-security interactive command

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
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Disclaimer:- The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. The views expressed in this E-mail message (including the enclosure/(s) or attachment/(s) if any) are those of the individual sender, except where the sender expressly, and with authority, states them to be the views of GlobalEdge. Before opening any mail and attachments please check them for viruses .GlobalEdge does not accept any liability for virus infected mails.


Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100930135618.GA4615@vigoh>
References: <1285836760-3234-1-git-send-email-haijun.liu@atheros.com> <20100930135618.GA4615@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Fri, 1 Oct 2010 22:40:30 +0800
Message-ID: <AANLkTikSO5K5LfB6FDKrjeTFoHNEDxnn0d_zqTw_QDKX@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Replace hard code of configuration flag
 with self-comment macro.
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: "Haijun.Liu" <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	dan.tian@atheros.com, suraj@atheros.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Sep 30, 2010 at 9:56 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Haijun,
>
> * Haijun.Liu <haijun.liu@atheros.com> [2010-09-30 16:52:39 +0800]:
>
>>
>> Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
>> ---
>>  net/bluetooth/l2cap_core.c |    6 +++---
>>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> Your patch doesn't build:
>
> net/bluetooth/l2cap_core.c: In function 'l2cap_config_req':
> net/bluetooth/l2cap_core.c:2988: error: 'L2CAP_CONF_FLAG_CONT'
> undeclared (first use in this function)
> net/bluetooth/l2cap_core.c:2988: error: (Each undeclared identifier is
> reported only once
> net/bluetooth/l2cap_core.c:2988: error: for each function it appears
> in.)
> net/bluetooth/l2cap_core.c: In function 'l2cap_config_rsp':
> net/bluetooth/l2cap_core.c:3096: error: 'L2CAP_CONF_FLAG_CONT'
> undeclared (first use in this function)
>
>
> You also have to fix your commit subject, it would be good if you can do
> it with 50 characters, but never overstep the 72 characters. If need to
> add more info the commit message is there for you ;)
>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Sorry for this mistake, I'll mail out right one soon.

-- 
Haijun Liu

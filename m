Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100930140042.GB4615@vigoh>
References: <1285836760-3234-1-git-send-email-haijun.liu@atheros.com>
 <1285836760-3234-2-git-send-email-haijun.liu@atheros.com> <20100930140042.GB4615@vigoh>
From: haijun liu <liuhaijun.er@gmail.com>
Date: Fri, 1 Oct 2010 22:31:14 +0800
Message-ID: <AANLkTi=nOWzTQU0N1BtNpDe6i+g5N43bwXOYHVw0rj+S@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Update conf_state with L2CAP_CONF_REQ_SENT
 before send config_req out in l2cap_config_req().
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: "Haijun.Liu" <haijun.liu@atheros.com>,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	dan.tian@atheros.com, suraj@atheros.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Sep 30, 2010 at 10:00 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Haijun,
>
> * Haijun.Liu <haijun.liu@atheros.com> [2010-09-30 16:52:40 +0800]:
>
>>
>> Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
>> ---
>>  net/bluetooth/l2cap_core.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 279f98a..9e788c2 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>
> Patch has been applied to my bluetooth-next-2.6 tree with modifications
> to the commit message and subject. Next time pay attention to not
> overstep the 72 characters in the commit subject and do not add a "." in
> the end of your subject. Thanks.
>
> --
> Gustavo F. Padovan
> ProFUSION embedded systems - http://profusion.mobi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thank you.

-- 
Haijun Liu

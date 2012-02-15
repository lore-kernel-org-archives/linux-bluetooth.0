Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACLukzLJc7GO3TP9mU5MrY2SmPLG7c9figWNxJP5KuK286DD8g@mail.gmail.com>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
	<1329241945-32414-3-git-send-email-anderson.lizardo@openbossa.org>
	<CACLukzLJc7GO3TP9mU5MrY2SmPLG7c9figWNxJP5KuK286DD8g@mail.gmail.com>
Date: Wed, 15 Feb 2012 06:44:55 -0400
Message-ID: <CAJdJm_O4v9zwFkg6U0qK8bCNHBB=RSdhLi-t0DOPmnoe7RP0DQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] thermometer: Fix re-enabling
 notification/indication on reconnection
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Santiago Carot <sancane@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Santiago,

On Wed, Feb 15, 2012 at 5:03 AM, Santiago Carot <sancane@gmail.com> wrote:
> Hi Anderson,
>
> 2012/2/14 Anderson Lizardo <anderson.lizardo@openbossa.org>:
>> If a result callback is not specified for gatt_write_char() it is
>> assumed that Write Command will be used. This is not valid for
>> Characteristic Descriptors, which only support Write Request.
>
> I'm not against this patch but from my point of view, I think this is
> a little obscure behaviour wich would deserve an advice coment in
> gatt.h due it isn't clear for anybody developping over GATT to guess
> it. On the other hand, _I remember another functions in gatt.h wich
> have similar double behaviour depending on the parameters provided in
> there, suach as gatt_discovery_primary, in wich a discover ALL primary
> service is done if the uuid is equal to NULL or disvovery service by
> UUID is done if uuid is provided, I think gatt_discover_char works in
> the same way. Maybe that having a good comments here could help to
> avoid this kind of errors in the future.

I agree this API can be improved. Feel free to send patches either
splitting them into separate functions, or properly documenting this
behavior. I think at this point there is no problem in changing this
GATT API, but sending as RFC would not hurt :)

Either way, the current upstream code will send invalid ATT
operations, so the fix is still appropriate.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

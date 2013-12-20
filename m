Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 4/5] android/hal-bluetooth: Add support for device service record property
Date: Fri, 20 Dec 2013 14:38:18 +0100
Message-ID: <3121104.trYEc2PX04@uw000953>
In-Reply-To: <D18535D5-351D-4C61-9D7E-6486E8558859@holtmann.org>
References: <1387535140-6223-1-git-send-email-szymon.janc@tieto.com> <1387535140-6223-5-git-send-email-szymon.janc@tieto.com> <D18535D5-351D-4C61-9D7E-6486E8558859@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> Hi Szymon,
> 
> > This allows to correctly handle device service record property.
> > ---
> > android/hal-bluetooth.c | 15 +++++++++++++++
> > android/hal-msg.h       |  7 +++++++
> > 2 files changed, 22 insertions(+)
> > 
> > diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
> > index d0c1c01..4ef2ebe 100644
> > --- a/android/hal-bluetooth.c
> > +++ b/android/hal-bluetooth.c
> > @@ -166,6 +166,21 @@ static void device_props_to_hal(bt_property_t *send_props,
> > 			break;
> > #endif
> > 		case HAL_PROP_DEVICE_SERVICE_REC:
> > +		{
> > +			static bt_service_record_t e;
> 
> why static here. Since we are essentially multi-threaded, this can be dangerous.

This is executed only in notification thread context, so not multi-threading here.
(yes, commit message could be better)

-- 
BR
Szymon Janc

Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Jul 2013 10:03:48 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for
 characteristics
Message-ID: <20130724170348.GA952@x220.p-661hnu-f1>
References: <20130724045756.GC14367@x220.p-661hnu-f1>
 <1374651156-19959-1-git-send-email-djcb.bulk@gmail.com>
 <CAJdJm_P-Zgg+r1Nc2OevfyQ1QkbpgbSYdVV9B-33WEZm=V553w@mail.gmail.com>
 <87ob9r7vuq.fsf@djcbsoftware.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ob9r7vuq.fsf@djcbsoftware.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dirk,

On Wed, Jul 24, 2013, Dirk-Jan C. Binnema wrote:
>  > My suggestion would be to rename the old one to GATT_OPT_CHR_UUID16
>  > and this could be GATT_OPT_CHR_UUID. But as Johan said, this could be
>  > in a separate patch.
> 
>  > >         GATT_OPT_CHR_PROPS,
>  > >         GATT_OPT_CHR_VALUE_CB,
>  > >         GATT_OPT_CHR_AUTHENTICATION,
> 
> That makes sense -- but as the newcomer here, I'll happily let the
> others reach some consensus on what the best naming would be, and I'll
> make a patch after that :-)

GATT_OPT_CHR_UUID16 and GATT_OPT_CHR_UUID sound fine to me so you can
proceed with those.

Johan

Return-Path: <cyrus@holtmann.org>
References: <1374587243-30452-1-git-send-email-djcb.bulk@gmail.com> <20130724045756.GC14367@x220.p-661hnu-f1>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] attrib/gatt_service_add: support 128-bit uuids for characteristics
In-reply-to: <20130724045756.GC14367@x220.p-661hnu-f1>
Date: Wed, 24 Jul 2013 10:25:29 +0300
Message-ID: <87fvv4ju6u.fsf@djcbsoftware.nl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Thanks for the quick review! I've updated the too-long lines and taught
emacs to avoid mixing tabs/space in bluez code.

On 2013-07-24 07:57, johan.hedberg@gmail.com wrote:

 > info->uuid.value is a union so I don't think it's safe to check any
 > particular member before you've checked uuid.type. However, isn't what
 > you want above to check that you have a BT_UUID16 or BT_UUID128? I.e.
 > there should be no need to check for info->uuid.value.u16 directly.

Makes sense; note that the value check was in the original code, which I
didn't want to touch. In any case, I've changed it now.

 > Be consistent with the coding style here: type casts should have a space
 > between the cast and the variable.

 > >  typedef enum {
 > >  	GATT_OPT_INVALID = 0,
 > >  	GATT_OPT_CHR_UUID,
 > > +	GATT_OPT_CHR_BT_UUID_T,
 > >  	GATT_OPT_CHR_PROPS,
 > >  	GATT_OPT_CHR_VALUE_CB,
 > >  	GATT_OPT_CHR_AUTHENTICATION,

 > To be honest, I'm not 100% sure this is the best name for the new
 > option, but I can't really think of anything much better either.
 > Renaming the existing one to UUID_STR and the new one to UUID (like the
 > old one was) would be one option, but it's one more patch and more code
 > changes.

Indeed, couldn't come up with a better name myself :/... The old one
takes a uint16_t, so maybe we could call it UUID_16, and perhaps in the
future add UUID_STR for string-encoded 128-bit uuids.

Anyway, I'll send an updated patch.

Cheers,
Dirk.
 

-- 
Dirk-Jan C. Binnema                  Helsinki, Finland
e:djcb@djcbsoftware.nl           w:www.djcbsoftware.nl
pgp: D09C E664 897D 7D39 5047 A178 E96A C7A1 017D DA3C

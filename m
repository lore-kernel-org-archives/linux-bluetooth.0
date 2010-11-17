Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCHv3 3/7] Add DBus OOB API documentation.
Date: Wed, 17 Nov 2010 13:49:51 +0100
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com> <1289922247-20712-4-git-send-email-szymon.janc@tieto.com> <20101116163729.GA3854@jh-x301>
In-Reply-To: <20101116163729.GA3854@jh-x301>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201011171349.51512.szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > +Service         org.bluez
> > +Interface       org.bluez.OOB
> > +Object path     /org/bluez
> 
> I think this should use the same path as the Manager API, which at the
> moment is /

I was following HealthManager way, but I'm fine if you prefer / path.

> > +		array{byte} hash, array{byte} randomizer
> > +			ReadLocalOobData(object adapter)
> 
> Having to pass an adapter path as a parameter seems weird. Wouldn't it
> make more sense to have this method in the Adapter path/interface
> instead? Also, we could toy around with the thought of putting the two
> other methods into the current Manager interface.

It is OK to me to move ReadLocalOobData to adapter path as this is an adapter
related data.

My initial idea was to keep all oob related methods in org.bluez.OOB interface
but I'm not going to insist on it.

-- 
Szymon Janc
on behalf of ST-Ericsson

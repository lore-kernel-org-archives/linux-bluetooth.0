Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101118123310.GA4101@jh-x301>
References: <1290009593-13658-1-git-send-email-bruna.moreira@openbossa.org>
	<20101118123310.GA4101@jh-x301>
Date: Thu, 18 Nov 2010 09:29:34 -0400
Message-ID: <AANLkTimGk6B-eDvP3yU3SNN8KNFvqZ_N4vPUXrPQk0ns@mail.gmail.com>
Subject: Re: [PATCH 1/3] Advertising data: extract local name
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Bruna Moreira <bruna.moreira@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Thu, Nov 18, 2010 at 8:33 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Variables should be always declared in the smallest possible scope, so
> your new type variable is in the wrong place (it should be declared
> inside the if-statement. Since this was the only issue I found with this
> patch I fixed it myself and pushed it upstream. Btw, is it really safe
> to ignore the type here? What if it's EIR_NAME_SHORT? Wouldn't you then
> want to perform full name discovery using e.g. the GAP GATT service
> later?

The idea is to populate dev->name with some temporary information
available on the advertising data, and later when GATT service
discovery happens (as part of device creation), we get the definitive
name. At the moment, the GATT service discovery is not happening
automatically (but Claudio's patches are a beginning of that, IIRC),
so the advertising information is the only name source for LE devices,
currently.

Of course, we need to make sure that once name resolution through GATT
service discovery is done, any future names in advertising data would
be ignored, but we have not implemented this yet.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil

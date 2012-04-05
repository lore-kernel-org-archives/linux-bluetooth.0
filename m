Return-Path: <cyrus@holtmann.org>
Message-ID: <1333642493.16897.7.camel@aeonflux>
Subject: Re: [PATCH v3] Bluetooth: Fix packet type for ESCO Link
From: Marcel Holtmann <marcel@holtmann.org>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Hemant Gupta <hemant.gupta@stericsson.com>
Date: Thu, 05 Apr 2012 09:14:53 -0700
In-Reply-To: <CACj007nwsZumYtKkFcEu2jQa=f7dZJYJ=szXEMVhO0n5goRCjg@mail.gmail.com>
References: <1333597594-21532-1-git-send-email-hemant.gupta@stericsson.com>
	 <CACj007nwsZumYtKkFcEu2jQa=f7dZJYJ=szXEMVhO0n5goRCjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

> > This patch uses the corect packet type for ESCO Link.
> > Without this patch esco packet types were anded with ~EDR_ESCO_MASK
> > resulting in setting bits that are not supported by controller
> > to 0 which means that corresponding EDR ESCO packet type is
> > supported(EDR Packet types are inverted as per BT Spec) which might
> > not be the case.
> >
> Any comments on this patch ?

as I said before, I like to see a hcidump in the commit messages that
shows the failure.

Regards

Marcel



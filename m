Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110622192037.GA2583@joana>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
	<1308686870-26101-3-git-send-email-andre.guedes@openbossa.org>
	<1308688620.2196.61.camel@aeonflux>
	<BANLkTik_5+s9coWFR0Nd2GsH6gO=pRBKUQ@mail.gmail.com>
	<1308761865.2196.77.camel@aeonflux>
	<BANLkTinTRAcNgdVZPygyfukXSpB8LhZpeg@mail.gmail.com>
	<20110622192037.GA2583@joana>
Date: Wed, 22 Jun 2011 17:00:53 -0300
Message-ID: <BANLkTinniMgn8Qs66gCrv98wgZPb24bk9Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Add MGMT_OP_SET_LE_SUPPORT command
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Jun 22, 2011 at 4:20 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Once we add enable_le I think we can also remove enable_smp, unless this is
> needed for for some qualification test. But I don't think so.

Yes, once we have enable_le param we'll remove enable_smp.

Andre

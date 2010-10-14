Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH -next] bluetooth: fix hidp kconfig dependency warning
From: Marcel Holtmann <marcel@holtmann.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
	akpm <akpm@linux-foundation.org>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20101013181652.7ddf481e.randy.dunlap@oracle.com>
References: <20101013181652.7ddf481e.randy.dunlap@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Oct 2010 07:22:35 +0300
Message-ID: <1287030155.3316.20.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

> Fix kconfig dependency warning to satisfy dependencies:
> 
> warning: (BT_HIDP && NET && BT && BT_L2CAP && INPUT || USB_HID && HID_SUPPORT && USB && INPUT) selects HID which has unmet direct dependencies (HID_SUPPORT && INPUT)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel



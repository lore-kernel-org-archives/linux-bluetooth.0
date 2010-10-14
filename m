Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Thu, 14 Oct 2010 09:18:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@linux-foundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -next] bluetooth: fix hidp kconfig dependency warning
Message-ID: <20101014121845.GB9250@vigoh>
References: <20101013181652.7ddf481e.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101013181652.7ddf481e.randy.dunlap@oracle.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

* Randy Dunlap <randy.dunlap@oracle.com> [2010-10-13 18:16:52 -0700]:

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Fix kconfig dependency warning to satisfy dependencies:
> 
> warning: (BT_HIDP && NET && BT && BT_L2CAP && INPUT || USB_HID && HID_SUPPORT && USB && INPUT) selects HID which has unmet direct dependencies (HID_SUPPORT && INPUT)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  net/bluetooth/hidp/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

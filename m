Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Sep 2010 04:23:29 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Update conf_state before send
 config_req out.
Message-ID: <20100930072329.GA3048@vigoh>
References: <AANLkTimQtkORjmsiO3wPULRErNXORBtHATbBvdCEsY27@mail.gmail.com>
 <20100928234934.GC8518@vigoh>
 <AANLkTikz3VTGtL5PY2nAXKO1z_XD4ROEZyUV3JXsrstn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikz3VTGtL5PY2nAXKO1z_XD4ROEZyUV3JXsrstn@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-09-29 19:11:29 +0800]:

>  Update conf_state with L2CAP_CONF_REQ_SENT before send
>  config_req out in l2cap_config_req().
> 
> 
> Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Still corrupted:

Applying: Bluetooth: Update conf_state before send config_req out.
fatal: corrupt patch at line 10
Patch failed at 0001 Bluetooth: Update conf_state before send config_req
out.

Make sure you can apply your patches sent with git send-email before
sending them to the mailing list. Thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

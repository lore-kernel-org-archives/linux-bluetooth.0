Return-Path: <cyrus@holtmann.org>
Date: Tue, 28 Sep 2010 20:49:34 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Update conf_state before send
 config_req out.
Message-ID: <20100928234934.GC8518@vigoh>
References: <AANLkTimQtkORjmsiO3wPULRErNXORBtHATbBvdCEsY27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimQtkORjmsiO3wPULRErNXORBtHATbBvdCEsY27@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-09-20 09:33:31 +0800]:

> Update conf_state with L2CAP_CONF_REQ_SENT before send config_req out.
> 
> 
> Signed-off-by: Haijun.Liu <Haijun.Liu@Atheros.com>

Both patches are corrupted, please fix that and rebase it against
http://git.kernel.org/?p=linux/kernel/git/padovan/bluetooth-next-2.6.git
Thanks.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

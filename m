Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Oct 2010 18:00:53 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	dan.tian@atheros.com, suraj <suraj@atheros.com>,
	Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [PATCH] Bluetooth: Replace hard code of configuration
 continuous flag
Message-ID: <20101004210053.GA3234@vigoh>
References: <1285943147-2546-1-git-send-email-haijun.liu@atheros.com>
 <AANLkTi=-4yF2qew7YVnESPd_jt7g8bvS12XYkhx27ko8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTi=-4yF2qew7YVnESPd_jt7g8bvS12XYkhx27ko8@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-10-01 22:43:52 +0800]:

> Replace hard code of configuration continuous flag with
> self-commented macro L2CAP_CONF_FLAG_CONT in functions
> l2cap_config_req() and l2cap_config_rsp().
> 
> Signed-off-by: Haijun.Liu <haijun.liu@atheros.com>

Put a ' ' instead of '.' to separate your surname.

> ---
>  include/net/bluetooth/l2cap.h |    2 ++
>  net/bluetooth/l2cap_core.c    |    6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)

Patch is corrupted again, please check where you are screwing up on
sending patches to the mailing list, then we can save my time and your
time. ;)

Applying: Bluetooth: Replace hard code of configuration continuous flag
fatal: corrupt patch at line 11
Patch failed at 0001 Bluetooth: Replace hard code of configuration
continuous flag

Regards,

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

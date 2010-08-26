Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 22:21:50 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 16/22] Store new configuration values in l2cap_pinfo
Message-ID: <20100826012150.GG16062@vigoh>
References: <AANLkTimnW0jk19cDG+r64Q+-HxdH2qdTBirTMB7ikr1W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimnW0jk19cDG+r64Q+-HxdH2qdTBirTMB7ikr1W@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:37:30 +0800]:

> From d093975dde6d85c824a5aaac943d676100810010 Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Mon, 23 Aug 2010 00:09:56 +0800
> Subject: [PATCH 16/22] Store new configuration values in l2cap_pinfo.
> 
> ---
>  include/net/bluetooth/l2cap.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 2d864d4..f2dd65d 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -406,6 +406,15 @@ struct l2cap_pinfo {
>  	__u16		remote_mps;
>  	__u16		mps;
> 
> +	__u8		ext_flowspec_enable;
> +	struct ext_flow_spec	loc_efs;
> +	struct ext_flow_spec	rem_efs;
> +
> +	__u8		extwin_enable;
> +	__u16		extwin_size;
> +	__u8		rem_extwin_enable;
> +	__u16		rem_extwin_size;

The same comment in 14/22 goes here and others patches in the patch set.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi

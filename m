Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v4 2/6] Bluetooth: Add SCO socket voice_setting option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 26 Mar 2013 13:22:50 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DE6F5576-C7C9-4EA9-B242-3489F0651FBC@holtmann.org>
References: <1363716255-21332-1-git-send-email-frederic.dalleau@linux.intel.com> <1363716255-21332-3-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch extends the current SCO socket option to add a 'voice_setting'
> member. This member is intended to choose data type at runtime.
> Incoming connections will be setup during defered setup. Outgoing connections
> have to be setup before connect(). The desired setting is stored in the sco
> socket info.
> This patch declares needed members, modifies getsockopt() and implements
> setsockopt(). Setting the mtu is not supported.

Signed-off-by line.

> ---
> include/net/bluetooth/sco.h |    2 ++
> net/bluetooth/sco.c         |   54 +++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 56 insertions(+)
> 
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index 1e35c43..41dbdfa 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -43,6 +43,7 @@ struct sockaddr_sco {
> #define SCO_OPTIONS	0x01
> struct sco_options {
> 	__u16 mtu;
> +	__u16 voice_setting;
> };

I find this parameter name a bit long. What about just "setting" or "settings" or "voice". I am open for suggestions.

Also should this be part of options or the socket address structure.

Another option would be to introduce a SCO_SETTINGS or SCO_VOICE socket option. With just this one parameter.

Since the default value of voice setting is not 0x0000, it might make actually more sense to introduce a new socket option. Playing the memset handling would only work nicely if the default would be 0x0000, but it isn't.

Regards

Marcel


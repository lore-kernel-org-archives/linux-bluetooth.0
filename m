Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Sep 2010 14:36:15 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext haijun liu <liuhaijun.er@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mat Martineau <mathewm@codeaurora.org>,
	"dantian.ip" <dantian.ip@gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace hard code of configuration
 continuation flag.
Message-ID: <20100929113615.GH1931@null>
References: <AANLkTi=mS2212wTd3nu_ENJ8ySyNSVMWgTmc-MT0421c@mail.gmail.com>
 <20100928234820.GB8518@vigoh>
 <AANLkTi=EVEwuKy3QwNJ1sVpe2_EJCkQQ3iGutKQQRneU@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=EVEwuKy3QwNJ1sVpe2_EJCkQQ3iGutKQQRneU@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Patch is ok but just one comment. See below.

On Wed, Sep 29, 2010 at 01:12:39PM +0200, haijun liu wrote:
> 
>  Replace hard code of configuration continuation flag with self-comment macro.
> 
> -	if (flags & 0x0001) {
> +	if (flags & L2CAP_CONF_FLAG_CONT) {
>  		/* Incomplete config. Send empty response. */
>  		l2cap_send_cmd(conn, cmd->ident, L2CAP_CONF_RSP,
>  				l2cap_build_conf_rsp(sk, rsp,

Maybe you could use L2CAP_CONF_FLAG_CONT also in l2cap_build_conf_rsp()?

-- 
Ville

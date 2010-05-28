Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100523023906.GB3385@vigoh>
References: <1274436293-15063-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20100523023906.GB3385@vigoh>
Date: Fri, 28 May 2010 10:14:31 +0300
Message-ID: <AANLkTilQoPjrNgqjtp7xeQF-yzrE6KNgDdagEXrIIGIv@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] Bluetooth: Check sk is not owned before freeing
	l2cap_conn
From: Ville Tervo <ville.tervo@iki.fi>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sun, May 23, 2010 at 5:39 AM, Gustavo F. Padovan <gustavo@padovan.org> wrote:

> Using the sock timer like you are you using looks too hackish, there are
> kernel struct for such defer works. I still prefer the first solution,
> that avoids the call to l2cap_chan_del() only.
> But we have to solve the problem with the sock_kill() call, I'm
> wondering if add a check inside l2cap_sock_kill is good idea. So we
> check if the socket is owned by user and if yes, we just return, however
> may have problem with socket refcnt doing that.
>
> Looking to the rfcomm code I found something that could be cause of the
> problem, there isn't any sock_hold() in the rfcomm code, maybe is it
> missing? Nevertheless it does the sock_put() without call sock_hold().
>
> Like you I'm trying to figure out how to fix this issue, I don't know
> yet how to fix it properly. I advice to take a look on the rfcomm code
> and check if we really are missing a sock_hold() there.

Wouldn't backlogging of destructive operations (l2cap disc rsp and
req) solve these issues? All operations cannot be backlogged since
they cannot mapped to certain sock.

-- 
Ville

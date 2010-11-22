Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 15:44:51 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Get ride of
 __rfcomm_get_sock_by_channel()
Message-ID: <20101122174451.GC23109@vigoh>
References: <1290036176-4022-1-git-send-email-padovan@profusion.mobi>
 <1290036176-4022-2-git-send-email-padovan@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290036176-4022-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo F. Padovan <padovan@profusion.mobi> [2010-11-17 21:22:56 -0200]:

> rfcomm_get_sock_by_channel() was the only user of this function, so I merged
> both into rfcomm_get_sock_by_channel(). The socket lock now should be hold
> outside of rfcomm_get_sock_by_channel() once we hold and release it inside the
> same function now.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |   19 +++++++------------
>  1 files changed, 7 insertions(+), 12 deletions(-)

I'm also pushing these two to bluetooth-next. It should be good as
nobody commented on it, or people don't looked to it since there is a
clear typo and in commit messase (ride -> rid)

-- 
Gustavo F. Padovan
http://profusion.mobi

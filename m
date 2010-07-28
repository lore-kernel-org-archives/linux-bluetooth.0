Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jul 2010 04:16:31 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: Re: [PATCH] Bluetooth: Resend ConfigReq on unknown options failure
Message-ID: <20100728071631.GD22156@vigoh>
References: <20100728033225.GB22156@vigoh>
 <1280301080-565-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280301080-565-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

* Gustavo F. Padovan <gustavo@padovan.org> [2010-07-28 04:11:20 -0300]:

> From: Gustavo F. Padovan <padovan@profusion.mobi>
> 
> If the remote device send a ConfigRsp with the unknown options failure we
> should remove that option from the ConfigReq and send it again.
> This patch only remove the RFC option in the case it is a unknown option.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |   17 +++++++++--------
>  net/bluetooth/l2cap.c         |   28 ++++++++++++++++++++++++----
>  2 files changed, 33 insertions(+), 12 deletions(-)

Can you please test thi patch? I think it fix the unknown option
problem.


-- 
Gustavo F. Padovan
http://padovan.org

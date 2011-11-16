Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 15:30:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] l2test: fix not setting priority of accepted
 socket
Message-ID: <20111116133023.GA7857@x220>
References: <1321355184-24628-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321355184-24628-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Nov 15, 2011, Luiz Augusto von Dentz wrote:
> SO_PRIORITY is not inherited upon accept so it has to be set manually in
> the new socket.
> ---
>  test/l2test.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)

Both patches have been applied. Thanks.

Johan

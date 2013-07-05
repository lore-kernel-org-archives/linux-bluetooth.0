Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jul 2013 13:20:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] audio/sink: Fix not notifying service about
 connection state
Message-ID: <20130705102022.GA10620@x220.p-661hnu-f1>
References: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372939245-18040-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Jul 04, 2013, Luiz Augusto von Dentz wrote:
> btd_service_connecting_complete should be called whenever the service
> is connected otherwise the service state will not be consistent.
> ---
>  profiles/audio/sink.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Both patches have been applied. Thanks.

Johan

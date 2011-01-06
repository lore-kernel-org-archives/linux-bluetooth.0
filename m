Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Jan 2011 00:39:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] Update telephony-ofono driver
Message-ID: <20110106223920.GA9398@jh-x301>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jan 05, 2011, Luiz Augusto von Dentz wrote:
> This patches update the ofono backend so it can be used with recent
> versions of ofono (> 0.28), it can be tested by compiling bluetoothd with
> --with-telephony=ofono
> 
> Since the hfp doesn't really support multiple modems, at least not in the
> same record/connection, the driver will pick the first modem that has
> org.ofono.NetworkRegistration since that is what hfp expect as indicator.
> 
> Calls are only picked/indicated if they belong to the modem in use
> otherwise they are ignored.
> 
> Note that there is still a plan to integrate hfp inside ofono and this
> changes doesn't change anything, it basically add the possibility to use
> ofono with BlueZ 4.x since 5.x probably will change this entirely.
> 
> Luiz Augusto von Dentz (10):
>   telephony-ofono: notify alerting calls when headset connects
>   telephony-ofono: fix not being able to answer alerting/waiting calls
>   telephony-ofono: fix not setting originating when status property
>     changes
>   telephony-ofono: make use of GetModems method
>   telephony-ofono: make use of GetCalls method
>   telephony-ofono: fix not canceling pending calls on exit
>   telephony-ofono: simplify watches handling logic
>   telephony-ofono: handle ofono appearing/disappearing from bus
>   telephony-ofono: add handling for Modem.Interfaces property
>   telephony-ofono: fix not updating indicators when a call is removed
> 
>  audio/telephony-ofono.c |  916 +++++++++++++++++++++++++++++++----------------
>  1 files changed, 604 insertions(+), 312 deletions(-)

All 10 patches have been pushed upstream. Thanks.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Apr 2014 11:27:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] agent: Allow to stack default agents
Message-ID: <20140429082713.GK21742@t440s.lan>
References: <1398695235-19682-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398695235-19682-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Apr 28, 2014, Szymon Janc wrote:
> There is no API for notifying agent that it is no longer default one.
> This can lead to situation when ie. console agent (bluetoothctl) is
> set as default leaving UI agent unfunctional after bluetoothctl exited.
> 
> This patch adds stacking of default agents in case more then one agent
> requested being default.
> ---
>  src/agent.c | 47 ++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 11 deletions(-)

Besides one minor coding style issue (which I fixed) this looks good to
me and should hopefully help avoid confusion when playing around with
bluetoothctl and GUI based agents. The patch has now been applied.

Johan

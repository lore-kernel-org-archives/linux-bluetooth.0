Return-Path: <cyrus@holtmann.org>
Date: Mon, 3 Nov 2014 16:03:23 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	Jukka Taimisto <jtt@codenomicon.com>
Subject: Re: [PATCH] Bluetooth: Fix invalid response for 'Start Discovery'
 command
Message-ID: <20141103140323.GA9985@t440s.lan>
References: <1415020856-9018-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415020856-9018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Nov 03, 2014, Szymon Janc wrote:
> According to Management Interface API 'Start Discovery' command should
> generate a Command Complete event on failure. Currently kernel is
> sending Command Status on early errors. This results in userspace
> ignoring such event due to invalid size.
> 
> bluetoothd[28499]: src/adapter.c:trigger_start_discovery()
> bluetoothd[28499]: src/adapter.c:cancel_passive_scanning()
> bluetoothd[28499]: src/adapter.c:start_discovery_timeout()
> bluetoothd[28499]: src/adapter.c:start_discovery_complete() status 0x0a
> bluetoothd[28499]: Wrong size of start discovery return parameters
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> Reported-by: Jukka Taimisto <jtt@codenomicon.com>
> ---
>  net/bluetooth/mgmt.c | 56 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 35 insertions(+), 21 deletions(-)

Applied to bluetooth-next. Thanks.

Johan

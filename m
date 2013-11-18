Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Nov 2013 16:27:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] audio/AVCTP: Use A/V_RemoteControl UUID for
 incoming connections
Message-ID: <20131118142753.GA18742@x220.p-661hnu-f1>
References: <1384782134-17118-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384782134-17118-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Nov 18, 2013, Luiz Augusto von Dentz wrote:
> By the time and incoming connection arrives it is not possible to
> determine the role, so this changes the UUID to A/V_RemoteControl which
> according to assigned number page bellow is the profile UUID for AVRCP:
> 
> https://www.bluetooth.org/en-us/specification/assigned-numbers/service-discovery
> ---
>  profiles/audio/avctp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan

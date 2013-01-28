Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jan 2013 18:00:28 -0600
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/3 v3] AVRCP: Fix not handling commands while
 browsing is connecting
Message-ID: <20130128000028.GA14431@x220>
References: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359330736-9190-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Sun, Jan 27, 2013, Luiz Augusto von Dentz wrote:
> With introdution of browsing channel the .init callback is called when
> browsing channel connection completes, but in the meantime the remote
> device can send commands over control channel.
> 
> To fix this the init callaback of control and browsing channel are now
> separated into .init_control and .init_browsing so the handler can be
> register as soon the respective channel connection completes.
> ---
> v2: Separate control and browsing inits and use handler id to track if channel
> has been initialized or not.
> v3: Adds patches 2 and 3
> 
>  profiles/audio/avrcp.c | 73 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 42 insertions(+), 31 deletions(-)

All three patches have been applied. Thanks.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Oct 2011 10:50:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix calling g_io_channel_shutdown twice for a
 gateway connection
Message-ID: <20111025085015.GA3514@fusion.localdomain>
References: <1319531195-32637-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319531195-32637-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Oct 25, 2011, Luiz Augusto von Dentz wrote:
> This happens in the following circumstance:
> 
> bluetoothd[30869]: audio/manager.c:hf_io_cb() Authorization denied!
> 
> (bluetoothd:30869): GLib-WARNING **: Invalid file descriptor.
> 
> Reported by Daniel Wagner <wagi@monom.org>
> ---
>  audio/manager.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)

Applied. Thanks.

Johan

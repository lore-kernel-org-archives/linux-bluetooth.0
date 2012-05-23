Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 May 2012 17:29:08 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/5] AVRCP: Add support for sending
 SetAbsoluteVolume
Message-ID: <20120523142908.GC19662@x220.P-661HNU-F1>
References: <1337695255-9197-1-git-send-email-luiz.dentz@gmail.com>
 <1337695255-9197-3-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337695255-9197-3-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, May 22, 2012, Luiz Augusto von Dentz wrote:
>  int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
>  
> +
>  size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);

Looks like you've got an extra empty line above.

Johan

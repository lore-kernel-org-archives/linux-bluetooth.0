Return-Path: <cyrus@holtmann.org>
Message-ID: <1324583293.1965.224.camel@aeonflux>
Subject: Re: [PATCH 12/12] Bluetooth: Don't disable interruptions on RFCOMM
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 22 Dec 2011 11:48:13 -0800
In-Reply-To: <1324580173-24957-12-git-send-email-padovan@profusion.mobi>
References: <1324580173-24957-1-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-2-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-3-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-4-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-5-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-6-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-7-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-8-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-9-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-10-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-11-git-send-email-padovan@profusion.mobi>
	 <1324580173-24957-12-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> As everything is now process context, disable interruptions is now
> pointless.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  net/bluetooth/rfcomm/sock.c |   12 ++++++------
>  net/bluetooth/rfcomm/tty.c  |   16 ++++++++--------
>  2 files changed, 14 insertions(+), 14 deletions(-)

are you sure here? Have you considered TTY callers?

Regards

Marcel



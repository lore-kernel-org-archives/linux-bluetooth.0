Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Mar 2013 17:21:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/5 v2] AVRCP: Fix reading wrong field as folder
 depth
Message-ID: <20130307152111.GA2409@x220>
References: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 07, 2013, Luiz Augusto von Dentz wrote:
> Folder depth is bit 10 of the parameters not the PDU operands
> ---
> v2: Make use of MIN macro to check player name length and fix zero length
> check for folder.
> 
>  profiles/audio/avrcp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch set has been applied. Thanks.

Johan

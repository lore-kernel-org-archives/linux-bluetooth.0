Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 May 2012 22:46:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/6] AVRCP: Fix initializing volume before checking
 PDU type
Message-ID: <20120527194610.GD31160@x220.P-661HNU-F1>
References: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337958168-9875-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, May 25, 2012, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Response may be rejected or not implemented so the operand used to
> initialize the variable may not even exist.
> ---
>  audio/avrcp.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

All of these patches except 2/6 (since Lucas had some feedback on it)
have been applied. Thanks.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jun 2011 16:07:52 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Bluetooth: Refactor hci_auth_complete_evt function
Message-ID: <20110601190752.GC2564@joana>
References: <1306849766-31540-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1306849766-31540-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306849766-31540-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-05-31 15:49:26 +0200]:

> Replace if(conn) with if(!conn) checking to avoid too many nested statements
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  net/bluetooth/hci_event.c |   83 ++++++++++++++++++++++-----------------------
>  1 files changed, 41 insertions(+), 42 deletions(-)

I applied both patches, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi

Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Apr 2011 15:34:45 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 7/7] Bluetooth: Add secure flag for mgmt_pin_code_req
Message-ID: <20110428183445.GB2302@joana>
References: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1303985279-3944-8-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303985279-3944-8-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

* Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> [2011-04-28 12:07:59 +0200]:

> Extend the mgmt_pin_code_request interface to require secure
> pin code (16 digit) for authentication.
> 
> This is a kernel part of the secure pin code requirement notification
> to user space agent.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  include/net/bluetooth/mgmt.h     |    1 +
>  net/bluetooth/hci_event.c        |    9 +++++++--
>  net/bluetooth/mgmt.c             |    3 ++-
>  4 files changed, 11 insertions(+), 4 deletions(-)

All patches but 5/7 were applied. thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi

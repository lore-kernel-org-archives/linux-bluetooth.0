Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Aug 2010 16:15:54 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Scherba <dscherba@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	rshaffer@codeaurora.org
Subject: Re: [PATCH 1/1] Use HCI device type to gate BR/EDR-specific HCI
 commands
Message-ID: <20100810201554.GA5080@jh-x301>
References: <20100810191616.GA26091@jh-x301>
 <1281469904-30408-1-git-send-email-dscherba@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1281469904-30408-1-git-send-email-dscherba@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Tue, Aug 10, 2010, David Scherba wrote:
> Use the hci_dev_info structure member 'type' to classify whether a HCI device
> is BR/EDR, or not.  If not, gate BR/EDR-specific HCI commands.
> ---
>  plugins/hciops.c |   20 +++++++++++++-------
>  src/adapter.c    |    2 +-
>  src/hcid.h       |    8 ++++++++
>  src/security.c   |    4 ++--
>  4 files changed, 24 insertions(+), 10 deletions(-)

Thanks. This one is now also pushed upstream.

Johan

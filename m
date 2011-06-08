Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Jun 2011 10:05:46 +0900
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Add support of secure pin code in mgmt code
Message-ID: <20110608010546.GB7145@dell.ccr.corp.intel.com>
References: <1307021861-20219-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307021861-20219-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Jun 02, 2011, Waldemar Rymarkiewicz wrote:
> Use secure pin code parameter received from the kernel in
> MGMT_EV_PIN_CODE_REQUEST event and propagate this to agent
> code.
> 
> Secure flag is specific for the pin code request only.
> ---
>  plugins/hciops.c  |    2 +-
>  plugins/mgmtops.c |    2 +-
>  src/agent.c       |   11 +++++++----
>  src/agent.h       |    4 ++--
>  src/device.c      |    4 ++--
>  src/device.h      |    2 +-
>  src/event.c       |   14 +++++++-------
>  src/event.h       |    2 +-
>  8 files changed, 22 insertions(+), 19 deletions(-)

Applied. Thanks.

Johan

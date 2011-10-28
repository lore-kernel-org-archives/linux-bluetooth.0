Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Oct 2011 14:17:21 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 bluez 0/2] Add BT 3.0+HS definitions
Message-ID: <20111028111713.GA13435@aemeltch-MOBL1>
References: <1319761719-16363-1-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319761719-16363-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 27, 2011 at 05:28:37PM -0700, Peter Krystad wrote:
> This patchset adds BT 3.0+HS signalling definitions
> 
> v2 - Use A2MP/a2mp nomenclature
> 
> Peter Krystad (2):
>   Add L2CAP Create/Move Channel definitions
>   Add A2MP definitions
> 
>  lib/a2mp.h  |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/l2cap.h |   44 +++++++++++++++++++
>  2 files changed, 177 insertions(+), 0 deletions(-)
>  create mode 100644 lib/a2mp.h

ack (taking that typedef is a bluez standard way)

Best regards 
Andrei Emeltchenko 


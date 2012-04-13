Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Apr 2012 12:14:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: hci_persistent_key should return bool
Message-ID: <20120413091418.GB10608@x220.ger.corp.intel.com>
References: <1334307675-2983-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334307675-2983-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Fri, Apr 13, 2012, Vishal Agarwal wrote:
> This patch changes the return type of function hci_persistent_key
> from int to bool.
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |   21 +++++++++++----------
>  net/bluetooth/mgmt.c             |    2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)

I'd improve the commit message a bit. First there should be an empty
line before the Signed-off-by. Secondly it's generally considered good
practice to answer the question "why?" in the commit message. I.e. you
could mention that it makes more sense/is more natural to use bool for
this variable.

Johan

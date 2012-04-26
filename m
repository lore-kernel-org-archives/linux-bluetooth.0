Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 17:05:32 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vishal Agarwal <vishal.agarwal@stericsson.com>
Cc: linux-bluetooth@vger.kernel.org, naresh.gupta@stericsson.com
Subject: Re: [PATCH] Bluetooth: Non significant part should be removed from
 EIR data
Message-ID: <20120426140532.GA6986@x220.P-661HNU-F1>
References: <1335448196-16093-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335448196-16093-1-git-send-email-vishal.agarwal@stericsson.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

On Thu, Apr 26, 2012, Vishal Agarwal wrote:
> Fix to remove non significant part(Padding zeros) of EIR data.
> Mgmt interface expects to receive only the significant part so
> it should be removed from the EIR data.
> 
> Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
> ---
>  include/net/bluetooth/hci_core.h |   17 +++++++++++++++++
>  net/bluetooth/hci_event.c        |    4 +++-
>  2 files changed, 20 insertions(+), 1 deletions(-)

I fixed up the commit message a bit more and then applied the patch to
bluetooth.git as well as bluetooth-next.git. Thanks!

Johan

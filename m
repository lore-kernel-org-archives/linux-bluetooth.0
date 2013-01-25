Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2013 09:50:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools: Fix glib assert in mgmt-tester if hci_vhci module
 is not loaded
Message-ID: <20130125075010.GB27699@x220>
References: <1358799954-6140-1-git-send-email-szymon@janc.net.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358799954-6140-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jan 21, 2013, Szymon Janc wrote:
> Print descriptive warning on HCI emulation setup failure and fail test
> gracefully. This is better comparing to glib assertion when not fully
> initialized HCI emulation is being unreferenced.
> ---
>  src/shared/hciemu.c | 31 ++++++++++++++++++++++---------
>  tools/mgmt-tester.c |  4 ++++
>  2 files changed, 26 insertions(+), 9 deletions(-)

Applied. Thanks.

Johan

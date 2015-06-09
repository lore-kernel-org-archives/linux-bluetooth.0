Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2] bluetooth: hci_bcsp: Clean up code Fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150609115144.GA19399@ubuntu>
Date: Tue, 9 Jun 2015 14:00:21 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <9A872E3A-B2EC-4E46-8115-477109A5AE87@holtmann.org>
References: <20150609115144.GA19399@ubuntu>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> From: Prasanna Karthik <mkarthi3@visteon.com>
> 
> Fix for spaces prohibited around that '->' reported by checkpatch and space prohibited
> between function name and open parenthesis '('
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> 
> ---
> V3: Reverted back Indentation,Now patch only has above fix, cleanedup
> ---
> ---
> drivers/bluetooth/hci_bcsp.c |   16 ++++++++--------
> 1 files changed, 8 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


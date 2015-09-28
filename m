Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCHv2] Bluetooth:hci_qca: Changed unsigned long to bool
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150928080319.GA3521@jci-VirtualBox>
Date: Mon, 28 Sep 2015 13:07:20 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"ext.szymon.janc@tieto.com" <ext.szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <38206047-FA6E-4F22-A07B-D1630661C218@holtmann.org>
References: <20150928080319.GA3521@jci-VirtualBox>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> 'retransmit' being set in HCI_IBS_TX_WAKING case, using bool would be
> efficient. Initialize local bool to false.
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
> drivers/bluetooth/hci_qca.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


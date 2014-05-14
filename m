Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Bluetooth: Fix L2CAP LE debugfs entries permissions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140514155335.GR4157@zurbaran>
Date: Wed, 14 May 2014 09:07:38 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <0BF32727-60D1-4539-B98A-B06F03FA57EA@holtmann.org>
References: <20140514155335.GR4157@zurbaran>
To: Samuel Ortiz <sameo@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Samuel,

> 0466 was probably meant to be 0644, there's no reason why everyone
> except root could write there.
> 
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
> net/bluetooth/l2cap_core.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth tree.

Gustavo, please make a pull request for 3.15 for this one. This is a security issue that we should address as quickly as possible.

Regards

Marcel


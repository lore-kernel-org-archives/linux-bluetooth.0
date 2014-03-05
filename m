Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for virtual HCI driver"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
Date: Wed, 5 Mar 2014 08:46:26 -0800
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7E804DF3-E191-427E-8E20-FE6ECDC490EA@holtmann.org>
References: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
To: =?iso-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> Adding the devname:vhci alias and thus adding a static /dev/vhci device node
> only works when assigning a fixed major/minor number. However, the code
> currently uses a dynamically assigned minor number. It is therefore impossible
> to create a static device and to autoload the module when accessing it.
> 
> Reverting this fixes the kmod error message
> depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and minor information. Ignoring.
> 
> This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.

NAK. We allocated a static minor for this.

Regards

Marcel


Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 1/3] Bluetooth: btmrvl: add DT bindings documentation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
Date: Wed, 19 Nov 2014 23:23:52 +0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Cathy Luo <cluo@marvell.com>,
	Avinash Patil <patila@marvell.com>
Message-Id: <9D22FD29-7291-4A1B-A20F-FFF42387970A@holtmann.org>
References: <1416389314-6327-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> Calibration data can be downloaded through device tree method. This
> patch adds the documentation. Also, instead of searching device tree
> node by name using of_find_node_by_name() API, let's use
> for_each_compatible_node().
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Avinash Patil <patila@marvell.com>
> ---
> Documentation/devicetree/bindings/btmrvl.txt | 22 ++++++++++++++++++++
> drivers/bluetooth/btmrvl_main.c              | 31 +++++++++++++---------------
> 2 files changed, 36 insertions(+), 17 deletions(-)
> create mode 100644 Documentation/devicetree/bindings/btmrvl.txt

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel


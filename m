Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Print error when dropping L2CAP data
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392752914-15392-1-git-send-email-szymon.janc@gmail.com>
Date: Tue, 18 Feb 2014 12:12:23 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <4A836E74-338A-46F3-AD56-F8BCD45E1E69@holtmann.org>
References: <1392752914-15392-1-git-send-email-szymon.janc@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Silently dropping L2CAP data (i.e. due to remote device not obeying
> negotiated MTU) is confusing and makes debugging harder.
> 
> Signed-off-by: Szymon Janc <szymon.janc@gmail.com>
> ---
> 
> I also wonder if kernel shouldn't just disconnect if data would be
> dropped. This is reliable connection after all...
> 
> net/bluetooth/l2cap_core.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel


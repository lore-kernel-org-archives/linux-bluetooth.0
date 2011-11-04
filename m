Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: make L2CAP sockets to inherit parent's
 priority
From: Marcel Holtmann <marcel@holtmann.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 04 Nov 2011 22:06:35 +0100
In-Reply-To: <1320415430-2054-1-git-send-email-luiz.dentz@gmail.com>
References: <1320415430-2054-1-git-send-email-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320440796.15441.299.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes priority set on a listen socket to be passed when accepting
> new connections.

I am in general fine with this, but is this the expected behavior of
SO_PRIORITY from other socket types?

Regards

Marcel



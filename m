Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Oct 2012 15:04:17 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH] Bluetooth: Rename __l2cap_connect() to l2cap_connect()
Message-ID: <20121012120416.GD28051@aemeltch-MOBL1>
References: <1350042040-1908-1-git-send-email-gustavo@padovan.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350042040-1908-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Oct 12, 2012 at 07:40:40PM +0800, Gustavo Padovan wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> 
> Use of "__" usually means we need to call the function with a lock held,
> which is not the case here.

I think it is OK to leave the function as is. We do not have such a strong
convention and we have too many locks anyway.

Best regards 
Andrei Emeltchenko 


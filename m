Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jan 2010 10:28:06 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	luiz.dentz-von@nokia.com,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluetoothd bug
Message-ID: <20100127082806.GA778@jh-x301>
References: <f9d4bd31001251014w1caaa753v39254c3031f5db0e@mail.gmail.com>
 <2d5a2c101001260309h4464805eg3e52ace6dd28f677@mail.gmail.com>
 <f9d4bd31001261033g2d23a089r21069797fea38d9b@mail.gmail.com>
 <2d5a2c101001270021m54f3e905rfeac8c2b8bc8156f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101001270021m54f3e905rfeac8c2b8bc8156f@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Jan 27, 2010, Luiz Augusto von Dentz wrote:
> From be0c1373499bbc480298429109124efbbe49f15a Mon Sep 17 00:00:00 2001
> From: Luiz Augusto Von Dentz <luiz.dentz-von@nokia.com>
> Date: Tue, 26 Jan 2010 16:17:21 +0200
> Subject: [PATCH 1/6] Fix possible invalid read when removing a temporary device
> 
> An invalid read may happens when doing the reverse service discovery but
> for some reason the device disconnects with the temporary flag set which
> will make the device to be removed without cancelling the service.
> ---
>  src/device.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

The patch has been pushed upstream. Thanks for the fix!

Johan

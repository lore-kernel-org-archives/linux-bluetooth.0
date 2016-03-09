Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGPBv4YJwMEMVSeJQmy5fwzgd6ANpwBUXeZeiv2Pox865Q@mail.gmail.com>
References: <CAEZxfGPBv4YJwMEMVSeJQmy5fwzgd6ANpwBUXeZeiv2Pox865Q@mail.gmail.com>
Date: Wed, 9 Mar 2016 22:47:52 +0200
Message-ID: <CABBYNZ+uYqOi7uYNGL6tJkJ5D2Cz=cOxCN5QbpLx1+Z7gC2Jxg@mail.gmail.com>
Subject: Re: Feature Request: Clean the cache upon device disconnection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?Q?Giovanni_Ortu=C3=B1o?= <ortuno@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi François,

On Wed, Mar 9, 2016 at 6:42 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> As we've discovered recently
> (https://github.com/thegecko/web-bluetooth-dfu/issues/12#issuecomment-194348474),
> it looks like BlueZ trunk doesn't clean/update its cache upon device
> disconnection.
>
> Is this on purpose?
> If not, can it be fixed?

I actually need more info, we do check if the cache is valid on every
reconnection, can someone provide the HCI trace of the issue perhaps
it is not using the fixes for the cache that have been merged
upstream.


-- 
Luiz Augusto von Dentz

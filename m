Return-Path: <hadess@hadess.net>
Message-ID: <1507218031.23708.46.camel@hadess.net>
Subject: Re: [PATCH 2/2] hostname: Fix "BlueZ 5.XX" adapter name on startup
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann
	 <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 05 Oct 2017 17:40:31 +0200
In-Reply-To: <1506085983.9350.33.camel@hadess.net>
References: <20170920125445.24792-1-hadess@hadess.net>
	 <20170920125445.24792-2-hadess@hadess.net>
	 <0268513E-AD33-4E4E-A926-2EC695DC1D86@holtmann.org>
	 <1505925333.9350.7.camel@hadess.net>
	 <6DC51AD5-E9D5-4874-AAA8-38A4BF7C1668@holtmann.org>
	 <CABBYNZLeNiw_5A_mBbLm6Uq2B-8+KEhuMKAsVerSAKeS3WbE+g@mail.gmail.com>
	 <1506085983.9350.33.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2017-09-22 at 15:13 +0200, Bastien Nocera wrote:
<snip>
> ef024c2c44b4f0dab3c054d062a911cacef1fdc9 is the first bad commit
> commit ef024c2c44b4f0dab3c054d062a911cacef1fdc9
> Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Date:   Fri Aug 11 15:39:15 2017 +0300
> 
>     gdbus: Fix calling GetAll while GetManagedObjects is pending
>     
>     If proxies are created while the client is not ready put them
> into a
>     pending list so only if they are not found in GetManagedObject
> reply
>     call GetAll.

Any updates on this?

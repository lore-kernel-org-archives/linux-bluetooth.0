Return-Path: <cyrus@holtmann.org>
Message-ID: <4A1CD504.9090202@hartkopp.net>
Date: Wed, 27 May 2009 07:52:04 +0200
From: Oliver Hartkopp <oliver@hartkopp.net>
MIME-Version: 1.0
To: Dave Young <hidave.darkstar@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Re: possible recursive locking in 2.6.30-rc6
References: <4A1A9D1D.2050301@hartkopp.net> <4A1AF7B0.4020701@hartkopp.net>	 <4A1BA619.4040401@hartkopp.net> <a8e1da0905261813i3577af33g101336259a51c03c@mail.gmail.com>
In-Reply-To: <a8e1da0905261813i3577af33g101336259a51c03c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Dave Young wrote:

> 
> Hi oliver
> 
> Could you try the attached patch and report your result?
> 

Hi Dave,

that fixed the problem!

BT DUN is working properly again. Many thanks!

Tested-by: Oliver Hartkopp <oliver@hartkopp.net>

Best regards,
Oliver

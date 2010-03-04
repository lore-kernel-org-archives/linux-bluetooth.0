Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Mar 2010 16:25:59 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix using invalid data from previous headset connection
Message-ID: <20100304202559.GA9944@jh-x301>
References: <2d5a2c101003021309o34b63249ub5940f67112eab6a@mail.gmail.com>
 <20100303033233.GA20411@jh-x301>
 <2d5a2c101003030025v40b2ca4ma985e5a544d7e707@mail.gmail.com>
 <20100304035014.GA26956@jh-x301>
 <2d5a2c101003040032g70434725ne3ad56042a080ed9@mail.gmail.com>
 <2d5a2c101003040629m39a89b32he5112bcf6e0d2047@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2d5a2c101003040629m39a89b32he5112bcf6e0d2047@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 04, 2010, Luiz Augusto von Dentz wrote:
> Attached is a new version no using slc instead of session,

Thanks. The patch is now pushed upstream.

> so far no problem with any telephony driver.

Ok, good. I think that we're protected by this thanks to the
"if (!active_devices)" check in most telephony*_ind functions.

Johan

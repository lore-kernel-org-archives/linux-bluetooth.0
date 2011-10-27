Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
Date: Thu, 27 Oct 2011 09:32:51 -0400
Message-ID: <CAJdJm_OkqgC=F3rkBixhpRzkB+8viHQATBRAJJfoQ6ppd2ZWVw@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Wed, Oct 26, 2011 at 3:20 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> +               int WriteValue(array{byte} value, int method)

I think you meant "uint8" as return value, which corresponds to the
ATT error code type.

> +
> +                   Write the value of the characteristic, with specified method :
> +                   0: Write without response. Always return 0.
> +                   1: Write with response. Return server response code.
> +                   Other write methods will be added in the future.
> +

Besides what others suggested, I would avoid using integers as
enumerations on D-Bus API, specially if the actual values are not
defined by any specification. If you take a look at other API docs in
doc/* you may see examples where string are used. IMHO this make the
client code much more readable and does not require looking at the API
doc all the time. Example:

###
uint8 WriteValue(array{byte} value, string method)

Write the value of the characteristic, with specified method:
"WithoutResponse" or "WithResponse". Other write methods may be added
in the future.
###

An alternative is to use dict, if multiple "flags" are allowed.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

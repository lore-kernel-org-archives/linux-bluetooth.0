Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5457A17D.9060404@LilandIT.com>
References: <5457A17D.9060404@LilandIT.com>
Date: Mon, 3 Nov 2014 11:32:42 -0800
Message-ID: <CAHrH25RfMAiNTHYBR=vT+KuBtVwEKPuLRFfEiMGF9Ya__9Y5nA@mail.gmail.com>
Subject: Re: How to get started on a GATT Server ?
From: Arman Uguray <armansito@chromium.org>
To: "Urbani, Edmund" <edmund.urbani@lilandit.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edmund,

> On Mon, Nov 3, 2014 at 7:38 AM, Urbani, Edmund <edmund.urbani@lilandit.com> wrote:
> Hello all,
>
> I am trying to write a simple GATT-based service of my own. Right now I
> don't really know which docs I should be looking at. I have skimmed through
> bluez sources (5.23) and found gatt-service.h and gatt.h, as well as the
> gatt-example plugin.
>
> So far I am still trying to figure out whether I should be going the C API
> route or maybe use the D-Bus interface. Also gatt-service.c seems to suggest
> that there is a way to register a GATT service over D-Bus but running it
> gives me this:
> RegisterService: Method "RegisterService" with signature "oa{sv}" on
> interface "org.bluez.GattManager1" doesn't exist"

The reason you're not seeing GattManager1 is because it's hidden
behind the "experimental" flag. So you need to configure and run bluez
with the --enable-experimental and the --experimental flags
respectively.

That said, that API implementation isn't complete and isn't in fact
even wired up with the internal attrib-server. We're working towards
rewriting all of the C API and finally implementing the proposed D-Bus
API but until then, I would ignore doc/gatt-api.txt (it's only a
proposal at the moment and isn't even included in release tarballs).
So for now you have to use the C API route. There will probably be an
announcement once that D-Bus API is finally supported.

>
> Any pointers to help me get started would be appreciated. Thanks!
>
> Kind regards,
>   Edmund
>
> --
>
> Mit freundlichen Grüßen
> Edmund Urbani
> Liland IT Team
>
> Email: Edmund.Urbani@Lilandit.com <mailto:Edmund.Urbani@lilandit.com>
>
> Liland IT GmbH ...does IT better
> Tel: +43 463 220111
> Fax: +43 463 220111-33
> Tel(GER): +49 221 65028588
>
> Find us at Facebook http://facebook.com/Lilandit
> http://green-badges.com
> http://iventcloud.com
> http://Lilandit.com
>
> <http://www.LilandIT.com> <http://www.LilandIT.com>
>
> Copyright © 2014, Liland IT GmbH
>
> Diese Mail enthaelt vertrauliche und/oder rechtlich geschuetzte
> Informationen.
> Wenn Sie nicht der richtige Adressat sind oder diese Email irrtuemlich
> erhalten haben, informieren Sie bitte sofort den Absender und vernichten Sie
> diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser
> Mail ist nicht gestattet.
>
> This email may contain confidential and/or privileged information.
> If you are not the intended recipient (or have received this email in error)
> please notify the sender immediately and destroy this email. Any
> unauthorised copying, disclosure or distribution of the material in this
> email is strictly forbidden.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Cheers,
Arman

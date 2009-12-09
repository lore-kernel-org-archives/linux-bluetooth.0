Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <453936.71245.qm@web52604.mail.re2.yahoo.com>
References: <453936.71245.qm@web52604.mail.re2.yahoo.com>
Date: Wed, 9 Dec 2009 14:53:28 +0530
Message-ID: <e378cfb20912090123m51645679n3e410d6208c6f51e@mail.gmail.com>
Subject: Re: How to force a fix pin
From: Nel D <newatlinux@gmail.com>
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi ,


On Wed, Dec 9, 2009 at 3:45 AM, Ed Tsang <netdesign_98@yahoo.com> wrote:
> Hi, My application scan for devices, send file to it. But some device (blackberry) will request a pin. With the bluetoothd 4.51. bluetooth-applet will pop up and enter a pin. If de-install it, the bluetoothd will complain "No agent available for 0 request (pin_code_request?).". And the remote device failed to pair with a "default pin 0000".
> Is there a way to force a default pin "0000".  look like /etc/bluetooth/pin is history.  Is there a simply work around.
>
> Net Des
>

Do you have the sources of 4.51 ? . I remember a command line utility
named simple-agent in test folder ( the location might have changed)
which i had used to pair.

Hope this helps.

Thanks,
 Nel


>
>
>      __________________________________________________________________
> Get a sneak peak at messages with a handy reading pane with All new Yahoo! Mail: http://ca.promos.yahoo.com/newmail/overview2/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

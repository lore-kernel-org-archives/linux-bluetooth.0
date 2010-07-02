Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7.0.1.0.2.20100701152541.031ae7c0@gmx.net>
References: <7.0.1.0.2.20100701152541.031ae7c0@gmx.net>
Date: Fri, 2 Jul 2010 10:56:22 -0300
Message-ID: <AANLkTik1haoPxJzpRsQ2FPFhOjYCcOqYVtug9eQVNIkc@mail.gmail.com>
Subject: Re: Bug with Alias
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

On Thu, Jul 1, 2010 at 10:33 AM, Peter Kornatowski <pkorn@gmx.net> wrote:
> Hello,
>
> I have several headsets of the same model, so I set an Alias for each to
> distinguish them in my own application. But since bluez 4.64 the Alias is
> bugged. Sometimes after a reboot or after a bluez restart when i read out
> the Alias through the dbus api, I get the Name instead. I also tried to read
> it with d-feet or through a dbus-send call (dbus-send --system --print-reply
> --dest=org.bluez /org/bluez/11344/hci0/dev_00_XX_XX_XX_XX_XX
> org.bluez.Device.GetProperties) and also got the Name instead of the Alias.
> But in the aliases file under /var/lib/bluetooth/XX:XX:XX:XX:XX:XX/aliases
> is the correct Alias. The bug seems to have something to do with the commit
> 48a2c31cdbc1f2ac2a2bbadbd505976f84a9eaca
> (http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=48a2c31cdbc1f2ac2a2bbadbd505976f84a9eaca).

Thanks for the bug report.

I suggested a fix[1], waiting for review.

> I hope someone can resolve this issue.
>
> Thanks,
> Peter
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


Cheers,
-- 
Vinicius

[1] http://git.infradead.org/users/vcgomes/bluez.git/commitdiff/d574f1d79edb8be697730e0d1a6bb3534190a6a3

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAE6HaMnFF7ym+FCWpVHCi=7=OJZeaS+uiF_qQDKHgpbzLUUu_w@mail.gmail.com>
References: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com>
	<CAE6HaMnFF7ym+FCWpVHCi=7=OJZeaS+uiF_qQDKHgpbzLUUu_w@mail.gmail.com>
Date: Wed, 22 May 2013 00:55:41 -0300
Message-ID: <CAE6HaMmUL2Dn6H0iBzh6Wrk+DzOzDUHa8fUNGDt6psAc6=JAUw@mail.gmail.com>
Subject: Fwd: [BUG] Set Powered=true doesn't power up the adapter
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

[forgot to add linux-bluetooth]

On Mon, May 20, 2013 at 11:07 PM, Alex Deymo <deymo@chromium.org> wrote:
> Hello,
>
> I'm seeing a problem while trying to power on the adapter once in a
> while just after reboot. What happens is that sending a dbus call to
> power on the adapter doesn't return. You can read a more detailed
> description of the bug here [1] but the resume is as follows:
>
> Sending org.freedesktop.DBus.Properties.Set for power up the adapter
> doesn't return (dbus timeouts after a while) just after reboot. Is a
> very rare bug, but happens from time to time. Restarting bluetoothd
> with -n -d to get the logs made it start returning with the error
> org.bluez.Error.Failed to the same call. I don't see any HCI command
> with btmon while doing this, so I think it's not a firmware issue at
> that point (could be some other thing before). From this state, I can
> call Set several times to power up the adapter, but doesn't work.
> What is interesting is that if instead of sending MGMT_OP_SET_POWERED
> from bluetoothd, we try to power up the adapter with hciconfig
> (calling ioctl(ctl, HCIDEVUP, hdev) ) the adapter goes up and
> everything works fine from there. We are running kernel 3.8, I don't
> know if this was already reported in a newer version.
>

I can consistently reproduce it:

1. run bluetoothd
2. rfkill block all
3. test-adapter powered on

(current bluetooth-next)

I only got things to work again after a hciconfig up, which makes me
think that the "rfkill block" confuses the kernel (probably) about the
state of the controller.

It is getting late here, I hope this helps, I will try to investigate
it better tomorrow.

> Hope it helps, I'll try to have more debugging information... but it
> would be useful it someone can tell me where to look at, since this is
> not very easy to reproduce.
> Best regards,
> Alex.
>
> [1] https://code.google.com/p/chromium/issues/detail?id=239896#c11
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius

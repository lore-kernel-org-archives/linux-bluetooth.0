Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 May 2013 14:22:13 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [BUG] Set Powered=true doesn't power up the adapter
Message-ID: <20130522172213.GA12160@samus.indt.org>
References: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com>
 <CAE6HaMnFF7ym+FCWpVHCi=7=OJZeaS+uiF_qQDKHgpbzLUUu_w@mail.gmail.com>
 <CAE6HaMmUL2Dn6H0iBzh6Wrk+DzOzDUHa8fUNGDt6psAc6=JAUw@mail.gmail.com>
 <61DC8CEB-C49A-466F-B5E3-F5B60D398157@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <61DC8CEB-C49A-466F-B5E3-F5B60D398157@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 08:47 Wed 22 May, Marcel Holtmann wrote:
> Hi Vinicius,
> 
> >> I'm seeing a problem while trying to power on the adapter once in a
> >> while just after reboot. What happens is that sending a dbus call to
> >> power on the adapter doesn't return. You can read a more detailed
> >> description of the bug here [1] but the resume is as follows:
> >> 
> >> Sending org.freedesktop.DBus.Properties.Set for power up the adapter
> >> doesn't return (dbus timeouts after a while) just after reboot. Is a
> >> very rare bug, but happens from time to time. Restarting bluetoothd
> >> with -n -d to get the logs made it start returning with the error
> >> org.bluez.Error.Failed to the same call. I don't see any HCI command
> >> with btmon while doing this, so I think it's not a firmware issue at
> >> that point (could be some other thing before). From this state, I can
> >> call Set several times to power up the adapter, but doesn't work.
> >> What is interesting is that if instead of sending MGMT_OP_SET_POWERED
> >> from bluetoothd, we try to power up the adapter with hciconfig
> >> (calling ioctl(ctl, HCIDEVUP, hdev) ) the adapter goes up and
> >> everything works fine from there. We are running kernel 3.8, I don't
> >> know if this was already reported in a newer version.
> >> 
> > 
> > I can consistently reproduce it:
> > 
> > 1. run bluetoothd
> > 2. rfkill block all
> > 3. test-adapter powered on
> > 
> > (current bluetooth-next)
> > 
> > I only got things to work again after a hciconfig up, which makes me
> > think that the "rfkill block" confuses the kernel (probably) about the
> > state of the controller.
> 
> what rfkill block does is to bring the controller down and actually refuse to bring it back up until rfkill unblock happens. If we can bring the controller up via mgmt, then we have a bug.

Seems that we have just one bug, when the controller is rfkill blocked, mgmt
Set Powered (for example) doesn't return (no Command Complete, no Command
Status).

If I send any Set Powered command after the controller is unblocked, while
there's still one pending command in the queue, this command will fail, and I
won't be able to bring the controller up, unless I force a HCI_RESET command.

So it seems that we need a way to mark an hdev as rfkill blocked.

Does anyone else have any other ideas?

> 
> Regards
> 
> Marcel
> 


Cheers,
-- 
Vinicius

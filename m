Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [BUG] Set Powered=true doesn't power up the adapter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGd9gwjYNvHLA3Ot7QXAEeMaTcYw2Ba-X1E_+240Q+a06QgbXw@mail.gmail.com>
Date: Thu, 30 May 2013 11:04:02 +0900
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <D6D827A2-BC49-4108-A085-5CDA20DFFC87@holtmann.org>
References: <CAGd9gwhNgRhgqzhxxZNyD-o=j4ksTXvFFhTQMawt4bv0b2VPcQ@mail.gmail.com> <CAE6HaMnFF7ym+FCWpVHCi=7=OJZeaS+uiF_qQDKHgpbzLUUu_w@mail.gmail.com> <CAE6HaMmUL2Dn6H0iBzh6Wrk+DzOzDUHa8fUNGDt6psAc6=JAUw@mail.gmail.com> <61DC8CEB-C49A-466F-B5E3-F5B60D398157@holtmann.org> <20130522172213.GA12160@samus.indt.org> <1E509939-3804-43E0-A047-09CCD38A4713@holtmann.org> <20130528071306.GA31172@x220> <CAGd9gwjYNvHLA3Ot7QXAEeMaTcYw2Ba-X1E_+240Q+a06QgbXw@mail.gmail.com>
To: Alex Deymo <deymo@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>> In case hci_dev_open() fails and rfkill would be one example for that,
>>> we do not return an error back to the mgmt command that originates
>>> this power on.
>>> 
>>> Of course there is the initial adapter power on and there is the mgmt
>>> triggered power on. And my guess is that these two are racing against
>>> each other.
>> 
>> It seems you're right about the cause. I just sent a patch to fix it.
> 
> I saw the patch about return an error back to the userspace, but still
> there is something weird here:
> I think I omit an important detail on my first email (ups =D.. but it
> was on our linked bug). After reboot, a power up initiated using the
> mgmt interface from the bluetoothd will not return, but the previously
> connected devices do work. So the adapter is connected to, for
> example, a mouse, and after reboot the adapter will be shown as
> Powered: False, Set Powered doesn't return, but you can happily move
> the bt mouse and it works.
> 
> Do you think that the patch about rfkill ( [PATCH] Bluetooth: Fix mgmt
> handling of power on failures ) should be enough to fix this issue?
> I'm still trying to reproduce the problem with dynamic debug enabled
> for bluetooth and launching bluetoothd with MGMT_DEBUG. The machine
> keeps rebooting until it faces the problem again... but no luck so far
> =(
> 

so hci_dev_open() can return more than just ERFKILL. It can also return EALREADY and other error. So this patch can indeed fix your issue as well. It is just rfkilled devices can reproduce this behavior pretty easily.

What I am thinking you are hitting is a race between the automatic power on (which goes through the same function) and the management power on. We might have a larger issue with a race condition hitting here, but the missing handling of the error is clearly one. There is the hci_req lock serializing the auto power-on and mgmt and so this should not happen, but we might have a bug somewhere else as well.

We might need a bit better instrumentation on being able to debug this. I mentioned this in some threads before, that we might want to have actually proper tracing support. Similar to what mac80211 does. Hint hint ;)

Johan, we might need to check if other errors need to be reported differently and EALREADY handled more gracefully during init of an adapter.

Regards

Marcel


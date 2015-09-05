Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACjvaw=OrVRqQG37j6gh7Pap7sksqonNhauBrHxTK720T-Uk-g@mail.gmail.com>
References: <CACjvaw=OrVRqQG37j6gh7Pap7sksqonNhauBrHxTK720T-Uk-g@mail.gmail.com>
Date: Sat, 5 Sep 2015 09:42:45 -0500
Message-ID: <CABKPALpzinm=rB-Ex7iNODNY0_-nGMUXPsS7QhJtsjBTktBTVw@mail.gmail.com>
Subject: Re: DBus WriteValue is failing for bluez 5.31 with kernel 4.1+
From: Neil Martin <neil@vnp.com>
To: Nazmul Alam <fadedreamz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Nazmul,

On Fri, Sep 4, 2015 at 7:05 AM, Nazmul Alam <fadedreamz@gmail.com> wrote:
> Hello,
> I am unable to write to atrribute value to a characteristics exposed
> via dbus on the new 4.1 kernel.
>
> Before upgrading to kernel 4.1 the same application can write
> attribute value to the characteristics via dbus without any issue.
>
> Following is the log collected from bluetoothd -
>
> org.freedesktop.DBus.Error.AccessDenied: Rejected send message, 1
> matched rules; type="method_call", sender=":1.24" (uid=0 pid=4112
> comm="bluez-5.31/src/bluetoothd -ndE ")
> interface="org.bluez.GattCharacteristic1" member="WriteValue" error
> name="(unset)" requested_reply="0" destination=":1.25" (uid=0 pid=4114
> comm="./test ")
>
> Any suggestions?
> Thanks in advance.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Caveat, I'm not a bluez developer, but since you haven't had any
replies I figured it wouldn't hurt to give you a few data points that
might help you narrow down the problem.  I am running 5.33 on a
raspberry pi with a 4.1 kernel.  I am able to write values to a
characteristic without any problems.

I'm a newbie with DBus and bluez, but doesn't the error suggest this
is DBus saying you don't have access, not bluez saying the
characteristic isn't writable?  Possibly this is a DBus security
issue.  I'd try googling for that error and see if you get any hints.

Is this the only part of your application that's running into problems
after upgrading to 4.1?

Neil

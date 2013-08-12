Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 1/3] sco-tester: Update ECONNABORTED to EOPNOTSUPP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <52089E1F.60704@linux.intel.com>
Date: Mon, 12 Aug 2013 16:22:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <88BDC584-6DC7-457A-92B3-3C00D30CCEBC@holtmann.org>
References: <1376062977-1497-1-git-send-email-frederic.dalleau@linux.intel.com> <09231CA6-E5F3-453E-9479-68F08072893A@holtmann.org> <52089E1F.60704@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

>> can we please have a proper thread on what error is appropriate to send  > from a socket interface when this situation happens. I see that
> > we are flipping errors, but my request to discuss this gets ignored.
>> 
> 
> I already gave my opinion previously. Let's recall it :"About the error ECONNABORTED, it is what the patch does : abort a connection. It is not used for other purposes. If you really want to change, I'm ok with EOPNOTSUPP, otherwise please suggest."

the last patchset that I reviewed had a different error code in the commit message than it had in the implementation. For me it is then impossible to understand what you intent was. Also an explanation why which error code is picked is important.

I really want commit messages be explanatory on why things a done this way. Use it as introduction to a patch and its justification.

> Regarding EOPNOTSUPP. Most use case are when a pointer in an interface is not implemented. We could consider that SetupSyncConn is not implemented in 2.0 adapter interfaces.

I spent some extra time now to dig into EOPNOTSUPP and how it is used in the current network subsystems the Linux kernel has. I normally refers to a local operation that is not supported. It is rarely used within the connect() system call, but it is indeed used there.

When EOPNOTSUPP is used, then it is in the context of the connect() system call implementation. It is used before any connection attempt is made. An example is when calling connect() on a DGRAM socket, but it only supports connect() in the STREAM socket.

For ECONNABORTED it is normally used in the context when the connection attempt is already in progress and it is then normally delivered via sk->sk_err to the user of the socket.

> > Please look for a good reference of the error code usage in other socket protocols or manpages
> 
> It is not obvious to find one good reference. But for example there is : Documentation/ioctl/hdio.txt:     EOPNOTSUPP    Hardware interface does not support bus power
> 
> Another option could be:
> [ENODEV]
>    No such device An attempt was made to apply an inappropriate function to a device; for example, trying to read a write-only device such as a printer.

ENODEV is not meant for sockets. We use it inside the Bluetooth subsystem for errors that relate to HCI devices, HID/input devices or TTY devices.

In summary so far we have the closest match with EOPNOTSUPP for one reason. The connect() system call is actually failing without any connection attempt. It tries to find the local controller assigned to this socket and if it does not support eSCO, it bails out. That makes it fall in line with how it should be used if we look at other systems calls or socket families.

However I only looked at the error codes you listed in this email. Maybe there is even a better one, maybe there is not. I am pretty much open to discuss alternatives here.

Regards

Marcel


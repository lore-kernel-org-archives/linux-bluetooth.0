Return-Path: <cyrus@holtmann.org>
Message-ID: <1322221581.29909.17.camel@aeonflux>
Subject: Re: RFCOMM Remote Port Negotiation
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrea Galbusera <gizero@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Nov 2011 12:46:21 +0100
In-Reply-To: <CAC+thW2oKHuMU3Ky+bLwU6BOhhaeJ5dBapYhYc3ctPsNhMcLXQ@mail.gmail.com>
References: <CAC+thW2oKHuMU3Ky+bLwU6BOhhaeJ5dBapYhYc3ctPsNhMcLXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrea,

> This days I have been thinking about a project, which involves
> replacing a serial cable with a bluetooth based solution. Nothing new,
> you'd say and that's exactly what I thought at first. Than I had to
> face this fact. Such an application involves communication between two
> host over a serial connection with a baudrate that changes over time.
> What I need is a "fully transparent" replacement for a serial cable
> and it needs to be compatible with the current software.
> 
> I know RFCOMM standard does provide multiplexor frames and RPN
> commands in particular, which allow for remote bluetooth device to be
> aware of any change in serial communication parameters on the other
> side. It also became pretty clear to me that what I'm supposed to
> realize is an RFCOMM Type 2 device. According to RFCOMM specification,
> a Type 2 device is an intermediate device that has a physical RS-232
> serial port on top of RFCOMM.
> 
> My question is? How would one implement such a thing with Linux? I'm
> not a kernel expert at all but, if my understanding is correct,
> rfcomm_recv_rpn() function in net/bluetooth/rfcomm/core.c is designed
> to reply to RPN frames (as required by the protocol specification) but
> does not provide any mechanism to signal other layers (maybe the tty
> device) of any remote request for changing port settings. Is my
> understanding correct? Does this mean that Linux RFCOMM kernel layer
> is currently designed for Type 1 devices only?
> 
> Even thinking to a user space solution for my problem does not seem
> easy at all to me. When the remote host changes line settings, RFCOMM
> layer will send RPN command accordingly (linux does so when changing
> tty settings). How to get such an information on the other side if
> rfcomm_recv_rpn() does, in fact, short-circuit RPN commands in the
> kernel?
> 
> I'm quite surprised no one ever had this requirement! I couldn't find
> much about RPN in the list archives and even on google. Also I noticed
> that many bluetooth-serial adapters on the market do behave the same
> way Linux does, and they simply reply to RPN without carrying out any
> request to change settings on their serial port. This could mean I'm
> completely on a wrong path!
> 
> Please! I ask you, bluetooth gurus, to improve my understanding, if
> possible. If in the end you do think reasonable any extension to the
> current kernel implementation, which take into account such a
> scenario, I'd be glad to participate and help.

the only way this works is with the RFCOMM TTY support anyway. Since
with the RFCOMM socket we do not have any of these signals.

To be honest here, nobody ever cared about this old fashion real serial
emulation. So you need to implement the hooks between the Linux TTY
layer and Bluetooth RFCOMM TTY support to make this work.

One thing that might will make this fail is the complicated looking in
the TTY layer and the way how certain things are executed in interrupt
context. So good luck here.

Regards

Marcel



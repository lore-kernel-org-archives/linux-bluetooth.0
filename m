Return-Path: <cyrus@holtmann.org>
Subject: Re: Bug: bluetooth not working after suspend/resume
From: etsang <Edwin.Tsang@ca.flextronics.com>
To: =?ISO-8859-1?Q?Keng-Y=FC?= Lin <kengyu@ubuntu.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <CADXHx7Z=9EFEweZ+LouXWdRePu6OBrj36uGA78=BMKjo0oMEJQ@mail.gmail.com>
References: <CADXHx7Z=9EFEweZ+LouXWdRePu6OBrj36uGA78=BMKjo0oMEJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Sep 2011 09:52:11 -0400
Message-ID: <1317131531.2158.7.camel@etsang-laptop>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kenyu,
  I am working on a similar BT issue. But it is on Android Gingerbread
kernel 2.6.25.7+.  After a idle for a while the BT was not return any
inquiry result (if it was not), if turn off BT then it will not turn
again until a power cycle. On the kernal log it was showing problem
loading into the TI wl327x. 
---
TIinit_7.2.31.bts
no proper response during fw download.
Do you you have a similar fw download failure when attempt to turn on
BT. Or might be a different issue?

Ed
On Tue, 2011-09-27 at 16:25 +0800, Keng-Yü Lin wrote:
> Hi all:
>   Since kernel.org/bugzilla is dead for a while, I sent the bug report
> here in hope to get more insight.
> 
>   This is a long-lasting bug and happens across several distros with
> different combinations of bluez/kernel verisions but shares much the
> same symptom that bluetooth is not working after the resume. As seen
> in the bug report below, it happens on a variety of different laptops
> too.
> 
>   Redhat:
>     https://bugzilla.redhat.com/show_bug.cgi?id=727106
> 
>   Debian:
>     http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=614929
> 
>   Ubuntu:
>     https://launchpad.net/bugs/824144
>     https://launchpad.net/bugs/824633
>     https://launchpad.net/bugs/823467
>     https://launchpad.net/bugs/822705
> 
>   Personally I did some investigation on the issue and found that
> bluetoothd does not receive the HCI commands of read_bd_addr,
> read_local_version, read_local_features, nor read_local_name. So in
> bluez.plugins/hciops.c:device_devup_setup(), init_adapter() is not
> called at resume.
> 
>   It can be further confirmed by the attached patch of bluez. It is
> ugly but can work around the bug as reported in some of the bug
> trackers above.
> 
>   I am looking for any advice to get it move on,  for the debugging
> and the fixing.
> 
>   Thanks,
> -kengyu


 
Legal Disclaimer:
The information contained in this message may be privileged and confidential. It is intended to be read only by the individual or entity to whom it is addressed or by their designee. If the reader of this message is not the intended recipient, you are on notice that any distribution of this message, in any form, is strictly prohibited. If you have received this message in error, please immediately notify the sender and delete or destroy any copy of this message


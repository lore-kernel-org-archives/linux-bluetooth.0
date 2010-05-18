Return-Path: <cyrus@holtmann.org>
From: =?iso-8859-1?q?Jos=E9_Antonio_Santos_Cadenas?=
	<jcaden@libresoft.es>
Reply-To: jcaden@libresoft.es
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Subject: Re: HDP proposed API(0.5)
Date: Tue, 18 May 2010 09:33:15 +0200
Cc: =?iso-8859-1?q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
	linux-bluetooth@vger.kernel.org
References: <201005171654.36923.jcaden@libresoft.es> <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com> <20100517213838.GB19907@vigoh>
In-Reply-To: <20100517213838.GB19907@vigoh>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005180933.15803.jcaden@libresoft.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

El Monday 17 May 2010 23:38:38 Gustavo F. Padovan escribió:
> Hi,
> 
> * João Paulo Rechi Vita <jprvita@gmail.com> [2010-05-17 18:17:58 -0300]:
> 
> <snip>
> 
> > On Mon, May 17, 2010 at 11:54, José Antonio Santos Cadenas
> > 
> > <jcaden@libresoft.es> wrote:
> > >                array GetDataChannelFileDescriptor(uint16 mdlid)
> > 
> > Wouldn't be better to pass the fd through the LinkConnected call on
> > Agent? Doing it here allows any process to get the fds.
> 
> I was thinking about the MCAP in kernel implementation, my conclusion is
> that we can solve one of the biggest problem of HDP API if we do it in
> kernel: the transparency of MCAP reconnection. HDP will open an MCAP
> socket and pass it to the user(IEEE app). Then if we need a
> reconnection, MCAP will transparently reconnect changing the L2CAP
> channel to transmit the data without the need to change the socket
> opened with the userspace.

This that you proposed is something that we thought when we started with 
MCAP/HDP. We finally decided to put MCAP outside the kernel because of the 
following reasons:
	-  The first and the most important is that everything that can be done in 
user space should be done in user space. We talked about this issue in the 
list some time ago and Marcel suggested us that if MCAP doesn't have 
interaction with other kernel subsystems, it should be implemented outside the 
kernel. You can read these mails here [1]. Basing on our experience with MCAP 
that's true, MCAP does not interact with any kernel subsystem.
	- An other reason is that reconnections *should not* be transparent at 
MCAP level. Any profile using MCAP should be concerned about the data channel 
disconnection and reconnection. In the case of HDP reconnections should be 
hide to the application layer.
	- Finally the kernel implementation will require a very complex API 
because MCAP require notifying lots of events some of the requiring a 
response(i.e., incoming mdl connection that need a response from the next 
level using MCAP with the configuration). Probably MCAP in the kernel space 
will be so complicated to used an you will require a user space library that 
make simpler the use of this API.

> 
> Keep the MCAP socket open means that we are keeping the MCL state for
> further reconnection.
> 
> Doing it inside the kernel removes a big amount of complexity of HDP and
> IEEE profiles, since we won't need any pipe or change of fd. That could
> be a killer feature to make it in the kernel.
> 
> Any comments? Is this reasonable?

In our opinion reconnections are not a reason to implement MCAP in kernel 
space because reconections should not be transparent at this level.

> 
> <snip>


[1] http://www.spinics.net/lists/linux-bluetooth/msg03001.html

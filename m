Return-Path: <cyrus@holtmann.org>
Date: Mon, 17 May 2010 18:38:38 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Cc: jcaden@libresoft.es, linux-bluetooth@vger.kernel.org
Subject: Re: HDP proposed API(0.5)
Message-ID: <20100517213838.GB19907@vigoh>
References: <201005171654.36923.jcaden@libresoft.es>
 <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTikCmZydkLG863_MbrMhiNlWx5GecQaXitr1q0xX@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

* João Paulo Rechi Vita <jprvita@gmail.com> [2010-05-17 18:17:58 -0300]:

<snip>

> On Mon, May 17, 2010 at 11:54, José Antonio Santos Cadenas
> <jcaden@libresoft.es> wrote:
> >
> >                array GetDataChannelFileDescriptor(uint16 mdlid)
> >
> 
> Wouldn't be better to pass the fd through the LinkConnected call on
> Agent? Doing it here allows any process to get the fds.

I was thinking about the MCAP in kernel implementation, my conclusion is
that we can solve one of the biggest problem of HDP API if we do it in
kernel: the transparency of MCAP reconnection. HDP will open an MCAP
socket and pass it to the user(IEEE app). Then if we need a
reconnection, MCAP will transparently reconnect changing the L2CAP
channel to transmit the data without the need to change the socket
opened with the userspace.

Keep the MCAP socket open means that we are keeping the MCL state for
further reconnection.

Doing it inside the kernel removes a big amount of complexity of HDP and
IEEE profiles, since we won't need any pipe or change of fd. That could
be a killer feature to make it in the kernel.

Any comments? Is this reasonable?

<snip>

-- 
Gustavo F. Padovan
http://padovan.org

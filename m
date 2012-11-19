Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Nov 2012 18:19:58 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] sco: BT_DEFER_SETUP for SCO sockets
Message-ID: <20121119201958.GA14006@joana>
References: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

* Frédéric Dalleau <frederic.dalleau@linux.intel.com> [2012-11-19 17:35:55 +0100]:

> Hi,
> 
> This is a better view about what can be done to implement DEFER_SETUP on SCO
> sockets. hci layer get some changes since previous behavior was to accept all
> SCO connections.
> The ugly hci_proto_defer has been removed and replaced by an additional flag
> parameter to hci_proto_connect_ind.
> Regarding testing, I'm still stuck by a txt timeout issue however, if the
> delay between accept and recv is set to 0, then the connection is working fine.
> And I even managed to get the sco connection established correctly once. So I
> believed this emulator problem.

You are telling me that your patch is not really working, I suggest you call
this series RFC before you get everything sorted out. The approach in general
is good, but I'd need confirmation that it works for actual defer delays, 3
seconds for example, and not 0.

	Gustavo

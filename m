Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Mar 2012 00:03:47 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv4 05/30] Bluetooth: Lock sk only if exist
Message-ID: <20120320030347.GA9142@joana>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1331814621-13905-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331814621-13905-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-15 14:29:56 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

We told about this several times, please include a commit message description
in all patches.

	Gustavo

Return-Path: <cyrus@holtmann.org>
Date: Fri, 24 Feb 2012 18:21:54 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] Bluetooth: Remove duplicated code in l2cap conn req
Message-ID: <20120224202154.GB28740@joana>
References: <1330092000-9420-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330092000-9420-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-02-24 16:00:00 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The same sequence sending L2CAP Connection Request was
> used in several places. Using subroutine makes those
> places easy to read.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   49 +++++++++++++++++--------------------------
>  1 files changed, 19 insertions(+), 30 deletions(-)

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

	Gustavo

Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 13:22:08 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv1 10/11] Bluetooth: Add put(hcon) when deleting hchan
Message-ID: <20121025152208.GD1764@joana>
References: <1350493622.26318.114.camel@aeonflux>
 <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1351167652-12346-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351167652-12346-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-25 15:20:51 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> When refcnt reaches zero disconnect timeout will run and hci_conn
> will be disconnected.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_conn.c |    2 ++
>  1 file changed, 2 insertions(+)

Patches 1-4 and 10 have been applied to bluetooth-next. I'll wait for more
feedback on the others, as this is still an RFC. Thanks.

	Gustavo

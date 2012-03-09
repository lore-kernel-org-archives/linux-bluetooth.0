Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Mar 2012 09:37:30 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Correct type for hdev lmp_subver
Message-ID: <20120309123729.GA16366@joana>
References: <1331286409-26774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331286409-26774-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-09 11:46:49 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Keep lmp_subver in host byte order. We have following conversion
> in hci_cc_read_local_version:
> hdev->lmp_subver = __le16_to_cpu(rp->lmp_subver);
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Applied, thanks.

	Gustavo

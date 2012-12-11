Return-Path: <cyrus@holtmann.org>
Date: Tue, 11 Dec 2012 20:17:05 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3 v1] Bluetooth: Move discovery state check inside
 hci_dev_lock()
Message-ID: <20121211221705.GB7912@joana>
References: <1354791958-28334-1-git-send-email-jaganath.k@samsung.com>
 <1354791958-28334-3-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354791958-28334-3-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

* Jaganath Kanakkassery <jaganath.k@samsung.com> [2012-12-06 16:35:57 +0530]:

> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> ---
>  net/bluetooth/hci_event.c |    9 ++++-----
>  net/bluetooth/mgmt.c      |    4 ----
>  2 files changed, 4 insertions(+), 9 deletions(-)

Please add a proper commit message. We do not allow empty commit messages,
even if the commit is trivial.

	Gustavo

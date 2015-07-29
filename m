Return-Path: <cyrus@holtmann.org>
Date: Wed, 29 Jul 2015 20:49:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anchit Narang <anchit.n@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, sachin.dev@samsung.com
Subject: Re: [PATCH v2] tools/hciconfig:Fixed Memory Leak
Message-ID: <20150729174903.GB3234@t440s.P-661HNU-F1>
References: <1437994586-19180-1-git-send-email-anchit.n@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437994586-19180-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anchit,

On Mon, Jul 27, 2015, Anchit Narang wrote:
> Freed memory allocated to structure hci_dev_list_req to avoid memory leak
> ---
>  tools/hciconfig.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan

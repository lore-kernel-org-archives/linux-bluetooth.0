Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Sep 2014 10:44:38 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com
Subject: Re: [PATCH v2 2/3] tools/btsnoop : Fix variable reassigning issue
Message-ID: <20140916074438.GA738@t440s.lan>
References: <1410761405-4525-1-git-send-email-gowtham.ab@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410761405-4525-1-git-send-email-gowtham.ab@samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Mon, Sep 15, 2014, Gowtham Anandha Babu wrote:
> The Variable 'written' is reassigned a value before the old one has been used.
> ---
>  tools/btsnoop.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

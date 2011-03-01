Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Mar 2011 15:59:27 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v1] Fix HCI LE advertising report dump
Message-ID: <20110301185927.GB32583@jh-x301>
References: <1298865502-12676-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1298865502-12676-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Mon, Feb 28, 2011, Andre Dieb Martins wrote:
> LE advertising report event has only one data block for each report.
> Thus, we can't reuse ext_inquiry_response_dump(), which loops over
> successive data blocks until reaches a zero-length one.
> 
> This commit introduces ext_inquiry_data_dump(), which dumps a frame
> containing data formatted according to [Vol 3] Part C, Section 8. This
> function is reused by ext_inquiry_response_dump().
> 
> Also adds RSSI parsing to each advertising report.
> ---
>  parser/hci.c |  146 +++++++++++++++++++++++++++++++++------------------------
>  1 files changed, 84 insertions(+), 62 deletions(-)

Pushed upstream. Thanks. I had to fix your commit message first though.
Please make sure that the lines are short enough to be properly viewable
with git log on a 80-column wide terminal (git log indents them by 4
characters).

Johan

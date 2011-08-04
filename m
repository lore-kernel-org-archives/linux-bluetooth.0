Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Aug 2011 15:58:50 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Add Name header check to ftp_chkput
Message-ID: <20110804125850.GB24323@dell>
References: <1312462196-18443-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312462196-18443-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, Aug 04, 2011, Slawomir Bochenski wrote:
> Validation of Name header was missing from ftp_chkput, thus still allowing
> actual putting.
> ---
>  plugins/ftp.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan

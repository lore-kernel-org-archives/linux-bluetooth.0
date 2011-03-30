Return-Path: <cyrus@holtmann.org>
Date: Wed, 30 Mar 2011 19:47:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Dieb Martins <andre.dieb@signove.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/6] Add parsing for ATT Write Request
Message-ID: <20110330164710.GA20595@jh-x301>
References: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1301493694-10957-1-git-send-email-andre.dieb@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Wed, Mar 30, 2011, Andre Dieb Martins wrote:
> Note we do not need extra parsing for ATT Write Response as it only has one
> field (opcode).
> ---
>  parser/att.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)

All patches in this set have been pushed upstream. Thanks.

Johan

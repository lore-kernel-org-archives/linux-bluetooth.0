Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Oct 2011 10:52:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH bluez] add get_le/get_be helpers
Message-ID: <20111025085242.GB3514@fusion.localdomain>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Oct 24, 2011, Emeltchenko Andrei wrote:
> Helpers to access LE / BE values. In bluetooth there is a mixture
> of LE / BE network byte order.
> ---
>  lib/bluetooth.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 64 insertions(+), 0 deletions(-)

Applied. Thanks.

Please start your commit messages with a capital letter in the future so
I don't have to keep fixing them manually.

Johan

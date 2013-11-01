Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Nov 2013 09:46:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] hidhost: Shutdown HID L2CAP sockets on unregister
Message-ID: <20131101074631.GB3484@x220.p-661hnu-f1>
References: <1383233418-14757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383233418-14757-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 31, 2013, Andrei Emeltchenko wrote:
> Fixes address already in use issue if we reenable HID.
> ...
> bluetoothd[2894]: Failed to listen on ctrl channel:
> 	l2cap_bind: Address already in use (98)
> ...
> ---
>  android/hid.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Applied (after fixing up the subject prefix). Thanks.

Johan

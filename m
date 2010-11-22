Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Nov 2010 15:40:50 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: do not use assignment in if condition
Message-ID: <20101122174050.GB23109@vigoh>
References: <1290424897-32463-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290424897-32463-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-11-22 13:21:37 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Fix checkpatch errors like:
> "ERROR: do not use assignment in if condition"
> Simplify code and fix one long line.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/hci_event.c |   18 ++++++++++++------
>  1 files changed, 12 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi

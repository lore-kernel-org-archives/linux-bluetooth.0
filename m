Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 Dec 2013 11:08:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 1/3] android/socket: Refactor connect to allow directly
 connect to rfcomm
Message-ID: <20131219090851.GA6199@x220.p-661hnu-f1>
References: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1387442960-4584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387442960-4584-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Dec 19, 2013, Andrei Emeltchenko wrote:
> Since Socket HAL allows us to specify RFCOMM channel number and directly
> connect refactor send function to allow connect directly is uuid is zero
> and channel number is specified.
> ---
>  android/socket.c | 71 +++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)

All three patches have been applied. Thanks.

Johan

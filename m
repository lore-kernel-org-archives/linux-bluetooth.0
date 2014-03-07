Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Mar 2014 11:25:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] emulator/btdev: Add dummy support for clearing the
 LE white list
Message-ID: <20140307092557.GA17724@localhost.P-661HNU-F1>
References: <1393683925-1216-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393683925-1216-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Mar 01, 2014, Anderson Lizardo wrote:
> Add just enough support for being able to bring up LE capable virtual
> controllers using "btvirt".
> 
> Fixes this error on "btvirt -l2":
> 
> Unsupported command 0x2010
> 
> And on "hciconfig hci0 up":
> 
> Can't init device hci0: Invalid request code (56)
> ---
>  emulator/btdev.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied. Thanks.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Mon, 20 Jan 2014 16:45:53 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] build: Bump D-Bus dependency to 1.6
Message-ID: <20140120144553.GA25608@x220.p-661hnu-f1>
References: <1390226087-14202-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390226087-14202-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Jan 20, 2014, Szymon Janc wrote:
> dbus_validate_path() was introduced in D-Bus 1.6 and it is no longer
> possible to build with 1.4.
> 
>  CCLD   tools/bluetooth-player
> tools/bluetooth-player.o: In function `cmd_change_folder':
> tools/bluetooth-player.c:741: undefined reference to `dbus_validate_path'
> collect2: ld returned 1 exit status
> ---
>  configure.ac | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1392300832-14142-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392300832-14142-1-git-send-email-andrzej.kaczmarek@tieto.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Date: Thu, 20 Feb 2014 08:39:01 +0100
Message-ID: <CAF3PWx3tHfPUZTfZiB_87LSmNTnrwzqnm6Cxpi8NhVOKBnSf2w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix channel check when binding RFCOMM sock
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 13 February 2014 15:13, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> When binding RFCOMM socket with non-zero channel we're checking if
> there is already any other socket which has the same channel number
> assigned and then fail. This check does not consider situation where
> we have another socket connected to remote device on given channel
> number in which case we still should be able to bind local socket.
>
> This patch changes __rfcomm_get_sock_by_addr() to return only sockets
> in either BT_BOUND or BT_LISTEN states, also name is updated to better
> describe what this function does now.
>
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>

ping...?

BR,
Andrzej

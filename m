Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329821707-11817-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329821707-11817-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1329821707-11817-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Tue, 21 Feb 2012 15:36:29 -0200
Message-ID: <CAA37ikZwvAcMh4ncNd=pNzH63UG5BEvpS3bu20Htus83LtiQ5A@mail.gmail.com>
Subject: Re: [PATCHv1 13/14] Bluetooth: Use l2cap chan lock in socket connect
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Feb 21, 2012 at 8:55 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Function l2cap_chan_connect does not return with locked socket
> anymore. So we take explicit lock in l2cap_sock_connect.
>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |   18 ++++++++++++++----
>  net/bluetooth/l2cap_sock.c |    2 ++
>  2 files changed, 16 insertions(+), 4 deletions(-)

Looks good.

Reviewed-by: Ulisses Furquim <ulisses@profusion.mobi>

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs

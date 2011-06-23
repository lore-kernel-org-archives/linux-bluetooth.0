Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308651896-21524-1-git-send-email-lkslawek@gmail.com>
References: <1308651896-21524-1-git-send-email-lkslawek@gmail.com>
Date: Thu, 23 Jun 2011 12:17:43 +0300
Message-ID: <BANLkTik6NwtCHA_YDBvYSDEV8R1V1dMtzA@mail.gmail.com>
Subject: Re: [PATCH obexd v2] Fix parameters in obexd.service.in
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 21, 2011 at 1:24 PM, Slawomir Bochenski <lkslawek@gmail.com> wrote:
> This adjusts obexd.service.in to changes introduced in commit
> e7792642accead1de0016bd7f78c74d9b6cad38a, making obexd use all built-in
> plugins when activated by D-Bus.
> ---
>  src/obexd.service.in |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/src/obexd.service.in b/src/obexd.service.in
> index 24571bd..e857f09 100644
> --- a/src/obexd.service.in
> +++ b/src/obexd.service.in
> @@ -1,3 +1,3 @@
>  [D-BUS Service]
>  Name=org.openobex
> -Exec=@libexecdir@/obexd --nodaemon --opp --ftp
> +Exec=@libexecdir@/obexd --nodaemon
> --
> 1.7.4.1

ack

-- 
Luiz Augusto von Dentz

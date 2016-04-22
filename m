Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1461144317-20684-2-git-send-email-beaufort.francois@gmail.com>
References: <1461144317-20684-1-git-send-email-beaufort.francois@gmail.com>
	<1461144317-20684-2-git-send-email-beaufort.francois@gmail.com>
Date: Fri, 22 Apr 2016 15:06:06 +0300
Message-ID: <CABBYNZK0SqkXDU9k+kfUcZ7XwbwUyXXSrH7vMtNtRJSfVP9Lgw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix nit in HACKING instructions
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Francois Beaufort <beaufort.francois@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Francois,

On Wed, Apr 20, 2016 at 12:25 PM, Francois Beaufort
<beaufort.francois@gmail.com> wrote:
> ---
>  HACKING | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/HACKING b/HACKING
> index 28f1009..d93730d 100644
> --- a/HACKING
> +++ b/HACKING
> @@ -146,12 +146,12 @@ backtraces, compiler errors, etc.
>
>    # git config format.subjectprefix "PATCH BlueZ"
>
> -6) Add a cover letter when introducing a new feature explaning what problem
> +7) Add a cover letter when introducing a new feature explaning what problem
>  you're trying to solve:
>
>    # git format-patch --cover-letter -M origin/master -o outgoing/
>    # edit outgoing/0000-*
>
> -7) Submit:
> +8) Submit:
>
>    # git send-email outgoing/*
> --
> 2.7.0

Applied, thanks.

-- 
Luiz Augusto von Dentz

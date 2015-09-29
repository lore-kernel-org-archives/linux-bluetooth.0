Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1443473638-28118-1-git-send-email-jamuraa@chromium.org>
References: <1443473638-28118-1-git-send-email-jamuraa@chromium.org>
Date: Tue, 29 Sep 2015 16:41:15 +0300
Message-ID: <CABBYNZKqXNVtk7894dcYdjjMqSnrZd2=ocm9LxMQxya2=PRpvA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/ad: Fix license to be LGPL
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marie Janssen <jamuraa@chromium.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marie,

On Mon, Sep 28, 2015 at 11:53 PM, Marie Janssen <jamuraa@chromium.org> wrote:
> Code in the shared directory should be LGPL.  It was mistakenly
> checked in as GPL.
> ---
>  src/shared/ad.c | 18 +++++++++++-------
>  src/shared/ad.h | 18 +++++++++++-------
>  2 files changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index 485bd7b..6259eb9 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -5,15 +5,19 @@
>   *  Copyright (C) 2015  Google Inc.
>   *
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
>   *
> - *  This program is distributed in the hope that it will be useful,
> + *  This library is distributed in the hope that it will be useful,
>   *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   *
>   */
>
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index 4b313ab..709563d 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -5,15 +5,19 @@
>   *  Copyright (C) 2015  Google Inc.
>   *
>   *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> + *  This library is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU Lesser General Public
> + *  License as published by the Free Software Foundation; either
> + *  version 2.1 of the License, or (at your option) any later version.
>   *
> - *  This program is distributed in the hope that it will be useful,
> + *  This library is distributed in the hope that it will be useful,
>   *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  Lesser General Public License for more details.
> + *
> + *  You should have received a copy of the GNU Lesser General Public
> + *  License along with this library; if not, write to the Free Software
> + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   *
>   */
>
> --
> 2.6.0.rc2.230.g3dd15c0

Pushed, thanks.


-- 
Luiz Augusto von Dentz

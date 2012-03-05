Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330692087-13021-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1330692087-13021-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1330692087-13021-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Mon, 5 Mar 2012 12:14:49 +0200
Message-ID: <CABBYNZ+Crjj=B-f6VWBArRJE7M5zQSJ+65EjkesKFSxcL7xHMw@mail.gmail.com>
Subject: Re: [PATCH obexd 1/3] client: fix naming convention in transfer api
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Mar 2, 2012 at 2:41 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The terms can be quite misleading, so this patch proposes to follow the
> terminology in the D-Bus api:
>       - Name: the remote name of the object being transferred
>       - Filename: the name of the file in local the filesystem
>
> Both values can be NULL independently.
>
> This also fixes the problem of using the terms differently in get and
> put operations. The result was that the properties "Name" and "Filename"
> were swapped in D-Bus in the case of get.

Please split this, have the fix to swapped parameters and then the
name modification in separated patch.

-- 
Luiz Augusto von Dentz

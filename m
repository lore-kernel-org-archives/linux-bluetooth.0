Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Dec 2010 15:53:44 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Fix crash when mmaping files which size is multiple
 of page size
Message-ID: <20101217135344.GA8222@jh-x301>
References: <1292592686-14908-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292592686-14908-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Dec 17, 2010, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> In this case the buffer returned by mmap is not NULL terminated so
> functions like strpbrk that expect a string goes out of bounds.
> 
> To fix this strpbrk_len was introduced which takes the size of the buffer
> making sure it never goes out of bounds.
> ---
>  src/textfile.c |   38 +++++++++++++++++++++++++++++++++-----
>  1 files changed, 33 insertions(+), 5 deletions(-)

Thanks. The patch looks good and seems to compile and run fine too. It
has been pushed upstream.

Johan

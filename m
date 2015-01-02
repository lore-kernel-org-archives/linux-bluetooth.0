Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Jan 2015 09:07:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH bluez] src/shared/ecc.c: include <config.h>
Message-ID: <20150102070746.GB13581@t440s.P-661HNU-F1>
References: <1420148306-18471-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420148306-18471-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Thu, Jan 01, 2015, Thomas Petazzoni wrote:
> The ecc.c file forgets to include <config.h>. This causes build
> failures with certain C libraries, because ecc.c uses O_CLOEXEC, which
> is only available when _GNU_SOURCE is defined. And _GNU_SOURCE gets
> defined by <config.h>, so it should be included.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  src/shared/ecc.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks. (after removing the Signed-off-by line which we don't
use for user space patches).

Johan

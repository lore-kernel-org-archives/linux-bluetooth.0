Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 09:04:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] hog: Fix characteristic descriptor discovery
Message-ID: <20121011070448.GE2223@x220.example.org>
References: <1349933483-10436-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1349933483-10436-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

João Paulo,

On Thu, Oct 11, 2012, João Paulo Rechi Vita wrote:
> The discover descriptors sub-procedure is complete when the error
> response is received and the error code is set to "Attribute Not Found"
> or the find information response has an attribute handle that is equal
> to the last handle in the request. This commit fixes the stop condition
> for characteristic descriptor discovery.
> ---
>  profiles/input/hog_device.c | 46 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 37 insertions(+), 9 deletions(-)

Both patches have been applied. Thanks.

I had to do some manual fix-up on the first patch due to conflicts with
patches from Vinicius so please check that I didn't make any mistakes.

Johan

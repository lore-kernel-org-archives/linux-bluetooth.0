Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Oct 2010 10:21:53 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression on suspend on opening
Message-ID: <20101015072153.GA3409@jh-x301>
References: <1287125828-5479-1-git-send-email-dmitriy.paliy@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287125828-5479-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dmitriy,

On Fri, Oct 15, 2010, Dmitriy Paliy wrote:
> This fixes regression when doing suspend on opening obex stream. If
> obex_write_stream returns length of buffer, it is treated as an error
> response later on, which is not correct.
> 
> Negative values returned by obex_write_stream are error codes, while
> positive ones mean length of buffer. Positive values are never used
> afterwards in the code. Therefore, due to this reason, and for being
> compliant with obex_read_stream, which also returns 0 only, it was
> decided to remove return of positive value representing length at all.
> 
> Result of such is also some code cleanup that removes unnecessary return
> len when it is zero.
> 
> A typo is fixed in comments as well.

Both patches have been pushed upstream. Thanks. Btw, don't be afraid to
put this kind of explanations in the commit messages themselves since
that info is easier to find in a couple of years time than this cover
letter email.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Mar 2014 10:46:03 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v0 35/62] unit: Use lower-case for 128-bit UUIDs
Message-ID: <20140321084603.GB5834@t440s.lan>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395326607-27068-36-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395326607-27068-36-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Thu, Mar 20, 2014, Claudio Takahasi wrote:
> According to ISO/IEC 9834-8: "It is recommended that the hexadecimal
> representation used in all human-readable formats be restricted to
> lower-case letters. Software processing this representation is, however,
> required to accept both upper and lower case letters as specified in
> 6.5.2."
> ---
>  unit/test-uuid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This patch has also been applied.

Johan

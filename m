Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 21:40:11 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix breaking long lines in vCard's fields
Message-ID: <20111014184011.GA7772@fusion.localdomain>
References: <1318600882-14204-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318600882-14204-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Fri, Oct 14, 2011, Rafal Michalski wrote:
> Previously limit length for vCard's (vCard 2.1 with Quoted Printable
> encoding) property line was always set as 75 (QP_LINE_LEN), after
> processing each single subfield (for instance under ADR property).
> Thus it was not possible to reach limit equal to 0 (then breaking line
> is required) for all property subfields.
> This patch fixes that issue and length of first line, containing property
> parameters, is limited as well.
> ---
>  plugins/vcard.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

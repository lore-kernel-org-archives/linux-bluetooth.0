Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Oct 2011 10:37:15 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v2] Support for encoding UTF-8 characters in
 vCard's fields
Message-ID: <20111013073715.GA8289@fusion.localdomain>
References: <1318413368-30795-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318413368-30795-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Wed, Oct 12, 2011, Rafal Michalski wrote:
> This patch provides additional condition for selection of Quoted Printable
> encoding (for vCard's 2.1 fields). It will be satisfied if there is any
> byte which value is out of range standard ASCII set. Such byte may be
> a part of sequence (composed of more than single byte) for non-standard
> characters specified by UTF-8 and if detected, CHARSET parameter for
> property is set as "UTF-8".
> This fix is required since without such improvement some carkits may
> display non-standard characters incorrectly (for instance they may be
> omitted completely).
> ---
>  plugins/vcard.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 46 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

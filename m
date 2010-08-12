Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Aug 2010 07:15:57 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Mol <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] ebook backend: separate concatenated vcards with \r\n.
Message-ID: <20100812111557.GB19780@jh-x301>
References: <201008121026.o7CAQDVU005280@joshua.mesa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008121026.o7CAQDVU005280@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Aug 12, 2010, Marcel Mol wrote:
> The END:VCARD is not ended with \r\n for single vcards.
> In a phonebook pull request vcards are concatenated as one
> big blob. Carkits seem to choke on the fact that an END:VCARD
> is directly followed by BEGIN:VCARD without \r\n separation.
> (as observed by many n900 users).
> ---
>  plugins/phonebook-ebook.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

This one is also upstream now. Thanks.

Johan

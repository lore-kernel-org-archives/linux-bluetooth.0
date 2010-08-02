Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Aug 2010 22:45:06 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Mol <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix vcard filter setting
Message-ID: <20100802194506.GA29596@jh-x301>
References: <201007281324.o6SDO2oH010611@joshua.mesa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201007281324.o6SDO2oH010611@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 27, 2010, Marcel Mol wrote:
> The bits for VCARD version 2.1 and version 3.0 were wrong:
> oin case of 2.1 the FN bit was on and for 3.0 it is off.
> The comment state that 3.0 needs FN while 2.1 does not.
> This patch fixes that.
> ---
>  plugins/phonebook-ebook.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Thanks for the patch. It's now in the upstream obexd tree.

Johan

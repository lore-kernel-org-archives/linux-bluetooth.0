Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Aug 2010 01:20:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Mol <marcel@mesa.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] obexd: ebook backend: return all TEL attribs from
 vcard in string
Message-ID: <20100802222022.GA3792@jh-x301>
References: <201008022209.o72M94DV017676@joshua.mesa.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008022209.o72M94DV017676@joshua.mesa.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Aug 03, 2010, Marcel Mol wrote:
> evcard_to_string() only took one TEL attrib from a vcard. But
> multiple TEL attribs are supported. This patch will convert
> all TEL attribs to strings.
> ---
>  plugins/phonebook-ebook.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)

Thanks for the quick update. The patch is now pushed upstream with a
couple more minor coding style cleanups (for which I didn't bother
having yet another review round ;) Take a look at the upstream tree if
you're interested in how exactly the final patch (and commit message)
ended up looking like.

Johan

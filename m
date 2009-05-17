Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 May 2009 21:42:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: alok barsode <alokbarsode@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, marcel@holtmann.org
Subject: Re: [PATCH 2/7] Adding set_powered method to hciops plugin.
Message-ID: <20090517184207.GA23860@jh-x301>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com> <1242131216-4081-2-git-send-email-alok.barsode@azingo.com> <20090515182256.GA18375@jh-x301> <20090516225406.GA19041@jh-x301> <8b5debfa0905170027t45955215p2b9edb663a27c4e2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8b5debfa0905170027t45955215p2b9edb663a27c4e2@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

On Sun, May 17, 2009, alok barsode wrote:
> The 3rd patch has dependencies on the 1st patch (using hci_send_cmd
> for hci_send_req) .
> did u get time to test that patch?

No. I stopped processing the patches after I hit the issues with the
second one.

> do you want me to rework all the patches so as to remove dependency on patch1?
> (which would basically mean removing that patch).

Resend a fixed second patch and any other patches that need updating due
to the fixes (afaik it only affects the third patch).

Johan

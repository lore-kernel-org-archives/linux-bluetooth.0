Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Jun 2011 13:38:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Cleanup: read_local_features callback is no longer used
Message-ID: <20110617103859.GD28423@dell.ger.corp.intel.com>
References: <1308266903-8700-1-git-send-email-andre.guedes@openbossa.org>
 <BANLkTi=PkiW+tbsdm3Cpen+3Vidmdzw5zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <BANLkTi=PkiW+tbsdm3Cpen+3Vidmdzw5zQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Thu, Jun 16, 2011, Andre Guedes wrote:
> Not sure you wanna remove the read_local_features callback, so I put it
> in a separated patch. Feel free to apply it or not.

Since the core daemon doesn't need this info anymore I think it's fine
to remove it. We can always add it back later if the need comes, but I
doubt it will. The patch has been pushed upstream. Thanks.

Johan

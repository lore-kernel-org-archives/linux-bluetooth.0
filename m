Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Jan 2012 12:18:44 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Peter Krystad <pkrystad@codeaurora.org>, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 0/4] Add BT 3.0+HS parsing
Message-ID: <20120104101842.GD16309@aemeltch-MOBL1>
References: <1323756157-15487-1-git-send-email-pkrystad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323756157-15487-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 12, 2011 at 10:02:33PM -0800, Peter Krystad wrote:
> This patch adds parsing and display of BT 3.0+HS signalling
> 
> v3 - same content but A2MP definitions placed in l2cap.h

Looks OK, despite I would not mix typedefs and normal structs in one
patch (maybe we can even remove typedefs later).

Johan, as definitions moved to existing header, hence without modifying
license can these patches be applied?

Best regards 
Andrei Emeltchenko 

> 
> Peter Krystad (4):
>   Add L2CAP Create/Move channel and A2MP definitions
>   Add parsing of L2CAP Create/Move Channel signals
>   Add parsing of A2MP signals
>   Minor cleanup of indentation in output
> 
>  lib/l2cap.h     |  159 +++++++++++++++++++-
>  parser/hci.c    |   15 ++-
>  parser/l2cap.c  |  449 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  parser/parser.h |    1 +
>  src/hcidump.c   |    1 +
>  5 files changed, 619 insertions(+), 6 deletions(-)
> 


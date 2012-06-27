Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Jun 2012 10:34:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix GDBus flags after conversion to macros
Message-ID: <20120627073433.GA3938@x220>
References: <1340745085-31244-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340745085-31244-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Jun 26, 2012, Lucas De Marchi wrote:
> Commit "aa3b9016bf444b60e1b7e1804dfc323a23a93c5a Convert GDBus methods
> to use macro helpers" converted the previous tables to use the new
> macros but some flags were lost.
> ---
>  attrib/client.c   | 2 +-
>  audio/control.c   | 2 +-
>  audio/headset.c   | 2 +-
>  audio/transport.c | 2 +-
>  src/manager.c     | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Applied. Thanks.

Johan

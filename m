Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 12:46:48 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ 1/8] adapter: Add DBus.Properties getters
Message-ID: <20121009104648.GA11846@x220.example.org>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Tue, Oct 09, 2012, Lucas De Marchi wrote:
> ---
>  src/adapter.c | 221 +++++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 149 insertions(+), 72 deletions(-)

All of these patches have been applied. I also pushed three other
patches to convert list-devices, test-adapter and test-device to support
the new interfaces.

Johan

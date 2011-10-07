Return-Path: <cyrus@holtmann.org>
Date: Fri, 7 Oct 2011 23:27:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add support for cancelling a LE Scan with Control-C
Message-ID: <20111007202723.GB23669@fusion.localdomain>
References: <1317912132-6644-1-git-send-email-vinicius.gomes@openbossa.org>
 <1317924207-25529-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317924207-25529-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Oct 06, 2011, Vinicius Costa Gomes wrote:
> +static int signal_received;

This needs to be declared volatile and according to our coding style
explicitly initialized to 0. Other than that the patch is fine. I went
ahead and fixed this issue myself and pushed the patch upstream. Thanks.

Johan

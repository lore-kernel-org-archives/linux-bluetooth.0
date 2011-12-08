Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Dec 2011 14:33:04 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/4] gobex: always set CONNECTION_ID to 1 on unit
 tests
Message-ID: <20111208123304.GA7819@x220>
References: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Dec 05, 2011, Luiz Augusto von Dentz wrote:
> This simplify the creation of new test by not requiring different
> variables for every connection response.
> ---
>  unit/test-gobex-transfer.c |   41 ++++++++++++-----------------------------
>  1 files changed, 12 insertions(+), 29 deletions(-)

All four patches have been applied. Thanks.

Johan

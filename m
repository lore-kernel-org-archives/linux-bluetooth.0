Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 20:44:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix build error for hciemu
Message-ID: <20111202184401.GA21388@fusion.localdomain>
References: <1322850015-395-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322850015-395-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Fri, Dec 02, 2011, Anderson Lizardo wrote:
> Error:
> 
> test/hciemu.c: In function 'create_snoop':
> test/hciemu.c:155: error: 'S_IRUSR' undeclared (first use in this
> function)
> test/hciemu.c:155: error: (Each undeclared identifier is reported only
> once
> test/hciemu.c:155: error: for each function it appears in.)
> test/hciemu.c:155: error: 'S_IWUSR' undeclared (first use in this
> function)
> test/hciemu.c:155: error: 'S_IRGRP' undeclared (first use in this
> function)
> test/hciemu.c:155: error: 'S_IROTH' undeclared (first use in this
> function)
> ---
>  test/hciemu.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Applied. Thanks.

Johan

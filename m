Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Sep 2011 12:19:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/3] More attribute allocation fixes
Message-ID: <20110927091917.GS3952@dell>
References: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Tue, Sep 20, 2011, Anderson Lizardo wrote:
> Since the commit "Fix allocation of attribute values" I submitted last week
> (which was authored by Vinicius), we found a few other issues related to
> attribute allocation (thanks to Hendrik Sattler for the review of that commit,
> BTW). This series fixes those issues. The last commit replaces a few memcpy()
> operations with assignments, as suggested by Hendrik.
> 
> The allocation fixes have been tested with valgrind to make sure there are no
> obvious leaks.

All three patches have been applied. Thanks.

Johan

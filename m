Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Nov 2011 13:58:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 00/17] Fix errno handling convention
Message-ID: <20111117115821.GA7004@fusion.localdomain>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Wed, Nov 16, 2011, Anderson Lizardo wrote:
> This series fix various places where variables which get errno values (usually
> named "err") are not following the convention of always being negative. The
> last 3 patches are simple fixes found during this review.

All patches have been applied. Thanks.

Johan

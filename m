Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Oct 2011 11:19:25 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 3/4] Add attrib server channel detach
Message-ID: <20111005081925.GB11882@fusion.localdomain>
References: <CAKT1EBeusTPfkxJ59otvV29dpBUHqYt1U5afUEPYr50vEk+xkw@mail.gmail.com>
 <1317750628-22563-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317750628-22563-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Oct 04, 2011, Claudio Takahasi wrote:
> BlueZ will act as GAP central role, so for outgoing connections the
> central is responsible for disconnecting the link. This patch adds
> a function allowing the central to detach from the local attribute
> server(removing the last GAttrib reference).
> ---
>  src/attrib-server.c |   34 +++++++++++++++++++++++++++++++---
>  src/attrib-server.h |    3 ++-
>  src/device.c        |   11 ++++++++++-
>  3 files changed, 43 insertions(+), 5 deletions(-)

These two patches have also been applied. Thanks.

Johan

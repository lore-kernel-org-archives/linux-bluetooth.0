Return-Path: <cyrus@holtmann.org>
Date: Tue, 27 Mar 2012 14:59:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC PATCH BlueZ] doc: Revert "Small API update"
Message-ID: <20120327115931.GK14481@x220>
References: <1332778374-15320-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332778374-15320-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Mon, Mar 26, 2012, Anderson Lizardo wrote:
> This reverts commit fd1ac97806d4531cb54523b3d694899afce281e7. It seems
> the "entered" param is not used anymore.
> ---
>  doc/agent-api.txt |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)

Why do you want to remove this? How else can we relay key press
notifications to the user? Like with your other patch the fact that some
code is not used doesn't necessarily mean that it should be removed but
that something needs to be added to make it useful.

Also, it seems we've forgotten this part from the mgmt API as there's no
event specified for it at the moment.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Tue, 9 Oct 2012 23:15:26 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] core: fix stop scanning after GCEP
Message-ID: <20121009211526.GA21303@x220.c.hospitality.swisscom.com>
References: <1349804307-20318-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1349804307-20318-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Tue, Oct 09, 2012, João Paulo Rechi Vita wrote:
> The session type identification on struct session req (commit 328661a0)
> broke the stop condition of the LE Genereal Connection Establishment
> Procedure. This commit creates new identificators for discovery sessions
> and makes their naming a bit more clear.
> ---
>  src/adapter.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)

Applied. Thanks.

Johan

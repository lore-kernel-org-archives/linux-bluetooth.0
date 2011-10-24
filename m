Return-Path: <cyrus@holtmann.org>
Date: Mon, 24 Oct 2011 16:03:19 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 BlueZ] Add new command and event for LTK storage
 support
Message-ID: <20111024140319.GA11029@fusion.localdomain>
References: <1319459187-11092-1-git-send-email-vinicius.gomes@openbossa.org>
 <1319463212-13307-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319463212-13307-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, Oct 24, 2011, Vinicius Costa Gomes wrote:
> This documents the new command and event that are to be added to
> the Management API to add support for persistent pairing of LE
> devices.
> ---
> 
> Changes:
>  - New command code, because new commands were added;
>  - Removed the Debug Keys parameter;
> 
> 
>  doc/mgmt-api.txt |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)

Applied, except that the event needed to be 0x0018 instead of 17 because
of the new Passkey Request event.

Johan

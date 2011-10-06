Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Oct 2011 19:08:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix using the attribute struct for encoding ATT
 pdus
Message-ID: <20111006160834.GA11338@fusion.localdomain>
References: <1317911897-6567-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1317911897-6567-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Oct 06, 2011, Vinicius Costa Gomes wrote:
> The enconding and decoding of ATT pdus should be kept as much
> free of dependences from other parts of the code as possible, so
> it can be used in many contexts.
> 
> In this case, for encoding and decoding notifications and indications
> we did have to pass an instance of an attribute instead of direct
> values.
> ---
>  attrib/att.c |   45 +++++++++++++++++++++++++--------------------
>  attrib/att.h |    9 ++++++---
>  2 files changed, 31 insertions(+), 23 deletions(-)

Did you forget to include the changes to the places where this API is
used? The source tree should remain compilable between each individual
commit (to maintain e.g. bisectability) and that's not happening with
your patch.

Johan

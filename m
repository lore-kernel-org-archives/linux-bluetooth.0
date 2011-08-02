Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Aug 2011 16:49:33 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Proximity API simplification
Message-ID: <20110802134933.GA17778@dell.ger.corp.intel.com>
References: <CAKT1EBepAMrUzRvOMMiEyr5Zmist-rzD55pfnkSe+hRMdtM26A@mail.gmail.com>
 <1311114990-21762-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311114990-21762-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Tue, Jul 19, 2011, Claudio Takahasi wrote:
> Delegates the Immediate Alert Level control to the caller(client).
> Immediate Alert Service is shared between Path Loss and Find Me.
> 
> Three signal level states are defined: "good", "regular" and "weak".
> Meaning that at least two thresholds are necessary to implement a
> proper state transition. "unknown" will be returned if the link is not
> active. For Path Loss, the logic to trigger the writting operation of
> the Immediate Alert Level characteristic needs to be implemented in
> the client. SignalLevel can be only one of the inputs to define when
> and which value to write in the characteristic.
> ---
>  doc/proximity-api.txt |   36 ++++++------------------------------
>  1 files changed, 6 insertions(+), 30 deletions(-)

Applied. Thanks.

Johan

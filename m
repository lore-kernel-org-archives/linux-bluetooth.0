Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Mar 2011 11:17:59 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Add sap_disconnect_ind interface for sap-sim drivers
Message-ID: <20110325091759.GA1150@jh-x301>
References: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
 <1300983402-2970-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300983402-2970-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldek,

On Thu, Mar 24, 2011, Waldemar Rymarkiewicz wrote:
> The sap_disconnect_ind() let's the sim driver to indicate
> immediate disconnection.
> 
> Add support of immediate disconnection in sap-dummy driver
> as well as a card status change in order to pass all PTS tests.
> ---
>  sap/sap-dummy.c |   31 ++++++++++++++++++++++++-------
>  sap/sap.h       |    1 +
>  sap/server.c    |    7 +++++++
>  3 files changed, 32 insertions(+), 7 deletions(-)

Are you planning to have some additional Disconnect* method in the
future since you didn't reuse the existing "Disconnect" method name for
this? The patch is also missing the corresponding update to sap-api.txt.

Johan

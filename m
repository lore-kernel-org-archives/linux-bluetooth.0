Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Oct 2011 13:18:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Rafal Michalski <michalski.raf@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Fix pulling single vCard for parameters header
 missing
Message-ID: <20111020101831.GA4896@fusion.localdomain>
References: <1319099688-4427-1-git-send-email-michalski.raf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319099688-4427-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Rafal,

On Thu, Oct 20, 2011, Rafal Michalski wrote:
> According to PBAP specification (ANNEX A), all application-parameters
> are optional in case of pulling single vCard entry, so header for
> application-parameters can be omitted, and it would be valid as well.
> Previously pulling single vCard was always failing with "Bad Request"
> status in such a circumstance.
> This patch fixes that issue and pulling single vCard is done successfully
> with "OK" status. Output vCard would contain all fields under 2.1 format
> (as for default settings).
> ---
>  plugins/pbap.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan

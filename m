Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 May 2011 13:53:42 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 06/12] Unify inquiry results and advertises
Message-ID: <20110518205342.GB31478@dell.amr.corp.intel.com>
References: <1305656757-9731-1-git-send-email-claudio.takahasi@openbossa.org>
 <1305747562-19595-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1305747562-19595-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,

On Wed, May 18, 2011, Claudio Takahasi wrote:
> Adapter needs to have only one method to allow discovery results
> integration for both interfaces: hciops and mgmtops. This patch
> moves the code related to advertises parsing to the same function
> that handles inquiry results.
> ---
>  src/adapter.c |   67 ++++++++++++++++++--------------------------------------
>  src/adapter.h |    7 +----
>  src/event.c   |   25 +++-----------------
>  3 files changed, 28 insertions(+), 71 deletions(-)

Patches 3, 4 and 5 have been pushed upstream, but this one causes a
compiler error with gcc 4.6:

src/adapter.c: In function ‘adapter_update_found_devices’:
src/adapter.c:3008:28: error: variable ‘le’ set but not used [-Werror=unused-but-set-variable]

Please fix and resend.

Johan

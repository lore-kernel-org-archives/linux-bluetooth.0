Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Nov 2014 11:32:56 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v9 2/3] Bluetooth: Extract generic start and stop
 discovery
Message-ID: <20141125093256.GB15104@t440s.ger.corp.intel.com>
References: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
 <1416728993-4189-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416728993-4189-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sat, Nov 22, 2014, Jakub Pawlowski wrote:
> This commit extract generic_start_discovery and generic_stop_discovery
> in preparation for start and stop service discovery. The reason behind
> that is that both functions will share big part of code, and it would
> be much easier to maintain just one generic method.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  net/bluetooth/mgmt.c | 89 +++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 33 deletions(-)

People's dislike of these generic* functions was previously pointed out
but no good options were proposed, so let me give a try:

Considering that we don't allow multiple concurrent stop or start
discovery operations (the mgmt commands will return "busy" errors),
couldn't we simply look up whatever pending start/discovery command
there is and then use that to derive our response? I.e. instead of a
single mgmt_pending_find (which we anyway need to do) there'd
potentially be two such calls.

Regarding Stop Service Discovery, I'm starting to doubt whether the
whole thing is needed at all. It's exactly the same as Stop Discovery
and you don't even attempt to check that the Stop Discovery/Stop Service
Discovery matches the actual ongoing discovery type (i.e. your code
would allow stopping a normal discovery with Stop Service Discovery and
vice versa). So I'd propose to just drop the new method and reuse the
existing Stop Discovery to stop either one of these two types.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Nov 2014 15:27:47 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v12 3/3] Bluetooth: start and stop service discovery
Message-ID: <20141128132747.GA12799@t440s.lan>
References: <1417161184-17663-1-git-send-email-jpawlowski@google.com>
 <1417161184-17663-3-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1417161184-17663-3-git-send-email-jpawlowski@google.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Thu, Nov 27, 2014, Jakub Pawlowski wrote:
> This patch introduces start service discovery method. The reason
> behind that is to enable users to find specific services in range
> by UUID. Whole filtering is done in mgmt_device_found.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci_core.h |   4 +
>  include/net/bluetooth/mgmt.h     |   9 ++
>  net/bluetooth/hci_core.c         |   5 +
>  net/bluetooth/mgmt.c             | 271 ++++++++++++++++++++++++++++++++++-----
>  4 files changed, 260 insertions(+), 29 deletions(-)

With the exception of "stop service discovery" in the subject of this
patch that doesn't exist anymore, the patches are starting to look quite
good to me. Thank you for your patience with the many review rounds so
far!

Btw, for consistency please try to formulate your commit message
subjects so that they start with a verb, e.g. "Add ...", "Implement
...", "Fix ..." etc.

I've asked Marcel to take one last review of your patches before we push
them upstream.

Johan

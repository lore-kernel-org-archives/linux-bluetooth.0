Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Mar 2015 22:02:57 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 2/3] Bluetooth: Refactor service discovery filter logic
Message-ID: <20150304200257.GA10070@t440s.P-661HNU-F1>
References: <1425406613-21420-1-git-send-email-jpawlowski@google.com>
 <1425406613-21420-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425406613-21420-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Mar 03, 2015, Jakub Pawlowski wrote:
> This patch refactor code responsible for filtering when service
> discovery method is used.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  net/bluetooth/mgmt.c | 95 ++++++++++++++--------------------------------------
>  1 file changed, 26 insertions(+), 69 deletions(-)

One thing I forgot to mention: please add some more meat to the bones
for this commit message. It's particularly important that you describe
*why* the patch is good. Anyone can with a bit of reading see that the
patch does some refactoring, but the reasoning for doing it it not quite
as clear (and will be even less so if we or anyone else looks at the
commit history 1+ years in the future).

The same applies for any other commit message where you feel you could
improve with these details.

Johan

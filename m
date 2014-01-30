Return-Path: <cyrus@holtmann.org>
Date: Thu, 30 Jan 2014 14:14:28 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Enable LTK distribution to slave devices
Message-ID: <20140130161428.GA26840@molly>
References: <1391032559-25183-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391032559-25183-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 13:55 Wed 29 Jan, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> So far we've only been requesting the LTK to be distributed to the
> master (initiator) of pairing, which is usually enough since it's the
> master that will establish future connections and initiate encryption.
> However, in the case that both devices support switching to the opposing
> role (which seems to be increasingly common) pairing will have to
> performed again since the "new" master will not have all information.
>
> As there is no real harm in it, this patch updates the code to always
> try distributing the LTK also to the slave device, thereby enabling role
> switches for future connections.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---

Looks good. Ack.


Cheers,
--
Vinicius

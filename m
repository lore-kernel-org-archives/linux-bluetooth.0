Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 16:26:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Cycling Speed and Cadence profile (CSCP) API
Message-ID: <20120928132613.GB5075@x220>
References: <1348585647-25458-1-git-send-email-andrzej.kaczmarek@tieto.com>
 <1348585647-25458-2-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1348585647-25458-2-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Tue, Sep 25, 2012, Andrzej Kaczmarek wrote:
> +			Possible values: "Other", "Top of shoe", "In shoe",
> +					"Hip", "Front Wheel", "Left Crank",
> +					"Right Crank", "Left Pedal",
> +					"Right Pedal", "Front Hub",
> +					"Rear Dropout", "Chainstay",
> +					"Rear Wheel", "Rear Hub"

As I've pointed out in a couple of other (unrelated) patch reviews keep
string dict values lower-case. Also leave the spaces out. So you'll end
up getting stuff like "top-of-shoe", "in-shoe", "hip", etc.

Johan

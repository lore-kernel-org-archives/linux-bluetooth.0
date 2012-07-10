Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Jul 2012 15:26:51 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: Override status if local user rejects
 pairing
Message-ID: <20120710182651.GA31771@x220>
References: <1341551602-1493-1-git-send-email-jaganath.k@samsung.com>
 <1341551602-1493-2-git-send-email-jaganath.k@samsung.com>
 <20120706092510.GB10494@x220.ger.corp.intel.com>
 <FBDDCCD50B2547FF8FC981999BB7949E@sisodomain.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FBDDCCD50B2547FF8FC981999BB7949E@sisodomain.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Sat, Jul 07, 2012, Jaganath wrote:
> I think we can change setting auth_rejected to true only if the
> pairing is local initiated and reset it in pairing_complete (). Since
> mgmt_auth_failed() will be called before pairing_complete () it will
> be fine I think.  Please let me know your view on that.

I think this should be consistent regardless of which side triggered the
pairing, i.e. use STATUS_REJECTED always when our agent rejects it.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 15:56:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Hemant Gupta <hemantgupta.ste@gmail.com>
Cc: Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] mgmt: Add support for Passkey handling
Message-ID: <20111215135616.GA3164@x220>
References: <1323950056-28708-1-git-send-email-hemant.gupta@stericsson.com>
 <20111215120851.GA10113@x220>
 <CACj007=R3bmR2e=xgAdSXPXb12OdkAPXh_0qGba+mM46KBjjyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACj007=R3bmR2e=xgAdSXPXb12OdkAPXh_0qGba+mM46KBjjyQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hemant,

On Thu, Dec 15, 2011, Hemant Gupta wrote:
> Tanks for the comment, I used it since the kernel was using le32, and
> the structure allocated was u32? Dont we require to do the type
> casting?

No. To my understanding the difference is only annotational, i.e. it's
only there to remind you of the endianness of the variable. In user
space we just use uint32_t but have to remember to call btohl before
using the value for anything.

Johan

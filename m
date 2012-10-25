Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 10:50:45 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/6] Bluetooth: mgmt: Add support for switching to LE
 peripheral mode
Message-ID: <20121025075045.GA22397@x220>
References: <1351112996-9597-1-git-send-email-johan.hedberg@gmail.com>
 <1351112996-9597-6-git-send-email-johan.hedberg@gmail.com>
 <20121024221341.GA22764@samus>
 <20121024223635.GA11976@x220.P-661HNU-F1>
 <20121025005842.GB22764@samus>
 <1351130085.1785.84.camel@aeonflux>
 <20121025045605.GB12303@echo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121025045605.GB12303@echo>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Thu, Oct 25, 2012, Vinicius Costa Gomes wrote:
> So, what information will we use to set the advertising type and the
> Flags field in the advertising event (think general/limited
> discoverable modes)?

Take a look at the create_ad() function in the last patch of this set.
Setting the right flags value is really quite simple. The advertising
type could be selected in a similar way, i.e. through hdev->dev_flags.

Johan

Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Sep 2013 13:03:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/8] Bluetooth: Test for HCI_SETUP and HCI_USER_CHANNEL
 in mgmt_valid_hdev()
Message-ID: <20130925100353.GA3158@x220.p-661hnu-f1>
References: <1380031363-1266-1-git-send-email-johan.hedberg@gmail.com>
 <1380031363-1266-4-git-send-email-johan.hedberg@gmail.com>
 <DFCF34C2-5AA9-4644-BB4B-3D6073DA9D42@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DFCF34C2-5AA9-4644-BB4B-3D6073DA9D42@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 24, 2013, Marcel Holtmann wrote:
> > If either one of the HCI_SETUP or HCI_USER_CHANNEL flags is set the
> > device is not considered valid for mgmt. By having these checks inside
> > the mgmt_valid_hdev function the a couple of places using it can be
> > simplified.
> 
> I looked at doing this and decided not to. Reason was that the device
> gets removed from mgmt anyway.

I'm not sure what significance you think "device gets removed from mgmt"
has. All that is is a mgmt event saying that index has been removed. In
addition to that we need to ensure that we don't send any more mgmt
events for such devices and that we don't include such devices in the
response to mgmt_read_index list.

These are the two places of the code that my patch simplifies, one is
the check for whether to send a "power on" mgmt event and the other the
response handling of read_index_list.

Johan

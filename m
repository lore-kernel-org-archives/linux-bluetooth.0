Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Dell Inspiron 5565 to
 btusb_needs_reset_resume_table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180522073410.10329-1-hdegoede@redhat.com>
Date: Tue, 22 May 2018 09:36:33 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <82E86C23-70AF-4D05-8DDE-7B6FBE879BA3@holtmann.org>
References: <20180522073410.10329-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The Dell Inspiron 5565 uses a QCA Rome chip which needs to be reset
> (and have its firmware reloaded) for bluetooth to work after
> suspend/resume.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=15750392
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel


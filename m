Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: btusb: Add Dell XPS 13 9360 to
 btusb_needs_reset_resume_table
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180426185206.29508-1-hdegoede@redhat.com>
Date: Mon, 30 Apr 2018 11:13:48 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org,
        Garrett LeSage <glesage@redhat.com>
Message-Id: <824B1832-3EE9-420C-8E38-CF2EEA37D288@holtmann.org>
References: <20180426185206.29508-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The Dell XPS 13 9360 uses a QCA Rome chip which needs to be reset
> (and have its firmware reloaded) for bluetooth to work after
> suspend/resume.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Cc: stable@vger.kernel.org
> Cc: Garrett LeSage <glesage@redhat.com>
> Reported-and-tested-by: Garrett LeSage <glesage@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-stable tree.

Regards

Marcel


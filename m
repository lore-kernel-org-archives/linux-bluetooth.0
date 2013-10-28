Return-Path: <cyrus@holtmann.org>
Message-ID: <526E7AA2.5010701@redhat.com>
Date: Mon, 28 Oct 2013 15:54:26 +0100
From: Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
To: Gustavo Padovan <gustavo@padovan.org>
CC: USB list <linux-usb@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Regression fix revert: "Bluetooth: Add missing reset_resume
 dev_pm_ops"
References: <1380374739-11581-1-git-send-email-hdegoede@redhat.com> <20131002190248.GB3130@joana> <508150F6-D142-4406-8CC9-57DDE754F391@holtmann.org>
In-Reply-To: <508150F6-D142-4406-8CC9-57DDE754F391@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Patch has been applied to bluetooth.git. Thanks.

Hmm, I'm not seeing this in 3.12 yet, not only should this be added
to 3.12 asap, it should also really get added to 3.11.x soon.

The regression this patch fixes is breaking btusb for lots of users, see:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1213239
https://bugzilla.redhat.com/show_bug.cgi?id=988481

Where lots of people are adding me too comments (and some are building
their own kernels with the revert and confirming it fixes things for
them).

Regards,

Hans

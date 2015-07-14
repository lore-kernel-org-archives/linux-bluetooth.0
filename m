Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2] Bluetooth: btbcm: allow btbcm_read_verbose_config to fail on Apple
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150714202530.GD27622@ret.masoncoding.com>
Date: Tue, 14 Jul 2015 22:56:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <723246B0-5D93-41E8-ACE4-9700E4F7B754@holtmann.org>
References: <20150714202530.GD27622@ret.masoncoding.com>
To: Chris Mason <clm@fb.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chris,

> Commit 1c8ba6d013 moved around the setup code for broadcomm chips,
> and also added btbcm_read_verbose_config() to read extra information
> about the hardware.  It's returning errors on some macbooks:
> 
> Bluetooth: hci0: BCM: Read verbose config info failed (-16)
> 
> Which makes us error out of the setup function.  Since this
> probe isn't critical to operate the chip, this patch just changes
> things to carry on when it fails.
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> cc: stable@vger.kernel.org # v4.1

patch has been applied to bluetooth-stable tree.

Regards

Marcel


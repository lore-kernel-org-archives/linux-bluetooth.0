Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Apr 2012 13:14:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: vishal agarwal <vishal.bluez@gmail.com>
Cc: Vishal Agarwal <vishal.agarwal@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: eir_append_data should take care of padding
Message-ID: <20120425101422.GB26311@x220>
References: <1335340311-25057-1-git-send-email-vishal.agarwal@stericsson.com>
 <20120425090505.GA25179@x220>
 <CA+_sZW-2a4NiLA4SpYV44DLwWnnFeiD88_K_gQOSQX9rN9Bugg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+_sZW-2a4NiLA4SpYV44DLwWnnFeiD88_K_gQOSQX9rN9Bugg@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vishal,

No top-posting! I think I've told you this already before.

On Wed, Apr 25, 2012, vishal agarwal wrote:
> In function mgmt_device_found, which is called from
> hci_extended_inquiry_result_evt eir_append_data function is called
> without taking care of padding bytes. I will create a new function
> which will return the padding offset in the EIR data andit will be
> called in function mgmt_device_found before calling the
> eir_append_data function.

That's indeed a bug but please do it in hci_extended_inquiry_result_evt
since in the LE case the mgmt_device_found already gets the right
parameter value and we'd be needlessly trying to find the offset for LE
events.

Johan

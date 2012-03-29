Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 12:12:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 2/3] Bluetooth: Add dst_type parameter to hci_connect
Message-ID: <20120329091236.GA22600@x220>
References: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
 <1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Tue, Mar 27, 2012, Andre Guedes wrote:
> +		le->dst_type = (dst_type == MGMT_ADDR_LE_RANDOM) ?
> +				ADDR_LE_DEV_RANDOM : ADDR_LE_DEV_PUBLIC;

You might want to make a simple helper function for the type conversion.

Also, I'm not so sure it's a good idea to directly reuse mgmt API
defines for the L2CAP socket interface. The values may in the end be the
same but probably there should be separate defines in l2cap.h.

Johan

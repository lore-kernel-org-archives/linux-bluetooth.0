Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] Bluetooth: Create a unique mgmt error code hierarchy
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <1321027800-353-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 11 Nov 2011 13:49:07 -0300
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E91B9660-3CDC-4632-8718-4C3103362219@openbossa.org>
References: <1321021134-31809-2-git-send-email-johan.hedberg@gmail.com> <1321027800-353-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Nov 11, 2011, at 1:10 PM, johan.hedberg@gmail.com wrote:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The management protocol uses a single byte for error codes (aka command
> status). In some places this value is directly copied from HCI and in
> other a POSIX error number is used. This makes it impossible for
> user-space to uniquily decipher the meaning of an error.
> 
> To solve this issue a new mgmt-specific set of error codes is added
> along with a conversion table for HCI status values.

Using _only_ POSIX error codes in management protocol doesn't solve
this problems? We could use the bt_to_errno() function to translate
HCI errors into POSIX errors.

BR,

Andre

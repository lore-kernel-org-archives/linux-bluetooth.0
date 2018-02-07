Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH BlueZ 1/2] tester: Set event mask for LE Read Local P-256
 PK Complete event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1517951037-2970-1-git-send-email-tedd.an@linux.intel.com>
Date: Wed, 7 Feb 2018 09:38:35 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Tedd Ho Jeong An <tedd.an@intel.com>
Message-Id: <D3FE6B24-F9A3-40AB-BA4A-DE31520112BF@holtmann.org>
References: <1517951037-2970-1-git-send-email-tedd.an@linux.intel.com>
To: Tedd Ho-Jeong An <tedd.an@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> LE Read Local P-256 PK command fails because LE Read Local P-256 PK
> Complete event and LE Meta event are disabled by default.
> This patch sets event masks for LE Read Local P-256 PK Complete and
> LE Meta Event to receive the events for 'LE Read Local PK' test and
> 'LE Generate DHKey' test.
> ---
> tools/hci-tester.c | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

both patches have been applied.

Regards

Marcel


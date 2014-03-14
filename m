Return-Path: <cyrus@holtmann.org>
From: "Poulain, Loic" <loic.poulain@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: ipc-common.h missing in bluez 5.16
Date: Fri, 14 Mar 2014 16:59:54 +0000
Message-ID: <50C3158CF44D924791C15F1437EF2EC65D29E4@HASMSX104.ger.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I Downloaded bluez-5.16.tar.xz from bluez.org, but there is a compile issue=
 for android target.
ipc-common.h is missing (in /android). Adding this file from master make it=
 works.

Regards,
Loic Poulain
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

Return-Path: <cyrus@holtmann.org>
Message-ID: <55B5E896.4000707@intel.com>
Date: Mon, 27 Jul 2015 10:15:18 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_uart: Add Intel baudrate configuration
 support
References: <1437472694-4805-1-git-send-email-loic.poulain@intel.com> <B70087AE-159E-4483-B599-11A4DD3D4538@holtmann.org>
In-Reply-To: <B70087AE-159E-4483-B599-11A4DD3D4538@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>
> this is a really bad behavior from our firmware then. We would actually like to get the cmd status or cmd complete on the current baud rate and once that has been confirmed, we switch to the new baud rate. I remember that there are actually two different baud rate change commands for the Intel controllers. Are you using the right one?

I don't know about a second vendor command to change the baudrate.
I use the same one used in hciattach_intel where the behavior seems 
identical.


Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

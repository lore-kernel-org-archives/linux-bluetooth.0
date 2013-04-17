Return-Path: <cyrus@holtmann.org>
Message-ID: <516E5317.7070705@linux.intel.com>
Date: Wed, 17 Apr 2013 09:45:27 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?=
 <frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 2/6] Bluetooth: Add bluetooth socket voice option
References: <1366126143-28545-1-git-send-email-frederic.dalleau@linux.intel.com> <1366126143-28545-3-git-send-email-frederic.dalleau@linux.intel.com> <7D7C6747-5C34-41F2-8EC7-4855C5689643@holtmann.org>
In-Reply-To: <7D7C6747-5C34-41F2-8EC7-4855C5689643@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

> wouldn't it be better if this default to the current controller setting. However I realize that the controller might be actually not yet present. So shouldn't we default to 0x0060 for CVSD.

For now, 0 is a placeholder. It maintains behavior for existing
code. BT_VOICE_CVSD is planned for S3, S2, S1 fallback for eSCO. But
IMHO, this needs some heavy interop testing. When interoperability is
ensured,  BT_VOICE_CVSD could be used as default. The patch will be a
one liner.

Regards,
Frédéric

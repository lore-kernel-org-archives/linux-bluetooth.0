Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [BUG] Btattach, ioctl fails to set flags from 32-bit user space to 64-bit
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAA+NYvRGebocnnYjdy2wLQkqsPT+WiNUE4trOS0zbL547Uar-w@mail.gmail.com>
Date: Fri, 22 Jan 2016 14:38:20 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E49EE6B1-CAEC-43D1-9B95-82EA592F628B@holtmann.org>
References: <CAA+NYvTV6WybKuO71Gehm6L2-vjsqVhmu5VjEQCfqFaWi1TU6Q@mail.gmail.com> <C72941BE-7F8A-4CD7-900E-5E8E6E42FD63@holtmann.org> <CAA+NYvRGebocnnYjdy2wLQkqsPT+WiNUE4trOS0zbL547Uar-w@mail.gmail.com>
To: Jaap Jan Meijer <jjmeijer88@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaap,

> Thank you, that was very good guess work. Btattach is now able to
> attach by bcm43241 in the mixed arch situation. Should I supply a
> patch or will you just add it? I'll will send-email a patch anyway.

I just send a patch that should be more correct on all platforms. Can you try that one out please.

Regards

Marcel


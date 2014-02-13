Return-Path: <cyrus@holtmann.org>
Message-ID: <52FC13F0.8040809@hurleysoftware.com>
Date: Wed, 12 Feb 2014 19:38:08 -0500
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Gianluca Anzolin <gianluca@sottospazio.it>,
 Alexander Holler <holler@ahsoftware.de>,
 Andrey Vihrov <andrey.vihrov@gmail.com>,
 Sander Eikelenboom <linux@eikelenboom.it>,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/24] rfcomm fixes
References: <1391997564-1805-1-git-send-email-peter@hurleysoftware.com> <3E0F3723-029F-4B12-8D77-9790FDBD3227@holtmann.org> <52F95A10.5010507@hurleysoftware.com> <433F6D97-A126-4F9F-96AC-4385575E005E@holtmann.org>
In-Reply-To: <433F6D97-A126-4F9F-96AC-4385575E005E@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 02/12/2014 05:58 PM, Marcel Holtmann wrote:
> we might also want to add some end-to-end test cases to rfcomm-tester that covers this behavior.

Are there some docs for the linux-bluetooth test harness?

I have some unit tests that I can port but I should probably understand
the bluetooth test framework first. A lot of my unit tests are designed
to test races with the ioctl interface, device creation and initialization,
teardown, tty open, close, etc.

Would that kind of unit test fit in the test harness design?

Regards,
Peter Hurley

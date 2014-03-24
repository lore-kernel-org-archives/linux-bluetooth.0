Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140324090341.GC26197@t440s.lan>
References: <1395429633-656-1-git-send-email-claudio.takahasi@openbossa.org>
	<20140324090341.GC26197@t440s.lan>
Date: Mon, 24 Mar 2014 10:40:02 -0300
Message-ID: <CAKT1EBcKfiBV061mXFMGu2kEvsWLe0oPGBkUAvE5nAjD+33e1g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 1/4] gatt: Fix coding style when testing pointers
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan:

On Mon, Mar 24, 2014 at 6:03 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Claudio,
>
> On Fri, Mar 21, 2014, Claudio Takahasi wrote:
>> Use !ptr instead of ptr == NULL
>> ---
>>  src/gatt-dbus.c | 10 +++++-----
>>  src/gatt.c      |  8 ++++----
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> I've applied patches 2 and 3 from this set. The other two didn't apply
> cleanly.
>
> Johan


I will re-send the patches again after "Add basic GATT
characteristics" gets integrated.

Regards,
Claudio

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100620040807.GA32372@vigoh>
References: <1276848536-29895-1-git-send-email-johan.hedberg@gmail.com>
	<20100620040807.GA32372@vigoh>
Date: Tue, 29 Jun 2010 15:58:04 +0300
Message-ID: <AANLkTilxzitFXhP-Q3TB_NHF7mtJer8I5pdtwnJ8Kt-3@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Reset the security level after an
	authentication failure
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Jun 20, 2010 at 7:08 AM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi Johan,
>
> * johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-06-18 11:08:56 +0300]:
>
>> From: Johan Hedberg <johan.hedberg@nokia.com>
>>
>> When authentication fails for a connection the assumed security level
>> should be set back to BT_SECURITY_LOW so that subsequent connect
>> attempts over the same link don't falsely assume that security is
>> adequate enough.
>>
>> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
>> ---
>>  net/bluetooth/hci_event.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> It works fine to me.

We have tested this patch.

>
> Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

Reviewed-by: Emeltchenko Andrei <andrei.emeltchenko@nokia.com>

Regards,
Andrei Emeltchenko

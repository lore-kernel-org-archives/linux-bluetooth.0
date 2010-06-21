Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100620041459.GB32372@vigoh>
References: <1276606565-4381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<20100620041459.GB32372@vigoh>
Date: Mon, 21 Jun 2010 14:41:21 +0300
Message-ID: <AANLkTil_iqbaU5HxyGeUnVXqM87x1O_yVGpJ2s76Uwwk@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update sec_level and auth_type for already
	existing connections
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Sun, Jun 20, 2010 at 7:14 AM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi Andrei,
>
> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-06-15 15:56:05 +0300]:
>
>> From: Ville Tervo <ville.tervo@nokia.com>
>>
>> Update auth level for already existing connections if it is lower
>> than required by new connection.
>>
>> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
>> Reviewed-by: Emeltchenko Andrei <andrei.emeltchenko@nokia.com>
>> Signed-off-by: Luciano Coelho <luciano.coelho@nokia.com>
>> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>> ---
>>  net/bluetooth/hci_conn.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> What's the use case here? i.e., how do I test your patch?

- Create a device using org.bluez.Adapter.CreateDevice() and
-  immediately call org.bluez.adapter.CreatePairedDevice() to pair.

EXPECTED OUTCOME:
Devices are paired, and confirmation is asked on both.

ACTUAL OUTCOME:
Devices are paired without confirmation. If I wait 10 seconds after
CreateDevice, the confirmation is asked on both devices.

-- Regards,
Andrei

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYPSTh0CcN6fKc9NcbYmvZK3j8AwfNnMqkBkoTt-UFccSg@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
	<CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
	<CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
	<CACUGKYMv_X4DgU+C0V=PA_PfYRQYnKO1LM4SoDbfcB2O-XkJvQ@mail.gmail.com>
	<CAJdJm_MYn=eG93WTPmHWu98t3Ufqrc9pXDpdBbCvbT-JdYeOaw@mail.gmail.com>
	<CACUGKYPSTh0CcN6fKc9NcbYmvZK3j8AwfNnMqkBkoTt-UFccSg@mail.gmail.com>
Date: Thu, 13 Sep 2012 14:36:47 -0400
Message-ID: <CAJdJm_PwrHdWnp6xXoYzd8GLigO3YSHdS-6feVj+c-9u3sjk5A@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Thu, Sep 13, 2012 at 2:18 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Anderson,
>
> Here's what I did:
>
> I set the EnableGatt=true and executed my bluetoothd. The debug
> messages of bluetoothd confirmed that it was responding to the request
> of my iPhone.

Which messages did you see?

>
> I used gatttool to connect to the device and read the characteristic..

gatttool is only for testing. It will open a bluetooth socket and talk
directly with the kernel (without bluetoothd help). In fact, it runs
just fine without any bluetoothd running (you need to do a "hciconfig
hciX up" though).

If you want your app to properly integrate with bluetoothd, you need
to create connections using BlueZ's D-Bus APIs.

Take a look at some example code:

test/test-device (if you need to do the pairing from your application)
test/test-attrib (if you want to talk to some profile not supported by
BlueZ yet)
test/test-thermometer (for GATT Health Thermometer)
test/test-proximity (for GATT Proximity)
...

if the profile you want to use is one of the official ones, we
encourage you implement them as a BlueZ plugin, and provide some D-Bus
API that your app (or other apps) can use. That way we avoid
duplicating profile implementations. See for example the thermometer
(HTP) and proximity (PXP) implementations in BlueZ.

Some others are in process of being implemented upstream: Battery,
Heart Rate, and Server profiles (Time, Alert Notification, Phone Alert
Status).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

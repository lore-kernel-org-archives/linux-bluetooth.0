Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYPf+2ZP6y5rfy8kbnanxCJt3pL800E6bHNO6WUSifQW+A@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
	<CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
	<CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
	<CACUGKYMv_X4DgU+C0V=PA_PfYRQYnKO1LM4SoDbfcB2O-XkJvQ@mail.gmail.com>
	<CAJdJm_MYn=eG93WTPmHWu98t3Ufqrc9pXDpdBbCvbT-JdYeOaw@mail.gmail.com>
	<CACUGKYPSTh0CcN6fKc9NcbYmvZK3j8AwfNnMqkBkoTt-UFccSg@mail.gmail.com>
	<CAJdJm_PwrHdWnp6xXoYzd8GLigO3YSHdS-6feVj+c-9u3sjk5A@mail.gmail.com>
	<CACUGKYNPWDCbQgtA6u33NXn_U3CMm9q6vGqEAaA9FOPPjqeJiw@mail.gmail.com>
	<CACUGKYPf+2ZP6y5rfy8kbnanxCJt3pL800E6bHNO6WUSifQW+A@mail.gmail.com>
Date: Thu, 13 Sep 2012 16:18:15 -0400
Message-ID: <CAJdJm_MFT=KTREZavd_oaOVT24+jUsAXH=d-K8F0Rwyi6V1rQg@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Thu, Sep 13, 2012 at 4:11 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Anderson,
>
> If I add a simple GATT/GAP server on gatttool, should I still use the
> DBUS to listen or I can communicate directly to the kernel?.

You either talk to bluetoothd (using D-Bus, like those test-* python
scripts do), which will handle connections for you, or you talk
directly to kernel using bluetooth socket (like gatttool does). You
have more flexibility talking to the kernel directly, but your app
will not be interoperable with other apps running at the same time,
specially if they try to call connect() at the same time (one of them
will get a EBUSY error).

Using D-Bus, on the other hand, bluetoothd queues the connections properly.

So you should use what is more appropriate for your use case.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYNPWDCbQgtA6u33NXn_U3CMm9q6vGqEAaA9FOPPjqeJiw@mail.gmail.com>
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
Date: Thu, 13 Sep 2012 16:11:28 -0400
Message-ID: <CAJdJm_PR+e0nRZ6bpfcV7JsBPmR6Zm8u0BcggAQTMQ2QO6GX5A@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Thu, Sep 13, 2012 at 2:44 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Which messages did you see?
>
> The ran the bluetoothd with debug message:
>
> [snip]

This log just shows the temporary device being created due to the
connection made by gatttool. bluetoothd does not have any open socket
where the ATT requests could be handled (unless the connection was
created by bluetoothd itself and not gatttool).

If bluetoothd GATT server processed the ATT request sent by your
phone, you would see this:

bluetoothd[NNNN]: src/attrib-server.c:channel_handler() op 0x10

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

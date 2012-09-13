Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYMv_X4DgU+C0V=PA_PfYRQYnKO1LM4SoDbfcB2O-XkJvQ@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
	<CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
	<CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
	<CACUGKYMv_X4DgU+C0V=PA_PfYRQYnKO1LM4SoDbfcB2O-XkJvQ@mail.gmail.com>
Date: Thu, 13 Sep 2012 14:07:14 -0400
Message-ID: <CAJdJm_MYn=eG93WTPmHWu98t3Ufqrc9pXDpdBbCvbT-JdYeOaw@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Thu, Sep 13, 2012 at 1:50 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Anderson,
>
> Here are the logs after reading the characteristic from my iPad apps
> that do the advertising.

I can just confirm what Vinicius said, the disconnection after 30s
happens because the IPad sent a "Read By Type req" that gatttool does
not answer because it does not run a GATT server.

Are you planning to implement any client (or server) profile for these
apps? If so, you should look at how to implement them as BlueZ
plugins.

You could also try to implement a simple GATT/GAP server on gatttool,
so you could use it for testing without any disconnections.


PS: interestingly, it seems IPad apps are able to send connectable
advertising over LE channel from a dual mode controller... which is
against Core spec 4.0... odd.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

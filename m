Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
	<CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
Date: Thu, 13 Sep 2012 06:53:37 -0400
Message-ID: <CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: John Tobias <john.tobias.ph@gmail.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

On Wed, Sep 12, 2012 at 10:52 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hello again,
>
> I enabled the GATT in my bluetoothd and found out that there was an
> unimplemented attribute (below) and might be the reason why the iPhone
> connection got disconnected after 30 secs.
>
> 2012-09-12 15:36:55.419980 > ACL data: handle 76 flags 0x02 dlen 9
>     ATT: Error (0x01)
>       Error: Attribute not found (10)
>       Read By Type req (0x08) on handle 0x0039
>
> I would like to know if anyone here has a patch?.

Just this snippet does not say much. "Attribute not found" errors are
common during service/characteristic discovery because they indicate
that the discovery has finished.

Could you post the whole hcidump since the connection establishment up
to the disconnection? That should help detecting the problem.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

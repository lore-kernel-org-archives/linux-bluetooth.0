Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8BF3576D9B1446A3AF8908F58AF314CE@sisodomain.com>
References: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
	<1362402872-13080-2-git-send-email-jaganath.k@samsung.com>
	<CAJdJm_P8unpbmR6Y1dzmkmXErrP6cLwaX8wza_6f+EPB5rr=CA@mail.gmail.com>
	<A94F3F1039284ED7AB00B9BC928893CD@sisodomain.com>
	<8BF3576D9B1446A3AF8908F58AF314CE@sisodomain.com>
Date: Fri, 8 Mar 2013 08:25:26 -0400
Message-ID: <CAJdJm_Om0Rpv__KaKTdiqUxHrKj9GWKi6S971zp1-pBJkjMA2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] attrib: Fix use after free of attrib
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Gomes <vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Mar 8, 2013 at 8:03 AM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
>> I got this issue in BlueZ 4.101 when I called "DiscoverCharacteristics".
>> "GetProperty" and "SetProperty" of characteristics. Please see the logs
> [...]

Sorry for the delay. I talked with Vinicius Gomes (who recently worked
on the GAttrib code), and he agrees this fix is valid.

Were you able to test this change on BlueZ 5, e.g. using gatttool or
some supported LE profile?

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil

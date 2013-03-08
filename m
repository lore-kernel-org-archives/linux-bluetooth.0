Return-Path: <cyrus@holtmann.org>
Message-id: <09E9BAE585E641F49AB5BF6C218841C9@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Gomes <vinicius.gomes@openbossa.org>
References: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
 <1362402872-13080-2-git-send-email-jaganath.k@samsung.com>
 <CAJdJm_P8unpbmR6Y1dzmkmXErrP6cLwaX8wza_6f+EPB5rr=CA@mail.gmail.com>
 <A94F3F1039284ED7AB00B9BC928893CD@sisodomain.com>
 <8BF3576D9B1446A3AF8908F58AF314CE@sisodomain.com>
 <CAJdJm_Om0Rpv__KaKTdiqUxHrKj9GWKi6S971zp1-pBJkjMA2Q@mail.gmail.com>
In-reply-to: <CAJdJm_Om0Rpv__KaKTdiqUxHrKj9GWKi6S971zp1-pBJkjMA2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] attrib: Fix use after free of attrib
Date: Fri, 08 Mar 2013 18:19:43 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

--------------------------------------------------
From: "Anderson Lizardo" <anderson.lizardo@openbossa.org>
Sent: Friday, March 08, 2013 5:55 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>; "Vinicius Gomes" 
<vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 2/3] attrib: Fix use after free of attrib

> Hi Jaganath,
>
> On Fri, Mar 8, 2013 at 8:03 AM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>>> I got this issue in BlueZ 4.101 when I called "DiscoverCharacteristics".
>>> "GetProperty" and "SetProperty" of characteristics. Please see the logs
>> [...]
>
> Sorry for the delay. I talked with Vinicius Gomes (who recently worked
> on the GAttrib code), and he agrees this fix is valid.
>
> Were you able to test this change on BlueZ 5, e.g. using gatttool or
> some supported LE profile?
>
I could not test this on BlueZ 5 since we are still using BlueZ 4.101 which 
I tested
and is working fine.

Thanks,
Jaganath 


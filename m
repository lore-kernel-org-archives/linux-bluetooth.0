Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6_p-EUnhGj_M1hpH59x_poQ7cAc1NxywXiW_Jzz57RrA@mail.gmail.com>
References: <CAPHSBCni_-kAXyr-qY+oXetq1R6A_fcdAjiYYEJRQtss3DEbRw@mail.gmail.com>
	<CAMOw1v6_p-EUnhGj_M1hpH59x_poQ7cAc1NxywXiW_Jzz57RrA@mail.gmail.com>
Date: Thu, 23 Feb 2012 09:46:22 +0530
Message-ID: <CAPHSBCkbHSOiPtjCPT-Dy5dU+QNmiQ-fdTSpUfOsUnDizeYOhw@mail.gmail.com>
Subject: Re: AVRCP Controller Role
From: Rohit Sharma <rohitsharmaddun@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Lucas.

Regards
Rohit Sharma

On Thu, Feb 23, 2012 at 1:29 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Hi Rohit,
>
> On Wed, Feb 22, 2012 at 8:02 AM, Rohit Sharma <rohitsharmaddun@gmail.com> wrote:
>> Hi All,
>>
>> I am testing the AVRCP support on bluez. For target role looks the
>> support is there and i am trying to test this using amarok player.
>> Thanks.
>> For Controller role i cannot get the information how can sending
>> VENDERDEPENDENT or PASSTHROUGH command is supported, please let me
>> know how can i test sending these commands.
>
> They are currently not supported. BlueZ in CT role has a very limited
> set of functionality (afair it's just volume up and down).
> Theoretically, CT role could share some bits with TG (see
> audio/avctp.c and audio/avrcp.c) but it's currently not done.
>
>
> Regards,
> Lucas De Marchi

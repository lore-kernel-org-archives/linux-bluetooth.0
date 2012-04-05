Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120405063513.GA804@aemeltch-MOBL1>
References: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
	<1333570571-29650-4-git-send-email-claudio.takahasi@openbossa.org>
	<20120405063513.GA804@aemeltch-MOBL1>
Date: Thu, 5 Apr 2012 20:17:17 -0300
Message-ID: <CACJA=fV5G2K7DFJqC1yO=FiaeZqAJBkfPDUKLTcovWy0ZcvHgQ@mail.gmail.com>
Subject: Re: [RFC BlueZ 4/4] l2test: Add option to inform the address type
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Apr 5, 2012 at 3:35 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Claudio,
>
> On Wed, Apr 04, 2012 at 05:16:11PM -0300, Claudio Takahasi wrote:
> ...
>
>> +     addr.l2_bdaddr_type = bdaddr_type;
>>       if (cid)
>
> ...
>
>> @@ -1020,6 +1022,7 @@ static void info_request(char *svr)
>> +     addr.l2_bdaddr_type = bdaddr_type;
>
> ...
>
>> @@ -1167,6 +1170,7 @@ static void do_pairing(char *svr)
>> +     addr.l2_bdaddr_type = bdaddr_type;
>
> ...
>
>> +             case 'V':
>> +                     bdaddr_type = atoi(optarg);
>
> Apparently there is no check that value is correct. I think that you can
> use here lookup_table (see l2cap_modes and chan_policies).

Sure, I'll do it.

Thanks,

Andre

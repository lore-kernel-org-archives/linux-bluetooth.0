Return-Path: <cyrus@holtmann.org>
From: "Zhang, Jingke" <jingke.zhang@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez/Obexd upstream test result_20120515
Date: Tue, 15 May 2012 09:03:52 +0000
Message-ID: <8C91AD8ED4077A4786B34154085899251024A4B6@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
	<20120515075406.GC31087@aemeltch-MOBL1>
	<8C91AD8ED4077A4786B34154085899251024A42C@SHSMSX102.ccr.corp.intel.com>
	<20120515081247.GD31087@aemeltch-MOBL1>
	<8C91AD8ED4077A4786B34154085899251024A463@SHSMSX102.ccr.corp.intel.com>
 <CABBYNZJGhUK6Ypv_s4Dt7Ekgi8AZ6fvKtL3hn4bL6Vo2XJoGdQ@mail.gmail.com>
In-Reply-To: <CABBYNZJGhUK6Ypv_s4Dt7Ekgi8AZ6fvKtL3hn4bL6Vo2XJoGdQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
I attached the sdp browse info into bug. Please check again, thanks!

-----Original Message-----
From: Luiz Augusto von Dentz [mailto:luiz.dentz@gmail.com] 
Sent: Tuesday, May 15, 2012 4:34 PM
To: Zhang, Jingke
Cc: Andrei Emeltchenko; linux-bluetooth@vger.kernel.org
Subject: Re: Bluez/Obexd upstream test result_20120515

Hi,

On Tue, May 15, 2012 at 11:17 AM, Zhang, Jingke <jingke.zhang@intel.com> wrote:
> Well, I can understand only the kernel panic picture is not enough, 
> however, it is also hard to get call trace from my testing machine 
> because there is no serial port. :(
>
> But it is interesting that, same environment has no same panic if I used obexd-0.44. So, I have to notify 0.45 potential issue. I saw something related to timer.c, but I am not sure where bug is.

Regarding bug 25109, this seems to be causing the problem:

obex-client[969]: client/bluetooth.c:transport_connect() port 65535

Apparently this is a problem parsing the record, can you attach the output of sdptool browse to the bug.

--
Luiz Augusto von Dentz

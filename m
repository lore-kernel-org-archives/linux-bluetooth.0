Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <8C91AD8ED4077A4786B34154085899251024A463@SHSMSX102.ccr.corp.intel.com>
References: <8C91AD8ED4077A4786B34154085899251024A31C@SHSMSX102.ccr.corp.intel.com>
	<20120515075406.GC31087@aemeltch-MOBL1>
	<8C91AD8ED4077A4786B34154085899251024A42C@SHSMSX102.ccr.corp.intel.com>
	<20120515081247.GD31087@aemeltch-MOBL1>
	<8C91AD8ED4077A4786B34154085899251024A463@SHSMSX102.ccr.corp.intel.com>
Date: Tue, 15 May 2012 11:34:18 +0300
Message-ID: <CABBYNZJGhUK6Ypv_s4Dt7Ekgi8AZ6fvKtL3hn4bL6Vo2XJoGdQ@mail.gmail.com>
Subject: Re: Bluez/Obexd upstream test result_20120515
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Zhang, Jingke" <jingke.zhang@intel.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, May 15, 2012 at 11:17 AM, Zhang, Jingke <jingke.zhang@intel.com> wrote:
> Well, I can understand only the kernel panic picture is not enough, however, it is also hard to get call trace from my testing machine because there is no serial port. :(
>
> But it is interesting that, same environment has no same panic if I used obexd-0.44. So, I have to notify 0.45 potential issue. I saw something related to timer.c, but I am not sure where bug is.

Regarding bug 25109, this seems to be causing the problem:

obex-client[969]: client/bluetooth.c:transport_connect() port 65535

Apparently this is a problem parsing the record, can you attach the
output of sdptool browse to the bug.

-- 
Luiz Augusto von Dentz

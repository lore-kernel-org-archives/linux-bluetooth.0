Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140307122228.GA4954@aemeltch-MOBL1>
References: <1394194543-3095-1-git-send-email-luiz.dentz@gmail.com>
	<20140307122228.GA4954@aemeltch-MOBL1>
Date: Fri, 7 Mar 2014 15:00:30 +0200
Message-ID: <CABBYNZJN5AU6jqDSq9P-MxKL09wZiiX1MFwUesRhzj+dGxLW7w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] android/avrcp-lib: Add avrcp_register_notification
 function
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Mar 7, 2014 at 2:22 PM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, Mar 07, 2014 at 02:15:40PM +0200, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> This adds avrcp_register_notification which can be used to send
>> RegisterNotification PDUs.
>
> Didn't I sent the same patch already? Why are we redoing the same work?

Im implementing the daemon side, this is the problem of sending big
patch sets it takes more time and I want to finish the AVRCP quickly
so we can have it tested. Btw, Im not sure why you are still defining
the PDU length public, this should probably be keep private until we
have proper struct defined, in fact I did mention that we might change
the way the handlers works in avrcp-lib to incorporate more logic and
do things like header checks that the unit test has been doing.

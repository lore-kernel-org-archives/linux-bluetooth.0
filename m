Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130606155959.GA9652@joana>
References: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
	<1370528339-7921-4-git-send-email-gustavo@padovan.org>
	<CABBYNZLxeRNBL4KBjs624pVSvDv76pbV4u+Y8K6VuNnHD8ApVg@mail.gmail.com>
	<20130606155959.GA9652@joana>
Date: Thu, 6 Jun 2013 23:06:36 +0700
Message-ID: <CABBYNZ+HZ1N4XD0X-3fNh0yiF5ALAkFpte+G9z_2YmiuSAhJ9w@mail.gmail.com>
Subject: Re: [RFC v0 4/5] adapter: add RequestDiscoverable() and ReleaseDiscoverable()
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Jun 6, 2013 at 10:59 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Luiz,
>
> * Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2013-06-06 22:50:32 +0700]:
>
>> Hi Gustavo,
>>
>> On Thu, Jun 6, 2013 at 9:18 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
>> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> >
>> > With those two methods BlueZ is now aware of client lifetime and can set
>> > Discoverable back to False if all clients exit or call
>> > ReleaseDiscoverable()
>> > ---
>>
>> This probably should be handled int the component controlling the
>> powered state like we used to have with RequestSession or we can have
>> an agent to the power/policy manager asking if it is ok to power on
>> the adapter.
>
> Not sure if it makes sense to put this in the component that handles power
> state (you mean ConnMan here, for example?). How an agent for this can help
> us. The problem I'm trying to solve here is, do not let the Discoverable True
> for infinite time if the who is using crashes.

There is the exact same problem with Powered isn't it? If the
application crashes will stay on, actually with an agent we can always
request the component controlling it e.g. ConnMan to confirm the
action.


--
Luiz Augusto von Dentz

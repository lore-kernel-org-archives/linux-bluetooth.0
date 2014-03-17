Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZL8Okni+ndvYUch80X5DkF4e4z-O86v00d_roS1JTOGEg@mail.gmail.com>
References: <1395043737-8905-1-git-send-email-luiz.dentz@gmail.com>
	<20140317083837.GA16561@aemeltch-MOBL1>
	<CABBYNZL8Okni+ndvYUch80X5DkF4e4z-O86v00d_roS1JTOGEg@mail.gmail.com>
Date: Mon, 17 Mar 2014 15:01:12 +0200
Message-ID: <CABBYNZLm2LoG12a1+1v9cDTBc0iG=yu5XFNnPDpCkH2HZ0GeEQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 01/12] android/avrcp-lib: Change API to register
 callbacks instead of PDU handlers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Mar 17, 2014 at 11:22 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Andrei,
>
> On Mon, Mar 17, 2014 at 10:38 AM, Andrei Emeltchenko
> <andrei.emeltchenko.news@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Mon, Mar 17, 2014 at 10:08:46AM +0200, Luiz Augusto von Dentz wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> This adds avrcp_register_player function to register callbacks for
>>> requests and responses, the fundamental difference is that the
>>> callbacks are called after the original PDU is parsed and the parameter
>>> are converted to host byte order making us able to unit test the
>>> parsing itself.

Pushed.

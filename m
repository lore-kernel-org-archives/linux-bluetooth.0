Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimwz1D4W9rT6E=84r+3OGkjTen=xg@mail.gmail.com>
References: <BANLkTi=L1xG3gVi9bmuW_YSWcOmu1HiRoQ@mail.gmail.com>
	<BANLkTin3vWrRigXOHQbJKr3rbN1xoirdYw@mail.gmail.com>
	<BANLkTi=1Si-h9AuMRCBKnBjhj6=LXYhuFQ@mail.gmail.com>
	<BANLkTinYb=i9iYNR0Uhd7YG84jdGht2gNg@mail.gmail.com>
	<BANLkTimwz1D4W9rT6E=84r+3OGkjTen=xg@mail.gmail.com>
Date: Wed, 1 Jun 2011 10:58:56 +0300
Message-ID: <BANLkTimyLAz6bFMv3eV_2QaCYfjGHH_wcA@mail.gmail.com>
Subject: Re: [PATCH] Init telephony before adding HFP SDP records
From: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, May 27, 2011 at 1:45 PM, Daniel Örstadius
<daniel.orstadius@gmail.com> wrote:
> Hi Luiz,
>
> On Fri, May 27, 2011 at 1:26 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Daniel,
>>
>> On Fri, May 27, 2011 at 11:40 AM, Daniel Örstadius
>> <daniel.orstadius@gmail.com> wrote:
>>> Hi Luiz,
>>>
>>> On Thu, May 26, 2011 at 6:44 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Daniel,
>>>>
>>>> On Thu, May 26, 2011 at 4:58 PM, Daniel Örstadius
>>>> <daniel.orstadius@gmail.com> wrote:
>>>>> Please review.
>>>>
>>>> For telephony-maemo6 it should be enough to just call
>>>> headset_server_init after state_changed/telephony_init.
>>>>
>>>
>>> Thanks for the feedback, that seems like a much leaner solution.
>>> Attaching new patch.
>>
>> Looks much better, shall I take care of fixing telephony-ofono or you
>> already have a patch for it?
>>
>> --
>> Luiz Augusto von Dentz
>> Computer Engineer
>>
>
> No, since I'm not familiar with ofono I didn't make a patch for that issue.
>
> Regards,
> Daniel
>

Since the patch was not applied I'm wondering how to proceed with it?

(Maybe I misunderstood, but isn't the ofono issue a separate bug that
exists regardless of the patch?)

Regards,
Daniel

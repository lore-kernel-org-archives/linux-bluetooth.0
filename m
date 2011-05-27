Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTi=1Si-h9AuMRCBKnBjhj6=LXYhuFQ@mail.gmail.com>
References: <BANLkTi=L1xG3gVi9bmuW_YSWcOmu1HiRoQ@mail.gmail.com>
	<BANLkTin3vWrRigXOHQbJKr3rbN1xoirdYw@mail.gmail.com>
	<BANLkTi=1Si-h9AuMRCBKnBjhj6=LXYhuFQ@mail.gmail.com>
Date: Fri, 27 May 2011 13:26:28 +0300
Message-ID: <BANLkTinYb=i9iYNR0Uhd7YG84jdGht2gNg@mail.gmail.com>
Subject: Re: [PATCH] Init telephony before adding HFP SDP records
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Daniel_=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Fri, May 27, 2011 at 11:40 AM, Daniel Örstadius
<daniel.orstadius@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, May 26, 2011 at 6:44 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Daniel,
>>
>> On Thu, May 26, 2011 at 4:58 PM, Daniel Örstadius
>> <daniel.orstadius@gmail.com> wrote:
>>> Please review.
>>
>> For telephony-maemo6 it should be enough to just call
>> headset_server_init after state_changed/telephony_init.
>>
>
> Thanks for the feedback, that seems like a much leaner solution.
> Attaching new patch.

Looks much better, shall I take care of fixing telephony-ofono or you
already have a patch for it?

-- 
Luiz Augusto von Dentz
Computer Engineer

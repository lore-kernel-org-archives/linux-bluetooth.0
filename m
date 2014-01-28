Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC] Initial avctp test
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140128103641.GB9043@aemeltch-MOBL1>
Date: Tue, 28 Jan 2014 04:10:04 -0800
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3FFA1B39-3B61-4291-98D1-82BA94479622@holtmann.org>
References: <1390838187-25006-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <CABBYNZKusSmbTTEVLmU2Xa4+L5dOaKCHt8dFaeT2jP_==uL+jw@mail.gmail.com> <20140128103641.GB9043@aemeltch-MOBL1>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

>>> This is initial invalid packet size test, sent as RFC since I am not
>>> sure what might be tested for avctp.
>>> 
>>> Andrei Emeltchenko (1):
>>>  unit/avctp: Add initial AVCTP test setup
>>> 
>>> Makefile.am       |   8 ++
>>> unit/test-avctp.c | 262 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 270 insertions(+)
>>> create mode 100644 unit/test-avctp.c
>>> 
>>> --
>>> 1.8.3.2
>> 
>> You should follow the testing spec:
>> https://www.bluetooth.org/docman/handlers/DownloadDoc.ashx?doc_id=40404
>> 
>> Please follow the same name convention that is used by the testing
>> spec and for now do not introduce any other test that is not part of
>> the testing spec.
> 
> I have this AVCTP.TS spec but what might be tested for example with test
> case "TP/CCM/BV-01-C"?
> 
> Even looking at session_cb() for AVCTP there seems to be only packet
> length check. In contrast for AVDTP there is command parser so you might
> be able to test something.
> 
> Shall we test AVRCP instead?

AVRCP and AVCTP need to be tested. This is not one or the other. It is both.

Regards

Marcel


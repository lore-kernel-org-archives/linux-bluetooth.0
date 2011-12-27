Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111227100059.GA5379@x220.P-661HNU-F1>
References: <1324396681-27276-1-git-send-email-sancane@gmail.com>
	<1324396681-27276-2-git-send-email-sancane@gmail.com>
	<20111227100059.GA5379@x220.P-661HNU-F1>
Date: Tue, 27 Dec 2011 11:07:40 +0100
Message-ID: <CACLukzJLewH3DKWXd5LW4pEPtcZoHVXeaeFVm=_1hYPmRicV_Q@mail.gmail.com>
Subject: Re: [PATCH 1/8] attrib-server: Initial steps towards multi-adapter
 GATT server support
From: Santiago Carot <sancane@gmail.com>
To: Santiago Carot-Nemesio <sancane@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi johan,

2011/12/27 Johan Hedberg <johan.hedberg@gmail.com>:
> Hi Santiago,
>
> On Tue, Dec 20, 2011, Santiago Carot-Nemesio wrote:
>> +struct gatt_adapter {
>> +     struct btd_adapter *adapter;
>> +     GIOChannel *l2cap_io;
>> +     GIOChannel *le_io;
>> +};
>
> Could we just call this struct attrib_server? That would be less
> confusing than having different types of adapters when in reality you
> only have one adapter. What we have here is an attrib server running on
> a specific adapter, so struct attrib_server would make most sense to me.
> Also update the corresponding function names to reflect this.

Do you mind if I send a patch on top fixing that?

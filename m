Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120202200553.GA837@x220.amr.corp.intel.com>
References: <1328209622-30529-1-git-send-email-luiz.dentz@gmail.com>
	<20120202200553.GA837@x220.amr.corp.intel.com>
Date: Thu, 2 Feb 2012 12:09:03 -0800
Message-ID: <CABBYNZLd2cv_v4-6V8oZg1Mpz-cDj0jsY85ciAykGTdYUfT58g@mail.gmail.com>
Subject: Re: [PATCH obexd 1/2] tools: Fix test-client to use ERTM while on
 packet mode
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan

On Thu, Feb 2, 2012 at 12:05 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Feb 02, 2012, Luiz Augusto von Dentz wrote:
>> +                                     BT_IO_OPT_MODE, 0x03,
>
> I think it'd be better to add proper defines for these magic values
> first.

Sure, gonna do that and send another series.

-- 
Luiz Augusto von Dentz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20140813092256.GB19215@t440s.lan>
References: <1407921074-19966-1-git-send-email-lukasz.rymanowski@tieto.com>
	<20140813092256.GB19215@t440s.lan>
Date: Wed, 13 Aug 2014 11:44:52 +0200
Message-ID: <CAMudyAvL+u-UK6J-FrP25fppzK1-fYnGCzW3DKuN+2DJ3X5GUQ@mail.gmail.com>
Subject: Re: [PATCH] tools/l2test: And listen and not receive mode option
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 13 August 2014 11:22, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lukasz,
>
> On Wed, Aug 13, 2014, Lukasz Rymanowski wrote:
>> +static void not_receive_mode(int sk) {
>> +
>> +     syslog(LOG_INFO, "Connected and not receiving !");
>> +     while (1) {};
>> +}
>
> A busy-loop taking up all CPU time doesn't seem very nice. Shouldn't you
> instead be at least polling for HUP/ERR events? That's what the
> do_listen function seems to expect to have happened when the handler
> returns.
>
You are right, even it is test tool. Anyway, we don't need that patch
at all as wrote in other email.

> Johan

Lukasz

Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130110144734.GA25196@samus>
References: <1357262465-19231-1-git-send-email-lucas.demarchi@profusion.mobi> <20130110144734.GA25196@samus>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Thu, 10 Jan 2013 12:59:29 -0200
Message-ID: <CAMOw1v4pcRiCzuEwsKjPOOAMvrQzi4X0biR6Eyj=3GpCHc50Xw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] build: Do not use deprecated AM_CONFIG_HEADER
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Jan 10, 2013 at 12:47 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Lucas,
>
> On 23:21 Thu 03 Jan, Lucas De Marchi wrote:
>> From: Lucas De Marchi <lucas.de.marchi@gmail.com>
>>
>> The long-obsoleted AM_CONFIG_HEADER macro was removed in automake 1.13.
>> Use AC_CONFIG_HEADERS instead.
>
> I think oFono and neard are still missing this fix. Would you care to
> send it?
>

Sure. Thanks for the prod.


Lucas De Marchi

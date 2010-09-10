Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100910181259.GA19693@vigoh>
References: <4C88D729.7050803@nokia.com>
	<20100910181259.GA19693@vigoh>
Date: Fri, 10 Sep 2010 21:26:18 +0300
Message-ID: <AANLkTimJKtZ_sEirYLzqgh1CaiOr1uqufc6Tj9VdPXcK@mail.gmail.com>
Subject: Re: MAP implementation status
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 10, 2010 at 9:12 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Radoslaw,
>
> * Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com> [2010-09-09 15:46:33 +0300]:
>
>>
>>   Hi all,
>> We plan to start implementation of Message Access Profile Server as
>> obexd plugin. Before we start with coding part I need to check if
>> someone else started implementing MAP Server, MNS Server of Map client.
>> If some code is already available, then we could combine our forces to
>> add MAP support for OBEXD.
>
> We had a Google Summer of Code Project on MAP this year. Vinicius was
> the mentor, he can talk about.

iirc it was mainly a MAP client, the other parts that are missing is:

- MAP plugin + drivers
- Backend infrastructure
- Backends

-- 
Luiz Augusto von Dentz
Computer Engineer

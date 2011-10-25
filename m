Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111025085242.GB3514@fusion.localdomain>
References: <1319448004-8513-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111025085242.GB3514@fusion.localdomain>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 25 Oct 2011 07:34:29 -0200
Message-ID: <CAMOw1v453iY4wKu46XcqtMQROT0T7Z0-xsTxAYWL6K0XQk=efQ@mail.gmail.com>
Subject: Re: [PATCH bluez] add get_le/get_be helpers
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 25, 2011 at 6:52 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Andrei,
>
> On Mon, Oct 24, 2011, Emeltchenko Andrei wrote:
>> Helpers to access LE / BE values. In bluetooth there is a mixture
>> of LE / BE network byte order.
>> ---
>>  lib/bluetooth.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 64 insertions(+), 0 deletions(-)
>
> Applied. Thanks.

Should we convert code to use these new functions?


Lucas De Marchi

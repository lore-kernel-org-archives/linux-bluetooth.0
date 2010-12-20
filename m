Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101220185421.GA553@vigoh>
References: <1292869005-12391-1-git-send-email-bruna.moreira@openbossa.org>
	<20101220185421.GA553@vigoh>
Date: Mon, 20 Dec 2010 16:10:55 -0400
Message-ID: <AANLkTinzGhG0JMb_6TP6ePj6Ssai6M7dfyVyRQqp2F29@mail.gmail.com>
Subject: Re: [PATCH 1/2] Move EIR flags definitions to adapter.c
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Dec 20, 2010 at 2:54 PM, Gustavo F. Padovan
<padovan@profusion.mobi> wrote:
> Hi Bruna,
>
> * Bruna Moreira <bruna.moreira@openbossa.org> [2010-12-20 14:16:44 -0400]:
>
>> ---
>>  src/adapter.c |    9 +++++++++
>>  src/sdpd.h    |    9 ---------
>>  2 files changed, 9 insertions(+), 9 deletions(-)
>
> What's the point on moving this? I supposed you were using these macros in the
> following patch but you're not.
>

It is only a cleanup patch. These macros are used just in adapter.c.
This patch is not related with the next one.

BR,
-- 
Bruna Moreira
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil

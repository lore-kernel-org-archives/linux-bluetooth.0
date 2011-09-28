Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316645518-1246-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <CAMOw1v6hSPeeL7rX3xdJ-2+c=vA1-h0SVqtKT1LLcpdWcinJsQ@mail.gmail.com>
 <1316645518-1246-1-git-send-email-lucas.demarchi@profusion.mobi>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 28 Sep 2011 17:07:11 -0300
Message-ID: <CAMOw1v57BdG3rEqqDVFK0p_9pfkEnfvMUnoM+TOG9Uy=xNmiuA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] avrcp: implement pdu continuation request and abort
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey,

On Wed, Sep 21, 2011 at 7:51 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>
> GetElementAttributes is the only one that can possibly overflow the MTU
> of AVC. When this command is received, if the response is larger than
> the MTU split the messages and queue them for later processing.
> ---
>
> v2: add missing call to cancel_pending_pdus()


Ignore this. I'll send a v3 later on top of other changes I have queued.



Lucas De Marchi

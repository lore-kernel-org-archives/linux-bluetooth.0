Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v6DkURj+MVoA99=E7Nihe3_97O5Dh2b+94WSnVM4Yixxg@mail.gmail.com>
References: <1315826997-13818-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v6DkURj+MVoA99=E7Nihe3_97O5Dh2b+94WSnVM4Yixxg@mail.gmail.com>
Date: Mon, 12 Sep 2011 17:40:59 +0300
Message-ID: <CABBYNZKx=YWwA3y9LxG1yScByxXS2C9nhgjCpuXtkVVyMEmCjA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/5] AVRCP: use a vtable to simplify PDU parsing/handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Mon, Sep 12, 2011 at 4:25 PM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> It might be my CFLAGS, but aren't you getting warnings of unused
> parameters since now every handler carries the transaction id?

Nope and Im not sure why checking unused parameter would be a nice
thing to have, specially dummy callbacks normally ignores some/all the
parameters.

-- 
Luiz Augusto von Dentz

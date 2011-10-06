Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v7y+UuSKLxHqx0B1f=+xrhbTP7RXH8Pc0M51n2_g2hCBQ@mail.gmail.com>
References: <1317844938-21950-1-git-send-email-luiz.dentz@gmail.com>
	<CAMOw1v7y+UuSKLxHqx0B1f=+xrhbTP7RXH8Pc0M51n2_g2hCBQ@mail.gmail.com>
Date: Thu, 6 Oct 2011 09:49:59 +0300
Message-ID: <CABBYNZJsY8zdXkiOuSBV0X+3QW3D83OiFGvAcRDdTNNz5dT0OA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] AVRCP: move MediaPlayer to adapter object
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 6, 2011 at 1:48 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> +
>> +       if (title == FALSE)
>> +               return TRUE;
>
> return FALSE;

That is on purpose, I do not want this to be mandatory to the player
so it doesn't need to pretend anything if not playing and we should be
able to handle this in the daemon.


-- 
Luiz Augusto von Dentz

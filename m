Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1958881669.454431417521836019.JavaMail.weblogic@epmlwas07a>
References: <1958881669.454431417521836019.JavaMail.weblogic@epmlwas07a>
Date: Tue, 2 Dec 2014 14:38:36 +0200
Message-ID: <CABBYNZ+JmU0yKTGJ1C3H16q==QzUO-jv=JJXdDZwgUKo3+ZbQQ@mail.gmail.com>
Subject: Re: Re: [PATCH] Fix SPP connection to wrong uuid
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath <jaganath.k@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Tue, Dec 2, 2014 at 2:03 PM, JAGANATH KANAKKASSERY
<jaganath.k@samsung.com> wrote:
> Hi Luiz,
>
>>> This patch iterates through the record list, finds the record with the uuid
>>> and get the channel from that
>>>
>>I suspect there is something else wrong here, we should be looking for
>>the specific UUID not 0x1101, perhaps that is happening because you
>>have a single agent that register for SPP generically, and don't set
>>any Service UUID, therefore it will look for any SPP rather than the
>>service UUID.
>
> Ok, I will check why searching uuid is 0x1101 and not the specific uuid.
> But we have registered different agents for each uuid, but has to check
> we are doing something wrong while registering.

You need to make sure you are setting the Service UUID properly:

string Service

The primary service class UUID
(if different from the actual
profile UUID)

-- 
Luiz Augusto von Dentz

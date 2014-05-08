Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAGVBWjRKqY8ji=J9sacZ=VXuKFOjBCpjxTwR=0U25zmLyR-6ig@mail.gmail.com>
References: <CAGVBWjRKqY8ji=J9sacZ=VXuKFOjBCpjxTwR=0U25zmLyR-6ig@mail.gmail.com>
Date: Thu, 8 May 2014 12:01:25 +0200
Message-ID: <CAN_7+YYxvbuni4mnamBjJe05zsv9dphQpn4j==WdfpjFLpeMww@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: Introduce Start/Stop Connection Monitor
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Tim Song <tengs@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tim,

On Wed, May 7, 2014 at 11:15 PM, Tim Song <tengs@google.com> wrote:
> The ConnectionTXPower tracked here is hard to use without knowing the
> maximum TX power of the controller, which can be obtained through the
> same HCI command.
>

Ok, I will add  ConnectionTXPowerMax property  in next version of this patch.

> The device could also expose the maximum TX power as an attribute,
> which can be set once on connection and does not need to be tracked
> with this connection monitor API.
>
> Regards,
> Tim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

BR
Lukasz

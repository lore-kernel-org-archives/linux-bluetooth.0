Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAFxSrVuaqCn8SrQq_QrMUXv0cXkJ=rm7=L3nCOeYNPkP2g-WmQ@mail.gmail.com>
References: <CAFxSrVuaqCn8SrQq_QrMUXv0cXkJ=rm7=L3nCOeYNPkP2g-WmQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Aug 2017 20:38:27 +0300
Message-ID: <CABBYNZ+NwigzARcAvBePMGjHVaW6T98o8-ZDejGdy8TRrE9CyQ@mail.gmail.com>
Subject: Re: usage of meshctl with zephyr node
To: Laczen JMS <laczenjms@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 29, 2017 at 4:50 PM, Laczen JMS <laczenjms@gmail.com> wrote:
> Hi,
>
> I have tried to use meshctl with a zephyr node, but I can't figure out
> how to use it. I have a zephyr node that is unprovisioned and I'm
> doing the following:
>
> [meshctl] # discover-unprovisioned on -> works and gives a new
> unprovisioned node (dddd000..)
> [meshctl] # discover-unprovisioned off
> [meshctl] # provision dddd -> works
> [Zephyr Mesh-Node-0100] # configure 0100
> [config: Target = 0100] # add-appkey 0 -> works: Node 0100 AppKey Status Success
> [config: Target = 0100] # bind 0 0 1000 -> works: Node 0100 Model App
> Status Success
> Element 0100 AppIdx 000
>         ModelId 1000
>         Binding successful AppIdx 000
> [config: Target = 0100] # back
> [Zephyr Mesh-Node-0100] # onoff 0100

I don't thing Zephyr supports onoff model, that might explain why this
is failing.

> [on/off: Target = 0100]# onoff 1 fails (does nothing) The debugging on
> the node gives the following message:
> [bt] [WRN] sdu_recv: No matching AppKey
> adding some extra debugging lines in the node gives the following information:
> (AID(&hdr) != keys->id):
> [bt] [WRN] sdu_recv: Appkey IDs hdr:31 keys:46
>
> Am I using meshctl incorrect ? I am doubting the bind command.
>
> Thanks, and kind regards,
>
> Jehudi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz

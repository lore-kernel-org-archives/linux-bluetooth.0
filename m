Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DEBB0CAA2616974FAE35E4B560B9A4373E1D0010@ORSMSX103.amr.corp.intel.com>
References: <CAFxSrVuaqCn8SrQq_QrMUXv0cXkJ=rm7=L3nCOeYNPkP2g-WmQ@mail.gmail.com>
 <CABBYNZ+NwigzARcAvBePMGjHVaW6T98o8-ZDejGdy8TRrE9CyQ@mail.gmail.com>
 <CAFxSrVvPYA3dnTr16g-N=pCWt9WUX2UEfpg7=sfcSnvQO2BbSg@mail.gmail.com> <DEBB0CAA2616974FAE35E4B560B9A4373E1D0010@ORSMSX103.amr.corp.intel.com>
From: Laczen JMS <laczenjms@gmail.com>
Date: Tue, 29 Aug 2017 20:41:00 +0200
Message-ID: <CAFxSrVvqvb3y9HjD1Zqx0mEw+qxZF8HUDqS1buSaqAhsDNJUEg@mail.gmail.com>
Subject: Re: usage of meshctl with zephyr node
To: "Gix, Brian" <brian.gix@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

Thanks for your reply, I was using the wrong appkey, it is working
now. Congratulations on supporting bluetooth mesh so fast after
publication of the standard.

Kind regards,

Jehudi

2017-08-29 20:13 GMT+02:00 Gix, Brian <brian.gix@intel.com>:
> Hi Jehudi,
>
> The local "OnOff Client" of meshctl is bound to Application Key 001, not 000 (see the local_node.json file).
>
> I am not certain the Zephyr supports the on/off opcode (even if the Composition data of Zephyr is claiming to support the model) but at a minimum, you should be sending appkey 001, and binding the on/off server to that key.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Laczen JMS
>> Sent: Tuesday, August 29, 2017 10:58 AM
>> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>> Cc: linux-bluetooth@vger.kernel.org
>> Subject: Re: usage of meshctl with zephyr node
>>
>> Hi Luiz,
>>
>> Thanks for the reply. Zephyr does support the onoff model. Using the silicon
>> lab mesh program for android I can control the onoff server model on the
>> node.
>>
>> What I don't know is if I can use the onoff command in meshctl to control the
>> onoff server model on the node. I am trying to provision, configure and
>> control a node using meshctl. The provisioning works, I am doubting the
>> configuring and controlling.
>>
>> For the configuring I am using: configure nodeID, add-appkey, bind, is this OK
>> ?
>>
>> For the controlling I am using onoff nodeID, onoff 1/0, is this OK?
>>
>> Kind regards,
>>
>> Jehudi
>>
>> 2017-08-29 19:38 GMT+02:00 Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com>:
>> > Hi,
>> >
>> > On Tue, Aug 29, 2017 at 4:50 PM, Laczen JMS <laczenjms@gmail.com>
>> wrote:
>> >> Hi,
>> >>
>> >> I have tried to use meshctl with a zephyr node, but I can't figure
>> >> out how to use it. I have a zephyr node that is unprovisioned and I'm
>> >> doing the following:
>> >>
>> >> [meshctl] # discover-unprovisioned on -> works and gives a new
>> >> unprovisioned node (dddd000..) [meshctl] # discover-unprovisioned off
>> >> [meshctl] # provision dddd -> works [Zephyr Mesh-Node-0100] #
>> >> configure 0100
>> >> [config: Target = 0100] # add-appkey 0 -> works: Node 0100 AppKey
>> >> Status Success
>> >> [config: Target = 0100] # bind 0 0 1000 -> works: Node 0100 Model App
>> >> Status Success Element 0100 AppIdx 000
>> >>         ModelId 1000
>> >>         Binding successful AppIdx 000
>> >> [config: Target = 0100] # back
>> >> [Zephyr Mesh-Node-0100] # onoff 0100
>> >
>> > I don't thing Zephyr supports onoff model, that might explain why this
>> > is failing.
>> >
>> >> [on/off: Target = 0100]# onoff 1 fails (does nothing) The debugging
>> >> on the node gives the following message:
>> >> [bt] [WRN] sdu_recv: No matching AppKey adding some extra debugging
>> >> lines in the node gives the following information:
>> >> (AID(&hdr) != keys->id):
>> >> [bt] [WRN] sdu_recv: Appkey IDs hdr:31 keys:46
>> >>
>> >> Am I using meshctl incorrect ? I am doubting the bind command.
>> >>
>> >> Thanks, and kind regards,
>> >>
>> >> Jehudi
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe
>> >> linux-bluetooth" in the body of a message to
>> >> majordomo@vger.kernel.org More majordomo info at
>> >> http://vger.kernel.org/majordomo-info.html
>> >
>> >
>> >
>> > --
>> > Luiz Augusto von Dentz
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html

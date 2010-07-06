Return-Path: <cyrus@holtmann.org>
From: "Perelet, Oleg" <operelet@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>, Bala Shanmugam
	<sbalashanmugam@atheros.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 6 Jul 2010 13:29:56 -0700
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT devices
Message-ID: <BCDE476F204B134B8B235FB275BC3AD80FC355337C@NALASEXMB01.na.qualcomm.com>
References: <1278333422-10368-1-git-send-email-sbalashanmugam@atheros.com>
 <1278437061.2789.62.camel@localhost.localdomain>
In-Reply-To: <1278437061.2789.62.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

>> Added support to load firmware to target RAM from Bluetooth USB transpor=
t
>> driver.=20

>we have discussed this a long time ago and the better approach would be
>to create a setup stage for all HCI drivers. For example for special HCI
>commands to set BD_ADDR and other details. Maybe also a firmware loading
>stage should be used. Making this USB specific sounds pretty much wrong
>to me at this point. At least SDIO might have similar issues.

>>The current approach looks more hackish than actually nicely integrated.

Thanks for bringing up old topic. We discussed this few years ago and thing=
s been somehow stalled. Besides, USB, SDIO there's UART which is used in a =
lot of embedded platforms and everybody hacks custom code around.

Overall Marcel suggests to have intermediate stage between DOWN and UP stat=
es for hci device aka - SETUP (call it any name).


Here are low level BT setup states that I "think" are common for majority o=
f embedded implementations:

1. low level GPIO, CLC etc setup - can not talk to chip before that.

2. Initial firmware/patch download - at this state one can talk HCI to chip=
, but chip is barely functional, firmware, patches etc are downloaded at th=
is stage.

3. "Run time config download" (often combined with #2, but I suggest to sep=
arate) this is when BDADDR is programmed and chip run time parameters for g=
iven platform are set up. For majority of chips this stage also defines Sle=
ep algorithm to be used. There are few ways of doing BT sleep - HCI, UART s=
ignaling or usage of extra WAKE GPIO's to determine sleep condition. Most o=
f them require initial HCI setup.

4. Enable Sleep and low power mode. Currently everybody hardcodes this step=
, some platforms have programmatic ifaces (aka sysfs)

5. WiFI coex setup if needed.

Feel free to add more here ....

At this stage hci can be brought to UP stage and be functional.


All of that is tight with RFKILL of course and also suspend/resume entries =
in transport driver. I'm also not doing in to details of sleep mode impleme=
ntation in this thread but welcome to discuss it in separate thread.

Oleg.





--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

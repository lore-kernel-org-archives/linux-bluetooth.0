Return-Path: <cyrus@holtmann.org>
From: <Waldemar.Rymarkiewicz@tieto.com>
To: <mcprabhakaran@gmail.com>, <linux-bluetooth@vger.kernel.org>
Date: Thu, 5 Aug 2010 13:07:09 +0300
Subject: RE: L2cap Security And Role Switch
Message-ID: <99B09243E1A5DA4898CDD8B700111448096BA3C23C@EXMB04.eu.tieto.com>
References: <AANLkTimAktDFG+abbsMpgKfkNtmX3tqqhwXd-OZwgRWj@mail.gmail.com>
In-Reply-To: <AANLkTimAktDFG+abbsMpgKfkNtmX3tqqhwXd-OZwgRWj@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, 

>-----Original Message-----
>From: linux-bluetooth-owner@vger.kernel.org 
>[mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of 
>Prabhakaran M.C
>Sent: Wednesday, August 04, 2010 4:09 PM
>To: linux-bluetooth@vger.kernel.org
>Subject: Reg: L2cap Security And Role Switch
>
>Hello All,
>
> Whenever L2cap security is HIGH and remote device does role 
>switch, Bluez accepts the Role switch and L2cap disconnects 
>the channel because of HIGH security.
>
> For PAN profile, I would like to keep the L2cap security to 
>HIGH since it involves internet browsing but the Widcomm stack 
>always does a role switch in PAN connection and Bluez 
>disconnects l2cap channel.
>
> Can someone please point in specification about the l2cap 
>security level and Role switch relation. I tried to find out 
>this but I could not get this behavior described in 
>specification. Please provide your comments and inputs. Thanks 
>in Advance.
>
>Thanks,
>Prabhakaran.
>--

Note that HIGH sec level requires encription on the link. Role switch procedure turn off  the encription before it starts switching roles and turn on it again after all. In 2.1 spec the controller handles switching off/on encription (pause/resume).

Thanks,
/Waldek
Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 14:44:37 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Zoltan Csik <zicsik@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: sdp.h correction and update
Message-ID: <20120814114437.GA10551@x220>
References: <CANM+e8yPJhe1anFTsTQYqmQf2k8BfRTgKrhsNkaWrRVdG=ybkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CANM+e8yPJhe1anFTsTQYqmQf2k8BfRTgKrhsNkaWrRVdG=ybkA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Zoltan,

On Tue, Jul 24, 2012, Zoltan Csik wrote:
> bluez-4.99\lib\sdp.h
> Line 98: #define VIDEO_CONF_SVCLASS_ID          0x110f
> 
> doesn't match with the latest SIG assigned numbers list:
> "A/V_RemoteControlController    0x110F  Audio/Video Remote Control Profile
> (AVRCP) Service Class           NOTE: The AVRCP specification v1.3 and later
> require that 0x110E also be included in the ServiceClassIDList before
> 0x110F for backwards compatibility.     "
> 
> Also according to above referenced list there are some service
> class_ID definitions missing from sdp.h:
> Headset - HS                 0x1131 Headset Profile (HSP)
> Message Access Server        0x1132 Message Access Profile (MAP)
> Message Notification Server  0x1133 Message Access Profile (MAP)
> Message Access Profile       0x1134 Message Access Profile (MAP)
> GNSS                         0x1135 Global Navigation Satellite System
> Profile (GNSS)
> GNSS_Server                  0x1136 Global Navigation Satellite System
> Profile (GNSS)

Could you send these fixes as proper git patches (git format-patch and
git send-email).

Johan

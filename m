Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ba5648fa0912230200k3aae7de2v920cb00de10cef43@mail.gmail.com>
References: <ba5648fa0912230200k3aae7de2v920cb00de10cef43@mail.gmail.com>
Date: Wed, 23 Dec 2009 15:31:29 +0530
Message-ID: <ba5648fa0912230201g3e02d641y98185edc09f532b4@mail.gmail.com>
Subject: Re: service search for headset
From: bluezprofile kernel <bluezprofile@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 23, 2009 at 3:30 PM, bluezprofile kernel
<bluezprofile@gmail.com> wrote:
> Hi,
> I am trying to get the service of the remote device. I have used
> sdptool browse <remote mac>
> to get the list of services supported by the remote device.
>
> I have done between two laptops and I am able to see the services available.
> When I do the same for my hands free device, I am not able to get the
> service details of handsfree unit.
> I have debugged this using sdptool application source.
> sdptool application sends the attribute request to the hands free
> device, in the reply I am not getting anything. (sdp_send_req and sdp_read_rsp)
>
> sdptool record <remote mac> works fine.
> sdptool browse --l2cap <remote mac> also works fine
> Why --l2cap option required. Please any one explain me.
>
> In my blueman application it shows the list of services when I pair.
> Are they using record mechanism to display services?
> Any one please help me in this regard.
>
> I have used bluez 5.58
> Nic Shen
>

Sorry it is bluez 4.58

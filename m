Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B0260B44D1AB@DNCE02.ent.ti.com>
References: <F0070FBC0FB3174D8D11444EB2D5B0260B44D1AB@DNCE02.ent.ti.com>
Date: Sun, 11 Mar 2012 21:11:41 -0300
Message-ID: <CAKT1EBcVv1ya0ArmgwNh968O9QSsQD6oNy1poJDeNgg_V=iuog@mail.gmail.com>
Subject: Re: HID Over GATT implementation
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen Ganir,

On Sun, Mar 11, 2012 at 9:54 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Hi.
>
> I have started the development of the HOGP (HID Over GATT Protocol) for the BlueZ Stack. The main idea of this adopted profile is to allow HID devices to operate over the low energy technology.
>
> The HID Over GATT Profile includes the following services :
> 1. Battery Service - allows the host to gather and display information regarding the peer device battery/batteries state.
> 2. Device Information Service - This service contains misc identification data of a device. The HOGP will use the PNP ID field.

Could you please explain how are you planning to share battery level
and PNP ID to HoG service?

device.c can have function to get/set Battery Level and PNP ID. IMO,
only Battery Level could be exported in the Device interface(instead
of creating a new interface for Battery).

BR,
Claudio

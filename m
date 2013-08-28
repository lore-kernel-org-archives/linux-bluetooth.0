Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5214C9DD.3090000@globaledgesoft.com>
References: <5214C9DD.3090000@globaledgesoft.com>
Date: Wed, 28 Aug 2013 10:19:11 -0300
Message-ID: <CAKT1EBdKWXYno1_v-P3xMHarSR5TbLZ3SrVJL_n2j4c6CWLPew@mail.gmail.com>
Subject: Re: LE GATT service discovery Over BR/EDR
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Sathish Narasimman <sathish.n@globaledgesoft.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sathish:

On Wed, Aug 21, 2013 at 11:08 AM, Sathish Narasimman
<sathish.n@globaledgesoft.com> wrote:
> Hi,
>
> I am reading core spec 4.0.
> GATT Features regarding Primary Service Discovery in page: 1911
>
> "GATT service discovery over BR/EDR transport will list services that only
> run
> over an LE transport and therefore only SDP service discovery shall be used
> on BR/EDR."
>
> Though SDP Service Discovery is able to get all the related service
> information. What is the use of
> GATT Service Discovery which gives only LE Information on BR/EDR Controller.

SDP record will not provide information related to characteristics and
descriptors.
For BR/EDR, GATT procedures are still required to discover, read and
write characteristics.

Below is an example of a SDP record for GATT based services:
Service Name: Generic Access Profile
Service Provider: BlueZ
Service RecHandle: 0x10001
Service Class ID List:
  "" (0x1800)
Protocol Descriptor List:
  "L2CAP" (0x0100)
    PSM: 31
  "ATT" (0x0007)
    uint16: 0x1
    uint16: 0x5

BR,
Claudio

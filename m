Return-Path: <ian@mnementh.co.uk>
Subject: Re: PATCH: RFC: Broadcom serdev driver
To: Marcel Holtmann <marcel@holtmann.org>,
 Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 Loic Poulain <loic.poulain@gmail.com>, Rob Herring <robh@kernel.org>
References: <afbbb4ed-d1aa-2ae8-33c5-1fab8e360551@mnementh.co.uk>
 <A31E83F8-3A6E-49DC-BF1A-0FA1C6E10552@holtmann.org>
 <372d1433-376c-8896-60a0-e24bbeede427@mnementh.co.uk>
 <20170708214623.fhzrzhcedo2hhov4@earth>
 <12AF72B3-C621-4E01-AB9B-10BF5E5913FE@holtmann.org>
From: Ian Molton <ian@mnementh.co.uk>
Message-ID: <d0fc2f90-4e6c-10bf-1707-5b0e16837e0d@mnementh.co.uk>
Date: Mon, 10 Jul 2017 22:27:08 +0100
MIME-Version: 1.0
In-Reply-To: <12AF72B3-C621-4E01-AB9B-10BF5E5913FE@holtmann.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 09/07/17 09:07, Marcel Holtmann wrote:

> actually I think that all of them need to be serdev only drivers. We
> just need to figure out on how to create the serdev devices for the
> ones that are not backed by DT.
In the mean time, I can clean up and resubmit my driver if its helpful?

-Ian

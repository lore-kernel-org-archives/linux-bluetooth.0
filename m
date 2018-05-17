Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
References: <adcc154e-622d-d974-87cc-23d9d0b220c3@posteo.de>
In-Reply-To: <adcc154e-622d-d974-87cc-23d9d0b220c3@posteo.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 May 2018 11:19:27 +0300
Message-ID: <CABBYNZLUKFm1u=OsSArm73Diq=dsXJTc0V2=MaYN7pt-9wjPCA@mail.gmail.com>
Subject: Re: meshctl: Failed to AcquireWrite
To: wenzel.reichmuth@posteo.de
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
On Wed, May 16, 2018 at 2:15 PM wenzel.reichmuth@posteo.de <
wenzel.reichmuth@posteo.de> wrote:

> Hello. I am using meshctl from bluez 5.49 and try to configure a mesh
> with zephyr nodes on redbear ble nano 2. I am able to discover and
> provision a node. but when i try to configure it e.g. appkey-add i get
> "Failed to AcquireWrite". Any hint, how to get this solved? there is
> sparse documentation for meshctl.

Perhaps the problem is with fd passing being blocked by something like
selinux, do you have logs of the problem?

-- 
Luiz Augusto von Dentz

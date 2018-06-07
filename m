Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Guilhem Lettron <guilhem@lettron.fr>
Date: Thu, 7 Jun 2018 13:56:06 +0200
Message-ID: <CAMQoE_1PA4XX_PkGe_NS8yQgroPQkBHbFJjsW-mGx4nRh25DmQ@mail.gmail.com>
Subject: HP Elite Presenter Mouse support
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
It seems that I'm the only one who buy an HP Elite Presenter Mouse (
http://www8.hp.com/us/en/products/oas/product-detail.html?oid=17872528&jumpid=reg_r1002_usen_c-001_title_r0001
)

This device uses BLE and can be transformed between a mouse and a
presenter / gesture mouse.
Currently, this "mouse" can only be used for presentation, page up /
down is working fine.
But neither traditional mouse or gesture mouse is working.
I'm on an ubuntu bionic and get some logs from bluez:
https://gist.github.com/guilhem/443cf5b588e6c1eb5d38ff7ed1ff5547
Does anyone know if there is a quick fix or quirk to put?
I'm available for any other information to debug it.

Thanks.
Guilhem Lettron

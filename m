Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Edward Jo <tkv2357@gmail.com>
Date: Fri, 16 Dec 2016 19:12:02 +0900
Message-ID: <CACqzuK_EY6No+DSekZMqzRqNvNo9_=zpDOBvve26LwRz5JOuRA@mail.gmail.com>
Subject: How can Gatt server know the changed MTU after MTU exchange?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

 I tried to find the DBus API to get the negotiated MTU in doc of Bluez 5.43,
but I couldn't.

 I would like that Gatt server send the response data chunk in MTU size when
client device sends 'Blob Read request' to GATT server.

 Is there a way Gatt server to get the negotiated MTU? Perhaps, I'm missing
something or misunderstanding.

Best regards,
Ed
